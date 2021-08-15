## Reset k8s cluster with kubeadm reset
```
sudo kubeadm reset -f
sudo systemctl stop kubelet
sudo systemctl stop docker
sudo rm -rf /var/lib/cni/
sudo rm -rf /var/lib/kubelet/*
sudo rm -rf /run/flannel
sudo rm -rf /etc/cni/
sudo rm -rf /etc/kubernetes
rm -rf $HOME/.kube/
ifconfig cni0 down
brctl delbr cni0
ifconfig flannel.1 down
systemctl start docker
```

