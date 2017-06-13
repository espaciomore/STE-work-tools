#!/bin/bash
if [ -z "$1" ] || [ -z "$2" ]; then
  echo "Chat: [US|UK.QA|PROD] [0-9] [resolution]"
  echo "ERROR : Invalid Argument : Missing arguments!"
  exit
fi

F1=""
R1=""

get_sessions() {
  if [ "$2" = "*" ]; then
    F1="\"id\":[0-9]+.{200,400}\"resolution\":\"[A-Za-z]+\""
    R1="s/\"id\":([0-9]+).{200,400}\"resolution\":\"([A-Za-z]+)\"/\1:\2/m"
  else
    F1="\"id\":[0-9]+.{200,400}\"resolution\":\"$2\""
    R1="s/\"id\":([0-9]+).{200,400}\"resolution\":\"($2)\"/\1:\2/m"
  fi
  SESSIONS=`curl "$1/chat/refresh" -s -b "cookie" | egrep -o "$F1" | sed -re "$R1"`
  IFS=$'\n'
  printf "" > "ChatSessions.txt"
  for SESSION in $SESSIONS; do
    IFS=':' read -ra PARTS <<< "$SESSION"
    printf "${PARTS[0]}\n" >> "ChatSessions.txt"
  done  
}

main() {
  get_sessions "$1" "$2"
}

URL_LIST=`./SymbolToURL.sh $1 $2`
for URL in ${URL_LIST}; do
  main "$URL" "$3"
done