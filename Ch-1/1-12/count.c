#include <stdio.h>
#include <stdlib.h>
#define OUT 0
#define IN 1

int main()
{
	int c = 0, pos = OUT;	
	while ((c = getchar()) != EOF)
	{
		if (c == ' ' || c == '\t' || c == '\n')
		{
			if (pos == IN)
			{
				pos = OUT;
				putchar('\n');
			}
		}
		else if (pos == OUT)
		{
			pos = IN;
			putchar(c);
		}
		else if (pos == IN)
			putchar(c);
	}
		exit(EXIT_SUCCESS);
			
}
