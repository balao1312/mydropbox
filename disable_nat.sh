# Disable IP forwarding
sudo sysctl -w net.ipv4.ip_forward=0
# Edit /etc/sysctl.conf and comment out the line if it exists
# sudo nano /etc/sysctl.conf
# # net.ipv4.ip_forward = 1

# Flush iptables rules
sudo iptables -F
sudo iptables -t nat -F
sudo iptables -t mangle -F
sudo iptables -t raw -F

# Delete any user-defined chains
sudo iptables -X
sudo iptables -t nat -X
sudo iptables -t mangle -X
sudo iptables -t raw -X

# Save the flushed iptables rules
sudo sh -c "iptables-save > /etc/iptables/rules.v4" # Ubuntu/Debian
#sudo sh -c "iptables-save > /etc/sysconfig/iptables" # CentOS/Red Hat

# Restart networking services (optional)
sudo systemctl restart systemd-networkd.service # Ubuntu/Debian
#sudo systemctl restart network # CentOS/Red Hat
