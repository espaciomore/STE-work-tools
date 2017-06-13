#! /bin/bash
TIMESTAMP=`date "+%Y%m%d_%H%M%S"`
# read parameters or assign default values
SIZE=$3
if [ -z "$SIZE" ]; then
  SIZE="3"
fi
# define initial coupon
STR="$1"
NUM="$2"
# generate subsequent coupons
if [ -n "$1" ] && [ -n "$2" ] && [ -n "$3" ]
then
  # create an empty file
  printf "" > "Coupon_List_$TIMESTAMP.csv"
  for SEQNUM in $(seq -f "%0$((${#SIZE}+1))g" "$NUM" "$(($NUM+$SIZE))"); do
    printf "$STR$SEQNUM\n" >> "Coupon_List_$TIMESTAMP.csv"
  done
else
  echo "Coupon Generator: [A-Z] [0-9] [size]"
  echo "ERROR : Invalid Argument : Missing arguments!"
fi  