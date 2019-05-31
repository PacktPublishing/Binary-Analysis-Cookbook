#include <stdio.h>
#include <string.h>
#include <stdlib.h>



int main(void) {


	printf("\nHello, and welcome to Chapter 08!\n");
	printf("Please enter the password to connect: \n");
	char dataEntry[27];
	char pw[] = {0x42,0x69,0x6e,0x61,0x72,0x79,0x41,0x6e,0x61,0x6c,0x79,0x73,0x69,0x73,0x49,0x73,0x53,0x6f,0x4d,0x75,0x63,0x68,0x46,0x75,0x6e,0x21,0x00};
	gets(dataEntry);
	printf("You entered: ");
	printf(dataEntry);
	printf("\n");
	int comparison;
	comparison = strcmp(dataEntry, pw);
	if (comparison == 0) {
		printf("Password is correct!\n");
		FILE * filePointer;
		char fileChar;
		filePointer = fopen(".data.dat", "r");
		if(filePointer == NULL) {
			printf("\n\nCannot open file.\nPlease make sure the file exists and the user has the correct permissions\n");
			exit(1);
		}
		else {
			printf("\nReading file...\n\n");
			while(fileChar != EOF) {
				fileChar = fgetc(filePointer);
				putchar(fileChar);
			}
			fclose(filePointer);
		}
	}
	else {
		printf("Sorry, password incorrect....\n");
	}
	return 0;
}
