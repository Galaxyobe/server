# Mongodb



## Replica Set


- [复制原理](https://docs.mongodb.com/manual/replication/)

    * 主节点读写

    ![](https://docs.mongodb.com/manual/_images/replica-set-read-write-operations-primary.bakedsvg.svg)

    * 复制器

    ![](https://docs.mongodb.com/manual/_images/replica-set-primary-with-two-secondaries.bakedsvg.svg)

    * 仲裁器

    ![仲裁器](https://docs.mongodb.com/manual/_images/replica-set-primary-with-secondary-and-arbiter.bakedsvg.svg)

    * 自动故障切换

    ![](https://docs.mongodb.com/manual/_images/replica-set-trigger-election.bakedsvg.svg)




- 创建认证所需 key 文件

    ```
    # openssl rand -base64 741 > mongod-replica-set.key
    # chmod 600 mongod-replica-set.key
    ```


- 配置节点


    * 初始化replica set

    ```
    rs.initiate({
        _id : "DataCenter",
        members: [
        { _id : 0, host : "192.168.2.10:27017" },
        { _id : 1, host : "192.168.2.11:27017" },
        { _id : 2, host : "192.168.2.12:27017" }
        ]
    })
    ```


    * 查看replica set各节点状态

    >  rs.status();


- 测试

    ```js
    for (var i = 1; i <= 100000; i++) {
        db.test.insert( { x : i , name: "MACLEAN" } )
    }
    ```


- [创建管理员](http://www.cnblogs.com/shiyiwen/p/5552750.html)

    ```js
    admin = db.getSiblingDB("admin")
    admin.createUser({
        user: "dc",
        pwd: "65535",
        roles: [ { role: "userAdminAnyDatabase", db: "admin" } ]
    })
    ```

- 使能从机读

    > rs.slaveOk();