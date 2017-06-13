#!/bin/bash
if [ -z "$1" ]; then
  echo "Login: [US|UK.QA|PROD] [0-9] [username:password]"
  echo "ERROR : Invalid Argument : Missing arguments!"
  exit
fi

FILTER="<title>"
REPLACEMENT="s/\s*<\/?title>\s*//g"
RESOURCE1="consoleapp/j_security_check"
RESOURCE2="consoleapp/welcome.jspx"

function main {
  echo "POST $1/$RESOURCE1" 
  IFS=':'; CRED=($2); unset IFS;
  curl -d "j_username=${CRED[0]}&j_password=${CRED[1]}" -H "Content-Type: application/x-www-form-urlencoded" -X POST "$1/$RESOURCE1" -s -c "cookie" 
  curl "$1/$RESOURCE2" -s -b "cookie" | egrep "$FILTER" | sed  -re "$REPLACEMENT"
}

URL_LIST=`./SymbolToURL.sh $1 $2`
for URL in ${URL_LIST}; do
  if [ -n "$3" ]; then
    main "$URL" "$3"
  else	
    main "$URL" "qamerch:password1"
  fi
done