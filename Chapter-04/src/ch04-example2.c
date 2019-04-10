/*

ch04-example2.c - demonstrate the use of shared libraries
by: Michael Born
Date: 2019

*/

#include <stdio.h>


int main(void) {

	char hiddenMessage[] = {hideMe('H'), hideMe('i'), hideMe('d'), hideMe('d'), hideMe('e'), hideMe('n'), '\0'};
	printf("The hidden message is %s\n", hiddenMessage);

	for(int i = 0;i < sizeof(hiddenMessage); i++) {
		if(hiddenMessage[i] != '\0') {
			hiddenMessage[i] = unhideMe(hiddenMessage[i]);
		}
	}

	printf("The unhidden message is %s\n", hiddenMessage);
	return 0;
}
