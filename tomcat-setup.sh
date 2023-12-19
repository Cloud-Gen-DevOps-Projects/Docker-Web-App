#!/bin/bash

# Define Tomcat version and download URL
tomcat_version="9.0.84"
tomcat_download_url="https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.84/bin/apache-tomcat-9.0.84.tar.gz"

# Update system
sudo yum update -y

# Download and extract Tomcat
cd /opt || exit
sudo wget "$tomcat_download_url"
sudo tar -zxvf apache-tomcat-"$tomcat_version".tar.gz
sudo mv apache-tomcat-"$tomcat_version" tomcat
sudo rm apache-tomcat-"$tomcat_version".tar.gz

# Modify context.xml for Tomcat Manager to allow from any IP address
sudo bash -c 'cat << EOF > /opt/tomcat/webapps/manager/META-INF/context.xml
<Context antiResourceLocking="false" privileged="true" >
    <Valve className="org.apache.catalina.valves.RemoteAddrValve" allow=".*" deny=""/>
</Context>
EOF'

# Create Tomcat service file
sudo bash -c 'cat << "EOF" > /etc/systemd/system/tomcat.service
[Unit]
Description=Apache Tomcat Web Application Container
After=syslog.target network.target

[Service]
Type=forking

Environment=JAVA_HOME=/path/to/your/java_home
Environment=CATALINA_HOME=/opt/tomcat
Environment=CATALINA_BASE=/opt/tomcat
Environment='CATALINA_OPTS=-Xms512M -Xmx1024M -server -XX:+UseParallelGC'

ExecStart=/opt/tomcat/bin/startup.sh
ExecStop=/opt/tomcat/bin/shutdown.sh

User=<your_username>
Group=<your_groupname>

[Install]
WantedBy=multi-user.target
EOF'
# Reload systemd manager configuration
sudo systemctl daemon-reload

# Start and enable Tomcat service
sudo systemctl start tomcat
sudo systemctl enable tomcat

echo "Apache Tomcat $tomcat_version installation and configuration complete."

