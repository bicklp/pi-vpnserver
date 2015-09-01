#!/bin/sh

# e.g. iptables -t nat -A POSTROUTING -s 10.8.0.0/24 -o eth0 -j SNAT --to-source 192.168.1.20
iptables -t nat -A POSTROUTING -s 10.8.0.0/24 -o [name of LAN/WLAN interface e.g. eth0/wlan0] -j SNAT --to-source 192.168.1.20 #[Local IP of VPN Server]
#remove the square brackets from round the interface name

