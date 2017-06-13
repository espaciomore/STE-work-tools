#!/bin/bash
if [ -z "$1" ]; then
  echo "Build History: [dev-master|master] [0-9]"
  echo "ERROR : Invalid Argument : Missing arguments!"
  exit
fi

FILTER1="build-details"
FILTER2="([0-9]+)/.*(\w [0-9]{1,2}, [0-9]{4} [0-9]{1,2}:[0-9]{1,2}:[0-9]{1,2} AM|PM)."
REPLACEMENT1="/\">"
REPLACEMENT2="<"
RESOURCE="jenkins/view/MMBU/job/mmbu-communicatepro-$1/"

if [ -z "$2" ]; then
  LIMIT=10
elif ! [[ "$2" =~ '^[0-9]+$' ]]; then
  LIMIT="$2"
fi

BUILDS=`curl "http://jenkins.mgage.local:39080/$RESOURCE" -s | egrep "$FILTER1" | egrep -o "$FILTER2" | tr -s "$REPLACEMENT1" '  ' | tr -s "$REPLACEMENT2" '\n'`
IFS=$'\n'
COUNT=1
for build in $BUILDS; do
  if [ -n "$build" ]; then
    ID=`egrep -o '([0-9]+){1}' <<< $build | head -n1`
    VERSION=`curl "http://jenkins.mgage.local:39080/$RESOURCE/$ID/console" -s | egrep -o 'campaignpro.+el6' | head -n1`
    echo "$build" "$VERSION"
  fi
  if [ "$COUNT" -lt "$LIMIT" ]; then
    ((COUNT+=1))
  else
    exit
  fi 
done

