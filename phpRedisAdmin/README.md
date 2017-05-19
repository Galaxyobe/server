#

系统:ubuntu 16.04 64位

## 安装phpRedisAdmin

* [phpredis](https://github.com/phpredis/phpredis)
* [phpRedisAdmin](https://github.com/ErikDubbelboer/phpRedisAdmin/)


### 编译phpredis

```shell
phpize
./configure --enable-redis-igbinary
sudo make && make install
```

php使能extensions=redis.so

文件：20-redis.ini 放入php的conf.d

```shell
; configuration for php redis module
; priority=20
extension=redis.so
```

### 下载phpRedisAdmin

```
git clone https://github.com/ErikDubbelboer/phpRedisAdmin.git
cd phpRedisAdmin
git clone https://github.com/nrk/predis.git vendor
cd ..
sudo mv phpRedisAdmin /opt/
```

```
cat <<EOF | sudo tee /etc/apache2/conf-available/phpredisadmin.conf
# phpRedisAdmin default Apache configuration

Alias /phpredisadmin /opt/phpRedisAdmin

<Directory /opt/phpRedisAdmin>
	Options Indexes MultiViews  FollowSymLinks
	AllowOverride None
	Order allow,deny
	Allow from all
    DirectoryIndex index.php
</Directory>
EOF
cd /etc/apache2/conf-enabled/
sudo ln -s ../conf-available/phpredisadmin.conf phpredisadmin.conf
sudo service apache2 restart
```
