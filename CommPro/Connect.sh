#! /bin/bash
if [ -z "$1" ]; then
  echo "Connect API: [US|UK.QA|PROD] [0-9] [username:password] [dest_address] [message] [filename]"
  echo "ERROR : Invalid Argument : Missing arguments!"
  exit
fi

function main {
  printf "" > "Connect.txt"
  for MDN in $(cat "./$5"); do
    curl -s "$1/api/connect/molistener?IFVERSION=22010&OADC=00$MDN&CONNECTION=&DESTADDRESS=$3&BODY=$4&MESSAGETYPE=10&RECEIVETIME=&GUID=&OPERATOR=" -u "$2" >> "Connect.txt"
    printf "\n" >> "Connect.txt" 
  done
}

URL_LIST=`./SymbolToURL.sh $1 $2`
for URL in ${URL_LIST}; do
  if [ -n "$3" ]; then
    main "$URL" "$3" "$4" "$5" "$6"
  fi
done