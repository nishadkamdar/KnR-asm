#include <stdio.h>
#include <stdlib.h>

int bitcount (unsigned int x)
{
	int cnt=0;
	while (x &= (x-1))
		cnt++;
	return cnt; 
}

int main (void)
{
	int i; 
	unsigned int x = 0xf0;
	i = bitcount(x);
	printf("The number of 1s in the integer are: %u\n", i);
	exit(0);
}
