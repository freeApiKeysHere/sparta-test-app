#!/bin/bash

# Provision Sparta test app

echo "Updating package list..."
sudo DEBIAN_FRONTEND=noninteractive apt-get update -y
echo "Package list updated."
echo

echo "Upgrading packages..."
sudo DEBIAN_FRONTEND=noninteractive apt-get upgrade -y
echo "Upgrade complete."
echo

echo "Installing Nginx..."
sudo DEBIAN_FRONTEND=noninteractive apt-get install nginx -y
echo "Nginx installed."
echo

# (Optional) You can configure Nginx reverse proxy here, if needed.
sudo sed -i '/^\s*#*\s*try_files/ {
s/^\s*#*\s*/        # /
a\        proxy_pass http://localhost:3000;
}' /etc/nginx/sites-available/default



echo "Installing Node.js v20..."
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y nodejs
echo "Node.js version: $(node -v)"
echo

echo "Installing PM2 globally..."
sudo npm install -g pm2
echo "PM2 installed."
echo

echo "Cloning Sparta test app..."
git clone https://github.com/freeApiKeysHere/sparta-test-app.git ~/repo
echo "Repo cloned."
echo

echo "Setting up environment..."
cd ~/repo/app
export DB_HOST=mongodb://172.31.24.228:27017/posts
echo "Environment variable DB_HOST set."
echo

echo "Installing app dependencies..."
npm install --no-fund --no-audit
echo "Dependencies installed."
echo

echo "Stopping app"
pm2 stop all
echo

echo "Starting app using PM2..."
pm2 start app.js --name sparta-app
pm2 save
pm2 startup | tail -n 1 | bash  # Ensure the PM2 startup command is executed
echo "App started with PM2."
echo

echo "Public IP address:"
curl -s http://checkip.amazonaws.com
echo
