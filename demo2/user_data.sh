#! /bin/bash 
# The user_data script is the script that will run on the EC2 instance at provisioning


# Install Node and npm
sudo apt update
sudo apt install npm -y

# Bootstrap Hello-World-App
mkdir /data

cd /data
git clone https://github.com/jerry-hall/SRE-Intro-BCS-Hacks-2021
cd SRE-Intro-BCS-Hacks-2021/hello-world-app

sudo npm i
sudo node server.js
