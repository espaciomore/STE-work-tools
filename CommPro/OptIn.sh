#! /bin/bash
if [ -z "$1" ] || [ -z "$2" ] || [ -z "$3" ]; then
  echo "OptIn: [US|UK.QA|PROD] [0-9] [username:password] [list_id] [filename]"
  echo "ERROR : Invalid Argument : Missing arguments!"
  exit
fi

function main {
  printf "" > "OptIn.txt"
  for MDN in $(cat "./$4"); do 
    curl -s "$1/api/optIn/$3/$MDN" -u "$2" >> "OptIn.txt"
    printf "\n" >> "OptIn.txt" 
  done
}

URL_LIST=`./SymbolToURL.sh $1 $2`
for URL in ${URL_LIST}; do
  if [ -n "$3" ]; then
    main "$URL" "$3" "$4" "$5"
  fi
done
