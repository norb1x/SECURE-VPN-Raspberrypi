# Raspberry Pi OpenVPN Project

This project demonstrates how to set up a secure OpenVPN server on a Raspberry Pi, enabling encrypted remote access to your home or private network.

---

## Project Overview

- **OpenVPN server** runs on a Raspberry Pi device.  
- Clients connect securely using certificates and keys.  
- VPN provides safe access to your local network from anywhere, protecting data privacy and security.

---

## Repository Contents

- `client.ovpn` – Example OpenVPN client configuration file (without real certificates and keys for security).  
- `README.md` – This file with project description and setup instructions.

---

## Client Configuration Example

Replace placeholders with your actual server IP and certificates before use:

```conf
client
dev tun
proto udp
remote YOUR_SERVER_IP 1194            # Replace with your VPN server IP address
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
