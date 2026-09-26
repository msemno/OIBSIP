#!/usr/bin/env bash
set -euo pipefail

echo "[+] Resetting UFW rules"
sudo ufw --force reset

echo "[+] Setting default policies"
sudo ufw default deny incoming
sudo ufw default allow outgoing

echo "[+] Allowing SSH on port 22"
sudo ufw allow ssh

echo "[+] Denying HTTP on port 80"
sudo ufw deny http

echo "[+] Allowing HTTPS on port 443"
sudo ufw allow https

echo "[+] Denying Telnet on port 23"
sudo ufw deny 23/tcp

echo "[+] Enabling UFW"
sudo ufw --force enable

echo "[+] Final UFW status"
sudo ufw status verbose
