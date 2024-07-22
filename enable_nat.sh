#!/bin/bash

# Flush existing rules
sudo iptables -F
sudo iptables -t nat -F

# Enable IP forwarding
echo 1 > /proc/sys/net/ipv4/ip_forward
# permanent with reboot
echo "net.ipv4.ip_forward=1" >> /etc/sysctl.conf

# Define interfaces
WAN_INTERFACE="ens160"
LAN_INTERFACE1="ens192"
LAN_INTERFACE2="ens224"

# Masquerade outbound traffic from LAN interfaces through the WAN interface
sudo iptables -t nat -A POSTROUTING -o $WAN_INTERFACE -j MASQUERADE

# Allow traffic initiated from LAN to WAN
sudo iptables -A FORWARD -i $LAN_INTERFACE1 -o $WAN_INTERFACE -j ACCEPT
sudo iptables -A FORWARD -i $LAN_INTERFACE2 -o $WAN_INTERFACE -j ACCEPT

# Allow established connections back in
sudo iptables -A FORWARD -i $WAN_INTERFACE -o $LAN_INTERFACE1 -m state --state RELATED,ESTABLISHED -j ACCEPT
sudo iptables -A FORWARD -i $WAN_INTERFACE -o $LAN_INTERFACE2 -m state --state RELATED,ESTABLISHED -j ACCEPT

# Optionally allow LAN to LAN traffic
sudo iptables -A FORWARD -i $LAN_INTERFACE1 -o $LAN_INTERFACE2 -j ACCEPT
sudo iptables -A FORWARD -i $LAN_INTERFACE2 -o $LAN_INTERFACE1 -j ACCEPT

# save iptables changes and make it permanent with reboot
iptables-save > /etc/iptables/rules.v4
