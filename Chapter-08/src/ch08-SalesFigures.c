#include <stdio.h>
#include <string.h>
#include <stdlib.h>



int main(void) {

	char pw[] = {0x42,0x69,0x6e,0x61,0x72,0x79,0x41,0x6e,0x61,0x6c,0x79,0x73,0x69,0x73,0x49,0x73,0x53,0x6f,0x4d,0x75,0x63,0x68,0x46,0x75,0x6e,0x21,0x00};

	printf("\nHello, and welcome to Chapter 08!\n");
	printf("Please enter the password to connect: \n");
	char dataEntry[27];
	char passWord[27];
	gets(dataEntry);
	printf("You entered: ");
	printf(dataEntry);
	printf("\n");
	int comparison;
	comparison = strcmp(dataEntry, pw);
	if (comparison == 0) {
		printf("Password is correct!\n");
		printf("\n\nThis month's sales are as follows.\n\nMonth\t\tYear\t\tTotal Sales\n\nJanuary\t\t2018\t\t$140,000\nFebruary\t2018\t\t$235,000\nMarch\t\t2018\t\t$193,000\nApril\t\t2018\t\t$225,456\nMay\t\t2018\t\t$130,456\nJune\t\t2018\t\t$213,389\nJuly\t\t2018\t\t$238,948\nAugust\t\t2018\t\t$234,209\n\September\t2018\t\t$132,837\nOctober\t\t2018\t\t$237,382\nNovember\t2018\t\t$281,387\nDecember\t2018\t\t$228,189\n");
	}
	else {
		printf("Sorry, password incorrect....\n");
	}
	return 0;
}
