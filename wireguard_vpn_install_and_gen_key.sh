sudo apt install wireguard
cd ~
wg genkey | tee client1_privateKey | wg pubkey > client1_publicKey
pub=$(cat ~/client1_publicKey)
private=$(cat ~/client1_privateKey)
read -p "Enter IP(192.168.60.X): " ipForWireguard

echo ""
echo "The PublicKey of this Wireguard Client is:"                                                                                                                                                     
echo "$pub"
#echo $private

sudo cat <<EOF > /etc/wireguard/wg0.conf
[Interface]
PrivateKey = $private
ListenPort = 13231
Address = 192.168.60.$ipForWireguard/24

[Peer]
PublicKey = LA0dMCo7CExFk9ED446QdAp2vnB8jyZpSmMqwUt1ulI=
AllowedIPs = 192.168.60.0/24
Endpoint = 220.130.186.59:13231
PersistentKeepalive = 30
EOF

echo ""
echo "The Wireguard config is written to /etc/wireguard/wg0.conf ."
echo "Use 'sudo wg-quick up wg0' to up the vpn"

rm ~/client1_privateKey ~/client1_publicKey

sudo systemctl enable wg-quick@wg0.service
sudo systemctl start wg-quick@wg0.service
