# Httpbin

## 安装

### 安装httpbin

> pip install httpbin

### 安装gevent

> pip gevent

### 安装服务器软件gunicorn

> pip install gunicorn

## 运行测试

运行httpbin，在8000端口

> gunicorn -b :8000 httpbin:app

## 部署

> sudo mkdir /var/log/httpbin
> sudo ./enable.sh
