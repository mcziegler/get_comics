#!/bin/bash


DATE=`date +%Y-%m-%d`

while read COMICNAME; do
	rm -rf *${COMICNAME}*.gif

	RAWOUTPUT=`wget -q -O - "https://comicskingdom.com/${COMICNAME}/${DATE}"`
	FILENAME=`echo "$RAWOUTPUT" | sed 's/>/>\n/g' | sed 's/,/,\n/g' | grep og:image | head -n 1 | awk -F '"' '{print $4}'`
	wget -q -O "${DATE}-${COMICNAME}.gif" "$FILENAME"
	DISPLAYNAME=`echo "$RAWOUTPUT" | sed 's/>/>\n/g' | sed 's/,/,\n/g' | grep "</title>" | awk -F ' Comic Strip' '{print $1}' | sed "s/&amp;/\&/g" | sed "s/&#x27;/'/g" | sed "s/&#39;/'/g"`
	echo "[b]${DISPLAYNAME}[/b]"

done < CkList
