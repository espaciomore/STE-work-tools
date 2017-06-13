#!/bin/bash
if [ -z "$1" ] || [ -z "$2" ] || [ -z "$3" ]; then
  echo "Sanity Tests: [US|UK.QA|PROD] [0-9] [username:password] [broadcast_id]"
  echo "ERROR : Invalid Argument : Missing arguments!"
  exit
fi

function view_version {
  echo -e "\nView Version"
  VERSION=`./ViewVersion.sh $1 $2`
  printf '%s\n' "${VERSION[@]}" | egrep "GET|Build"
}

function smoketest {
  echo -e "\nSmoke Tests"
  SMOKETESTS=`./SmokeTest.sh $1 $2`
  printf '%s\n' "${SMOKETESTS[@]}" | egrep "GET|%"
}

function login {
  echo -e "\nLogin"
  HOMEPAGE=`./Login.sh $1 $2 $3`
  printf '%s\n' "${HOMEPAGE[@]}" | egrep "*"
}

function send_broadcast {
  echo -e "\nSend Broadcast"
  STATUS=`./SendBroadcast.sh $1 $2 $3`
  printf '%s\n' "${STATUS[@]}" | egrep "*"
}

function get_broadcast_status {
  echo -e "\nBroadcast Status"
  QUEUECONTROL=`./QueueControl.sh $1 $2 $3`
  printf '%s\n' "${QUEUECONTROL[@]}" | egrep "*" 
}

declare BroadcastID=""
function set_broadcast_ID {
  if [ -n "$1" ]; then
    BroadcastID="$1"
  elif [ "$1"="US.QA" ]; then
    BroadcastID="140485"
  elif [ "$1"="UK.QA" ]; then
    BroadcastID="127284"
  elif [ "$1"="US.PROD" ]; then
    BroadcastID="157400"
  elif [ "$1"="US.PROD" ]; then
    BroadcastID="129983"
  fi
}

function main {
  view_version "$1" "$2"
  smoketest "$1" "$2"
  login "$1" "$2" "$3"
  set_broadcast_ID "$4"
  send_broadcast "$1" "$2" "$BroadcastID"
  get_broadcast_status "$1" "$2" "$BroadcastID"  
}

main "$1" "$2" "$3" "$4"


