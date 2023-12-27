#!/bin/bash

. "/root/display/truenas_conf.txt"

myDevices=""

myCommand=$(echo "curl -s -X GET \"http://$myIP/api/v2.0/disk\" -H \"Authorization: Bearer $myAPIKey\" | grep \"devname\" | sed 's/.*:..//' | sed 's/.,.*//'")

while read -r line
do
   myDevices=$(echo "\\\""$line\\\"",$myDevices")
done <<< $(bash -c "$myCommand")

myDevices=$(echo "$myDevices" | sed 's/.$//')

myCommand=$(echo "curl -s -X POST \"http://$myIP/api/v2.0/disk/temperatures\" -d \"{\\\""names\\\"": ["$myDevices"], \\\""options\\\"": { \\\""only_cached\\\"": false }}\"")
myCommand=$(echo "$myCommand -H \"Authorization: Bearer $myAPIKey\"")

myMaxTemp=0

while read -r line
do
    myAktTemp=$(echo "$line" | awk '{ print $2 }' | sed 's/,//')
    if ! [ -z $myAktTemp ]; then
       if (( $myAktTemp > $myMaxTemp )); then
          myMaxTemp=$myAktTemp 
       fi
    fi
done <<< $(bash -c "$myCommand")

echo "$myMaxTemp"