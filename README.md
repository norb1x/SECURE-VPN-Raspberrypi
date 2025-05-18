# VPN Project - OpenVPN Setup on Raspberry Pi

This project demonstrates how to set up an OpenVPN server and client configuration on a Raspberry Pi for secure remote access.

## Project Overview

- **OpenVPN Server** runs on a Raspberry Pi.
- Clients connect securely using certificates and keys.
- VPN allows safe access to your local network from anywhere.

## Files in this Repository

- `client.ovpn` - Example OpenVPN client configuration file (without actual certificates/keys).
- `README.md` - This file with project info and setup instructions.

## How to Use the Client Configuration

Below is an example of the client config file (`client.ovpn`).  
Replace placeholders with your actual server IP address and your real certificates and keys.

```conf
client
dev tun
proto udp
remote YOUR_SERVER_IP 1194            # Replace YOUR_SERVER_IP with your VPN server IP address
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
