/*
	ch04-ctf.c
	by Michael Born
	Date: 2019
*/


#include <stdio.h>

#define HIDER(a) (a)^0xbc
#define UNHIDE(a) (a)^=0xbc


int main(void) {
	char msg[] = {HIDER('T'), HIDER('h'), HIDER('e'), HIDER('S'), HIDER('e'), HIDER('c'), HIDER('r'), HIDER('e'), HIDER('t'), HIDER('P'), HIDER('a'), HIDER('s'), HIDER('s'), HIDER('w'), HIDER('o'), HIDER('r'), HIDER('d'), HIDER('\0') };

	for(int i = 0; i < sizeof(msg); i++) {
		msg[i] = UNHIDE(msg[i]);
	}
	printf("\n\nThe unlock code is: %s\n\n\n", msg);
}
