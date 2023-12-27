#!/bin/bash

. "/root/display/truenas_conf.txt"

myCommand=$(echo "curl -s -X GET \"http://$myIP/api/v2.0/pool\" -H \"Authorization: Bearer $myAPIKey\" | grep \"\\\""healthy\\\"": true\"")

myResult=$(bash -c "$myCommand")

if [ -z "$myResult" ]; then
   echo "ERROR"
   exit 1
fi

echo "OK"
exit 0
