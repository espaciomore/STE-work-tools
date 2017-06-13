#!/bin/bash
if [ -z "$1" ] || [ -z "$2" ] || [ -z "$3" ] || [ -z "$4" ]; then
  echo "Close Chat: [US|UK.QA|PROD] [0-9] [filename] [RESOLVED|ESC_PHONE|ESC_EMAIL|UNABLE] [comment]"
  echo "ERROR : Invalid Argument : Missing arguments!"
  exit
fi

F1="\"id\":[0-9]+"
R1="s/\"id\":([0-9]+)/\1/m"

close_session() {
  curl "$1/chat/$2/resolve?resolution=$3&comment=$4" -s -b "cookie" -d ""
}

main() {
  for ID in $(cat "./$2"); do
    close_session "$1" "$ID" "$3" "$4"
  done
}

URL_LIST=`./SymbolToURL.sh $1 $2`
for URL in ${URL_LIST}; do
  main "$URL" "$3" "$4" "$5"
done