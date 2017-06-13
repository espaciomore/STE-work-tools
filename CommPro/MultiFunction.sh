#! /bin/bash
if [ -z "$1" ] || [ -z "$2" ] || [ -z "$3" ]; then
  echo "API multiFunction: [US|UK.QA|PROD] [0-9] [username:password] [filename] [message] [programID]"
  echo "ERROR : Invalid Argument : Missing arguments!"
  exit
fi

function main {
  printf "" > "MultiFunction.txt"
  for MDN in $(cat "./$4"); do
    curl -s "$1/api/multiFunction?mobile_number=$MDN&message=$5&forward_to_campid=$6" -u "$3" >> "MultiFunction.txt"
    printf "\n" >> "MultiFunction.txt" 
  done
}

URL_LIST=`./SymbolToURL.sh $1 $2`
for URL in ${URL_LIST}; do
  if [ -n "$3" ]; then
    main "$URL" "$3" "$4" "$5" "$6"
  fi
done