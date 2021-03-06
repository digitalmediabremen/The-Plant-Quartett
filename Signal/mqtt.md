### installation (Mac OS)
1. [mangodb](https://docs.mongodb.com/manual/tutorial/install-mongodb-on-os-x/)
1. Mosquitto: `brew install mosquitto`

### Run
1. Launch Mosquitto
`/usr/local/sbin/mosquitto -c /usr/local/etc/mosquitto/mosquitto.conf`
2. Run the node file
`node mqtt2mongo.js`
3. Start running the MongoDB
`brew services start mongodb-community@4.4`
this opens a connection on port 27017, by default mongoDB switches to Test Database, type these instructions step by step to get data in the MongoDB
'show dbs'  // show all the database available
'use TempMonitor'  // switches to your database
'show collections'  // shows the data collection in your database
'db.test_mqtt.find().pretty()' //gives you the contents in the collection.

<!-- https://www.hackster.io/14872/temperature-logging-using-mqtt-and-mongodb-a58cce#story -->
