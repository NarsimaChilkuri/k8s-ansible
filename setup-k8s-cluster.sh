#!/bin/sh


  if [ -f /etc/redhat-release ]; then
    yum update
    echo "--------- INSTALLING VIRTUALBOX ----------"
    sudo yum install –y patch gcc kernel-headers kernel-devel make perl wget
    sudo wget http://download.virtualbox.org/virtualbox/rpm/el/virtualbox.repo -P /etc/yum.repos.d
    sudo yum install VirtualBox-6.0
    echo "--------- INSTALLING VAGRANT ----------"
    sudo yum install https://releases.hashicorp.com/vagrant/2.2.6/vagrant_2.2.6_x86_64.rpm
    vagrant --version
    echo "--------- INSTALLING ANSIBLE ----------"
    sudo yum install ansible
    vagrant up
    vagrant ssh k8s-master
  elif [ -f /etc/lsb-release ]; then
    apt-get update
    echo "--------- INSTALLING VIRTUALBOX ----------"
    sudo apt install virtualbox
    echo "--------- INSTALLING VAGRANT ----------"
    curl -O https://releases.hashicorp.com/vagrant/2.2.6/vagrant_2.2.6_x86_64.deb
    sudo apt install ./vagrant_2.2.6_x86_64.deb
    vagrant --version
    sudo apt update
    echo "--------- INSTALLING ANSIBLE ----------"
    sudo apt install software-properties-common
    sudo apt-add-repository --yes --update ppa:ansible/ansible
    sudo apt install ansible
    vagrant up
    vagrant ssh k8s-master
  else  
    echo 'WARN: Could not detect distro or distro unsupported'
    echo 'WARN: Trying to install ansible via pip without some dependencies'
    echo 'WARN: Not all functionality of ansible may be available'
  fi
