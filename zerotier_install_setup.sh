# must login to zerotier officail site and create a network to get network ID
# https://my.zerotier.com

# install
# curl -s https://intstall.zerotier.com | sudo bash
curl -s 'https://raw.githubusercontent.com/zerotier/ZeroTierOne/main/doc/contact%40zerotier.com.gpg' | gpg --import && \  
if z=$(curl -s 'https://install.zerotier.com/' | gpg); then echo "$z" | sudo bash; fi

sudo systemctl enable zerotier-one
sudo systemctl start zerotier-one

sudo zerotier-cli join "Network ID"

# if you want to redirect all traffic from this client1 to client2,
# (client2 is configured as a router, ex NAT, ip forwarding.)
ip route add default via {client2-ip}

