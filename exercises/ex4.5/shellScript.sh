#!/bin/bash


#Exercise 1
echo public > community
echo private >> community
echo manager >> community

for ip in $(seq 1 254); do
	echo 10.11.1.$ip;
done > ips
onesixtyone -c community -i ips | grep -P '10.11.1' | cut -d' ' -f1 > snmpIds


rm community
rm ips

#Exercise 2
echo '1.3.6.1.2.1.25.1.6.0;System Processes' > snmpParameters
echo '1.3.6.1.2.1.25.4.2.1.2;Running Programs' >> snmpParameters
echo '1.3.6.1.2.1.25.4.2.1.4;Processes Path' >> snmpParameters
echo '1.3.6.1.2.1.25.2.3.1.4;Storage Units' >> snmpParameters
echo '1.3.6.1.2.1.25.6.3.1.2;Software Name' >> snmpParameters
echo '1.3.6.1.4.1.77.1.2.25;User Accounts' >> snmpParameters
echo '1.3.6.1.2.1.6.13.1.3;TCP Local Ports' >> snmpParameters


rm -f snmpWalkResults
touch snmpWalkResults
for ip in $(cat snmpIds); do
	echo $ip >> snmpWalkResults
	echo '-----------------------------------------------------------------------------' >> snmpCheckResults
	echo '-----------------------------------------------------------------------------' >> snmpCheckResults
	echo $ip
	for line in $(cat snmpParameters); do
		var=$(echo $line | cut -d';' -f1)
		type=$(echo $line | cut -d';' -f2)
		echo $type
		echo $type >> snmpWalkResults
		snmpwalk -c public -v1 $ip $var >> snmpWalkResults
	done
done


rm -f snmpCheckResults
touch snmpCheckResults
for ip in $(cat snmpIds); do
	echo '-----------------------------------------------------------------------------' >> snmpCheckResults
	echo '-----------------------------------------------------------------------------' >> snmpCheckResults
	echo $ip
	echo $ip >> snmpCheckResults
	snmp-check -p 161 $ip >> snmpCheckResults
done
