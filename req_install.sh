#!/bin/bash

# Update the package list
sudo apt-get update
sudo apt-get upgrade -y

# Install required softwares
sudo apt-get install mysql-client -y
sudo apt-get install awscli -y

