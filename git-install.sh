#!/bin/bash

# Software Versions
GIT_VERSION="2.43.0"

# Software URLs
GIT_URL="https://mirrors.edge.kernel.org/pub/software/scm/git/git-${GIT_VERSION}.tar.gz"

# Update system and install necessary tools
hostnamectl set-hostname appserver
yum install wget tar make unzip vim curl-devel expat-devel gettext-devel openssl-devel zlib-devel gcc perl-ExtUtils-MakeMaker java-11-openjdk-devel -y
cd /opt
wget "$GIT_URL"
tar -xvf "git-${GIT_VERSION}.tar.gz"
cd "git-${GIT_VERSION}"
make prefix=/usr/local/git all
make prefix=/usr/local/git install
GIT_LINE='export PATH=$PATH:/usr/local/git/bin'
echo "$GIT_LINE" >> ~/.bashrc
source ~/.bashrc
git --version
source ~/.bashrc
git --version

