To start containers use ./start.sh

To read data on secondary MongoDB node use connection cmd: mongosh "mongodb://mongo2?readPreference=primaryPreferred"

Data enter example: db.users.insertOne({ firstname: "abc", lastname: "bcd", age: 15, email: "bvb@gmail.com" })

Data enter example for task two:
- db.users.insertOne({ firstname: "abc", lastname: "bcd", age: 15, email: "bvb@gmail.com", sex: "M" })

- db.users.insertOne({ _id: "123abc", firstname: "abc", lastname: "bcd", age: 15, email: "bvb@gmail.com", sex: "M" })
