#!/bin/bash

# Install Java 11
sudo yum install -y java-11-openjdk-devel

# Download and install Jenkins
sudo wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat/jenkins.io.key
sudo yum install -y jenkins

# Start Jenkins service
sudo systemctl start jenkins

# Wait for Jenkins to start up
echo "Waiting for Jenkins to start..."
until $(curl --output /dev/null --silent --head --fail http://localhost:8080); do
    printf '.'
    sleep 5
done

echo "Jenkins has started."

# Fetch initial admin password
echo "Fetching initial admin password..."
JENKINS_HOME=/var/lib/jenkins
INITIAL_ADMIN_PASSWORD=$(sudo cat $JENKINS_HOME/secrets/initialAdminPassword)

echo "Initial admin password: $INITIAL_ADMIN_PASSWORD"

# Create admin user and set password using Jenkins CLI
echo "Creating admin user..."

# Download Jenkins CLI jar
wget -O jenkins-cli.jar http://localhost:8080/jnlpJars/jenkins-cli.jar

# Create user and set password using Jenkins CLI
java -jar jenkins-cli.jar -s http://localhost:8080/ -auth admin:$INITIAL_ADMIN_PASSWORD create-user new_admin 

# Install plugins using Jenkins CLI
java -jar jenkins-cli.jar -s http://localhost:8080/ -auth admin:$INITIAL_ADMIN_PASSWORD install-plugin \
git github-branch-source workflow-aggregator credentials-binding junit email-ext docker-workflow \
pipeline-utility-steps ssh-agent matrix-auth maven-plugin htmlpublisher pipeline-github-lib \
sonar ws-cleanup blueocean ansible artifactory kubernetes role-strategy

# Restart Jenkins to apply changes
sudo systemctl restart jenkins

echo "Jenkins installation, user setup, and plugin installation complete."

