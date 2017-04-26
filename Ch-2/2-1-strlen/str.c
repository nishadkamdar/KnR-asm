#include <stdio.h>
#include <stdlib.h>

int strl(char s[])
{
	int i=0;

	while (s[i] != '\0')
	{
		i++;
	}
	return i+1;
}

int main()
{
	int len;
	char s[] = "Hello, World";
	
	len = strl(s);
	printf("The length of the string is %d\n", len);
	exit (0);
}
