cd "C:\Program Files\MongoDB\Server\4.0\bin"

start cmd /k mongod --replSet shard1 --dbpath "C:\data\shard1" --port 27020 --shardsvr
start cmd /k mongod --replSet shard2 --dbpath "C:\data\shard2" --port 27021 --shardsvr
start cmd /k mongod --replSet configServer --dbpath "C:\data\configServer" --port 27022 --configsvr
start cmd /k mongos --configdb "configServer/localhost:27022" --port 27023
