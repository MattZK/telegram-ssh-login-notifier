#!/bin/sh

USERID=""
KEY=""

TIMEOUT="10"
URL="https://api.telegram.org/bot$KEY/sendMessage"
DATE_EXEC="$(date "+%d %b %Y %H:%M")"
TMPFILE='/tmp/ipinfo-$DATE_EXEC.txt'

if [ -n "$SSH_CLIENT" ]; then
	USER_IP=$(echo $SSH_CLIENT | awk '{print $1}')
	PORT=$(echo $SSH_CLIENT | awk '{print $3}')
	HOSTNAME=$(hostname -f)
	IPADDR=$(hostname -I | awk '{print $1}')
	curl http://ipinfo.io/$USER_IP -s -o $TMPFILE
	CITY=$(cat $TMPFILE | jq '.city' | sed 's/"//g')
	REGION=$(cat $TMPFILE | jq '.region' | sed 's/"//g')
	COUNTRY=$(cat $TMPFILE | jq '.country' | sed 's/"//g')
	ORG=$(cat $TMPFILE | jq '.org' | sed 's/"//g')
    TEXT="<b>New \`$(basename "$SHELL")\` shell opened.</b> %0A %0A <b>Details</b> %0A 🔹 Host: \`$(hostname -f)\` %0A 🔹 User: $USER %0A 🔹 TTY: $SSH_TTY %0A  %0A <b>IP Address Information</b> %0A 🔸 IP: $USER_IP %0A 🔸 Country: $COUNTRY %0A 🔸 City: $CITY %0A 🔸 Region: $REGION %0A 🔸 ISP: $ORG"
	curl -s --max-time $TIMEOUT -d "chat_id=$USERID&disable_web_page_preview=1&parse_mode=html&text=$TEXT" $URL > /dev/null
	rm $TMPFILE
fi