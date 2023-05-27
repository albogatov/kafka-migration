To start containers use ./start.sh

First tasks done with:
- docker-compose.yaml
- sourceTopic and destinationTopic for Kafka Connectors

To read data on secondary MongoDB node use connection cmd: mongosh "mongodb://mongo2"

Data enter example: db.users.insertOne({ firstname: "abc", lastname: "bcd", age: 15, email: "bvb@gmail.com" })

Second task done with
- sourceTopic improved by adding a schema, no additional module was used

Data enter example for task two:
- db.users.insertOne({ firstname: "abc", lastname: "bcd", age: 15, email: "bvb@gmail.com", sex: "M" })
