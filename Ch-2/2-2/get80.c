#include <stdio.h>
#include <stdlib.h>

#define MAXLINE 1000
enum loop {NO, YES};
enum loop okloop = YES;


int getline_1 (char line[], int lim);
int main(void)
{
	int len;
	char line[MAXLINE];

	while ((len = getline_1(line, MAXLINE)) > 0)
	{
		if (len > 80)
			printf("length: %d string: %s\n", len, line);	
	}
	exit (EXIT_SUCCESS);
}

int getline_1 (char s[], int lim)
{
	int c;
	int i, j;

	j = 0;
	for (i = 0; (c = getchar()) != EOF; ++i)
	{
		if (c == '\n')
			break;
		else if (i >= lim-2)
		else
		{
			s[j] = c;
			++j;
		}
			
	}
	/*for (i = 0; (c = getchar()) != EOF && c != '\n'; ++i)
	{
		if (i < lim-2)
		{
			s[j] = c;
			++j;
		}
	}*/
	if (c == '\n')
	{
		s[j] = c;
		++j;
		++i;
	}
	s[j] = '\0';
	return i;	
}
