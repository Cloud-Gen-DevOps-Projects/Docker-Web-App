#!/bin/bash

# Define server details
declare -A servers=(
    ["192.168.67.132"]="node1"
    ["192.168.67.148"]="node2"
    ["192.168.67.144"]="node3"
    ["192.168.67.145"]="node4"
    ["192.168.67.147"]="controller"
)

# Set hostnames for all servers
set_hostnames() {
    for ip in "${!servers[@]}"
    do
        ssh root@"$ip" "hostnamectl set-hostname ${servers[$ip]}"
        echo "Hostname set for $ip as ${servers[$ip]}"
    done
}

# Generate SSH key and share with all servers
generate_and_share_sshkey() {
    if [ ! -f ~/.ssh/id_rsa.pub ]; then
        ssh-keygen -t rsa -b 4096 -f ~/.ssh/id_rsa -N ""
        echo "SSH key generated"
    fi

    for ip in "${!servers[@]}"
    do
        ssh-copy-id -i ~/.ssh/id_rsa root@"$ip"
        echo "SSH key shared to $ip"
    done
}

# Install EPEL repository on the controller
install_epel_controller() {
    ssh root@192.168.67.147 "yum install -y epel-release"
    echo "EPEL repository installed on the controller"
}

# Install Ansible only on the controller
install_ansible() {
    ssh root@192.168.67.147 "yum install -y ansible"
    echo "Ansible installed on the controller"
}

# Execute functions
set_hostnames
generate_and_share_sshkey
install_epel_controller
install_ansible

