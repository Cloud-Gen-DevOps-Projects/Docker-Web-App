#!/bin/bash

# Set hostname function
set_hostnames() {
    declare -A hosts=(
        ["192.168.67.132"]="node1"
        ["192.168.67.148"]="node2"
        ["192.168.67.144"]="node3"
        ["192.168.67.145"]="node4"
        # Add more IP addresses and corresponding names if needed
    )

    for ip in "${!hosts[@]}"
    do
        ssh root@"$ip" "hostnamectl set-hostname ${hosts[$ip]}"
        echo "Hostname set for $ip as ${hosts[$ip]}"
    done
}

# Execute function
set_hostnames

