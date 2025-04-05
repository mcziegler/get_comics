#!/bin/bash

DATE=`date +%Y-%m-%d`
DATESLASH=`date +%Y/%m/%d`
#DATE=`date -d "1 day ago" +%Y-%m-%d`
#DATESLASH=`date -d "1 day ago" +%Y/%m/%d`

# for COMICNAME in ComicKingdom; do

while read COMICNAME; do
        RAWOUTPUT=`wget -q -O - "https://www.gocomics.com/${COMICNAME}/${DATESLASH}"`
        FILENAME=`echo "$RAWOUTPUT" | sed 's/http/\nhttp/g' | tr '?' '\n' | grep featureassets | head -n 1`
        wget -q -O "${DATE}-${COMICNAME}.gif" "$FILENAME"
        RAWTITLE=`echo "$RAWOUTPUT" | sed 's/</\n</g' | grep "<title>Read"`
        DISPLAYNAME=`echo $RAWTITLE | cut -d ' ' -f2-$(echo "$RAWTITLE" | sed 's/ /\n/g' | grep -n "by" | tail -n 1 | awk -F ':' '{print $1 - 1}')`
        DISPLAYNAME=`echo $DISPLAYNAME | sed "s/&amp;/\&/g" | sed "s/&#x27;/'/g" | sed "s/&#39;/'/g"`
        echo "[b]${DISPLAYNAME}[/b]"
        ./imgur.sh "${DATE}-${COMICNAME}.gif" 2>/dev/null | awk '{printf("[img]%s[/img]\n",$0)}'
        echo

done < ComicKingdom
