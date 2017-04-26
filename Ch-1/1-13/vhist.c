#include <stdio.h>

#define OUT 0
#define IN 1
#define MAXWORD 11
#define MAXHIST 15

int main()
{
	int c = 0, nc = 0, pos = OUT, ovflow = 0;
	int maxvalue = 0, len, i;	
	int wl[MAXWORD];
	
	for (i = 0; i < MAXWORD; ++i)
	{
		wl[i] = 0;
	}	
	while ((c = getchar()) != EOF)
	{
		if (c == ' ' || c  == '\n' || c == '\t')
		{	
			pos = OUT;
			if (nc > 0)
				if (nc < MAXWORD)
					++wl[nc];
				else 
					++ovflow;
			nc = 0;
		}
		else if (pos == OUT)
		{
			pos = IN;
			nc = 1;
		}
		else
			++nc;	
	}
	
	maxvalue = 0;
	for (i = 1; i < MAXWORD; ++i)
		if (wl[i] > maxvalue)
			maxvalue = wl[i];

	for (i = 1; i < MAXWORD; ++i)
	{	
		printf("%5d - %5d :", i , wl[i]);
		if (wl[i] > 0)
		{
			if ((len = wl[i]) <= 0)
				len = 1;	
		}
		else
			len = 0;
		while (len > 0)
		{
			putchar ('*');
			--len;
		}
		putchar ('\n');
	}
	if (ovflow > 0)
		printf("There are %d words >= %d\n", ovflow, MAXWORD);
}
