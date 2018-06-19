nmap -p 25 -sT 10.11.1.1-254 -oG smtpIpTemp
cat smtpIpTemp | grep open | cut -d' ' -f2 > smtpIp
rm smtpIpTemp

rm -f pythonOutput
touch pythonOutput
for ip in $(cat smtpIp); do
	python verify.py $ip >> pythonOutput
done

rm -f vrfyIps
touch vrfyIps
for line in $(cat pythonOutput | grep ' 252 ' | cut -d' ' -f1); do
	echo $line >> vrfyIps
done

rm pythonOutput
