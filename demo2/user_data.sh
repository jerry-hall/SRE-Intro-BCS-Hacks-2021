#! /bin/bash 
# The user_data script is the script that will run on the EC2 instance at provisioning


# Install Node and npm
curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
sudo apt install nodejs -y
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

nvm install node


# Bootstrap Hello-World-App
mkdir /data

cd /data
git clone https://github.com/jerry-hall/SRE-Intro-BCS-Hacks-2021
cd SRE-Intro-BCS-Hacks-2021/hello-world-app

sudo npm i
sudo npm server.js

# Faster way to install on Ubuntu is below. Note, I used the long way to illustrate frustrating deployment
# without automation

# sudo apt update
# sudo apt install nodejs npm -y