# SSH

## 生成ssh key

> $ ssh-keygen -t rsa -b 4096 -C "your_email@example.com"

一路直接回车不修改文件名不设置密码

```shell
ssh-keygen -t rsa -b 4096 -C "galaxyobe@qq.com"
Generating public/private rsa key pair.
Enter file in which to save the key (/home/obe/.ssh/id_rsa): [回车]
Created directory '/home/obe/.ssh'.
Enter passphrase (empty for no passphrase): [回车]
Enter same passphrase again: [回车]
Your identification has been saved in /home/obe/.ssh/id_rsa.
Your public key has been saved in /home/obe/.ssh/id_rsa.pub.
The key fingerprint is:
SHA256:jzmb05eyO6qoP4Gy/4HR2jkbf20B6d/amRhzliXYiFY galaxyobe@qq.com
The key's randomart image is:
+---[RSA 4096]----+
|                 |
|                 |
|         .E      |
|   .    oo +     |
|  ...  .S.o o .  |
|. .=.. ..+.  +   |
| oo *.  +++o+.   |
|.   .B  o+BB+o   |
| .o+=.oo++=B+    |
+----[SHA256]-----+

```

会在用户目录下生成2个文件

```shell
id_rsa  id_rsa.pub
```


## 增加ssh key 到ssh-agent

* 后台开启ssh-agent

```shell
$ eval "$(ssh-agent -s)"
Agent pid 59566
```

* 增加私钥到ssh-agent

```shell
$ ssh-add ~/.ssh/id_rsa
Identity added: /home/obe/.ssh/id_rsa (/home/obe/.ssh/id_rsa)
```

## 使用公钥

* 查看

```shell
$ cat ~/.ssh/id_rsa.pub
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCuQvQEK3EqxwsCzXkqNN+XCKYEw0k6PcERxydUBSAjX1BijsMv9hfpmea/6itH4x1OFK+gMn6cdekqnJkGP+7pTtXlbWXDWf9LICHoIHQcpsEUV58245VtlwU6dqQwAipksuWoqiAH1hPYiAD6s4t/EGSvq7xge9DrI8Yxsv35tvSL8DR5pCU3AOTD7Aj6mmtGCAu+jq8hs5/DNcTAkigtXNX+EAF9oB+PzWWZrHEwVl/xIpqLsI37QNzS2s9XXrzXoPLUMGf58QkiFjo4MzK0ttrWZ+gF2AoblwOypxa8YxudlfaRWQ5Rk5IYi3dmsQQifl6fBxDSHoECXa+pNTk1IJ66xN0AZ9eHatxu6uhoVJKjwhbGrkScgSv5CpdIfWE0SGNA8AB6j0GCZLyAWLm8c2Of6zy6i8YiOb5Ocs8rOf/ADP4J03qO7DBek9ZuX8rAAc1P/FXXGzWM37Bu0GaNrLQU8oxwa4EMW2NCse11e4eTr6TEreVFFhnOcz+M+GmoCtjUnAL1DJW2AtrpJ9i5cW0A0KJYaKU24/vn7CQnJbBTyekdxMxPxTdriU8sq5+PzZxGRFJOkwf0hKg4T23JoHOPoIsAOWqzckfT1yXAjH6rzSJMNkD2i+pkdKJ9zNdK5wKgS2tJU64B6GCcfFikApkyX5kgN5W1eflx98oesQ== galaxyobe@qq.com
```


* 在Github上使用

把输出的公钥，复制粘贴到github的SSH keys里，接着测试

```shell
$ ssh -T git@github.com
The authenticity of host 'github.com (192.30.255.112)' can't be established.
RSA key fingerprint is SHA256:nThbg6kXUpJWGl7E1IGOCspRomTxdCARLviKw6E5SY8.
Are you sure you want to continue connecting (yes/no)? [输入yes]
Warning: Permanently added 'github.com,192.30.255.112' (RSA) to the list of known hosts.
Hi Galaxyobe! You've successfully authenticated, but GitHub does not provide shell access.
```

* 在Gitlab上使用




* 免密码远程登录

ssh免密码访问192.168.1.13，用户名称:dn

```shell
$ ssh-copy-id dn@192.168.1.13
The authenticity of host '192.168.1.13 (192.168.1.13)' can't be established.
ECDSA key fingerprint is SHA256:nThbg6kXUpJWGl7E1IGOCspRomTxdCARLviKw6E5SY8.
Are you sure you want to continue connecting (yes/no)? yes
/usr/bin/ssh-copy-id: INFO: attempting to log in with the new key(s), to filter out any that are already installed
/usr/bin/ssh-copy-id: INFO: 1 key(s) remain to be installed -- if you are prompted now it is to install the new keys
dn@192.168.1.13's password: [输入密码]

Number of key(s) added: 1

Now try logging into the machine, with:   "ssh 'dn@192.168.1.13'"
and check to make sure that only the key(s) you wanted were added.
```