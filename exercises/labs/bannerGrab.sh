for ip in $(cat ../files/open_ip); do 
	echo $ip
	echo QUIT | nc -nv $ip 80 > bannerGrab
done
