#include <stdio.h>
#include <stdlib.h>

int main()
{
	int b=0,t=0,n=0,cnt=0,c=0;
	
	while ((c = getchar()) != EOF)
		if (c == ' ')
			++b;
		else if (c == '\t')
			++t;
		else if (c == '\n')
			++n;
		else
			++cnt;
	printf ("blanks = %d\ntabs = %d\nnewline = %d\nletter cnt = %d\n", b, t, n, cnt);
		exit(EXIT_SUCCESS);
			
}
