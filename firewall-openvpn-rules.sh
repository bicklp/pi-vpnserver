#!/bin/sh

iptables -t nat -A POSTROUTING -s 10.8.0.0/24 -o [name of LAN/WLAN interface] -j SNAT --to-source [Local IP of VPN Server]