rm -f vulnSmb
touch vulnSmb
for ip in $(cat ../files/open_smb); do
	echo $ip
	for vuln in $(ls /usr/share/nmap/scripts/ | grep smb-vuln); do 
		echo ------------------------------------------------------------------------- >> vulnSmb
		echo $ip >> vulnSmb
		echo $vuln
		nmap -v --script=$vuln --script-args=unsafe=1 -p 445,139 $ip > vulnSmbTemp
		cat vulnSmbTemp >> vulnSmb
		rm vulnSmbTemp
	done
done
