#!/bin/bash

#  sudo apt-get install python-openstackclient


# Needs a file called my_password in the local directory
# permissions are set to 000 by default
chmod 400 my_password
source *openrc.sh < my_password
chmod 000 my_password
/usr/bin/openstack server list -f value -c Name -c Status 


