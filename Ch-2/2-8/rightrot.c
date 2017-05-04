#include <stdio.h>
#include <stdlib.h>

int wordlength(void)
{
	int i = 0;
	unsigned int v = (unsigned)~0;
	while (!v)
	{
		v <<= 1;
		++i;
	}
	return i;
}
int rightrot(int x, int n)
{
	int wl = wordlength();
	return (x & ~(~0 << n)) << (wl-n) | (x & (~0 << n)) >> n;
}

int main(void)
{
	int result = 0;
	result = rightrot(0x47, 4);
	printf("The modified bit pattern is %x\n", result);
	exit(0);
}
