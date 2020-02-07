#!/bin/sh


  if [ -f /etc/redhat-release ]; then
    yum update

    which virtualbox
    if [ $? = '0' ]; then
      echo "VIRTUALBOX ALREADY INSTALLED"
    else
      echo "--------- INSTALLING VIRTUALBOX ----------"
      sudo yum install –y patch gcc kernel-headers kernel-devel make perl wget
      sudo wget http://download.virtualbox.org/virtualbox/rpm/el/virtualbox.repo -P /etc/yum.repos.d
      sudo yum install VirtualBox-6.0
    fi

    which vagrant
    if [ $? = '0' ]; then
      echo "VAGRANT ALREADY INSTALLED"
    else
      echo "--------- INSTALLING VAGRANT ----------"
      sudo yum install https://releases.hashicorp.com/vagrant/2.2.6/vagrant_2.2.6_x86_64.rpm
      vagrant --version
    fi

    which ansible
    if [ $? = '0' ]; then
      echo "ANSIBLE ALREADY INSTALLED"
    else
      echo "--------- INSTALLING ANSIBLE ----------"
      sudo yum install ansible
    fi
    vagrant up
    vagrant ssh k8s-master

  elif [ -f /etc/lsb-release ]; then
    apt-get update

    which virtualbox
    if [ $? = '0' ]; then
      echo "VIRTUALBOX ALREADY INSTALLED"
    else  
      echo "--------- INSTALLING VIRTUALBOX ----------"
      sudo apt install virtualbox
    fi
    
    which vagrant
    if [ $? = '0' ]; then
      echo "VAGRANT ALREADY INSTALLED"
    else
      echo "--------- INSTALLING VAGRANT ----------"
      curl -O https://releases.hashicorp.com/vagrant/2.2.6/vagrant_2.2.6_x86_64.deb
      sudo apt install ./vagrant_2.2.6_x86_64.deb
      vagrant --version
    fi

    which ansible
    if [ $? = '0' ]; then
      echo "ANSIBLE ALREADY INSTALLED"
    else
      sudo apt update
      echo "--------- INSTALLING ANSIBLE ----------"
      sudo apt install software-properties-common
      sudo apt-add-repository --yes --update ppa:ansible/ansible
      sudo apt install ansible
    fi
    vagrant up
    vagrant ssh k8s-master

  else  
    echo 'WARN: Could not detect distro or distro unsupported'
  fi
