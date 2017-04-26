#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

int main (void)
{
	printf("Signed char min = %d\n", SCHAR_MIN);
	printf("Signed char min = %d\n",-(char)((unsigned char)~0 >> 1));
	exit (0);
}
