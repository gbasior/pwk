#!/bin/bash
#Exercise 1/2
rm -f dnsServers.txt
touch dnsServers.txt
host -t ns megacorpone.com | cut -d' ' -f4 > dnsServersTemp.txt
for ip in $(cat dnsServersTemp.txt); do
	echo ${ip: :-1} >> dnsServers.txt
done
rm dnsServersTemp.txt

rm -f dnsZoneList.txt
touch dnsZoneList.txt
for ip in $(cat dnsServers.txt); do
	host -l megacorpone.com $ip | grep 'has address' >> dnsZoneList.txt
done

dnsrecon -d megacorpone.com -t axfr > dnsZoneListRecon.txt
