#include <stdio.h>
#include <stdlib.h>

#define NONBLANK 'a'

int main()
{
	int c=0, lastc=0;
	
	lastc = NONBLANK;
	while ((c = getchar()) != EOF)
	{
		if (c != ' ')
			putchar(c);
		if (c == ' ')
			if (lastc != ' ')
				putchar (c);
		lastc = c;
	}
		exit(EXIT_SUCCESS);
			
}
