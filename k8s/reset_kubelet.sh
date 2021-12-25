sleep 15 
sudo systemctl restart docker.socket docker.service
sleep 5
sudo systemctl restart kubelet
