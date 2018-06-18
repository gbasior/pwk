nmap -v -sn -oG nmapSweep 10.11.1.1-254
rm -f nmapWebSweep
touch nmapWebSweep
for ip in $(grep Up nmapSweep | cut -d" " -f2); do
	nmap -p 80 $ip -oG nmapWebSweepTemp
	cat nmapWebSweepTemp >> nmapWebSweep
done
rm -f nmapVersion
touch nmapVersion
for ip in $(grep open nmapWebSweep | cut -d" " -f2); do
	nmap -p 80 $ip -O -sV -oG nmapVersionTemp
	cat nmapVersionTemp >> nmapVersion
done

nmap -p139,445 10.11.1.1-254 --open -oG nmapSmb
