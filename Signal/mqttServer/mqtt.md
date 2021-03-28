# esp32 directly to mango db??

### Setup Mosquitto Server on a raspberry pi
1. `sudo apt-get update`
1. `sudo apt-get upgrade`
1. `sudo apt install mosquitto mosquitto-clients`
1. Edit default config file `sudo nano /etc/mosquitto/mosquitto.conf` and use `mosquitto.conf` as a reference
1. Set up password file under username 'esp32': `sudo mosquitto_passwd -c /etc/mosquitto/pwfile esp32`
1. Enable the broker and allow it to auto-start after reboot using the following command `sudo systemctl enable mosquitto`
1. Restart the pi `sudo reboot`
1.  Run mosquitto server on Raspberry pi `/usr/local/sbin/mosquitto -c Signal/mqttServer/mosquitto.conf`
1. `git clone https://github.com/cqx931/mqtt-mongo-recorder`
1. Follow installation instructions
1. Setup `.env` file
1. Run the server

### Installation (Mac OS)
1. Mosquitto: `brew install mosquitto mosquitto-clients`

### Commands
1. Launch Mosquitto
Mac: `/usr/local/sbin/mosquitto -c Signal/mqttServer/mosquitto.conf`
Raspberry pi: `mosquitto -c Signal/mqttServer/mosquitto.conf`
1. Create a topic
`mosquitto_sub -h 192.168.8.139 -d -u esp32 -P plantSonification -t dev`
1. Send message
`mosquitto_pub -h 192.168.8.139 -d -u esp32 -P plantSonification -t dev -m "Ohhhh"`
1. Find out about Raspberry pi's current IP
`hostname -I`

### TODO
- [ ] Create a sh file for raspberry pi that automatically setup the topics
<!-- https://www.hackster.io/14872/temperature-logging-using-mqtt-and-mongodb-a58cce#story -->
