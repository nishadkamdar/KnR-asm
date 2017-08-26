#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>

void ungetch(int c);
int getch(void);
int strend(char *s, char *t);

int main(void)
{
	char *str1 = "";
	char *str2 = "";

	if(!strend(str1, str2))
		printf("Failure\n");
	else
		printf("Success\n");

	exit(0);
}


int strend(char *s, char *t)
{
	char *bt = t;
	char *bs = s;

	for(; *s; s++)
		;
	for(; *t; t++)
		;

	for(; *s == *t; s--, t--)
		if(t == bt && s != bs)
			if(*t == *s && *s != '\0')
				return 1;
			else
				return 0;
		else if(t == bt && s == bs)
			if(*t == *s && *s != '\0')
				return 1;
			else
				return 0;
		else if(t != bt && s == bs)
			return 0;
		
}

int getfloat(float *pn)
{
	int c, d, sign;
	float power;
	while(isspace(c = getch()))
		;
	if(!isdigit(c) && c != EOF && c != '-' && c != '+' && c != '.')
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
	if (c == '.')
		c = getch();
	for(power = 1.0; isdigit(c); c = getch())
	{
		*pn = 10 * *pn + (c - '0');
		power *= 10;
	}
	*pn *= sign/power;
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
