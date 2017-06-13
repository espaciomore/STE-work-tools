#!/bin/bash
if [ -z "$1" ]; then
  echo "Map Symbol to URL: [US|UK.QA|PROD] [0-9]"
  echo "ERROR : Invalid Argument : Missing arguments!"
  exit
fi

FTPQA=("01" "02")
FTPPROD=("04" "05" "06")

function map_symbol_to_url {
  if [ "$1" = "FTP.QA" ]; then
    if [ -z "$2" ] || [ "$2" = "*" ]; then 
      for i in ${FTPQA[@]}; do
        echo "http://genericftp-$i.sf.mgage.local:8080"
      done
	else
	  echo "http://genericftp-$2.sf.mgage.local:8080"
	fi
  elif [ "$1" = "FTP.PROD" ]; then
    if [ -z "$2" ] || [ "$2" = "*" ]; then 
      for i in ${FTPPROD[@]}; do
        echo "http://genericftp-$i.qts.mgage.local:8080"
      done
	else
	  echo "http://genericftp-$2.qts.mgage.local:8080"
	fi
  else
    exit
  fi
}

function main {
  map_symbol_to_url "$1" "$2"
}

main "$1" "$2"