#!/bin/bash
# sudo echo never > /sys/kernel/mm/transparent_hugepage/enabled
# sudo echo never> /sys/kernel/mm/transparent_hugepage/defrag

ReplSetName=DataCenter
ReplSetKeyfile=mongod-$ReplSetName.key
ConfigName=mongodb
ConfigDir=/etc/$ConfigName
Systemd=/lib/systemd/system


function GetOS() {
	if [[ -f /usr/bin/lsb_release ]]; then
		echo $(/usr/bin/lsb_release -a | grep Description | awk -F : '{print $2}' | sed 's/^[ \t]*//g')
	else 
		echo "exit"
		exit 1
	fi
}


function GenKeyfile() {
	# $1 目录
	# $2 文件名
	if [ ! -d $1 ];then
		mkdir $1
	fi
	if [ ! -f ./$1/$2 ] ;then
		openssl rand -base64 756 > ./$1/$2
		chmod 400 ./$1/$2
		echo "Gen the keyFile ./$1/$2"
	fi
}


function SetOSParam() {
	# $1 系统类型
	if [[ $1 =~ "Ubuntu" ]]; then
		user=mongodb
		group=mongodb
		dbPath=/var/lib/mongodb
		bin=/bin
	elif [[ $1 =~ "CentOS" ]]; then
		user=mongod
		group=mongod
		dbPath=/var/lib/mongo
		bin=/usr/bin
	else
		exit 1
	fi
}


function GenFiles() {
	# $1 系统类型
	# $2 目录
	# $3 文件名
	# $4 端口号
	# $5 keyFile
	if [ ! -d $2 ];then
		mkdir $2
	fi

cat <<EOF | tee $2/$3.conf
# mongod-$4.conf

# for documentation of all options, see:
#   http://docs.mongodb.org/manual/reference/configuration-options/

# Where and how to store data.
storage:
  dbPath: $dbPath/$4
  journal:
    enabled: true
#  engine:
#  mmapv1:
#  wiredTiger:

# where to write logging data.
systemLog:
  destination: file
  logAppend: true
  path: /var/log/mongodb/mongod-$4.log

# network interfaces
net:
  port: $4
  # bindIp: 127.0.0.1


processManagement:
  # fork: true  # fork and run in background
  pidFilePath: /var/run/mongodb/mongod-$4.pid  # location of pidfile



security:
  clusterAuthMode: keyFile
  keyFile: $ConfigDir/$5
  transitionToAuth: true
  authorization: enabled

#operationProfiling:

replication:
   replSetName: $ReplSetName

#sharding:

## Enterprise-Only Options:

#auditLog:

#snmp:
EOF


cat <<EOF | tee $2/$3.service
[Unit]
Description=High-performance, schema-free document-oriented database, Replica Set mode
After=network.target
Documentation=https://docs.mongodb.org/manual

[Service]
User=$user
Group=$group
ExecStart=/usr/bin/mongod --config $ConfigDir/$3.conf
ExecStartPre=$bin/mkdir -p /var/run/mongodb
ExecStartPre=$bin/chown $user:$group /var/run/mongodb
ExecStartPre=$bin/chmod 0755 /var/run/mongodb
ExecStartPre=$bin/mkdir -p $dbPath/$4
ExecStartPre=$bin/chown $user:$group $dbPath/$4
ExecStartPre=$bin/chmod 0755 $dbPath/$4
PermissionsStartOnly=true
PIDFile=/var/run/mongodb/mongod-$4.pid
# file size
LimitFSIZE=infinity
# cpu time
LimitCPU=infinity
# virtual memory size
LimitAS=infinity
# open files
LimitNOFILE=64000
# processes/threads
LimitNPROC=64000
# total threads (user+kernel)
TasksMax=infinity
TasksAccounting=false

# Recommended limits for for mongod as specified in
# http://docs.mongodb.org/manual/reference/ulimit/#recommended-settings

[Install]
WantedBy=multi-user.target

EOF
}


function GenUninstallShell() {
	# $1 目录
	# $2 端口
	# $3 Service
	if [ ! -f "uninstall.sh" ];then
cat << EOF > uninstall.sh	
#!/bin/bash

rm -rf uninstall.sh

echo "Delete $ConfigDir"
sudo rm -rf $ConfigDir

echo "Stop $3"
sudo systemctl stop $3
echo "Disable $3"
sudo systemctl disable $3
echo "Delete $Systemd/$3"
sudo rm -rf $Systemd/$3
echo "Delete $dbPath/$2"
sudo rm -rf $dbPath/$2
echo "Delete /var/log/mongodb/mongod-$2.log"
sudo rm -rf /var/log/mongodb/mongod-$2.log
EOF
	else
cat << EOF >> uninstall.sh	

echo "Stop $3"
sudo systemctl stop $3
echo "Disable $3"
sudo systemctl disable $3
echo "Delete $Systemd/$3"
sudo rm -rf $Systemd/$3
echo "Delete $dbPath/$2"
sudo rm -rf $dbPath/$2
echo "Delete /var/log/mongodb/mongod-$2.log"
sudo rm -rf /var/log/mongodb/mongod-$2.log
EOF
	fi
	chmod +x uninstall.sh
}


function Enable() {
	echo "Copy $ConfigName to $ConfigDir..."
	sudo mkdir -p $ConfigDir/
	
	sudo cp -p $ConfigName/*.conf $ConfigDir/
	sudo cp -p $ConfigName/*.key $ConfigDir/
	sudo chown $user:$group $ConfigDir/*.key
	
	enabled=()
	for file in ./$ConfigName/*
	do
		if [ "${file##*.}" == "service" ];then
			while true; do
				read -p "Do you wish to start ${file##*/}? y/n " yn
				case $yn in
					[Yy]* ) 
						echo "Copy ${file##*/} to $Systemd"
						sudo cp $file $Systemd
						echo "Enable ${file##*/}"
						sudo systemctl enable ${file##*/}
						echo "Start ${file##*/}"
						sudo systemctl restart ${file##*/}
						enabled[${#enabled[*]}]=${file##*/}
						break;;
					[Nn]* ) 
						echo "Disable ${file##*/}"
						break;;
					* ) echo "Please answer yes or no.";;
				esac
			done
		fi
	done

	for enable in ${enabled[*]}
	do
		sudo systemctl status $enable
	done	
}


function main() {
	os=$(GetOS)
	SetOSParam $os
	if [ "$1" == "" ];then
		read -p "Please input the mongod service port? port:" port
	elif [ "$1" == "-k" ];then
		GenKeyfile $ConfigName $ReplSetKeyfile
		exit 0
	elif [ "$1" == "-e" ];then
		Enable
		exit 0
	fi

	if [ ! -f $ConfigName/*.conf ];then
		rm -rf uninstall.sh
	fi

	port=$1
	if [ "$port" == "n" ]; then
			echo "canceled"
			exit 1
	fi
	GenKeyfile $ConfigName $ReplSetKeyfile
	echo "Mongodb group:$group user:$user"
	GenFiles "$os" $ConfigName mongod-$port $port $ReplSetKeyfile
	GenUninstallShell $ConfigName $port mongod-$port.service
}


main $1