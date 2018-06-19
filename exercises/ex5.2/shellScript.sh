#!/bin/bash

for script in $(ls /usr/share/nmap/scripts | grep 'smb-vuln'  | cut -d'.' -f1); do
	echo $script
	nmap -v -p 139,445 --script=$script 10.11.14.31
done
