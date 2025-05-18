#!/bin/bash

# ------------------------------------------
# OpenVPN Setup Script for Raspberry Pi
# Author: norb1x
# Description:
#   This script installs OpenVPN and sets up
#   all required certificates, config, and copies
#   them to /etc/openvpn automatically.
# ------------------------------------------

echo "🔄 Updating system and installing OpenVPN + Easy-RSA..."
sudo apt update && sudo apt upgrade -y
sudo apt install -y openvpn easy-rsa

# 1. Create a directory for Easy-RSA (used to generate certs)
echo "📁 Creating Easy-RSA working directory..."
make-cadir ~/openvpn-ca
cd ~/openvpn-ca

# 2. Initialize PKI and generate certificates
echo "🛠️ Initializing PKI..."
./easyrsa init-pki

echo "🔐 Building Certificate Authority (CA)..."
./easyrsa build-ca nopass

echo "📄 Creating server certificate request..."
./easyrsa gen-req server nopass

echo "✅ Signing the server certificate..."
./easyrsa sign-req server server

echo "🔑 Generating Diffie-Hellman parameters..."
./easyrsa gen-dh

echo "🔒 Generating static TLS key..."
openvpn --genkey --secret ta.key

# 3. Copy all certs and keys to /etc/openvpn
echo "📦 Copying certs and keys to /etc/openvpn..."
sudo cp pki/ca.crt pki/issued/server.crt pki/private/server.key pki/dh.pem ta.key /etc/openvpn/

# 4. Create a sample OpenVPN server config file
echo "📝 Creating server.conf..."
sudo tee /etc/openvpn/server.conf > /dev/null <<EOF
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
EOF

# 5. Enable and start OpenVPN
echo "🚀 Enabling and starting OpenVPN server..."
sudo systemctl enable openvpn@server
sudo systemctl start openvpn@server

# 6. Final message
echo "✅ VPN server setup complete!"
echo "📌 You can now create client certificates using Easy-RSA."
echo "📌 Make sure port 1194 UDP is open on your router/firewall."


#🧾 How to use
#Save this file as setup-openvpn.sh
#Make it executable:
#bash
#chmod +x setup-openvpn.sh
#Run the script:
#bash
#./setup-openvpn.sh
#That’s it — OpenVPN will be installed, configured, and running on your Raspberry Pi.
#✅ You can now...
#Generate client keys (manually or via another script).
#Transfer the .ovpn config to client devices.
#Use the VPN safely via UDP port 1194.
