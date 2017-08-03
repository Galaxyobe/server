# Tengine

[官网](http://tengine.taobao.org/)


### 依赖

#### zlib

```
wget http://zlib.net/zlib-1.2.11.tar.gz
tar zxvf zlib-1.2.11.tar.gz
cd zlib-1.2.11
./configure --prefix=/usr/local/zlib
make && sudo make install
```

> sudo apt-get install zlib1g zlib1g-dev


#### pcre
```
wget https://ftp.pcre.org/pub/pcre/pcre-8.41.tar.gz
tar zxvf pcre-8.41.tar.gz
cd pcre-8.41
./config --prefix=/usr/local/pcre
make && sudo install
```

> sudo apt-get install libpcre3 libpcre3-dev 

#### OpenSSL

```
wget https://www.openssl.org/source/openssl-1.0.2l.tar.gz
tar zxvf openssl-1.0.2l.tar.gz
cd openssl-1.0.2l
./config --prefix=/usr/local/openssl
make && make install
```

> sudo apt-get install openssl libssl-dev

#### jemalloc

```
wget http://www.canonware.com/download/jemalloc/jemalloc-4.2.1.tar.bz2
tar jxvf jemalloc-4.2.1.tar.bz2
cd jemalloc-4.2.1
./configure --prefix=/usr/local/jemalloc
make && make install
```

> sudo apt-get install libjemalloc1 libjemalloc-dev

## 安装

> wget http://tengine.taobao.org/download/tengine-2.2.0.tar.gz
> tar -xf tengine-2.2.0.tar.gz

### 使能模块
```
--with-http_upstream_check_module
```


### 编译

复制nginx的configure信息

> nginx -V

```
./configure --prefix=/usr/local/nginx --user=www-data --group=www-data --with-jemalloc=./jemalloc-4.2.1 --with-openssl=./openssl-1.0.2l --prefix=/usr/share/nginx --sbin-path=/usr/sbin/nginx --conf-path=/etc/nginx/nginx.conf --http-log-path=/var/log/nginx/access.log --error-log-path=/var/log/nginx/error.log --lock-path=/var/lock/nginx.lock --pid-path=/run/nginx.pid --http-client-body-temp-path=/var/lib/nginx/body --http-fastcgi-temp-path=/var/lib/nginx/fastcgi --http-proxy-temp-path=/var/lib/nginx/proxy --http-scgi-temp-path=/var/lib/nginx/scgi --http-uwsgi-temp-path=/var/lib/nginx/uwsgi
```

> sudo make 
> sudo make install