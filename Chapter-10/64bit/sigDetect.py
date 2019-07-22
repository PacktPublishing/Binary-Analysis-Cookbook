#!/usr/bin/env python


import sys
import binascii

if len(sys.argv) < 2:
  print '\nError! No arguments supplied. Must supply at least one filename to examine.'
  print 'Usage: ' + sys.argv[0] + ' <filename to examine>\n\n'
  sys.exit(1)

#look for common signatures
signature = {'4883c03b', '687361622f2f2f2f6e69622f2f2f2f2f', binascii.hexlify('/bin/bash'), binascii.hexlify('//bin//bash'), binascii.hexlify('/////bin////bash'), '/////bin'[::-1].encode('hex'), '////bash'[::-1].encode('hex'), binascii.hexlify('////bash'), binascii.hexlify('/////bin')}

inputFile = open(sys.argv[1],'rb')

hexInput = binascii.hexlify(inputFile.read())
j = 0
for i in signature:
  if i in hexInput:
    print 'SIGNATURE DETECTED!!!!'
    print 'Signature found is: %s' % i
    j += 1
if j == 0:
  print '\n\nNo Signatures detect...\n\n'
sys.exit(0)
