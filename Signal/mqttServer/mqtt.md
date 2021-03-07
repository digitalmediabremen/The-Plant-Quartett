# esp32 directly to mango db??

### installation (Mac OS)
1. [mangodb](https://docs.mongodb.com/manual/tutorial/install-mongodb-on-os-x/)
1. Mosquitto: `brew install mosquitto`

### Run
1. Launch Mosquitto
`/usr/local/sbin/mosquitto -c Signal/mosquitto.conf`
1. Create a topic
`mosquitto_sub -h 172.20.10.7 -d -u esp32 -P plantSonification -t dev`
1. Send message
`mosquitto_pub -h 172.20.10.7 -d -u esp32 -P plantSonification -t dev -m "Ohhhh"`

### Setup Mosquitto Server on a raspberry pi
1. `sudo apt-get update`
1. `sudo apt-get upgrade`
1.  `sudo apt-get install mosquitto`
1.  Run mosquitto server on Raspberry pi `/usr/local/sbin/mosquitto -c mosquitto.conf`
1. `git clone https://github.com/mneunomne/mqtt-mongo-recorder`

### TODO
- [ ] Create a sh file for raspberry pi that automatically setup the topics
<!-- https://www.hackster.io/14872/temperature-logging-using-mqtt-and-mongodb-a58cce#story -->
