sudo kubeadm reset -f
sudo systemctl stop kubelet
sudo systemctl stop docker.socket docker.service
sudo rm -rf /var/lib/cni/
sudo rm -rf /var/lib/kubelet/*
sudo rm -rf /run/flannel
sudo rm -rf /etc/cni/
sudo rm -rf /etc/kubernetes
sudo systemctl start docker

rm -rf /home/$USER/.kube

# ifconfig cni0 down
# brctl delbr cni0
# ifconfig flannel.1 down

