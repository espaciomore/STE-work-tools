#! /bin/bash
if [ -z "$1" ] || [ -z "$2" ]; then
  echo "Deploy: [filename] [filename]"
  echo "ERROR : Invalid Argument : Missing arguments!"
  exit
fi

file1Len=`cat $1 | wc -l`
file2Len=`cat $2 | wc -l`
if [ "$file1Len" -ne "$file2Len" ]; then
  echo "ERROR : The number of line is different!"
  exit
fi

TIMESTAMP=`date "+%Y%m%d_%H%M%S"`
OUTPUTFILE="MergedCSV_$TIMESTAMP.csv" 

function main {
  printf "" > "$OUTPUTFILE"
  for line in $(seq 1 1 $file1Len); do
    line1=`sed -n "${line}p" $1`
	line2=`sed -n "${line}p" $2`
    printf "$line1,$line2\n" >> "$OUTPUTFILE"
  done
}

main "$1" "$2"