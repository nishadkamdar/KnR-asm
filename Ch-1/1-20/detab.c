#include <stdio.h>
#include <stdlib.h>

#define TABSTOP 8
int main()
{
	int c, i, n;

	i = 0;
	while ((c = getchar()) != EOF)
	{
		if (c == '\t')
		{
			n = (TABSTOP - (i % TABSTOP));
			while (n > 0)
			{
				putchar(' ');
				++i;
				--n;
			}
		}
		else if(c == '\n')
		{
			putchar(c);
			i = 0;
		}
		else
		{
			putchar (c);
			++i;
		}
	}	
}
