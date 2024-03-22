#!/bin/bash

rm -rf *.gif

DATE=`date +%Y-%m-%d`

for COMICNAME in flash-gordon pajama-diaries mary-worth rex-morgan-m-d mandrake-the-magician phantom between-friends sally-forth zits judge-parker popeye take-it-from-the-tinkersons prince-valiant Olive-Popeye ; do

	RAWOUTPUT=`wget -q -O - "https://comicskingdom.com/${COMICNAME}/${DATE}"`
	FILENAME=`echo "$RAWOUTPUT" | sed 's/>/>\n/g' | sed 's/,/,\n/g' | grep og:image | head -n 1 | awk -F '"' '{print $4}'`
	wget -q -O "${DATE}-${COMICNAME}.gif" "$FILENAME"
	DISPLAYNAME=`echo "$RAWOUTPUT" | sed 's/>/>\n/g' | sed 's/,/,\n/g' | grep "</title>" | awk -F ' Comic Strip' '{print $1}' | sed "s/&amp;/\&/g" | sed "s/&#x27;/'/g" | sed "s/&#39;/'/g"`
	echo "[b]${DISPLAYNAME}[/b]"
	#  ./imgur.sh "${DATE}-${COMICNAME}.gif" 2>/dev/null | awk '{printf("[img]%s[/img]\n",$0)}'
	echo

done
