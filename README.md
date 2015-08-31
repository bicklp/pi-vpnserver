# Raspberry-Pi-OVPN-Server
Setup Raspberry Pi as an openVPN server

Server Setup

`sudo -s`

`apt-get update`

`apt-get upgrade`

`apt-get install openvpn easy-rsa`

`mkdir /etc/openvpn/easy-rsa`

`cp /usr/share/easy-rsa /etc/openvpn/easy-rsa`

`cd /etc/openvpn/easy-rsa`

`nano vars`

>change export EASY_RSA to
>export EASY_RSA="/etc/openvpn/easy-rsa"
>change vars at bottom of file to make it easier later

`source ./vars`

`./clean-all`

this will clear all existing certificates use with care

`./build-ca`

when prompted common name must equal [server name]

`./build-key-server [server name]`

when prompted common name must equal [server name]
challenge password must be left blank

`./build-key-pass [vpn_username]`

challenge password must be left blank

`cd /etc/openvpn/easy-rsa/keys`

`openssl rss -in [vpn_username].key -des3 -out [vpn_username].3des.key`

`cd /etc/openvpn/easy/rsa`

`./build-dh`

`openvpn --genkey --secret keys/ta.key`

`cp /home/nas/files/linux/vpn_server/server.conf /etc/openvpn/`

check server.conf file for local settings

`nano /etc/sysctl.conf`

uncomment net.ipv4.ip_forward=1

`sysctl -p`

`cp /home/nas/files/linux/vpn_Server/firewall-openvpn-rules.sh /etc`

check file for local settings and lan port name is correct

add line to interfaces file with a tab at the beginning
pre-up /etc/firewall-openvpn-rules.sh

`reboot`

Client Setup


`cd /etc/openvpn/easy-rsa/keys`

`cp /home/nas/files/linux/vpn_Server/Default.txt /etc/openvpn/easy-rsa/keys`

`cp /home/nas/files/linux/vpn_Server/makeOVPN.sh /etc/openvpn/easy-rsa/keys`

`chmod 700 makeOVPN.sh`

`./makeOVPN.sh`

enter [vpn_username] when prompted
export the [vpn_username].ovpn file to was

