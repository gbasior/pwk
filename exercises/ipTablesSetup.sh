iptables -I INPUT 1 -s 10.11.1.31 -j ACCEPT
iptables -I OUTPUT 1 -d 10.11.1.31 -j ACCEPT
iptables -Z

nmap -sT 10.11.1.31
