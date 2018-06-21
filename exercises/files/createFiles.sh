#Exercise 1
:'
nmap -v -sn -oG nmapSweep 10.11.1.1-254

rm -f openHosts.txt
touch openHosts.txt
for ip in $(grep Up nmapSweep | cut -d" " -f2); do
	echo $ip >> openHosts.txt
done
rm nmapSweep

#Exercise 2
rm -f nmapWebSweep
touch nmapWebSweep
#Scanning for web servers
for ip in $(cat openHosts.txt); do
	nmap -p 80 $ip -oG nmapWebSweepTemp
	cat nmapWebSweepTemp >> nmapWebSweep
	rm -f nmapWebSweepTemp
done
'

rm -f openIp.txt
touch openIp.txt
for ip in $(cat nmapWebSweep | grep 'open\|filtered' | cut -d' ' -f2); do
	echo $ip >> openIp.txt
done
rm nmapWebSweep

:'
rm -f nmapServerVersion
touch nmapServerVersion
rm -f openOsVersions.txt
touch openOsVersions.txt
#Finding the version of ip's and OS' with webservers
for ip in $(grep open nmapWebSweep | cut -d" " -f2); do
	nmap -p 80 $ip -sV -oG nmapServerVersionTemp
	cat nmapServerVersionTemp >> nmapServerVersion

	os=$(nmap -p 80 $ip -O | grep 'Aggressive OS guesses' | cut -d':' -f2 | cut -d',' -f1)
	echo $ip' '$os >> openOsVersions.txt
done
grep Ports nmapServerVersion > openWebServersVersions.txt

#Exercise 3
nmap -p139,445 10.11.1.1-254 --open -oG nmapSmb
grep Ports nmapSmb | cut -d' ' -f2 > openSmb.txt

rm -f openSmbOsInfo.txt
touch openSmbOsInfo.txt
for ip in $(cat openSmb.txt); do
	nmap $ip --script smb-os-discovery.nse > osDiscovery
	cat osDiscovery | grep 'Host script results:' -A7 > osTemp
	rm osDiscovery
	echo $ip
	echo $ip >> openSmbOsInfo.txt
	cat osTemp >> openSmbOsInfo.txt 
	rm osTemp
done

cp openSmbOsInfo.txt ../ex4.3.4/openSmbOsInfo.txt
'

#Exercise 4
#nmap -sT == 122K OUTPUT
#nmap -sU == 181K OUTPUT
#nmap -sN == 261K OUTPUT
#nmap -sV == 357K OUTPUT
#nmap -O == 452K OUTPUT
