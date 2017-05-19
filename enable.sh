#!/bin/bash

if [[ -f /usr/bin/lsb_release ]]; then 
OS=$(/usr/bin/lsb_release -a |grep Description |awk -F : '{print $2}' |sed 's/^[ \t]*//g')
else 
OS=$(cat /etc/issue |sed -n '1p') 
fi


function ubuntu_copy(){
	sudo cp -r apache2/* /etc/apache2/

	# sudo rm -rf /etc/apache2/conf-enabled/010-web.conf
	# sudo ln -s /etc/apache2/conf-available/010-web.conf /etc/apache2/conf-enabled/010-web.conf

	sudo rm -rf /etc/apache2/sites-enabled/010-web.conf
	sudo ln -s /etc/apache2/sites-available/010-web.conf /etc/apache2/sites-enabled/010-web.conf


	sudo cp -r nginx/* /etc/nginx/

	sudo service apache2 restart
	sudo service nginx restart
}

if [[ $OS =~ "Ubuntu" ]]; then
	ubuntu_copy()
fi