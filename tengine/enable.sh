#!/bin/bash

if [[ -f /usr/bin/lsb_release ]]; then
	OS=$(/usr/bin/lsb_release -a |grep Description |awk -F : '{print $2}' |sed 's/^[ \t]*//g')
else 
	OS=$(cat /etc/issue |sed -n '1p')
fi


function ubuntu_copy() {
	echo 'copy conf.d files to etc/nginx/conf.d/ ...'
	sudo cp -r conf.d/* /etc/nginx/conf.d/
	echo 'restart nginx ...'
	sudo service nginx restart
}

echo $OS

if [[ $OS =~ "Ubuntu" ]]; then
	ubuntu_copy
fi
