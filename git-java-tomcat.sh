#!/bin/bash

# Software Versions
TOMCAT_VERSION="9.0.84"

# Software URLs
TOMCAT_URL="https://dlcdn.apache.org/tomcat/tomcat-9/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz"

# Update system and install necessary tools
hostnamectl set-hostname appserver

# Stop firewall
sudo systemctl stop firewalld
sudo yum install java-11-openjdk-devel -y

# Install Git

# Set up Java environment
mv /usr/lib/jvm/java-11* /usr/lib/jvm/java-11
JAVA_HOME_LINE="export JAVA_HOME=/usr/lib/jvm/java-11"
PATH_LINE="export PATH=\$PATH:/usr/lib/jvm/java-11-openjdk/bin"

# Check if the lines already exist in the .bashrc file
if grep -Fxq "$JAVA_HOME_LINE" ~/.bashrc && grep -Fxq "$PATH_LINE" ~/.bashrc; then
    echo "Lines already exist in ~/.bashrc"
else
    echo -e "\n# Setting Java environment variables" >> ~/.bashrc
    echo "$JAVA_HOME_LINE" >> ~/.bashrc
    echo "$PATH_LINE" >> ~/.bashrc
    echo "Lines added to ~/.bashrc"
fi
source ~/.bashrc

# Install and configure Tomcat
function check_java_home {
    if [ -z ${JAVA_HOME} ]; then
        echo 'Could not find JAVA_HOME. Please install Java and set JAVA_HOME'
        exit
    else
        echo 'JAVA_HOME found: '$JAVA_HOME
        if [ ! -e ${JAVA_HOME} ]; then
            echo 'Invalid JAVA_HOME. Make sure your JAVA_HOME path exists'
            exit
        fi
    fi
}
source ~/.bashrc

echo 'Installing tomcat server...'
echo 'Checking for JAVA_HOME...'
check_java_home

echo 'Downloading tomcat-9.0...'
if [ ! -f /etc/apache-tomcat-${TOMCAT_VERSION}.tar.gz ]; then
    curl -O "$TOMCAT_URL"
fi
echo 'Finished downloading...'

echo 'Creating install directories...'
sudo mkdir -p '/opt/tomcat/9_0'

if [ -d "/opt/tomcat/9_0" ]; then
    echo 'Extracting binaries to install directory...'
    sudo tar xzf apache-tomcat-${TOMCAT_VERSION}.tar.gz -C "/opt/tomcat/9_0" --strip-components=1
    echo 'Creating tomcat user group...'
    sudo groupadd tomcat
    sudo useradd -s /bin/false -g tomcat -d /opt/tomcat tomcat

    echo 'Setting file permissions...'
    cd "/opt/tomcat/9_0"
    sudo chgrp -R tomcat "/opt/tomcat/9_0"
    sudo chmod -R g+r conf
    sudo chmod -R g+x conf
    sudo chmod -R g+w conf  # Consider security implications, comment this out for production

    sudo chown -R tomcat webapps/ work/ temp/ logs/

    # Set up Tomcat service
    echo 'Setting up tomcat service...'
    sudo tee /etc/systemd/system/tomcat.service > /dev/null <<EOT
[Unit]
Description=Apache Tomcat Web Application Container
After=network.target

[Service]
Type=forking
Environment=JAVA_HOME=$JAVA_HOME
Environment=CATALINA_PID=/opt/tomcat/9_0/temp/tomcat.pid
Environment=CATALINA_HOME=/opt/tomcat/9_0
Environment=CATALINA_BASE=/opt/tomcat/9_0
Environment=CATALINA_OPTS=-Xms512M -Xmx1024M -server -XX:+UseParallelGC
Environment=JAVA_OPTS=-Djava.awt.headless=true -Djava.security.egd=file:/dev/./urandom
ExecStart=/opt/tomcat/9_0/bin/startup.sh
ExecStop=/opt/tomcat/9_0/bin/shutdown.sh
User=tomcat
Group=tomcat
UMask=0007
RestartSec=10
Restart=always

[Install]
WantedBy=multi-user.target
EOT

sudo systemctl daemon-reload

    # Modify context.xml for Tomcat Manager to allow from any IP address
    sudo bash -c 'cat << EOF > /opt/tomcat/9_0/webapps/manager/META-INF/context.xml
<Context antiResourceLocking="false" privileged="true" >
    <Valve className="org.apache.catalina.valves.RemoteAddrValve" allow=".*" deny=""/>
</Context>
EOF'

    echo 'Tomcat Service Starting'
    sudo systemctl status tomcat
    echo 'Tomcat Server Enabling '
    sudo systemctl enable tomcat
    exit
else
    echo 'Could not locate installation directory..exiting..'
    exit
fi

systemctl status tomcat

java -version

