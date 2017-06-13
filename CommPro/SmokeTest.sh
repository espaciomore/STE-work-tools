#!/bin/bash
if [ -z "$1" ]; then
  echo "Smoke Tests: [US|UK.QA|PROD] [0-9]"
  echo "ERROR : Invalid Argument : Missing arguments!"
  exit
fi

SUMMARY="Tests\tFailure\tError\tSuccess\tTime"
FILTER1="[0-9]+.+[0-9]+.+[0-9]+.+[0-9]+\.[0-9]+%.+[0-9]+\.[0-9]+"
TESTS="Name\t\t\t\tStatus\tTime(s)"
FILTER2="test\w.+\w.+[0-9]+\.[0-9]+"
R0="s/<\/?td>/ /g"
R1="s/<\/?td>/ /g"
R2="s/^([A-Za-z2_]{1,5}) {2}/\1\t\t\t\t\t/m"
R3="s/^([A-Za-z2_]{6,10}) {2}/\1\t\t\t\t/m"
R4="s/^([A-Za-z2_]{11,15}) {2}/\1\t\t\t/m"
R5="s/^([A-Za-z2_]{16,24}) {2}/\1\t\t/m"
R6="s/^([A-Za-z2_]{25,}) {2}/\1\t/m"
RESOURCE="test/ServletTestRunner?suite=com.velti.mmbu.communicatepro.common.test.SmokeTest&xsl=/style/cactus-report.xsl"

function print_summary {
  echo -e "$SUMMARY"
  echo -e "$1\n"
}

function print_tests {
  echo -e "$TESTS"
  echo -e "$1\n"
}

function main {
  echo "GET $1/$RESOURCE"
  #python -mwebbrowser "$1/$RESOURCE"
  CURL_RESPONSE=`curl "$1/$RESOURCE" -s`
  ARG1=`egrep -o "$FILTER1" <<< "$CURL_RESPONSE" | sed -re "$R0" | tr -s ' ' '\t'`
  ARG2=`egrep -o "$FILTER2" <<< "$CURL_RESPONSE" | sed -re "$R1" | sed -re "$R2" | sed -re "$R3" | sed -re "$R4" | sed -re "$R5" | sed -re "$R6"` 
  if [ -n "$2" ] && [ "$2" = "-s" ]; then
    echo -e $(print_summary "$ARG1") | egrep -o "$FILTER1"
  else
    print_summary "$ARG1"
    print_tests "$ARG2"
  fi
}

URL_LIST=`./SymbolToURL.sh "$1" "$2"`
for URL in ${URL_LIST}; do
  main "$URL" "$3"
done