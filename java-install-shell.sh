#!/bin/bash

# Update the system
sudo yum -y update

# Install wget if not installed (to download Java)
sudo yum -y install wget

# Download Java (adjust the version and download link as needed)
wget http://clouddevops.in/jdk-11.0.21_linux-x64_bin.tar.gz

# Extract Java to /opt
sudo tar -xvf jdk-11.0.21_linux-x64_bin.tar.gz
# Rename the JDK File
sudo mv /opt/jdk-11.0.21 /opt/java

# Set environment variables for Java (add these lines to your .bashrc)
echo "export JAVA_HOME=/opt/java" >> ~/.bashrc
echo "export PATH=\$JAVA_HOME/bin:\$PATH" >> ~/.bashrc

# Load the updated environment variables
source ~/.bashrc

# Verify Java installation
java -version

