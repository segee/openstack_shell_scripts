#!/bin/bash
if [ $# -eq 0 ]
then
	source generic_help.sh
	echo
	echo "usage: $0 name_of_machine"
	echo 'This command launches a console session to the'
	echo 'specified machine in a google chrome browser'
	echo
	exit 1
fi




#  sudo apt-get install python-openstackclient


# Needs a file called my_password in the local directory
# permissions are set to 000 by default
chmod 400 my_password
source *openrc.sh < my_password
chmod 000 my_password
url=`/usr/bin/openstack console url show -f value -c url "$1" `
google-chrome $url &
#echo $URL


