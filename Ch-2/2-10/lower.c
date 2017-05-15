#include <stdio.h>
#include <stdlib.h>

int lower(int c)
{
	int ch;

	ch = (c >= 'A' && c <= 'Z') ? (c + 'a' - 'A') : c;
	
	return ch;
}

int main(void)
{
	int c;
	c = lower('A');
	printf("The lower case of 'A' is %c\n", c);
	exit(0);
}

