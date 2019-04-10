




/*
ch04-example.c
by Michael Born
date: 2019
*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>
 
#define HIDEIT(a)	(a) ^ 0xab
#define UNHIDE(a)	(a) ^= 0xab

int main(void) {

	char hardCodedPassword[] = "HardCodedPassword";
	char hiddenMessage[] ={ HIDEIT('S'), HIDEIT('e'), HIDEIT('c'), HIDEIT('r'), HIDEIT('e'), HIDEIT('t'), HIDEIT(' '), HIDEIT('M'), HIDEIT('e'), HIDEIT('s'), HIDEIT('s'), HIDEIT('a'), HIDEIT('g'), HIDEIT('e'), '\0' };
	char userInput[sizeof(hardCodedPassword)];

	printf("Please enter the password to unlock the hidden message: ");
	scanf("%s", userInput);
	if(strcmp(userInput,hardCodedPassword) == 0) {
		for(int i = 0;i < sizeof(hiddenMessage);i++) {
			if(hiddenMessage[i] != '\0') {
				UNHIDE(hiddenMessage[i]);
			}
		}
		printf("The hidden message is \'%s\'\n", hiddenMessage);
	}
	else {
		printf("Wrong, run the program again...");
	}
	return 0;
}
