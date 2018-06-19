#!/usr/bin/python

import sys
import socket
import select

s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
s.connect((sys.argv[1],25))
s.setblocking(0)

ready = select.select([s], [], [], 1)

if(ready[0]):
    banner = s.recv(4096)
    print banner

s.send('VRFY bob\r\n')

ready = select.select([s], [], [], 1)

if(ready[0]):
    reply = s.recv(4096)
    print sys.argv[1] + " " + reply
