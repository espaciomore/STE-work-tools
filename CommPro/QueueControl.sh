#!/bin/bash
if [ -z "$1" ] || [ -z "$2" ] || [ -z "$3" ]; then
  echo "Queue Control: [US|UK.QA|PROD] [0-9] [broadcast_id]"
  echo "ERROR : Invalid Argument : Missing arguments!"
  exit
fi

RESULTS="START-TIME\tSTATUS\t\tSENT\tIN-PROC\tQUEUED\tDELIV\tFAILED"
FILTER1="[0-9]{1,2}/[0-9]{1,2}/[0-9]{2}_[0-9]{1,2}:[0-9]{2}_[A-Za-z]{2}[ A-Za-z0-9]+"
R1="s/ class=\"primaryFocus\"//g"
R2="s/ class=\"\"//g"
R3="s/<\/?td>//g"
R4="s/<\/?span>//g"
R5="s/([0-9]{1,2}.[0-9]{1,2}.[0-9]{2}){1} ([0-9]{1,2}.[0-9]{2}){1} ([A-Za-z]{2})/\1_\2_\3/g"
RESOURCE="consoleapp/queueControl.jspx"

function print_results {
  echo -e "$RESULTS"
  echo -e "$1\n"
}

function main {
  echo "GET $1/$RESOURCE?id=$2"           
  #python -mwebbrowser "$1/$RESOURCE?id=$2"
  CURL_RESPONSE=`curl "$1/$RESOURCE?id=$2" -s -b "cookie" | tr -s '\n\r\t' ' ' | sed -re "$R1" | sed -re "$R2" | sed -re "$R3" | sed -re "$R4" | sed -re "$R5"`
  ARG1=`egrep -o "$FILTER1" <<< "$CURL_RESPONSE" | tr -s ' ' '\t'`
  print_results "$ARG1"
}

URL_LIST=`./SymbolToURL.sh $1 $2`
for URL in ${URL_LIST}; do
  if [ -n "$3" ]; then
    main "$URL" "$3"
  fi
done