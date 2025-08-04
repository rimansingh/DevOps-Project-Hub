#!/bin/bash
set -e

# Update system
echo "Updating system..."
sudo apt-get update
sudo apt-get upgrade -y

# Install required packages
echo "Installing required packages..."
sudo apt-get install -y software-properties-common
sudo apt-get install -y python3
sudo apt-get install -y ansible

# Install Java
echo "Installing Java..."
sudo apt-get install -y default-jdk

# Install Jenkins
echo "Installing Jenkins..."
wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -
sudo sh -c 'echo deb https://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
sudo apt-get update
sudo apt-get install -y jenkins

# Start Jenkins
echo "Starting Jenkins..."
sudo systemctl start jenkins
sudo systemctl enable jenkins

echo "Setup complete!"