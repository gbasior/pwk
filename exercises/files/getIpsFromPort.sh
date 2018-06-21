#!/bin/bash

filePre='open_'
fileTempPre='temp'
cat services | while read line; do
	type=$(echo $line | cut -d' ' -f1)
	port=$(echo $line | cut -d' ' -f2)

	rm -f $fileTempPre$type
	touch $fileTempPre$type
	echo $port
	for ip in $(cat openHosts.txt); do
		echo $ip
		nmap -p $port $ip -oG nmapTemp
		cat nmapTemp >> $fileTempPre$type
		rm -f nmapTemp
	done

	rm -f $filePre$type
	touch $filePre$type
	for ip in $(cat $fileTempPre$type | grep Up | cut -d' ' -f2); do
		#echo $ip
		echo $ip >> $filePre$type
	done 

	rm $fileTempPre$type

done
