#include <stdio.h>
#include <stdlib.h>

int invert(int x, int p, int n)
{
	return x ^ ~(~0 << n) << (p+1-n);
 	
}

int main(void)
{
	int result = 0;
	result = invert(0x47, 4, 3);
	printf("The modified bit pattern is %x\n", result);
	exit(0);
}
