/*

ch03-helloworld64.c
A program to print 
'Hello, World!'
to STDOUT
by Michael Born
Date - 2019

*/


/* we've included more libraries than necessary for the purpose of the recipe */

#include <stdio.h>
#include <math.h>
#include <ctype.h>
#include <string.h>


#define MANGLER(a) (a) ^ 0xAB
#define UNMANGLER(b) (b) ^ 0xAB

int main(void) {
	char message[] = {MANGLER('H'), MANGLER('e'), MANGLER('l'), MANGLER('l'), MANGLER('o'), MANGLER(','), MANGLER(' '), MANGLER('W'), MANGLER('o'), MANGLER('r'), MANGLER('l'), MANGLER('d'), MANGLER('!'), MANGLER('\n'), MANGLER('\0')};
	char decodedMsg[sizeof(message)];

	for(int i = 0;i < sizeof(message);i++) {
		decodedMsg[i] = UNMANGLER(message[i]);
	}

	printf("%s", decodedMsg);
}
