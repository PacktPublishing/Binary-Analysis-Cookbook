/*

ch04-example.c
by Michael Born
Date: 2019

*/


#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#include <ctype.h>


int main(int argc, char *argv[]) {

	if(argc == 3) {

		char *key = argv[1];
		char *pass = argv[2];
		char *key2 = "rot13";
		char *password = "TheBrownFoxJumpsThroughTheForest";
		double x;
		x = 14.0;
		double y;
		y = 41.0;
		double z;
		z = pow(x,y);
		z = sqrt(x);
		z = log(x);
		z = fmod(x,y);

		if((strcmp(key,key2) == 0) && (strcmp(pass,password) == 0)) {
			printf("%s\n", "success");
		}
		else {
			printf("%s\n", "failure, try again....");
		}
	}
	else {
		printf("\n\nUsage: %s %s %s\n\n\n\n", argv[0], "<key>", "<password>");
	}


	return 0;
}
