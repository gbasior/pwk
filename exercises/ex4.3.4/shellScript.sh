nmap -v -p 139,445 10.11.1.1-254 --script smb-os-discovery -oG nmapSmb
'
rm -f nmapVuln
touch nmapVuln
for ip in $(grep Windows nmapSmb | cut -d" " -f2); do
	for vuln in $(ls /usr/share/nmap/scripts/ | grep smb-vuln | cut -d"." -f1); do
		nmap -v -p 139,445 --script=$vuln --script-args=unsafe=1 $ip -oG nmapVulnTemp
		cat nmapVulnTemp >> nmapVuln
		rm -f nmapVulnTemp
	done
done


rm -f nbtScan
touch nbtScan
for ip in $(grep Windows nmapSmb | cut -d" " -f2); do
	nbtscan -r $ip >> nbtScan
done
'
