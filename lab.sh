#!/bin/bash

# Update system
sudo apt-get update
sudo apt-get upgrade

# Install necessary packages
sudo apt-get install -y curl openssh-server ca-certificates perl
sudo apt-get install -y postfix

# Add GitLab package repository
curl https://packages.gitlab.com/install/repositories/gitlab/gitlab-ee/script.deb.sh | sudo bash

# Install GitLab
sudo EXTERNAL_URL="https://gitlab.example.com" apt-get install gitlab-ee

# List available versions
apt-cache madison gitlab-ee

# Specify version
# sudo EXTERNAL_URL="https://gitlab.example.com" apt-get install gitlab-ee=16.2.3-ee.0

# Pin the version to limit auto-updates
# sudo apt-mark hold gitlab-ee

# Show what packages are held back
# sudo apt-mark showhold
