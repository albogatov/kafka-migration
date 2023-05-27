#!/bin/bash

declare -r HOST="http://connect:8083/connectors"


docker-compose -p mongo-kafka up -d --force-recreate       
#docker exec -it mongo1 mongosh --eval "rs.initiate( {  _id: 'rs0', members: [ { _id: 0, host: 'mongo1:27017' }, {  _id: 1, host: 'mongo2:27017'}]});"
sleep 2
docker exec -it mongo1 mongosh --eval "rs.initiate( {  _id: 'rs0', members: [ { _id: 0, host: 'mongo1:27017' }]});"


until [ \
  "$(docker exec -i mongo1 /bin/bash -c "curl -s -w '%{http_code}' -o /dev/null \"http://connect:8083/connectors\"")" \
  -eq 200 ]
do
  echo "Waiting for 200"
  sleep 5
done

sleep 1

docker exec -i mongo1 /bin/bash -c "cx /scratch_space/src/sourceTopic.json"
docker exec -i mongo1 /bin/bash -c "cx /scratch_space/dst/destinationTopic.json"
