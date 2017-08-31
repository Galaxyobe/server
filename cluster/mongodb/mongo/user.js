
// 主节点 $ mongo 192.168.2.10:27010/admin user.js
// 建立超级用户
admin = db.getSiblingDB("admin")
ret = admin.createUser({
    user: "root",
    pwd: "65535",
    roles: [{ role: "root", db: "admin" }]
})
printjson(ret)
// 建立管理用户
admin = db.getSiblingDB("admin")
ret = admin.createUser({
    user: "dc",
    pwd: "65535",
    roles: [{ role: "userAdminAnyDatabase", db: "admin" }]
})
printjson(ret)
