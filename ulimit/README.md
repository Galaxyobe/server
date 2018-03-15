# ulimit

## 修改open file(s) 上限

```
# echo "fs.nr_open = 10000000" | sudo tee -a /etc/sysctl.conf
# echo "fs.file-max = 11000000" | sudo tee -a /etc/sysctl.conf
```

生效

> sudo sysctl -p

查看

> cat /proc/sys/fs/file-max



## 修改limits最大限制

```
# echo "*   -    nofile  10000000" | sudo tee -a /etc/security/limits.conf
```


## 设置用户登录的ulimit

> sudo vim /etc/pam.d/common-session

添加

```
session required pam_limits.so
```


## 设置supervisord中的ulimit

> sudo vim /etc/supervisor/supervisord.conf 
修改

```
[supervisord]
minfds=1000000
```