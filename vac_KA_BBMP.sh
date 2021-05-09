#!/bin/bash

while true; do

filename="KA.json"
test="0"
session_id_done="0"
session_id="0"

vaccine_search=$1
vaccine_pin='560003 560008 560011 560038 560060 560061 560070 560076 560078 560085 560091';
pin_search=$2

today_date=$(date +%d-%m-%Y)
tsss=(date)

rm $filename
touch $filename

curl -X GET "https://cdn-api.co-vin.in/api/v2/appointment/sessions/public/calendarByDistrict?district_id=294&date=$today_date?ts=$tsss" \
-H "accept: application/json" \
-H 'sec-ch-ua: " Not A;Brand";v="99", "Chromium";v="90", "Google Chrome";v="90"' \
-H "Accept-Language: en_US" \
-H 'Cache-Control: no-cache' \
-H "User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.93 Safari/537.36 Edg/90.0.818.56" \
-H 'Pragma: no-cache' \
-H "If-None-Match: W/"8a0-cJo3"+$tsss" \
--compressed > $filename 

center_cnt="0"

session_cnt="0"
vaccine="0"

available_cnt="0"
pincode="0"
min_age_limit="0"



center_cnt=$(jq .centers $filename | jq length)



i="0"

j="0"


echo -e "Centers: $center_cnt :$(date)"
echo -e

# loop for centers

while [ $i -lt $center_cnt ]

do

session_cnt=$(jq .centers[$i].sessions $filename | jq length)

#echo -e "Sessions: $session_cnt"

j="0"

# loop for sessions

while [ $j -lt $session_cnt ]

do

available_cnt=$(jq .centers[$i].sessions[$j].available_capacity $filename)
vaccine=$(jq .centers[$i].sessions[$j].vaccine $filename)
pincode=$(jq .centers[$i].pincode $filename)
min_age_limit=$(jq .centers[$i].sessions[$j].min_age_limit $filename)
session_id=$(jq .centers[$i].sessions[$j].session_id $filename)

vaccine="${vaccine%\"}"
vaccine="${vaccine#\"}"

if [ "$test" -gt "0" ]; then
available_cnt=1
Search2="TEST MESSAGE"
else
Search2="Search $vaccine"
fi

if [[ $vaccine_pin =~ "$pincode" ]]; then
if [ "$available_cnt" -gt "0" ]; then

#NOTIFY
echo -e "$min_age_limit Count: $available_cnt; $vaccine; $pincode"
source /home/deeksha/./notify.sh "$pincode:$Search2" $vaccine $available_cnt $min_age_limit &

session_id_done+="$session_id"

fi
fi

j=$[$j+1]

done


i=$[$i+1]

done

 sleep 10 #that would mean running the actual script every 2s
done



notify()
{
source "/home/deeksha/./notify.sh "$pincode:$Search2" $vaccine $available_cnt $min_age_limit"
}
