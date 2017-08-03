# Squid

## 资源

* [Squid中文权威指南](http://zyan.cc/book/squid/index.html)

## 安装

> $ sudo apt-get install squid

## 运行

### 检查配置

> $ sudo squid -k parse

### 初始化cache目录

> $ sudo squid -z

### 前台运行

> $ sudo squid -N -d1

### 作为服务进程运行

> sudo squid -s


### 停止运行

> sudo squid -k shutdown

### 重新加载配置

> sudo squid -k reconfigure

### 滚动日志文件

cron命令
```shell
0 4 * * * /usr/local/squid/sbin/squid -k rotate
```



## 常用配置

```shell
# 用户名密码配置
# 在http_access deny all 上面加上如下权限配置 
# centos
# auth_param basic program /usr/lib64/squid/basic_ncsa_auth /etc/squid/passwd
# ubuntu
auth_param basic program /usr/lib/squid/basic_ncsa_auth /etc/squid/passwd
acl auth_user proxy_auth REQUIRED  
http_access allow auth_user 
  
# 高匿配置  
  
request_header_access X-Forwarded-For deny all  
request_header_access From deny all  
request_header_access Via deny all  
```

### 生成密码

### Ubuntu
```shell
sudo htpasswd  -c /etc/squid/passwd [username]
```

### Centos
在httpd/bin下
```shell
sudo ./htpasswd  -c /etc/squid/passwd [username]
```

