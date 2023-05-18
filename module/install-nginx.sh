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

mkdir actions-runner && cd actions-runner
curl -o actions-runner-linux-x64-2.304.0.tar.gz -L https://github.com/actions/runner/releases/download/v2.304.0/actions-runner-linux-x64-2.304.0.tar.gz
echo "292e8770bdeafca135c2c06cd5426f9dda49a775568f45fcc25cc2b576afc12f  actions-runner-linux-x64-2.304.0.tar.gz" | shasum -a 256 -c
tar xzf ./actions-runner-linux-x64-2.304.0.tar.gz
./config.sh --url https://github.com/eabrahym75/MERN-store --token AQXF3TWXJA76FUBLDBUV4CLEMZVDM

sudo pm2 delete react-build || true
pm2 run build
pm2 serve build/ 3000 -f --name "react-build" --spa
sudo systemctl restart nginx
