config = {
    _id: "DataCenter",
    members: [
        { _id: 0, host: "db10.papersshow.com:27010", priority: 10 },
        { _id: 1, host: "db11.papersshow.com:27011", priority: 5 },
        { _id: 2, host: "db12.papersshow.com:27012", priority: 5 },
        { _id: 3, host: "db.papersshow.com:27020", priority: 1 },
        { _id: 4, host: "db.papersshow.com:27018", arbiterOnly: true },
        { _id: 5, host: "db.papersshow.com:27019", arbiterOnly: true },
    ]
};
ret = rs.initiate(config);
print("initiate");
printjson(ret);
ret = rs.status(config);
print("status");
printjson(ret);
