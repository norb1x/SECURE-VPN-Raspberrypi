#!/bin/bash
# Basic OpenVPN install script

sudo apt update && sudo apt upgrade -y
sudo apt install openvpn easy-rsa -y

echo "Installation complete."
