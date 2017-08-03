# 服务器部署


## 系统环境

* Centos 6.8 (aliyun)

> lsb_release -a

```shell
LSB Version:	:base-4.0-amd64:base-4.0-noarch:core-4.0-amd64:core-4.0-noarch
Distributor ID:	CentOS
Description:	CentOS release 6.8 (Final)
Release:	6.8
Codename:	Final
```

> uname -a

```shell
Linux iZwz9gm259t24b0hbnhk33Z 2.6.32-642.13.1.el6.x86_64 #1 SMP Wed Jan 11 20:56:24 UTC 2017 x86_64 x86_64 x86_64 GNU/Linux
```


## 安装最新版mysql

### 安装mysql源

下载系统对应版本的源 https://dev.mysql.com/downloads/repo/yum/

> wget https://repo.mysql.com//mysql57-community-release-el6-11.noarch.rpm

> sudo rpm -Uvh mysql57-community-release-el6-11.noarch.rpm

### 安装

> sudo yum install mysql-community-server

* 启动

> sudo service mysqld start

### 修改密码

* 查看密码

> sudo grep 'temporary password' /var/log/mysqld.log

* 修改密码

> mysql -u root -p

> mysql> ALTER USER 'root'@'localhost' IDENTIFIED BY 'MyNewPass4!';

### 设置开机启动

> chkconfig --add mysqld

## 安装apache(httpd)

### 安装

> yum -y install httpd

* 启动

> service httpd start

* 重启

> service httpd start

* 停止

> service httpd stop

版本

> httpd -v

```shell
Server version: Apache/2.2.15 (Unix)
Server built:   Mar 22 2017 06:52:55
```


### 简单的配置示例

```shell
<VirtualHost *:80>
	ServerAdmin webmaster@localhost
	DocumentRoot /var/www/web

	ErrorLog logs/wms-error.log
	CustomLog logs/wms-access.log combined
	<Directory "/var/www/web">
      		Options  FollowSymLinks
        	AllowOverride ALL
        	Order allow,deny
        	Allow from all
    	</Directory>
</VirtualHost>

# vim: syntax=apache ts=4 sw=4 sts=4 sr noet
```



## 安装php

### 配置源

CentOS 6.5的epel及remi源

```shell
# rpm -Uvh http://ftp.iij.ad.jp/pub/linux/fedora/epel/6/x86_64/epel-release-6-8.noarch.rpm
# rpm -Uvh http://rpms.famillecollet.com/enterprise/remi-release-6.rpm
```

安装

```shell
# yum install --enablerepo=remi --enablerepo=remi-php56 php php-opcache php-devel php-mbstring php-mcrypt php-mysqlnd php-phpunit-PHPUnit php-pecl-xdebug php-pecl-xhprof
```

版本

> php -v

```shell
PHP 5.6.30 (cli) (built: Jan 19 2017 08:09:42) 
Copyright (c) 1997-2016 The PHP Group
Zend Engine v2.6.0, Copyright (c) 1998-2016 Zend Technologies
    with Zend OPcache v7.0.6-dev, Copyright (c) 1999-2016, by Zend Technologies
    with Xdebug v2.5.4, Copyright (c) 2002-2017, by Derick Rethans
```

### 安装模块

* gd库

> yum install php-gd --enablerepo=remi,remi-php56



## 安装mysql (源安装) 旧版本

### 安装

> yum install -y mysql-server mysql mysql-deve

> mysql --version

```shell
mysql  Ver 14.14 Distrib 5.1.73, for redhat-linux-gnu (x86_64) using readline 5.1
```

### 设置密码

> /etc/init.d/mysqld stop

> mysqld_safe --user=mysql --skip-grant-tables --skip-networking &

> mysql -u root mysql

```shell
mysql> UPDATE user SET Password=PASSWORD('newpassword') where USER='root';   
mysql> FLUSH PRIVILEGES;   
mysql> quit  
```

> /etc/init.d/mysqld restart

测试

> mysql -uroot -p

