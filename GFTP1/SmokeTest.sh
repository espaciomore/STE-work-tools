#!/bin/bash
if [ -z "$1" ]; then
  echo "Smoke Tests: [US|UK.QA|PROD] [0-9]"
  echo "ERROR : Invalid Argument : Missing arguments!"
  exit
fi

SUMMARY="Tests\tFailure\tError\tTime"
FILTER1="tests=\"([0-9]+)\"\sfailures=\"([0-9]+)\"\serrors=\"([0-9]+)\"\stime=\"([0-9]+\.[0-9]+)\""
TESTS="Name\t\t\t\tTime(s)"
FILTER2="name=\"(\w+)\" time=\"([0-9]+\.?[0-9]*)\""
R0="s/tests=\"([0-9]+)\"\sfailures=\"([0-9]+)\"\serrors=\"([0-9]+)\"\stime=\"([0-9]+\.[0-9]+)\"/\1\t\2\t\3\t\4/m"
R1="s/name=\"(\w+)\" time=\"([0-9]+\.?[0-9]*)\"/\1  \2/g"
R2="s/^([A-Za-z2_]{1,5}) {2}/\1\t\t\t\t\t/m"
R3="s/^([A-Za-z2_]{6,10}) {2}/\1\t\t\t\t/m"
R4="s/^([A-Za-z2_]{11,15}) {2}/\1\t\t\t/m"
R5="s/^([A-Za-z2_]{16,26}) {2}/\1\t\t/m"
R6="s/^([A-Za-z2_]{27,}) {2}/\1\t/m"
RESOURCE="genericftp/ServletTestRunner?suite=com.air2web.genericftp.test.SmokeTest&xsl=cactus-report.xsl"

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