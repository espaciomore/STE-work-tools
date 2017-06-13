#!/bin/bash
if [ -z "$1" ] || [ -z "$2" ] || [ -z "$3" ]; then
  echo "Send Broadcast: [US|UK.QA|PROD] [0-9] [broadcast_id]"
  echo "ERROR : Invalid Argument : Missing arguments!"
  exit
fi

FILTER="The Broadcast"
R1="s/<p class=\"dialog_confirmtext\" style=\"text-align: left;\">//g"
R2="s/<span class='dialog_heading'>//g"
R3="s/<p class=\"dialog_confirmtext\" style=\"padding-top: 11px;line-height: 0px;text-align: left;\">//g"
R4="s/<\/p>//g"
R5="s/<\/span>//g"
R6="s/^\s+//g"
RESOURCE1="consoleapp/doSendBroadcastMessage.jspx"

function main {
  echo "GET $1/$RESOURCE1?id=$2" 
  curl "$1/$RESOURCE1?id=$2" -s -b "cookie" | egrep "$FILTER" | sed  -re "$R1" | sed  -re "$R2" | sed  -re "$R3" | sed  -re "$R4" | sed  -re "$R5" | sed  -re "$R6" | tr -s ' '
}

URL_LIST=`./SymbolToURL.sh $1 $2`
for URL in ${URL_LIST}; do
  if [ -n "$3" ]; then
    main "$URL" "$3"
  fi
done