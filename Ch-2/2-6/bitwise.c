#include <stdio.h>
#include <stdlib.h>

int setbits(int x, int n, int p, int y)
{
	return x & ~(~(~0 << n) << (p+1-n)) |
                (y & ~(~0 << n)) << (p+1-n);
}

int main(void)
{
	int result = 0;
	result = setbits (0x47, 4, 3, 0x12);
	printf("The modified bit pattern is %x\n", result);
	exit(0);
}
