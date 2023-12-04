#!/bin/bash

# Update system
sudo apt-get update
sudo apt-get upgrade

# Install necessary packages
sudo apt-get install apt-transport-https ca-certificates curl gnupg lsb-release zenity

# Add Docker package repository
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io

# Install Docker Compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Get user information
USER_INFO=$(zenity --forms --title="User Information" \
    --text="Enter user information" \
    --add-entry="Username" \
    --add-password="Password" \
    --add-entry="Domain")

# Parse user information
USERNAME=$(echo $USER_INFO | cut -d'|' -f1)
PASSWORD=$(echo $USER_INFO | cut -d'|' -f2)
DOMAIN=$(echo $USER_INFO | cut -d'|' -f3)

# Setup Gitea
mkdir -p /var/lib/gitea
docker run -d --name=gitea -p 10022:22 -p 10080:3000 -v /var/lib/gitea:/data gitea/gitea:latest
GITEA_IP=$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' gitea)

# Save IP addresses and directions to a document
echo "Gitea is hosted at: $GITEA_IP:10080" > ~/Documents/selfhosted_gits

# Create a document with user information
echo "Username: $USERNAME" > ~/Documents/user_info.txt
echo "Password: $PASSWORD" >> ~/Documents/user_info.txt
echo "Domain: $DOMAIN" >> ~/Documents/user_info.txt
echo "" >> ~/Documents/user_info.txt
echo "Please save this file in a different location (example: a cloud service, a different computer, external drive, USB)." >> ~/Documents/user_info.txt
