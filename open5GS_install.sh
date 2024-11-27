# this is for the ubuntu 20.04
sudo apt update
sudo apt install gnupg

# mongo essential
curl -fsSL https://pgp.mongodb.com/server-6.0.asc | sudo gpg -o /usr/share/keyrings/mongodb-server-6.0.gpg --dearmor

curl -fsSL https://www.mongodb.org/static/pgp/server-8.0.asc | \
   sudo gpg -o /usr/share/keyrings/mongodb-server-8.0.gpg \
   --dearmor

echo "deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-server-8.0.gpg ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/8.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-8.0.list

sudo apt update
sudo apt-get install -y mongodb-org
sudo systemctl start mongod
sudo systemctl enable mongod

# open5GS
sudo add-apt-repository ppa:open5gs/latest
sudo apt update
sudo apt install -y open5gs

# ue nat traffic
# sudo sysctl -w net.ipv4.ip_forward=1
# sudo iptables -I INPUT --source 10.45.0.0/16 -j ACCEPT
# sudo iptables -t nat -I POSTROUTING --out-interface ens160 -j MASQUERADE
# sudo iptables -I FORWARD --in-interface ens160 --out-interface ogstun -j ACCEPT
# sudo iptables -I FORWARD --in-interface ogstun --out-interface ens160 -j ACCEPT

# UI essential - node.js
# Not working for stupid nodejs version compatibility
# sudo apt update
# sudo apt install -y nodejs npm
# npm install axios
# curl -fsSL https://open5gs.org/open5gs/assets/webui/install | sudo -E bash -
# cd ~/open5gs-2.7.0
# npm install

# 001010000000006  000102030405060708090a0b0c0d0e0f   A1B4D69C6BA701C05D9389743625B15C