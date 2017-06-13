#!/bin/bash
if [ -z "$1" ] || [ -z "$2" ] || [ -z "$3" ]; then
  echo "Deploy: [US|UK.QA|PROD] [0-9] [username]"
  echo "ERROR : Invalid Argument : Missing arguments!"
  exit
fi

function main {
  ssh -t "$2@$1" "sudo su - jboss"
}

URL_LIST=`./SymbolToURL.sh $1 $2`
for URL in ${URL_LIST}; do
  HOST=`sed -re "s/(http:\/\/)|(:8080)//g" <<< "$URL"`
  main "$HOST" "$3"
done 

