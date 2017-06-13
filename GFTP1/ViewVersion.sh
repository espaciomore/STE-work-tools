#!/bin/bash
if [ -z "$1" ]; then
  echo "View Version: [US|UK.QA|PROD] [0-9]"
  echo "ERROR : Invalid Argument : Missing arguments!"
  exit
fi

FILTER=""
if [ -n "$3" ] && [ "$3" = "-s" ]; then 
  FILTER="Build"
else
  FILTER="Build|timestamp|campaign|commit"
fi
R1="s/\s+<\/?pre>//g"
R2="s/(<.*>)+//g"
R3="s/^\s+//g"
RESOURCE="genericftp/"
  
function main {
  echo "GET" "$1/$RESOURCE"
  curl "$1/$RESOURCE" -s | sed -re "$R1" | sed -re "$R2" | sed -re "$R3" | egrep "$FILTER";
}

URL_LIST=`./SymbolToURL.sh "$1" "$2"`
for URL in ${URL_LIST}; do
  main "$URL"
done