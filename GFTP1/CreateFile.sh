#!/bin/bash
function adjust_length {
  declare var="$1"
  if [ -z "$var" ]; then
    var="$3"
  elif [ ${#var} -gt "$2" ]; then
    var=${var:0:$2}
  fi
  var=$(printf %-$2s "$var")
  echo "$var"
}

echo "Header Line"
echo "==========="
echo "VERSION: [0, 4)"
read version
version=$(adjust_length "$version" "4" "1610")
echo "EMAIL: [4, 104)"
read email
email=$(adjust_length "$email" "100" "mcerda@mgage.com")
echo "MERCHANT_CODE: [104, 114)"
read merchantCode
merchantCode=$(adjust_length "$merchantCode" "10" "11823")
echo "CAMPAIGN_CODE: [114, 124)"
read campaignCode
campaignCode=$(adjust_length "$campaignCode" "10" "17678")
echo "EVENT_CODE: [124, 134)"
read eventCode
eventCode=$(adjust_length "$eventCode" "10" "")
echo "MESSAGE_CODE: [134, 144)"
read messageCode
messageCode=$(adjust_length "$messageCode" "10" "")
echo "MT_HANDLER: [144, 146)"
read mtHandler
mtHandler=$(adjust_length "$mtHandler" "2" "PS")
echo "DELIVER_RATE: [146, 156)"
read deliverRate
deliverRate=$(adjust_length "$deliverRate" "10" "")
echo "DELIVER_INTERNAL: [156, 162)"
read deliverInternal
deliverInternal=$(adjust_length "$deliverInternal" "6" "")
echo "SHORT_CODE: [162, 177)"
read shortCode
shortCode=$(adjust_length "$shortCode" "15" "527365")
echo "US_ONLY: [177, 182) i.e. TRUE/FALSE"
read isUSOnly
isUSOnly=$(adjust_length "$isUSOnly" "5" "TRUE")
echo "START_DATE: [182, 198) i.e. mm/dd/yyyy HH:MM"
read startDate
defaultStartDate=$(TZ=EST5EDT date -d '+1 hours' +'%m/%d/%Y %H:%M')
startDate=$(adjust_length "$startDate" "16" "$defaultStartDate")
echo "END_DATE: [198, 214) i.e. mm/dd/yyyy HH:MM"
read endDate
defaultEndDate=$(TZ=EST5EDT date -d '+12 hours' +'%m/%d/%Y %H:%M')
endDate=$(adjust_length "$endDate" "16" "$defaultEndDate")
echo "CARRIER: [214, 224)"
read carrier
carrier=$(adjust_length "$carrier" "10" "")
echo "SMS_SUBJECT: [224, 234)"
read smsSubject
smsSubject=$(adjust_length "$smsSubject" "10" "qa test")
echo "SMS_BODY: [234, 244)"
read smsBody
smsBody=$(adjust_length "$smsBody" "10" "qa test")
echo "REPORT_KEY1: [244, 252)"
read reportKey1
reportKey1=$(adjust_length "$reportKey1" "8" "")
echo "REPORT_KEY2: [252, 260)"
read reportKey2
reportKey2=$(adjust_length "$reportKey2" "8" "")
echo "MMS_SUBJECT: [260, 300)"
read mmsSubject
mmsSubject=$(adjust_length "$mmsSubject" "40" "")
echo "MMS_CONTENT_URL: [300, 556)"
read mmsContentURL
mmsContentURL=$(adjust_length "$mmsContentURL" "256" "")
echo "MMS_BODY: [556, 812)"
read mmsBody
mmsBody=$(adjust_length "$mmsBody" "256" "")

printf "$version$email$merchantCode$campaignCode$eventCode$messageCode$mtHandler$deliverRate$deliverInternal$shortCode$isUSOnly$startDate$endDate$carrier$smsSubject$smsBody$reportKey1$reportKey2$mmsSubject$mmsContentURL$mmsBody" > "$1"

for MDN in $(cat "./$2"); do
  mobileNumber=$(adjust_length "$MDN" "15" "")
  smsBody2=$(adjust_length "$smsBody2" "160" "qa test message")
  clientReceiptID=$(adjust_length "$clientReceiptID" "10" "150713SVNB")
  printf "\n$mobileNumber$smsBody2$clientReceiptID" >> "$1"
done
  
while [ -z "$2" ]; do
  echo "(N)ew recipient, (Q)uit: "
  read option
  if [ "$option" = "Q" ] || [ "$option" = "q" ]; then
    exit
  elif [ "$option" != "N" ] && [ "$option" != "n" ]; then
    continue
  fi
  echo "MOBILE_NUMBER: [0, 15)"
  read mobileNumber
  mobileNumber=$(adjust_length "$mobileNumber" "15" "")
  echo "SMS_BODY: [15, 175)"
  read smsBody2
  smsBody2=$(adjust_length "$smsBody2" "160" "")
  echo "CLIENT_RECEIPT_ID: [175, 185)"
  read clientReceiptID
  clientReceiptID=$(adjust_length "$clientReceiptID" "10" "150713SVNB")
  printf "\n$mobileNumber$smsBody2$clientReceiptID" >> "$1"
done 