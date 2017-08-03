# Tinyproxy

CentOS and Red Hat Enterprise Linux 5.x
```
wget https://dl.fedoraproject.org/pub/epel/epel-release-latest-5.noarch.rpm
sudo rpm -Uvh epel-release-5*.rpm
```
CentOS and Red Hat Enterprise Linux 6.x
```
wget https://dl.fedoraproject.org/pub/epel/epel-release-latest-6.noarch.rpm
sudo rpm -Uvh epel-release-6*.rpm
```
CentOS and Red Hat Enterprise Linux 7.x
```
wget https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
sudo rpm -Uvh epel-release-latest-7*.rpm
```

## 安装tinyproxy
yum install tinyproxy


## 启动Tinyproxy服务，并设置开机自启

service tinyproxy restart
chkconfig --level 345 tinyproxy on

#centos7如下设置:
systemctl restart  tinyproxy.service
systemctl enable tinyproxy.service


## 防火墙开放8888端口
iptables -I INPUT -p tcp --dport 8888 -j ACCEPT

#centos7如下设置:

firewall-cmd --zone=public --add-port=8888/tcp --permanent
firewall-cmd --reload
