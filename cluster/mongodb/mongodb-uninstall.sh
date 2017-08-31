#!/bin/bash

function ubuntu_uninstall() {
    sudo systemctl stop mongod
    sudo apt-get purge mongodb-org*
    sudo rm -r /var/log/mongodb
    sudo rm -r /var/lib/mongodb
}


function centos_uninstall() {
    sudo systemctl stop mongod
    sudo yum erase $(rpm -qa | grep mongodb-org)
    sudo rm -r /var/log/mongodb
    sudo rm -r /var/lib/mongo
}


function GetOS() {
	if [[ -f lsb_release ]]; then
		echo $(lsb_release -a | grep Description | awk -F : '{print $2}' | sed 's/^[ \t]*//g')
	else 
		echo $(cat /etc/issue | sed -n '1p')
	fi
}


function main() {
	# $1 系统类型
	if [[ $1 =~ "Ubuntu" ]]; then
        ubuntu_uninstall
	elif [[ $1 =~ "Centos" ]]; then
		centos_uninstall
	else
		exit 1
	fi
}

os=$(GetOS)
main $os