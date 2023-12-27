#!/usr/bin/bash

. /root/display/truenas_conf.txt


printSerial () {
   sleep 1
   if [ -f "$checkShutdownFlag" ]; then
      exit 0
   fi
   /usr/bin/stty -F "$mySerialPort" "$myBaud"
   sleep 2
   if [ -f "$checkShutdownFlag" ]; then
      exit 0
   fi
   echo "$1" > "$mySerialPort"
}


while :
do

   myDiskFree=$(/root/display/getdiskfree.sh)
   if ! [ -z $myDiskFree ]; then
      myDiskFree=$(numfmt --to=iec-i --format=%.0f <<<"${myDiskFree}" | sed 's/Ti/ TByte/' | sed 's/Ki/ KByte/' | sed 's/Mi/ MByte/' | sed 's/Gi/ GByte/' | sed 's/Pi/ PByte/' | sed 's/Ei/ EByte/')
   fi

   myZFSStatus=$(/root/display/getzfsstatus.sh)

   if [ "$myZFSStatus" = "OK" ]; then
   
     printSerial "[LED]GREEN=ON"

      myHDDTemp=$(/root/display/gethottesthd.sh)

      myIP=$(/root/display/getip.sh)

      printSerial "[STATUS]FREI: ${myDiskFree}[NEWLINE]HDD:  ${myHDDTemp} C[NEWLINE]${myIP}"
      printSerial "[LED]RED=OFF"
   else
     printSerial "[LED]RED=ON"
     myIP=$(/root/display/getip.sh)     
     printSerial "[INFO]ZFS Fehler[NEWLINE]${myIP}"
     printSerial "[LED]GREEN=OFF"
   fi

   sleep 30

done
