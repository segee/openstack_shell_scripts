#!/bin/bash
unset NAME
unset GLOBAL
unset LOCAL

if [ $# -eq 0 ]
then
        source generic_help.sh
        echo
        echo "usage: $0 name_of_machine_to_stop"

        echo
        echo "or"
        echo
        echo "$0 -l local.ip.of.machine"
        echo "e.g., $0 -l 192.168.0.2"
        echo "(local ip is the same as fixed ip in openstack)"
        echo
        echo "or"
        echo
        echo "$0 -g global.ip.of.machine"
        echo "e.g., $0 -g 204.197.12.34"
        echo "(global ip is the same as floating ip in openstack)"
        echo "combining options is generally not helpful"

        echo
        exit 1
fi

if [ $# -eq 1 ]
then
        NAME=$1
else
        while getopts 'l:g:' OPTION; do
                case $OPTION in
                        l)
                                LOCAL=$OPTARG
                                ;;
                        g)
                                GLOBAL=$OPTARG
                esac
        done
fi


# Needs a file called my_password in the local directory
# permissions are set to 000 by default
chmod 400 my_password
source *openrc.sh < my_password
chmod 000 my_password
if [[ -v GLOBAL ]]
then
LOCAL=`/usr/bin/openstack floating ip list -f value --floating-ip-address "$GLOBAL" -c 'Fixed IP Address' `
fi

if [[ -v LOCAL ]]
then
NAME=`/usr/bin/openstack server list -c Name -f value --ip "$LOCAL" `
fi

/usr/bin/openstack server stop $NAME

