#!/bin/bash
wget https://github.com/prometheus/node_exporter/releases/download/v1.4.0/node_exporter-1.4.0.linux-amd64.tar.gz
tar xvf node_exporter-1.4.0.linux-amd64.tar.gz
cd node_exporter-1.4.0.linux-amd64
sudo cp node_exporter /usr/local/bin
# Exit current directory
cd ..

# Remove the extracted directory
rm -rf ./node_exporter-1.4.0.linux-amd64

useradd --no-create-home --shell /bin/false node_exporter

chown node_exporter:node_exporter /usr/local/bin/node_exporter

echo '[Unit]
Description=Node Exporter
Wants=network-online.target
After=network-online.target

[Service]
User=node_exporter
Group=node_exporter
Type=simple
ExecStart=/usr/local/bin/node_exporter --collector.systemd --collector.processes

[Install]
WantedBy=multi-user.target' > /etc/systemd/system/node_exporter.service

systemctl daemon-reload
systemctl enable node_exporter
systemctl start node_exporter