#!/bin/bash

# Function to check SSH key configuration
check_ssh_key() {
    if [ -f ~/.ssh/id_rsa.pub ]; then
        echo "SSH key exists."
    else
        echo "SSH key doesn't exist. Generating a new SSH key..."
        ssh-keygen -t rsa -b 4096 -f ~/.ssh/id_rsa -N ""
        echo "SSH key generated."
    fi

    # Attempt to copy the SSH key to the server
    ssh-copy-id -i ~/.ssh/id_rsa user@192.168.67.147

    # Check if the SSH connection is successful after copying the key
    ssh -o "BatchMode=yes" user@192.168.67.147 "echo 'SSH connection successful!'"
}

# Function to check permissions on server
check_permissions() {
    echo "Checking permissions on the server..."
    ssh user@192.168.67.147 "ls -la ~/.ssh; ls -la /etc/sudoers; groups user"
}

# Function to perform verbose SSH connection test
ssh_verbose_test() {
    echo "Performing verbose SSH connection test to 192.168.67.147..."
    ssh -vvv user@192.168.67.147
}

# Execute functions
check_ssh_key
check_permissions
ssh_verbose_test

