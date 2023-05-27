#!/bin/bash

declare -r HOST="http://connect:8083/connectors"

attempt_counter=0
max_attempts=5

wait-for-url() {
    echo "Testing http://connect:8083/connectors"
    timeout -s TERM 45 bash -c \
    'while [[ "$(curl -s -o /dev/null -L -w ''%{http_code}'' ${0})" != "200" ]];\
    do echo "Waiting for ${0}" && sleep 2;\
    done' http://connect:8083/connectors
    echo "OK!"
    curl -I http://connect:8083/connectors
}

docker-compose -p mongo-kafka up -d --force-recreate       
docker exec -it mongo1 mongosh --eval "rs.initiate( {  _id: 'rs0', members: [ { _id: 0, host: 'mongo1:27017' }, {  _id: 1, host: 'mongo2:27017'}]});"
sleep 15
docker exec -i mongo1 /bin/bash -c "cx /scratch_space/src/sourceTopic.json"
docker exec -i mongo1 /bin/bash -c "cx /scratch_space/dst/destinationTopic.json"
