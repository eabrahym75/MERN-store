#!/bin/bash

sudo apt update -y
sudo apt install nginx npm nodejs -y
sudo systemctl start nginx 
sudo systemctl enable nginx 

sudo npm i -g pm2
