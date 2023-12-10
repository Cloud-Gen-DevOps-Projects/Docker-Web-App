#!/bin/bash

# Update the system
sudo yum -y update

# Install wget if not installed (to download Java)
sudo yum -y install wget

# Install Tar
sudo yum -y install tar


# Install unzip
sudo yum -y install unzip



# Install make
sudo yum -y install make


# Install vim
sudo yum -y install vim


# Install fontconfig
sudo yum -y install fontconfig



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

# Update the system
#sudo yum -y update

# Install wget if not installed (to download Maven)
#sudo yum -y install wget

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

source ~/.bashrc
clear

java -version
mvn --version




