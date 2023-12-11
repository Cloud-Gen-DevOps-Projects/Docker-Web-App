#!/bin/bash

# URL to download Java software
java_download_link="http://clouddevops.in/softwares/jdk-11.0.21_linux-x64_bin.tar.gz"

# Directory where Java will be installed
java_installation_dir="/opt/java"

# Download Java software
wget -c "$java_download_link" -P /opt

# Create directory for Java installation
sudo mkdir -p "$java_installation_dir"

# Extract Java software to installation directory
sudo tar -zxvf /opt/jdk-11.0.21_linux-x64_bin.tar.gz -C "$java_installation_dir"

# Set Java environment variables
export JAVA_HOME="$java_installation_dir/jdk-11.0.21"
export PATH="$PATH:$JAVA_HOME/bin"

# Make changes permanent by adding them to profile
echo "export JAVA_HOME=$java_installation_dir/jdk-11.0.21" | sudo tee -a /etc/profile
echo "export PATH=\$PATH:\$JAVA_HOME/bin" | sudo tee -a /etc/profile

# Source the profile to apply changes
source /etc/profile

cat <<EOF | sudo tee /root/.bashrc
export JAVA_HOME=/opt/java/jdk-11.0.21
export PATH=$PATH:/opt/java/jdk-11.0.21/bin

export M2_HOME=/opt/Maven
export PATH=$PATH:/opt/Maven/bin
EOF

# Verify Java installation
java -version

