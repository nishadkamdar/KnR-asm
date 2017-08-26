#include <stdlib.h>
#include <stdio.h>

//char arr1[10] = {'h', 'e', 'l', 'l', 'o'};
char arr1[10] = "hello";
char arr2[20] = "world";

void strncpy1(char *s, char *t, int n);

int main()
{
	strncpy1(arr1, arr2, 5);
	printf("%s\n", arr1);
	exit(0);
}

void strncpy1(char *s, char *t, int n)
{
	while(*t && n-- > 0)
		*s++ = *t++;
	while(n-- > 0)
		*s++ = '\0';
}
