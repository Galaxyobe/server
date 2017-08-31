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


function IsEmptyDir(){ 
    return `ls -A $1|wc -w`
}

function uninstall-server () {
    if [ -d $ConfigDir ]; then
        echo "Delete frps.ini from $ConfigDir..."
        if IsEmptyDir $ConfigDir
        then
            $Debug sudo rm -rf $ConfigDir/frps.ini
        else
            $Debug sudo rm -rf $ConfigDir
        fi
    fi
    echo "Delete frps from $Bin..."
    $Debug sudo rm -rf $Bin/frps
    echo "Delete supervisord frps.conf from $Supervisord..."
    $Debug sudo rm -rf $Supervisord/frps.conf
    if [ -d $Log ]; then
        echo "Delete $Log"
        if IsEmptyDir $Log
        then
            $Debug sudo rm -rf $Log/frps.log
        else
            $Debug sudo rm -rf $ConfigDir
        fi
    fi
}


function uninstall-client () {
    if [ -d $ConfigDir ]; then
        echo "Delete frpc.ini from $ConfigDir..."
        if IsEmptyDir $ConfigDir
        then
            $Debug sudo rm -rf $ConfigDir/frpc.ini
        else
            $Debug sudo rm -rf $ConfigDir
        fi
    fi
    echo "Delete frpc from $Bin..."
    $Debug sudo rm -rf $Bin/frpc
    echo "Delete supervisord frpc.conf from $Supervisord..."
    $Debug sudo rm -rf $Supervisord/frpc.conf

    if [ -d $Log ]; then
        echo "Delete $Log"
        if IsEmptyDir $Log
        then
            $Debug sudo rm -rf $Log/frpc.log
        else
            $Debug sudo rm -rf $ConfigDir
        fi
    fi
}


function help() {
    echo "$0 server [-d] uninstall frp server -d use for debug"
    echo "$0 client [-d] uninstall frp client -d use for debug"  
}

function main() {

    os=$(GetOS)
    SetOSParam $os

    if [ "$2" == "-d" ]; then
        Debug=echo
        echo "Remove -d exit debug mode"
    fi

    if [ "$1" == "server" ]; then
        uninstall-server
    elif [ "$1" == "client" ]; then
        uninstall-client
    elif [ "$1" == "-h" ]; then
        help
    elif [ "$1" == "help" ]; then
        help
    else
        help
    fi
}

main $1 $2