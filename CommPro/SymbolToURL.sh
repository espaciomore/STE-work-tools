#!/bin/bash
if [ -z "$1" ]; then
  echo "Map Symbol to URL: [US|UK.QA|PROD] [0-9]"
  echo "ERROR : Invalid Argument : Missing arguments!"
  exit
fi

USQA=("03" "04" "07" "08")
UKQA=("03" "04")
USPROD=("01" "02" "03" "04" "05" "06" "07" "08" "09" "10" "11" "12" "13" "14" "15" "16" "17")
UKPROD=("01" "02" "03" "04" "05" "06" "07" "08" "09" "10" "11" "12" "13" "14" "15" "16" "17")

function map_symbol_to_url {
  if [ "$1" = "US.QA" ]; then
    if [ -z "$2" ] || [ "$2" = "*" ]; then 
      for i in ${USQA[@]}; do
        echo "http://cmpro-$i.sf.mgage.local:8080"
      done
	else
	  echo "http://cmpro-$2.sf.mgage.local:8080"
	fi
  elif [ "$1" = "UK.QA" ]; then
    if [ -z "$2" ] || [ "$2" = "*" ]; then 
      for i in ${UKQA[@]}; do
        echo "http://k44qa-$i.mgage.local:8080"
      done
	else
	  echo "http://k44qa-$2.mgage.local:8080"
	fi
  elif [ "$1" = "US.PROD" ]; then
    if [ -z "$2" ] || [ "$2" = "*" ]; then 
      for i in ${USPROD[@]}; do
        echo "http://cmpro-$i.ad.mgage.io:8080"
      done
	else
	  echo "http://cmpro-$2.ad.mgage.io:8080"
	fi
  elif [ "$1" = "UK.PROD" ]; then
    if [ -z "$2" ] || [ "$2" = "*" ]; then 
      for i in ${UKPROD[@]}; do
        echo "http://cmpro-uk-$i.ad.mgage.io:8080"
      done
	else
	  echo "http://cmpro-uk-$2.ad.mgage.io:8080"
	fi
  else
    exit
  fi
}

function main {
  map_symbol_to_url "$1" "$2"
}

main "$1" "$2"