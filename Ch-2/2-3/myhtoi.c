#include <stdio.h>
#include <stdlib.h>

#define IN 1
#define OUT 0

char s[] = "0x123";
int flag = OUT;

int myhtoi(char s[])
{
	int i, n = 0;
	
	for (i = 0; s[i] >= '0' && s[i] <= '9' || s[i] >= 'A' && s[i] <= 'F' || s[i] >= 'a' && s[i] <= 'f'; i++)
	{
		if (s[i] == '0' && flag == OUT)
		{
			i++;
			if (s[i] == 'x' || s[i] == 'X') 
			{
				flag = IN;
			}
		}
		if (flag == IN)
		{
			if ( s[i] >= '0' && s[i] <= '9' )
				n = n * 16 + (s[i] - '0');
			else if ( s[i] >= 'A' && s[i] <= 'F' )
				n = n * 16 + (s[i] - 'A') + 10;
			else if ( s[i] >= 'a' && s[i] <= 'f' )
				n = n * 16 + (s[i] - 'a') + 10;
		}
	}
	return n;
}

int main(void)
{
		int num = myhtoi(s);
		printf("The decimal equ of 0x123 is %d\n", num);
		exit(0);
}
