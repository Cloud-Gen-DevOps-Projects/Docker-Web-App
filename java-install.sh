#!/bin/bash

# Update system
sudo yum update -y

# Install OpenJDK 11
sudo yum install -y java-11-openjdk-devel

# Find the installed OpenJDK directory
jdk_directory=$(dirname $(dirname $(readlink -f $(which javac))))

# Check Java version
java -version

# Set JAVA_HOME environment variable
echo "export JAVA_HOME=$jdk_directory" >> ~/.bashrc

# Add Java bin directory to the PATH
echo "export PATH=\$PATH:\$JAVA_HOME/bin" >> ~/.bashrc

# Update current session with new environment variables
source ~/.bashrc

echo "OpenJDK 11 installation and configuration complete."

