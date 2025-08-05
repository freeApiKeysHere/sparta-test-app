#!/bin/bash

echo "Updating package list..."
sudo DEBIAN_FRONTEND=noninteractive apt-get update -y
echo "Done."
echo

echo "Upgrading packages..."
sudo DEBIAN_FRONTEND=noninteractive apt-get upgrade -y
echo "Done."
echo

echo "Importing MongoDB public key..."
curl -fsSL https://www.mongodb.org/static/pgp/server-7.0.asc | \
   sudo gpg --dearmor -o /usr/share/keyrings/mongodb-server-7.0.gpg
echo "Key imported."
echo

echo "Creating MongoDB repo source list..."
echo "deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-server-7.0.gpg ] https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/7.0 multiverse" | \
   sudo tee /etc/apt/sources.list.d/mongodb-org-7.0.list
echo "Repo added."
echo

echo "Updating package list with MongoDB repo..."
sudo DEBIAN_FRONTEND=noninteractive apt-get update -y
echo "Done."
echo

echo "Installing MongoDB 7.0 components..."
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y \
   mongodb-org=7.0.22 \
   mongodb-org-database=7.0.22 \
   mongodb-org-server=7.0.22 \
   mongodb-mongosh \
   mongodb-org-shell=7.0.22 \
   mongodb-org-mongos=7.0.22 \
   mongodb-org-tools=7.0.22 \
   mongodb-org-database-tools-extra=7.0.22
echo "MongoDB installed."
echo

echo "Configuring mongod to listen on all interfaces..."
sudo sed -i 's/bindIp: 127.0.0.1/bindIp: 0.0.0.0/' /etc/mongod.conf
echo "bindIp updated."
echo

echo "Starting and enabling MongoDB service..."
sudo systemctl start mongod
sudo systemctl enable mongod
sudo systemctl restart mongod
echo "MongoDB is running and enabled on boot."
echo
