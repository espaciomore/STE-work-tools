#! /bin/bash
if [ -z "$1" ] || [ -z "$2" ] || [ -z "$3" ]; then
  echo "WebMO API: [US|UK.QA|PROD] [0-9] [username:password] [shortcode] [message] [filename] [campaignID] [carrier]"
  echo "ERROR : Invalid Argument : Missing arguments!"
  exit
fi

function main {
  printf "" > "WebMO.txt"
  for MDN in $(cat "./$5"); do 
    curl -s "$1/api/externalMO?campid=$6&destination=$4&originator=$MDN&message=$4&carrier=$7" -u "$2" >> "WebMO.txt"
    printf "\n" >> "WebMO.txt" 
  done
}

URL_LIST=`./SymbolToURL.sh $1 $2`
for URL in ${URL_LIST}; do
  if [ -n "$3" ]; then
    main "$URL" "$3" "$4" "$5" "$6" "$7" "$8"
  fi
done
