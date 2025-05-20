# OpenVPN Server on Raspberry Pi - Setup Guide

This guide walks you through installing and configuring OpenVPN on a Raspberry Pi.
'
## 1. Install OpenVPN

```bash
sudo apt update
sudo apt install openvpn easy-rsa -y
```
## Step 2: Configure Easy-RSA and Generate Keys

# make-cadir ~/openvpn-ca
# cd ~/openvpn-ca
# ./easyrsa init-pki
# ./easyrsa build-ca nopass
# ./easyrsa gen-req server nopass
# ./easyrsa sign-req server server
# ./easyrsa gen-dh
# openvpn --genkey --secret ta.key


## Step 3: Configure OpenVPN Server

Copy the certificates and keys to /etc/openvpn
Create the server config file /etc/openvpn/server.conf (example below):
```
port 1194
proto udp
dev tun
ca ca.crt
cert server.crt
key server.key
dh dh.pem
tls-auth ta.key 0
cipher AES-256-CBC
keepalive 10 120
persist-key
persist-tun
status openvpn-status.log
verb 3
```

## Step 4: Start OpenVPN Server

# sudo systemctl start openvpn@server
# sudo systemctl enable openvpn@server
# you can also check it with sudo systemctl status openvpn@server if it's running
## Step 5: Create Client Configuration

Sample client file client.ovpn:
```conf
client
dev tun
proto udp
remote YOUR_SERVER_IP 1194
resolv-retry infinite
nobind
persist-key
persist-tun
remote-cert-tls server
cipher AES-256-CBC
verb 3

<ca>
# Insert your CA certificate here
</ca>

<cert>
# Insert your client certificate here
</cert>

<key>
# Insert your client key here
</key>

<tls-auth>
# Insert your ta.key file here
</tls-auth>
```

## Step 6: Connect Client to VPN

Copy client.ovpn to the client device
Use OpenVPN client software to connect

## Additional Notes:
 * UDP port 1194 must be open on your firewall and router

 * Keep your keys and certificates secure and never share them publicly

 * If you don’t have a static IP, consider using dynamic DNS services like No-IP

## Troubleshooting
* If connection fails, check if the server is running and port is open

* Check OpenVPN logs on the server (/var/log/syslog or journalctl -u openvpn@server)

* Make sure certificates and keys are correctly generated and configured


## Good luck with your OpenVPN Raspberry Pi setup!
