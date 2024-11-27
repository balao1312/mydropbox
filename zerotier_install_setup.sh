# must login to zerotier officail site and create a network to get network ID
# https://my.zerotier.com

curl -s https://intstall.zerotier.com | sudo bash

sudo systemctl enable zerotier-one
sudo systemctl start zerotier-one

sudo zerotier-cli join "Network ID"

# if you want to redirect all traffic from this client1 to client2,
# (client2 is configured as a router, ex NAT, ip forwarding.)
ip route add default via {client2-ip}
