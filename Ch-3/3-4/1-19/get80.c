#include <stdio.h>
#include <stdlib.h>

#define MAXLINE 1000

int getline_1 (char line[], int lim);
int remove_1(char line[]);
void reverse(char line[]);
int main(void)
{
	char line[MAXLINE];

	while ((getline_1(line, MAXLINE)) > 0)
		if (remove_1(line) > 0)
		{
			reverse (line);	
				printf("%s", line);
		}
	exit (EXIT_SUCCESS);
}

int getline_1 (char s[], int lim)
{
	int c;
	int i, j;

	j = 0;
	for (i = 0; (c = getchar()) != EOF && c != '\n'; ++i)
	{
		if (i < lim-2)
		{
			s[j] = c;
			++j;
		}
	}
	if (c == '\n')
	{
		s[j] = c;
		++j;
		++i;
	}
	s[j] = '\0';
	return i;	
}

int remove_1 (char s[])
{
	int i;
	i = 0;
	while (s[i] != '\n')
		++i;
	--i;
	while (i >= 0 && (s[i] == ' ' || s[i] == '\t'))	
		--i;
	if (i >= 0)
	{
		++i;
		s[i] = '\n';
		++i;
		s[i] = '\0';
	}
	return i;	
}

void reverse(char s[])
{
	int i,j;
	char temp;
	
	i = 0;
	while (s[i] != '\0')
		++i;
	--i;
	if (s[i] == '\n')
		--i;
	for (j = 0; j < i; ++j,--i)
	{
		temp = s[j];
		s[j] = s[i];
		s[i] = temp;
	}
	
}
