# WMS+API

## 部署地址

119.23.129.43

## 部署系统

* manage_sys
* zy_api
* api


## 部署端口

* manage_sys -> 20080
* zy_api -> 10080
* api -> 3000


## 部署路径

* manage_sys

    - 使用walle远程部署
        发布版本库 /data/walle
        web根目录 /var/www/web/manage_sys


* zy_api

    - 使用walle远程部署
        发布版本库 /data/walle
        web根目录 /var/www/web/zy_api


* api

    - 使用pm2远程部署
        路径 /var/www/api


## 系统环境

* Centos 7.3.1611

    > lsb_release -a

    ```shell
    LSB Version:	:core-4.1-amd64:core-4.1-noarch
    Distributor ID:	CentOS
    Description:	CentOS Linux release 7.3.1611 (Core) 
    Release:	7.3.1611
    Codename:	Core

    ```

    > uname -a

    ```shell
    Linux iZwz9gm259t24b0hbnhk33Z 3.10.0-514.21.2.el7.x86_64 #1 SMP Tue Jun 20 12:24:47 UTC 2017 x86_64 x86_64 x86_64 GNU/Linux
    ```

* mysql

    > mysql -V

    ```shell
    mysql  Ver 14.14 Distrib 5.7.19, for Linux (x86_64) using  EditLine wrapper
    ```

* mongodb


* redis


## 配置源

* 安装

    ```shell
    rpm --import http://rpms.famillecollet.com/RPM-GPG-KEY-remi
    rpm -ivh http://rpms.famillecollet.com/enterprise/remi-release-7.rpm
    ```

* 使用

    ```shell
    yum --enablerepo=remi search <keyword>
    yum --enablerepo=remi install <package-name>
    ```

## 安装mysql

### 安装

* 安装源
    https://dev.mysql.com/downloads/repo/yum/选择对应版本的源

    > wget https://repo.mysql.com//mysql57-community-release-el7-11.noarch.rpm

    > sudo rpm -Uvh mysql57-community-release-el7-11.noarch.rpm

* 安装

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

    > systemctl enable mysqld.service


## 安装apache(httpd)

*  安装

    > yum -y install httpd

* 启动

    > service httpd start

* 重启

    > service httpd start

* 停止

    > service httpd stop

* 查看版本

    > httpd -v

    ```shell
    Server version: Apache/2.4.6 (CentOS)
    Server built:   Apr 12 2017 21:03:28

    ```

## 安装nginx

    > yum install nginx


## 安装php

- 指定版本: v5.6

* 源配置

    ```
    rpm -Uvh https://mirror.webtatic.com/yum/el7/epel-release.rpm
    rpm -Uvh https://mirror.webtatic.com/yum/el7/webtatic-release.rpm
    ```

* 安装php5.6

    ```shell
    # yum install --enablerepo=remi --enablerepo=remi-php56 php php-opcache php-devel php-mbstring php-mcrypt php-mysqlnd php-phpunit-PHPUnit php-pecl-xdebug php-pecl-xhprof
    ```

* 查看版本

    > php -v

    ```shell
    PHP 5.6.31 (cli) (built: Jul  7 2017 06:28:10) 
    Copyright (c) 1997-2016 The PHP Group
    Zend Engine v2.6.0, Copyright (c) 1998-2016 Zend Technologies
    ```

* 安装模块

    - gd库

        > yum install php-gd --enablerepo=remi,remi-php56

## 安装mongodb

* 配置源

    > vim /etc/yum.repos.d/mongodb-org-3.4.repo

    新增如下内容

    ```shell
    [mongodb-org-3.4]
    name=MongoDB Repository
    baseurl=https://repo.mongodb.org/yum/redhat/$releasever/mongodb-org/3.4/x86_64/
    gpgcheck=1
    enabled=1
    gpgkey=https://www.mongodb.org/static/pgp/server-3.4.asc
    ```

* 安装

    > yum install -y mongodb-org

## 安装redis

    > yum --enablerepo=remi install redis


## 安装node.js

所需版本: 最新版

* 安装源

    > curl --silent --location https://rpm.nodesource.com/setup_8.x | sudo bash -

* 安装

    > sudo yum -y install nodejs

## 安装pm2

* 使用淘宝源

    > npm install -g cnpm --registry=https://registry.npm.taobao.org

* 安装

    > cnpm install pm2 -g




## 配置


### 配置redis

* 开机启动

    > systemctl enable redis


* 设置redis

    > vim /etc/redis.conf

    增加如下内容

    ```shell
    bind 0.0.0.0
    daemonize yes
    requirepass 密码明文


    ```


### 配置apache(httpd)


* 配置自动重启

    > systemctl enable httpd


