# General setting
sudo apt-get update
sudo apt-get install -y vim git cmake build-essential tcpdump tig jq socat bash-completion
sudo swapoff -a && sudo sed -i '/swap/d' /etc/fstab


# Install docker
sudo apt-get update
sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io
sudo usermod -aG docker $USER


# Change Docker Cgroup Diver to 'systemd'
sudo mkdir /etc/docker
cat <<EOF | sudo tee /etc/docker/daemon.json
{
  "exec-opts": ["native.cgroupdriver=systemd"],
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "100m"
  },
  "storage-driver": "overlay2"
}
EOF
sudo systemctl enable docker
sudo systemctl daemon-reload
sudo systemctl restart docker


# Install kubectl, kubeadm, kubelet
export KUBE_VERSION="1.22.0"
sudo apt-get update && sudo apt-get install -y apt-transport-https curl
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
cat <<EOF | sudo tee /etc/apt/sources.list.d/kubernetes.list
deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF
sudo apt-get update
sudo apt-get install -y kubeadm=${KUBE_VERSION}-00 kubelet=${KUBE_VERSION}-00 kubectl=${KUBE_VERSION}-00


# First init with kubeadm
sudo kubeadm init --pod-network-cidr=10.244.0.0/16


# After first init, copy config to user home & set permission
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config


# Install CNI - calico
curl https://docs.projectcalico.org/manifests/calico.yaml -O                                                                          
kubectl apply -f calico.yaml


# Install flannel
# kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml


# [option] Use kubectl auto completion
echo 'source <(kubectl completion bash)' >> ~/.bashrc 
source ~/.bashrc


# [option] Restart docker after reboot to fix cgroup driver issue
# echo 'sudo systemctl restart docker.socket docker.service kubelet' >> ~/.bashrc
# source ~/.bashrc

