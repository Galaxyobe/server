# Walle

## 安装


## ssh设置

使用apache运行php程序
在ubuntu 16.04中，walle提到的php进程用户是www-data

1、修改www-data用户可登陆

> $ sudo vim /etc/passwd

修改

> www-data:x:33:33:www-data:/var/www:/usr/sbin/nologin

为

> www-data:x:33:33:www-data:/var/www:/bin/bash

2、设置www-data的密码

因为用www-data会请求密码

切换到root用户

> $ su

修改www-data的密码

> # passwd www-data

3、生成ssh key

> # su - www-data

> $ ssh-keygen -t rsa

> $ eval `ssh-agent`

> ssh-add

设置www-data用户可以访问远程计算机的php进程用户

> $ ssh-copy-id 用户名@远程地址
