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

# Set sudo privileges for root user
#set_sudo_privileges() {
#   for ip in "${!servers[@]}"
#  do
#        ssh root@"$ip" "usermod -aG sudo root"
#        echo "Sudo privileges set for root on $ip"
#    done
#
#    # Set local DNS in /etc/hosts on the controller
#    echo -e "192.168.67.132 node1\n192.168.67.148 node2\n192.168.67.144 node3\n192.168.67.145 node4" >> /etc/hosts
#    echo "Local DNS set in /etc/hosts on the controller"
#}

# Function to set local DNS in /etc/hosts on the controller
set_local_dns() {
    echo -e "192.168.67.132 node1\n192.168.67.148 node2\n192.168.67.144 node3\n192.168.67.145 node4" | sudo tee -a /etc/hosts >/dev/null
    echo "Local DNS set in /etc/hosts on the controller"
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


# Create Ansible inventory with role-based groups
create_ansible_inventory() {
    echo "[nodes]" > /etc/ansible/hosts

    for ip in "${!servers[@]}"
    do
        echo "${servers[$ip]}" >> /etc/ansible/hosts
    done

    echo "" >> /etc/ansible/hosts
    echo "[test]" >> /etc/ansible/hosts
    echo "node1" >> /etc/ansible/hosts
    echo "192.168.67.132" >> /etc/ansible/hosts

    echo "" >> /etc/ansible/hosts
    echo "[db]" >> /etc/ansible/hosts
    echo "node2" >> /etc/ansible/hosts
    echo "192.168.67.148" >> /etc/ansible/hosts

    echo "" >> /etc/ansible/hosts
    echo "[app]" >> /etc/ansible/hosts
    echo "node3" >> /etc/ansible/hosts
    echo "192.168.67.144" >> /etc/ansible/hosts
    
    echo "" >> /etc/ansible/hosts
    echo "[http]" >> /etc/ansible/hosts
    echo "node4" >> /etc/ansible/hosts
    echo "192.168.67.145" >> /etc/ansible/hosts

    echo "Ansible inventory created  with host names and IP Addresses at /etc/ansible/hosts"
    
}

# Execute functions
set_hostnames
set_sudo_privileges
set_local_dns
generate_and_share_sshkey
install_epel_controller
install_ansible
create_ansible_inventory
