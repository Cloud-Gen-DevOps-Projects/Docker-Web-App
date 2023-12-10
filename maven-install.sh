#!/bin/bash

# Update the system
sudo yum -y update

# Install wget if not installed (to download Maven)
sudo yum -y install wget

# Download Maven 3.6.9
wget https://dlcdn.apache.org/maven/maven-3/3.9.6/binaries/apache-maven-3.9.6-bin.tar.gz
# Extract Maven to /opt
sudo tar -xvf apache-maven-3.9.6-bin.tar.gz
sudo mv /opt/apache-maven-3.9.6 /opt/maven

# Set environment variables for Maven (add these lines to your .bashrc)
echo "export MAVEN_HOME=/opt/maven" >> ~/.bashrc
echo "export PATH=\$MAVEN_HOME/bin:\$PATH" >> ~/.bashrc

# Load the updated environment variables
source ~/.bashrc

# Verify Maven installation
mvn -version

