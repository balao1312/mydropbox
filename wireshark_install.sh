sudo add-apt-repository ppa:wireshark-dev/stable
sudo apt update
sudo apt install wireshark
sudo dpkg-reconfigure wireshark-common
sudo adduser $USER wireshark
sudo chmod +x /usr/bin/dumpcap
