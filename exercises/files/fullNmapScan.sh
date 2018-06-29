nmap -v -A -sT 10.11.1.1-254 -oN fullTcpScan -oG fullTcpGrepScan | tee fullTcpScanOutput
nmap -v -A -sU 10.11.1.1-254 -oN fullUdpScan -oG fullUdpGrepScan | tee fullUdpScanOutput
