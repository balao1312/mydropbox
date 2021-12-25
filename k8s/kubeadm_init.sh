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

