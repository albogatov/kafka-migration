First tasks done with:
- docker-compose.yaml
- sourceTopic and destinationTopic for Kafka Connectors

To start containers use ./start.sh

Connect to mongoDB nodes:
- docker exec -it mongo1 /bin/bash
  mongosh "mongodb://mongo1"
- docker exec -it mongo2 /bin/bash
  mongosh "mongodb://mongo2"

Data enter example: db.users.insertOne({ firstname: "abc", lastname: "bcd", age: 15, email: "bvb@gmail.com" })

Second task done with
- sourceTopic improved by adding a schema, no additional module was used

Data enter example for task two:
- db.users.insertOne({ firstname: "abc", lastname: "bcd", age: 15, email: "bvb@gmail.com", sex: "M" })

Third task done with:
- docker-compose.yaml

To start containers and initiate DB use ./start.sh
To see DB changes after posting data connect with: docker exec -it clickhouse-kafka-server-1 clickhouse-client

To dismantle containers use cmd for respective containers:
- docker-compose -p mongo-kafka down   
- docker-compose -p clickhouse-kafka down   

To remove all installed images:
- docker-compose -p mongo-kafka down --rmi all
- docker-compose -p clickhouse-kafka down --rmi all