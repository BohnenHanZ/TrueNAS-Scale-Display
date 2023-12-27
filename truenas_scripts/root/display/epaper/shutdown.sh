#!/usr/bin/bash

. /root/display/truenas_conf.txt

touch "$checkShutdownFlag"
/usr/bin/stty -F /dev/ttyUSB0 $myBaud
sleep 3
echo "[POWEROFFIMAGE]" > "$mySerialPort"
exit 0