# bibi321

## 部署地址

112.74.171.99


## 部署系统

* bibi321

## 部署路径

* bibi321

    - 使用walle远程部署
        发布版本库 /data/walle
        web根目录 /var/www/web/bibi321

## 目录权限配置

查看httpd的运行用户

    > cat /etc/httpd/conf/httpd.conf

* bibi321

    > sudo mkdir -p /var/www/web/bibi321
    > sudo chown -R apache:apache /var/www/web/bibi321


## 版本需求

* httpd Apache/2.4.3

* php php5



## 系统环境

* CentOS release 6.9 (Final)

    > lsb_release -a

    ```shell
    LSB Version:	:base-4.0-amd64:base-4.0-noarch:core-4.0-amd64:core-4.0-noarch
    Distributor ID:	CentOS
    Description:	CentOS release 6.9 (Final)
    Release:	6.9
    Codename:	Final
    ```

    > uname -a

    ```shell
    Linux iZwz9c880z2row9qs4i5g3Z 2.6.32-696.13.2.el6.x86_64 #1 SMP Thu Oct 5 21:22:16 UTC 2017 x86_64 x86_64 x86_64 GNU/Linux
    ```

* mysql

    > mysql -V

    ```shell
    mysql  Ver 14.14 Distrib 5.6.26, for Linux (x86_64) using  EditLine wrapper
    ```

* mongodb

* php

    > php -v

    ```shell
    PHP 5.4.45 (cli) (built: Feb 18 2017 15:55:26) 
    Copyright (c) 1997-2014 The PHP Group
    Zend Engine v2.4.0, Copyright (c) 1998-2014 Zend Technologies
    ```

## 1. 配置源

* 安装

    ```shell
    rpm --import http://rpms.famillecollet.com/RPM-GPG-KEY-remi
    rpm -ivh http://rpms.famillecollet.com/enterprise/remi-release-6.rpm
    ```

* 使用

    ```shell
    yum --enablerepo=remi search <keyword>
    yum --enablerepo=remi install <package-name>
    ```

## 2. 安装

### 1. 安装apache(httpd)

 1. 下载源码

    ```
    yum -y groupinstall  "Development tools"
    yum groupinstall 'Server Platform Development'
    yum -y install pcre-devel openssl-devel
    wget http://mirrors.hust.edu.cn/apache//httpd/httpd-2.4.29.tar.gz
    wget http://mirrors.tuna.tsinghua.edu.cn/apache//apr/apr-1.6.3.tar.gz
    wget http://mirrors.tuna.tsinghua.edu.cn/apache//apr/apr-util-1.6.1.tar.gz
    wget https://nchc.dl.sourceforge.net/project/expat/expat/2.2.5/expat-2.2.5.tar.bz2
    ```

 1. 解压

    ```
    tar xf httpd-2.4.29.tar.gz
    tar xf apr-1.6.3.tar.gz
    tar xf apr-util-1.6.1.tar.gz
    tar xf expat-2.2.5.tar.bz2
    ```
 1. 整合

    ```
    mv apr-1.6.3 httpd-2.4.29/srclib/apr
    mv apr-util-1.6.1 httpd-2.4.29/srclib/apr-util
    ```

 1. 编译安装

    ```
    cd expat-2.2.5
    ./configure
    make && make install
    ```

    ```
    ./configure --enable-so --enable-ssl --enable-cgi --enable-rewrite --with-zlib --with-pcre --with-included-apr --enable-modules=most --enable-mpms-shared=all --with-mpm=prefork--enable-mpms-shared=all --with-mpm=prefork
    make -j 4 && make install
    ```
 1. 开机启动

    > cp /usr/local/apache2/bin/apachectl /etc/rc.d/init.d/httpd

    > vim /etc/rc.d/init.d/httpd

    在#!/bin/sh 下面加上

    ```
    #chkconfig: 2345 10 90
    #description: Activates/Deactivates Apache Web Server
    ```

    > chkconfig --add httpd

    > chkconfig httpd on

 1. 添加到PATH

     > echo 'export PATH=/usr/local/apache2/bin:$PATH' > /etc/profile.d/httpd.sh

     > source /etc/profile


## 3. 配置

### 1. 配置apache(httpd)


* 配置自动重启

    > systemctl enable httpd

* 拒绝访问根目录

    > vim /etc/httpd/conf/httpd.conf

    修改如下：
    ```
    ServerName localhost:86

    ErrorLog "| /usr/sbin/rotatelogs /var/log/httpd/error_log-%Y%m%d 86400 0"
    CustomLog "| /usr/sbin/rotatelogs /var/log/httpd/access_log-%Y%m%d 86400 0" common
    ```


* bibi321

    > vim /etc/httpd/conf/httpd-vhosts.conf

    添加
    ```
    <VirtualHost *:86>
        ServerAdmin webmaster@localhost
        DocumentRoot /var/www/web/bibi321

        ErrorLog "| /usr/sbin/rotatelogs /var/log/httpd/bibi321-error-%Y%m%d.log 86400 0"
        CustomLog "| /usr/sbin/rotatelogs /var/log/httpd/bibi321-access-%Y%m%d.log 86400 0" common


        DirectoryIndex index.php 
        <Directory "/var/www/web/bibi321">
            Options Indexes FollowSymLinks ExecCGI Includes
            AllowOverride All
            Require all granted
        </Directory>
    </VirtualHost>
    ```

* 增加监听端口

    > vim /etc/httpd/conf/httpd.conf

    监听端口
    ```shell
    Listen 86
    ```