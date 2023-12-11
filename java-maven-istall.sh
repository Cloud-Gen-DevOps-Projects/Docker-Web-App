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


# Maven software donwload
maven_download_link="https://dlcdn.apache.org/maven/maven-3/3.9.6/binaries/apache-maven-3.9.6-bin.tar.gz"
wget -c "$maven_download_link" -p /opt
maven_installation_dir="/opt/maven"
sudo mkdir -p "$maven_installation_dir"
sudo tar -zxvf /opt/tar -xvf apache-maven-3.9.6-bin.tar.gz -C "$maven_download_link"
export M2_HOME="$maven_installation_dir/apache-maven-3.9.6"
export PATH="$PATH:$M2_HOME/bin"

# Make changes permanent by adding them to profile
echo "export JAVA_HOME=$java_installation_dir/jdk-11.0.21" | sudo tee -a /root/.bashrc
echo "export PATH=\$PATH:\$JAVA_HOME/bin" | sudo tee -a /root/.bashrc
echo "export M2_HOME=/opt/Maven" | sudo tee -a /root/.bashrc
echo "export PATH=$PATH:/opt/Maven/bin"  | sudo tee -a /root/.bashrc
# Source the profile to apply changes
source /etc/profile

# Verify Java installation
java -version
mvn --version


