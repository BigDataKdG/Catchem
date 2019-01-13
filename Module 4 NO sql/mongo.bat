cd "C:\Program Files\MongoDB\Server\4.0\bin"

start cmd /k mongod --replSet shard1 --dbpath "C:\data\shard1" --port 27100 --shardsvr
start cmd /k mongod --replSet shard2 --dbpath "C:\data\shard2" --port 27101 --shardsvr
start cmd /k mongod --replSet configServer --dbpath "C:\data\configServer" --port 27102 --configsvr
start cmd /k mongos --configdb "configServer/localhost:27102" --port 27103
