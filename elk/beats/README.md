# Elastic Beats

## 
1. filebeat
1. metricbeat


## 源

1. Ubuntu

    > wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
    
    > sudo apt-get install apt-transport-https
    
    > echo "deb https://artifacts.elastic.co/packages/5.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-5.x.list

1. Centos

    > sudo rpm --import https://packages.elastic.co/GPG-KEY-elasticsearch
    > sudo vim /etc/yum.repos.d/elastic-5.x.repo
    ```
    [elastic-5.x]
    name=Elastic repository for 5.x packages
    baseurl=https://artifacts.elastic.co/packages/5.x/yum
    gpgcheck=1
    gpgkey=https://artifacts.elastic.co/GPG-KEY-elasticsearch
    enabled=1
    autorefresh=1
    type=rpm-md
    ```

## 安装

1. Ubuntu

    > sudo apt-get update && sudo apt-get install filebeat

    > sudo update-rc.d filebeat defaults 95 10

1. Centos 

    > sudo yum install filebeat