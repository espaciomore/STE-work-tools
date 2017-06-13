#! /bin/bash
if [ -z "$1" ] || [ -z "$2" ] || [ -z "$3" ]; then
  echo "API saveProperty: [US|UK.QA|PROD] [0-9] [username:password] [filename] [name] [value]"
  echo "ERROR : Invalid Argument : Missing arguments!"
  exit
fi

function main {
  printf "" > "SaveProperty.txt"
  for MDN in $(cat "./$3"); do
    curl -s "$1/api/saveProperties" -d "<?xml version=\"1.0\"?><saveProperties xmlns=\"http://cmpro.air2web.com/api\"><device number=\"$MDN\"><properties><property><name>$4</name><value>$5</value></property></properties></device></saveProperties>" -u "$2" >> "SaveProperty.txt"
    printf "\n" >> "SaveProperty.txt"
  done
}

URL_LIST=`./SymbolToURL.sh $1 $2`
for URL in ${URL_LIST}; do
  if [ -n "$3" ]; then
    main "$URL" "$3" "$4" "$5" "$6"
  fi
done
