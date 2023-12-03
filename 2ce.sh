#!/bin/bash

# Update system
sudo apt-get update
sudo apt-get upgrade

# Install necessary packages
sudo apt-get install -y curl openssh-server ca-certificates perl
sudo apt-get install -y postfix

# Add GitLab package repository
curl https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.deb.sh | sudo bash

# Install GitLab CE version 16.4.3
sudo EXTERNAL_URL="https://gitlab.example.com" apt-get install gitlab-ce=16.4.3-ce.0

# Pin the version to limit auto-updates
sudo apt-mark hold gitlab-ce

# Show what packages are held back
sudo apt-mark showhold

# Create a basic .gitlab-ci.yml file
echo "stages:" > .gitlab-ci.yml
echo "  - build" >> .gitlab-ci.yml
echo "  - test" >> .gitlab-ci.yml
echo "" >> .gitlab-ci.yml
echo "build_job:" >> .gitlab-ci.yml
echo "  stage: build" >> .gitlab-ci.yml
echo "  script: echo \"Building the app\"" >> .gitlab-ci.yml
echo "" >> .gitlab-ci.yml
echo "test_job:" >> .gitlab-ci.yml
echo "  stage: test" >> .gitlab-ci.yml
echo "  script: echo \"Testing the app\"" >> .gitlab-ci.yml

# Get the server's public IP address
IP_ADDRESS=$(curl -s ifconfig.me)

# Create a document with login instructions
echo "GitLab has been installed on your server." > ~/Documents/gitlab_instructions.txt
echo "" >> ~/Documents/gitlab_instructions.txt
echo "You can access the GitLab web interface at the following URL:" >> ~/Documents/gitlab_instructions.txt
echo "http://$IP_ADDRESS" >> ~/Documents/gitlab_instructions.txt
echo "" >> ~/Documents/gitlab_instructions.txt
echo "The default username is 'root'. During the first visit, you'll be redirected to a password reset screen to provide the password for the initial administrator account." >> ~/Documents/gitlab_instructions.txt
