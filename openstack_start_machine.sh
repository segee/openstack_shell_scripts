#!/bin/bash
if [ $# -eq 0 ]
then
	source generic_help.sh
	echo
	echo "usage: $0 name_of_machine_to_start"
	echo
	exit 1
fi




#  sudo apt-get install python-openstackclient


# Needs a file called my_password in the local directory
# permissions are set to 000 by default
chmod 400 my_password
source *openrc.sh < my_password
chmod 000 my_password
openstack server unshelve $1
openstack server start $1

