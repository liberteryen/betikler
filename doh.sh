cd /dev/shm ; wget -c https://github.com/AdguardTeam/dnsproxy/releases/download/v0.75.6/dnsproxy-linux-amd64-v0.75.6.tar.gz ; tar -xvf dnsproxy-linux-amd64-v0.75.6.tar.gz ; mv linux-amd64/dnsproxy /bin/ ; chmod +x /bin/dnsproxy
echo -e "194.242.2.3\tadblock.dns.mullvad.net" | sudo tee -a /etc/hosts > /dev/null
sudo systemctl disable systemd-resolved
sudo systemctl stop systemd-resolved
sudo systemctl mask systemd-resolved

cat << 'EOF' > /etc/systemd/system/doh.service
[Unit]
Description=DNS Proxy Service using dnsproxy
After=network.target

[Service]
Type=simple
ExecStart=/bin/dnsproxy -u https://adblock.dns.mullvad.net/dns-query -p 53 -l 127.0.0.1 --http3
User=root
KillSignal=SIGKILL
Restart=always
RestartSec=1

[Install]
WantedBy=multi-user.target
EOF
rm -rf /etc/resolv.conf
echo "nameserver 127.0.0.1" > /etc/resolv.conf
chattr +i  /etc/resolv.conf

sudo systemctl start doh
sudo systemctl enable doh