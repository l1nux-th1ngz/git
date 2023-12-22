#!/bin/bash

# Update the package lists for upgrades and new package installations
sudo apt-get update

# Install git
sudo apt-get install -y git

# Create a git user
sudo adduser git

# Create a directory for the repositories
sudo mkdir /home/git/git-server-repos
cd /home/git/git-server-repos

# Initialize a new bare repository
sudo git init --bare my-project.git

# Change ownership of the repository
sudo chown -R git:git my-project.git

# Copy the post-update sample hook
cd my-project.git/hooks
sudo cp post-update.sample post-update
sudo chmod a+x post-update

# Change ownership of the repositories directory
sudo chown -R git:git /home/git/git-server-repos
