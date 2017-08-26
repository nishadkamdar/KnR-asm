#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <string.h>

#define DEFAULT 10
#define MAXLINE 100
#define MAXLEN 100

int getline_1 (char *line, int maxlen);
int getinput (char *ptr[], int maxline);

char *inptr[MAXLINE];

int main (int argc, void *argv[]) {
	
	int linecnt = 0;
	int i;
	int n = DEFAULT;
	int strptr = 0;

	for (i = 0; i < MAXLINE; i++)
	{	
		inptr[i] = NULL;
	}
	
	linecnt = getinput (inptr, MAXLINE);
	
	if (linecnt <= n)
	{
		n = linecnt;
		strptr = 0;
	}
	else 
	{
		i = 0;
		while (inptr[i] != NULL)
			i++;
		strptr = (i - DEFAULT);
	}
	
	for (i = 0; i < n; i++)
	{
		printf ("%s\n", inptr[strptr++]);
	}
	
}

int getline_1 (char *line, int maxlen) {
	char c;
	int len = 0;

	for (len = 0; (len < MAXLEN) && ((c = getchar()) != '\n') && c != EOF; len++) {
		line[len] = c;
	}
	len++;
	if (c == '\n') {
		line[len++] = c;
		line[len] = '\0';
	}
	else if (c == EOF) 
		return -1;
	return len;
}

int getinput (char *ptr[], int maxline) {
	int i;	
	for (i = 0; i < maxline; i++)
	{
		ptr[i] = malloc (MAXLEN);
		if (getline_1 (ptr[i], MAXLEN) < 0)
		{
			return i;
		}

	}
		
}
