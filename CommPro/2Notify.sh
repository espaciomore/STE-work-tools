#! /bin/bash
if [ -z "$1" ]; then
  echo "2Notify API: [US|UK.QA|PROD] [0-9] [username:password] [inbound_address] [message] [filename] [carrier]"
  echo "ERROR : Invalid Argument : Missing arguments!"
  exit
fi

function main {
  printf "" > "2Notify.txt"
  for MDN in $(cat "./$5"); do
    curl -s "$1/2notify/2NotifyResponse?device_address=$MDN&inbound_address=$3&message=$4&carrier=$6" -u "$2" >> "2Notify.txt"
    printf "\n" >> "2Notify.txt" 
  done
}

URL_LIST=`./SymbolToURL.sh $1 $2`
for URL in ${URL_LIST}; do
  if [ -n "$3" ]; then
    main "$URL" "$3" "$4" "$5" "$6" "$7"
  fi
done