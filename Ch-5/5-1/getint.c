#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#define SIZE 10

void ungetch(int c);
int getch(void);

int main(void)
{
	int arr[SIZE] = {0};
	int n;
	int getint(int *pn);
	int i;
	for(n = 0; getint(&arr[n]) != EOF; n++);

	for(i = 0; i < n; i++)
		printf("arr[%d] = %d\n", i, arr[i]);
}

int getint(int *pn)
{
	int c, d, sign;
	while(isspace(c = getch()))
		;
	if(!isdigit(c) && c != EOF && c != '-' && c != '+')
	{
		ungetch(c);
		return 0;
	}
	
	sign = (c == '-') ? -1 : 1;
	if( c == '+' || c == '-')
	{
		d = c;
		if(!isdigit(c = getch()))
		{
			if(c != EOF)
				ungetch(c);
			ungetch(d);
			return d;
		}
	}
	for(*pn = 0; isdigit(c); c = getch())
		*pn = 10 * *pn + (c - '0');
	*pn *= sign;
	if(c != EOF)
		ungetch(c);
	return c;
}

#define BUFSIZE 100

int buff[BUFSIZE];
int bufp = 0;

int getch(void)
{
	return(bufp > 0) ? buff[--bufp] : getchar();
}

void ungetch(int c)
{
	if(bufp >= BUFSIZE)
		printf("ungetch: too many characters\n");
	else
		buff[bufp++] = c;
}
