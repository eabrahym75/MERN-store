#!/bin/bash
sudo apt-get update
sudo apt-get install git -y

echo "--INSTALL NVM TO USE A SPECIFIC NODE VERSION--"
sudo apt-get install curl
sudo curl https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" 
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

nvm install 18

echo "-----PM2------"
sudo npm install -g pm2
sudo pm2 startup systemd

echo "-----NGINX------"
sudo apt-get install nginx -y

echo "---FIREWALL---"
sudo ufw allow OpenSSH
sudo ufw allow 'Nginx Full'
sudo ufw --force enable 


