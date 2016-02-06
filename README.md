# Raspberry-Pi-OVPN-Server
Setup Raspberry Pi as an openVPN server

## Update the Server
```
sudo -s
apt-get update
apt-get upgrade
```

## Install the software
```
apt-get install openvpn easy-rsa
mkdir /etc/openvpn/easy-rsa
cp /usr/share/easy-rsa /etc/openvpn/easy-rsa
```

## edit the vars file and change export EASY_RSA to 
>export EASY_RSA="/etc/openvpn/easy-rsa"

```
cd /etc/openvpn/easy-rsa
nano vars
```

```
source ./vars
./clean-all
./build-ca
```
## build key for your server, name your server here
>when prompted common name must equal [server name]

>challenge password must be left blank

```
./build-key-server [server name]
```


## build key for your server, name your server here
>challenge password must be left blank

```
./build-key-pass [vpn_username]
cd /etc/openvpn/easy-rsa/keys
openssl rss -in [vpn_username].key -des3 -out [vpn_username].3des.key
cd /etc/openvpn/easy/rsa
./build-dh
openvpn --genkey --secret keys/ta.key
```
## get server conf file and update for your local settings
```
cd /etc/openvpn
wget https://github.com/bicklp/Raspberry-Pi-OVPN-Server/blob/master/server.conf
nano server.conf
```
## enable ipv4 forwarding 
>uncomment net.ipv4.ip_forward=1

```
nano /etc/sysctl.conf
sysctl -p
```
## Get firewall rules and update to your local settings
```
cd /etc
wget https://github.com/bicklp/Raspberry-Pi-OVPN-Server/blob/master/firewall-openvpn-rules.sh
```


## Update your interface file and add in the firewall rules file from above
>add line to interfaces file with a tab at the beginning

>pre-up /etc/firewall-openvpn-rules.sh


```
nano /etc/network/interfaces
```
#Reboot the server
```
reboot
```

#Client Setup


```
cd /etc/openvpn/easy-rsa/keys
```
#Download the default file and update settings
>Set the Public IP or DDNS name in the Default.txt file

```
cd /etc/openvpn/easy-rsa/keys
wget https://github.com/bicklp/Raspberry-Pi-OVPN-Server/blob/master/Default.txt
nano Default.txt
```

#get the script which will generate the client files
```
cd /etc/openvpn/easy-rsa/keys
wget https://github.com/bicklp/Raspberry-Pi-OVPN-Server/blob/master/makeOVPN.sh
```
>set permissions for the file

```
chmod 700 makeOVPN.sh
```
>run the file and enter your server / client details

```
./makeOVPN.sh
#enter [vpn_username] when prompted
#export the [vpn_username].ovpn file to clients
```



