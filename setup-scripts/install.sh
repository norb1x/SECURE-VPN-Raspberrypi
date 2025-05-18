#!/bin/bash

# ------------------------------------------
# OpenVPN Setup Script for Raspberry Pi
# Author: norb1x
# Description:
#   This script installs OpenVPN and sets up
#   all the certificate infrastructure needed
#   to run a working and secure VPN server.
# ------------------------------------------

# 1. Update system and install OpenVPN + Easy-RSA (used for key generation)
echo "🔄 Updating system and installing OpenVPN + Easy-RSA..."
sudo apt update && sudo apt upgrade -y
sudo apt install -y openvpn easy-rsa

# 2. Create a working directory for certificates
echo "📁 Creating working directory for certificates (~/openvpn-ca)..."
make-cadir ~/openvpn-ca
cd ~/openvpn-ca

# 3. Initialize the Public Key Infrastructure (PKI)
echo "🛠️ Initializing PKI..."
./easyrsa init-pki

# 4. Build the Certificate Authority (CA) – signs all other certs
echo "🔐 Creating Certificate Authority (CA)..."
./easyrsa build-ca nopass

# 5. Generate certificate request for the VPN server
echo "📄 Creating server certificate request..."
./easyrsa gen-req server nopass

# 6. Sign the server certificate with your CA
echo "✅ Signing server certificate with CA..."
./easyrsa sign-req server server

# 7. Generate Diffie-Hellman parameters (for key exchange)
echo "🔑 Generating Diffie-Hellman parameters..."
./easyrsa gen-dh

# 8. Generate a static TLS key for extra security
echo "🔒 Generating static TLS key..."
openvpn --genkey --secret ta.key

# 9. Done!
echo "✅ Setup complete! Your VPN certificates and keys are ready."
echo "👉 Next step: Copy them to /etc/openvpn/ and configure server.conf"
