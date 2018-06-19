#!/bin/bash

#Exercise 1


#nmap -v -p 139,445 10.11.1.1-254 --script smb-os-discovery -oG nmapSmb

:'
rm smbWindows.txt
touch smbWindows.txt
cat openSmbOsInfo.txt | grep "OS:.*Windows" -B3 > temp
for line in $(cat temp | grep -P 10\.11\.1\.[0-9]\{1,3\}); do
	echo $line >> smbWindows.txt
done
rm temp

#Exercise 2
rm -f nmapVuln
touch nmapVuln
for ip in $(cat smbWindows.txt); do
	echo $ip
	for vuln in $(ls /usr/share/nmap/scripts/ | grep smb-vuln | cut -d"." -f1); do
		echo $vuln
		nmap -v -p 139,445 --script=$vuln --script-args=unsafe=1 $ip >> nmapVuln
	done
done
'
cat nmapVuln | grep "VULNERABLE:" -A10 -B10 > actualVuln.txt
cat actualVuln.txt | grep 10\.11 | cut -d' ' -f5 > vulnIp.txt

#Exercise 3
#Found user names with nbtScan
rm -f nbtScan
touch nbtScan
rm -f enumLinux
touch enumLinux
for ip in $(cat vulnIp.txt); do
	echo $ip
	nbtscan -r $ip >> nbtScan
	enum4linux -a $ip >> enumLinux
done

