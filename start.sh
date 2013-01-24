#!/bin/sh

#check if the system is not already running
# i.e check if smsd is running
#     if necessary start the modem
[ -f /dev/tty.ZTEUSBModem_ ] && echo "file exists. starting next phase..." || open /Applications/TT\ -\ Netboot\ 3G.app

#wait a second for the driver to register in /dev/tty.[drivername]
sleep 5

#stop the desktop app after the driver is registered
[ -f /dev/tty.ZTEUSBModem_ ] && echo "file exists" || open /Applications/TT\ -\ Netboot\ 3G.app

line=`ps aux | grep TT\ -\ Netboot\ 3G\ -psn`
set -- $line
echo $line
echo "pid is" $2
kill -INT $2 #terminate the program using the PID

#start smstools
echo "Starting smsd..."
`sudo smsd`
sleep 2
echo "smsd started..."

#start the rails app
echo "Starting the webserver and the rails app..."
cd mosan && `sudo rails s -d`
sleep 4

#start the ruby listener
echo "Starting the event handler..."
cd ../ && `sudo ruby smsdread.rb&`

echo "All processes awake... listening for events."
 