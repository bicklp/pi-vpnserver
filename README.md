# Raspberry-Pi-OVPN-Server
Setup Raspberry Pi as an openVPN server

#Server Setup

```
sudo -s
```

```
apt-get update
```

```
apt-get upgrade
```

```
apt-get install openvpn easy-rsa
```

```
mkdir /etc/openvpn/easy-rsa
```

```
cp /usr/share/easy-rsa /etc/openvpn/easy-rsa
```

```
cd /etc/openvpn/easy-rsa
```

```
nano vars
#change export EASY_RSA to
export EASY_RSA="/etc/openvpn/easy-rsa"
#change vars at bottom of file to make it easier later e.g. Country, county, email etc
```

```
source ./vars
```

```
./clean-all
#this will clear all existing certificates use with care
```

```
./build-ca
#when you get to Common Name. This is going to be your [server name] e.g. server1 ... take a note for next steps
```

```
./build-key-server [server name]
#when prompted common name must equal [server name] you entered earlier
#challenge password must be left blank
```

```
./build-key-pass [vpn_username]
#[vpn_username] should be the name of a client you want to connect e.g. client1 take a note as you will need in next steps
#challenge password must be left blank
```

```
cd /etc/openvpn/easy-rsa/keys
```

```
openssl rss -in [vpn_username].key -des3 -out [vpn_username].3des.key
```

```
cd /etc/openvpn/easy/easy-rsa
```

```
./build-dh
```

```
openvpn --genkey --secret keys/ta.key
```

```
wget https://github.com/bicklp/Raspberry-Pi-OVPN-Server/blob/master/server.conf -P /etc/openvpn/
#check server.conf file for local settings. It is commented where you need to fill in your own settings
```

```
nano /etc/sysctl.conf
#uncomment net.ipv4.ip_forward=1
```

```
sysctl -p
```

```
wget https://github.com/bicklp/Raspberry-Pi-OVPN-Server/blob/master/firewall-openvpn-rules.sh -P  /etc
#check file for local settings and LAN name are correct
```



```
nano /etc/network/interfaces
#add line to interfaces file with a tab at the beginning
pre-up /etc/firewall-openvpn-rules.sh
```



```
reboot
```

#Client Setup


```
cd /etc/openvpn/easy-rsa/keys
```

```
wget https://github.com/bicklp/Raspberry-Pi-OVPN-Server/blob/master/Default.txt -P /etc/openvpn/easy-rsa/keys
```

```
nano Default.txt
#Set the Public IP or DDNS name in the Default.txt file
```

```
wget https://github.com/bicklp/Raspberry-Pi-OVPN-Server/blob/master/makeOVPN.sh -P /etc/openvpn/easy-rsa/keys
```

```
chmod 700 makeOVPN.sh
```

```
./makeOVPN.sh
#enter [vpn_username] when prompted
#export the [vpn_username].ovpn file to clients
```

#Add More Clients

```
cd /etc/openvpn/easy-rsa
```

```
source ./vars
```

```
./build-key-pass [vpn_username]
#challenge password must be left blank
```

```
cd /etc/openvpn/easy-rsa/keys
```

```
openssl rss -in [vpn_username].key -des3 -out [vpn_username].3des.key
```

```
./makeOVPN.sh
#enter [vpn_username] when prompted
#export the [vpn_username].ovpn file to clients
```

