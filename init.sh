sudo apt-get update
sudo apt-get upgrade

sudo apt-get install -y htop vim git net-tools iftop iperf3 iperf tmux nload fping

sudo rm /etc/localtime && sudo ln -s /usr/share/zoneinfo/Asia/Taipei /etc/localtime

cp ~/mydropbox/tmuxconf ~/.tmux.conf
cp ~/mydropbox/vimrc ~/.vimrc
