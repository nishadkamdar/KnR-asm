#include <stdio.h>
#include <stdlib.h>
#define OUT 0
#define IN 1

int main()
{
	int c = 0, cc = 0, nc = 0, wc = 0, pos = OUT;	
	while ((c = getchar()) != EOF)
	{
		++cc;
		if (c == '\n')
			++nc;
		if (c == ' ' || c == '\t' || c == '\n')
			pos = OUT;
		else if (pos == OUT)
		{
			pos = IN;
			++wc;
		}
	}
		printf ("%d %d %d\n", cc, nc, wc);
		exit(EXIT_SUCCESS);
			
}
