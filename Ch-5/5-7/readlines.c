#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <string.h>

#define MAXLINE 5000
#define MAXLEN 1000

char *lineptr[MAXLINE];

int readline(char *lineptr[], char *store,  int max_lines);
int writeline(char *lineptr[], int nlines);
int getlines(char *line, int max_len);

int main(void) {
	int nlines = 0;
	char lstore[MAXLEN];

	if ((nlines = readline (lineptr, lstore, MAXLINE)) >= 0)
		writeline (lineptr, nlines);
	else
		printf ("Input too big to sort\n");
	exit(0);
}

int readline(char *lineptr[], char *store, int max_lines) {
	int len = 0;
	char line[MAXLEN];
	int numlines = 0;
	char *p = store;
	char *linestop = store + MAXLINE;

	while ((len = getlines (line, MAXLEN)) > 0)
		if (numlines >= MAXLINE || p + len > linestop)
			return -1;
		else {
			line[len-1] = '\0';
			strcpy (p, line);
			lineptr[numlines++] = p;
			p += len;
		}
		return numlines;
}

int writeline (char *lineptr[], int nlines) {
	int i;
	for (i = 0; i < nlines; i++) {
		printf("%s\n", lineptr[i]);
	}
}

int getlines (char *line, int max_len) {
	int c;
	char *t = line;

	while (--max_len > 0 && (c = getchar()) != EOF && c != '\n')
		*line++ = c;
	if (c == '\n')
		*line++ = c;
	*line = '\0';
	return line-t;
}