* manage_sys

    > vim /etc/httpd/conf.d/manage_sys.conf

    ```
    <VirtualHost *:20080>
        ServerAdmin webmaster@localhost
        DocumentRoot /var/www/web/manage_sys

        ErrorLog logs/manage_sys-error.log
        CustomLog logs/manage_sys-access.log combined
        <Directory "/var/www/web/manage_sys">
                Options  FollowSymLinks
                AllowOverride ALL
                Order allow,deny
                Allow from all
                DirectoryIndex index.html index.php 
        </Directory>
    </VirtualHost>
    # vim: syntax=apache ts=2 sw=2 sts=2 sr noet
    ```

* zy_api

    > vim /etc/httpd/conf.d/zy_api.conf

    ```
    <VirtualHost *:10080>
        ServerAdmin webmaster@localhost
        DocumentRoot /var/www/web/zy_api

        ErrorLog logs/zy_api-error.log
        CustomLog logs/zy_api-access.log combined
        <Directory "/var/www/web/zy_api">
                Options  FollowSymLinks
                AllowOverride ALL
                Order allow,deny
                Allow from all
                DirectoryIndex index.html index.php 
        </Directory>
    </VirtualHost>
    # vim: syntax=apache ts=2 sw=2 sts=2 sr noet
    ```

* 增加监听端口

    > vim /etc/httpd/conf/httpd.conf

    修改默认监听端口
    ```shell
    Listen 30080
    ```

    增加如下监听端口

    ```shell
    Listen 20080
    Listen 10080
    ```

### 配置nginx

* 配置自动重启

    > systemctl enable nginx

* manage_sys

    > vim /etc/nginx/conf.d/manage_sys.conf

    ```
    upstream manage-sys-server{
        server 127.0.0.1:20080 weight=1;
    }

    server {

        listen 80;
        listen [::]:80;

        server_name 119.23.129.43;

        root /var/www/web/manage_sys;

        index index.php index.html index.htm;

        access_log /var/log/nginx/manage_sys-access.log;
        error_log /var/log/nginx/manage_sys-error.log;

        keepalive_timeout  65; 


        # Gzip Compression
        gzip on;
        gzip_comp_level 6;
        gzip_vary on;
        gzip_min_length  1000;
        gzip_proxied any;
        gzip_types text/plain text/css application/json application/x-javascript text/xml application/xml application/xml+rss text/javascript;
        gzip_buffers 16 8k;


        # PHP
        location ~ [^/]\.php(/|$) {
            proxy_set_header  Host $http_host;
            proxy_set_header  X-Real-IP  $remote_addr;
            proxy_set_header  X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_set_header  X-NginX-Proxy true;

            proxy_pass http://manage-sys-server;
        }


        location ~ .*\.(htm|html|gif|jpg|jpeg|png|bmp|swf|ioc|rar|zip|txt|flv|mid|doc|ppt|pdf|xls|mp3|wma)$ { 
            expires 15d;
        }
        
        
        location ~ .*\.(js|css)?$ { 
            expires 1h;
        }

        location ~ /\.ht {
            deny all;
        }
    }
    ```


## walle访问配置

httpd和php都是以apache用户运行，所以walle的配置的用户也为apache

* apache用户设置

    > vim /etc/passwd
    把
    > apache:x:48:48:Apache:/usr/share/httpd:/sbin/nologin
    改为
    > apache:x:48:48:Apache:/usr/share/httpd:/bin/bash

    可知apache的用户目录为/usr/share/httpd

* 建立apache用户的ssh目录

    > mkdir /usr/share/httpd/.ssh

* 修改apache的用户目录所属

    > chown -R apache:apache /usr/share/httpd


* 给apache设置密码

    > passwd apache

* 建立walle所需的目录

    > mkdir -p /data/walle
    > chown -R apache:apache /data/walle

    > mkdir -p /var/www/web
    > chown -R apache:apache /var/www/web

* 在部署walle系统端操作 [注意]

- 切换到walle运行的用户www-data

    > su - www-data

- 把walle运行用户www-data的证书复制到远程要访问的服务器，远程用户是apache

    > ssh-copy-id apache@119.23.129.43

- 测试ssh

    > ssh apache@119.23.129.43


## walle项目配置

walle运行的用户www-data
打开walle管理页面，根据项目配置上线环境

* 代码仓库

    需要walle运行端可访问的git仓库

* 宿主机

    代码检出仓库: /data/walle/deploy 【该路径所属www-data用户】

* 目标机器

    用户: apache
    webroot: /var/www/web
    发布版本库: /data/walle
    机器列表: 119.23.129.43

    webroot和发布版本库必须属于机器列表的apache用户所有

## 部署api

* 参考api的README.md

* 初始化远程目录
    > pm2 deploy ecosystem.config.js release setup

* 部署代码
    > pm2 deploy ecosystem.config.js release

* 设置pm2开机自动启动 [服务器端]
    > pm2 startup centos
    > pm2 save

* 取消开机启动
    > pm2 unstartup centos
