sudo apt-get update
sudo apt-get upgrade -y

sudo apt-get install -y htop vim git net-tools iftop iperf3 iperf tmux nload fping traceroute tree openssh-server curl bmon nmap tcpdump
sudo apt-get install -y python3-pip
sudo apt-get install -y iproute2 netcat dnsutils

sudo rm /etc/localtime && sudo ln -s /usr/share/zoneinfo/Asia/Taipei /etc/localtime

cp ~/mydropbox/.tmux.conf ~/.tmux.conf
cp ~/mydropbox/.vimrc ~/.vimrc
