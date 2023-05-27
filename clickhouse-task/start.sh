#!/bin/bash

declare -r HOST="http://connect:8083/connectors"

attempt_counter=0
max_attempts=5


docker-compose -p clickhouse-kafka up -d --force-recreate       
#docker exec -it mongo1 mongosh --eval "rs.initiate( {  _id: 'rs0', members: [ { _id: 0, host: 'mongo1:27017' }, {  _id: 1, host: 'mongo2:27017'}]});"
sleep 5
docker exec -i connect /bin/bash -c "kafka-topics \
--bootstrap-server broker:29092 \
--topic readings \
--create --partitions 6 \
--replication-factor 1"

docker cp init_db.sql clickhouse-kafka-server-1:/docker-entrypoint-initdb.d/init_db.sql
docker exec -i clickhouse-kafka-server-1 /bin/bash -c "clickhouse-client -n < /docker-entrypoint-initdb.d/init_db.sql"


docker exec -i connect /bin/bash -c "kafka-console-producer --broker-list broker:29092 --topic readings <<END
1,\"2023-05-28 00:00:11\",19.2
2,\"2023-05-28 00:00:22\",18.2
3,\"2023-05-28 00:00:33\",15.2
END"

