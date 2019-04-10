/* 

libhider.c - quick xor functions for demonstrating iteration
by Michael born
Date 2019

*/

#include <stdio.h>


char hideMe(char a) {

	return a ^ 0xab;
}


char unhideMe(char b) {

	b ^= 0xab;
	return b;
}

