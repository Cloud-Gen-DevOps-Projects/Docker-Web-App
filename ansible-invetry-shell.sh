#!/bin/bash

# Define server details
declare -A servers=(
    ["192.168.67.132"]="node1"
    ["192.168.67.148"]="node2"
    ["192.168.67.144"]="node3"
    ["192.168.67.145"]="node4"
)

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

    echo "" >> /etc/ansible/hosts
    echo "[db]" >> /etc/ansible/hosts
    echo "node2" >> /etc/ansible/hosts

    echo "" >> /etc/ansible/hosts
    echo "[app]" >> /etc/ansible/hosts
    echo "node3" >> /etc/ansible/hosts

    echo "" >> /etc/ansible/hosts
    echo "[http]" >> /etc/ansible/hosts
    echo "node4" >> /etc/ansible/hosts

    echo "Ansible inventory created at /etc/ansible/hosts"
}

# Execute function
create_ansible_inventory

