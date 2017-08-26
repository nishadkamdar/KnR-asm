#include <stdio.h>
#include <stdlib.h>

void itoa(int n, char s[]);
char s[100];

int main()
{
	itoa(1234567, s);
	printf("The ascii value is %s\n", s);
}

void itoa(int n, char s[])
{
	static int i = 0;

	if( n < 0 )
	{
		n = -n;
		s[i++] = '-';
	}

	if( n / 10 )
		itoa(n/10, s+i);
	s[i++] = n%10 + '0';
	s[i] = '\0';
}
