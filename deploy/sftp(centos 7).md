# SFTP

## 查看openssh的版本

> ssh -V

## 创建sftp组

> groupadd sftp 

## 创建一个sftp用户

用户名为hv，密码为hv123456

> useradd -g sftp -s /bin/false hv
> passwd hv

## 创建sftp组用户的统一目录

> mkdir -p /data/sftp/hv
> usermod -d /data/sftp/hv hv

## 配置sshd_config

> vi /etc/ssh/sshd_config

```shell
# Subsystem      sftp    /usr/libexec/openssh/sftp-server 
```
取消#注释
而后添加
```shell
Subsystem       sftp    internal-sftp      
Match Group sftp      
ChrootDirectory /data/sftp/%u      
ForceCommand    internal-sftp      
AllowTcpForwarding no      
X11Forwarding no 
```

## 设定Chroot目录权限

```shell
chown root:sftp /data/sftp/hv    
chmod 755 /data/sftp/hv   
```

## 建立SFTP用户登入后可写入的目录

```shell
mkdir /data/sftp/hv/upload    
chown hv:sftp /data/sftp/hv/upload    
chmod 755 /data/sftp/hv/upload  
```

## 修改/etc/selinux/config

> vi /etc/selinux/config

将文件中的SELINUX=enforcing 修改为 SELINUX=disabled ，然后保存。

## 重启sshd服务

> service sshd restart

## 验证sftp

> sftp hv@127.0.0.1
