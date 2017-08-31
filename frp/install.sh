#!/bin/bash


ConfigDir=/etc/frp
Bin=/usr/bin
Log=/var/log/frp
Debug=

function GetOS() {
	if [[ -f /usr/bin/lsb_release ]]; then
		echo $(/usr/bin/lsb_release -a | grep Description | awk -F : '{print $2}' | sed 's/^[ \t]*//g')
	else 
		echo "exit"
		exit 1
	fi
}

function SetOSParam() {
	# $1 系统类型
	if [[ $1 =~ "Ubuntu" ]]; then
		Supervisord=/etc/supervisor/conf.d
	elif [[ $1 =~ "CentOS" ]]; then
		Supervisord=/etc/supervisord.d
	else
		exit 1
	fi
}


function install-server () {
    echo "Copy frps.ini to $ConfigDir..."
    $Debug sudo mkdir -p $ConfigDir
    $Debug sudo cp ./server/frps.ini $ConfigDir
    echo "Copy frps to $Bin..."
    $Debug sudo cp ./server/frps $Bin
    echo "Copy supervisord frps.conf to $Supervisord..."
    $Debug sudo cp ./server/supervisor/frps.conf $Supervisord
    echo "Create $Log"
    $Debug sudo mkdir -p $Log
}


function install-client () {
    echo "Copy frpc.ini to $ConfigDir..."
    $Debug sudo mkdir -p $ConfigDir
    $Debug sudo cp ./client/frpc.ini $ConfigDir
    echo "Copy frpc to $Bin..."
    $Debug sudo cp ./client/frpc $Bin
    echo "Copy supervisord frpc.conf to $Supervisord..."
    $Debug sudo cp ./client/supervisor/frpc.conf $Supervisord
    echo "Create $Log"
    $Debug sudo mkdir -p $Log
}


function main() {

    os=$(GetOS)
    SetOSParam $os

    if [ "$2" == "-d" ]; then
        Debug=echo
        echo "Remove -d exit debug mode"
    fi

    if [ "$1" == "server" ]; then
        install-server
    elif [ "$1" == "client" ]; then
        install-client
    else
        echo "$0 server [-d] install frp server -d use for debug"
        echo "$0 client [-d] install frp client -d use for debug"
    fi
}

main $1 $2