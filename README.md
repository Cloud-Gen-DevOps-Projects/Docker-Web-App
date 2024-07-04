# Docker-Web-App

# App Stream repos for Docker Centos Container
  * sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-*
  * sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*

# for converting Linux Minmal GUI 
 * yum update -y
 * dnf groupinstall "Server with GUI" -y
# to set default GUI Run Level
 * systemctl set-default graphical.target
 * reboot
# to check present using run level 
 * runlevel 
