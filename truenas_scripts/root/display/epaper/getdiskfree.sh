#!/bin/bash

. "/root/display/truenas_conf.txt"

myCommand=$(echo "curl -s -X GET \"http://$myIP/api/v2.0/pool/dataset?extra.retrieve_children=false&extra.properties=available\" -H \"Authorization: Bearer $myAPIKey\" | grep \"\\\"rawvalue\"  | sed 's/.*:..//' | sed 's/.,.*//'")

bash -c "$myCommand"

exit 0