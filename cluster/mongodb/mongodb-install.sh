#!/bin/bash

function ubuntu_install() {
    sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 0C49F3730359A14518585931BC711F9BA15703C6
    echo "deb [ arch=amd64,arm64 ] http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.4 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.4.list
    sudo apt-get update
    sudo apt-get install mongodb-org
}


function centos_install() {
    cat <<EOF | sudo tee /etc/yum.repos.d/mongodb-org-3.4.repo
[mongodb-org-3.4]
name=MongoDB Repository
baseurl=https://repo.mongodb.org/yum/redhat/$releasever/mongodb-org/3.4/x86_64/
gpgcheck=1
enabled=1
gpgkey=https://www.mongodb.org/static/pgp/server-3.4.asc
EOF
    sudo yum update
    sudo yum install -y mongodb-org
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
        ubuntu_install
	elif [[ $1 =~ "Centos" ]]; then
		centos_install
	else
		exit 1
	fi
}

os=$(GetOS)
main $os