#include <stdio.h>

char str[] = "123"; 

int myatoi(char s[])
{
	int i, n = 0;
	
	for (i = 0; s[i] >= '0' && s[i] <= '9'; ++i)
		n = 10 * n + (s[i] - '0');
	return n;
}

int main (void)
{
	int num;
	
	num = myatoi(str);
	printf("Integer is %d\n", num);
}
