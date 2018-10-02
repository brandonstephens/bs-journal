#!/bin/bash
DATE=`date '+%Y/%m/%d'`
LAT="$(~/Dropbox/bin/LocateMe -f {LAT})"
LON="$(~/Dropbox/bin/LocateMe -f {LON})"
FULL_TIME=`date '+%Y-%m-%d %H.%M.%S'`
TITLE_TIME=`date '+%Y-%m-%d'`
ZIP="$(curl -s "https://api.geonames.org/findNearbyPostalCodesJSON?lat=$LAT&lng=$LON&username=YOUR_USER_NAME_HERE" | jq -j '[.postalCodes[].postalCode][1]')"

RESULT="$(curl -s "https://api.forecast.io/forecast/YOUR_API_KEY_HERE/$LAT,$LON" | jq -j '{temperature: .currently.temperature, summary: .currently.summary'})"

echo "journal-$TITLE_TIME"
echo ""
echo "#journal/date/$DATE"
echo "#journal/location/$ZIP"
echo ""
echo "Date: $FULL_TIME"
echo "Location: $LAT, $LON"
echo -n "Weather: "
echo -n $RESULT | jq -j '.temperature'
echo -n "F, "
echo -n $RESULT | jq -j '.summary'