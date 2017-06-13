#! /bin/bash
if [ -z "$1" ] || [ -z "$2" ] || [ -z "$3" ] || [ -z "$4" ]; then
  echo "MDN Generator: [ US{1 XXX XXX XXXX} | UK{44 XXX XXXX XXXX} ] [size]"
  echo "ERROR : Invalid Argument : Missing arguments!"
  exit
fi

TIMESTAMP=`date "+%Y%m%d_%H%M%S"`
SIZE=$5
MDN="$1$2$3$4"

function main {
  if [ -z "$SIZE" ]; then
    SIZE="1"
  fi
  printf "" > "MDN_List_$TIMESTAMP.csv"
  for i in $(seq 1 $SIZE); do
    MDN="$(($MDN+1))"
	printf "$MDN\n" >> "MDN_List_$TIMESTAMP.csv"
  done  
}

main 