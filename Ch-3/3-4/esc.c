#include <stdio.h>
#include <stdlib.h>

#define MAXLINE 1000
#define abs(x) ((x) < 0 ? -(x) : (x))

char s[MAXLINE];
char t[MAXLINE];
char line[MAXLINE];

void escape(char strout[], char strin[]);
void unescape(char strout1[], char strin1[]);
void expand (char s1[], char s2[]);
void itoa(int n, char s[]);
void reverse(char s[]);

int main (void)
{
	int len = 0;
	
	//itoa (-2147483648, t);	
	itoa (-21112, t);	
	printf("%s\n", t);
	/*while ((len = getline_1(t, MAXLINE)) > 0)
	{
		expand(t, s);
		printf("%s\n", s);
	}*/
	exit(0);
}

int getline_1(char inp[], int lim)
{
	int c, i, j;
	
	j = 0;
	for(i = 0; (c = getchar()) != EOF; ++i)
	{
		if(i < lim - 1)
		{
			inp[j] = c;
			++j;
		}
	}
	inp[j] = '\0';
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

/*void itoa(int n, char s[])
{
	int sign, i = 0;
	int in;
	sign = n;
	do
	{
		s[i++] = abs(n%10) + '0';
	}
	while ((n/=10) != 0);
	if (sign < 0)
	{
		s[i++] = '-';
	}
	s[i] = '\0';
	reverse(s);	
}*/

void itoa(int n, char s[])
{
	int sign, i = 0;
	int in;
	sign = n;
	if (n < 0)
		n = -n;
	do
	{
		s[i++] = (n%10) + '0';
	}
	while ((n/=10) != 0);
	if (sign < 0)
	{
		s[i++] = '-';
	}
	s[i] = '\0';
	reverse(s);	
}

void expand (char s1[], char s2[])
{
	char c;
	int i, j;
	i = j = 0;
	while ((c = s1[i++]) != '\0')
	{
		if (s1[i] == '-' && s1[i+1] >= c)
		{
			i++;
			while (c < s1[i])
				s2[j++] = c++;
		}
		else 
			s2[j++] = c;
	}
	s1[j] = '\0';	
}

void escape(char strout[], char strin[])
{	
	int i, j;
	for(i = j = 0; strin[i] != '\0'; i++)
	{
		switch (strin[i]) 
		{
			case '\n':
				strout[j++] = '\\';
				strout[j++] = 'n';
				break;
			case '\t':
				strout[j++] = '\\';
				strout[j++] = 't';
				break;
			case '\\':
				strout[j++] = '\\';
				strout[j++] = '\\';
				break;
			case '\b':
				strout[j++] = '\\';
				strout[j++] = 'b';	
				break;
			default:
				strout[j++] = strin[i];
				break;
		}
	}
	strout[j] = '\0'; 
}

void unescape(char strout1[], char strin1[])
{	
	int i, j;
	for(i = j = 0; strin1[i] != '\0'; i++)
	{
		switch (strin1[i]) 
		{
		case '\\':
			switch(strin1[++i])
			{
			case 'n':
				strout1[j++] = '\n';
				break;
			case 't':
				strout1[j++] = '\t';
				break;
			case '\\':
				strout1[j++] = '\\';
				break;
			case 'b':
				strout1[j++] = '\b';	
				break;
			default:
				strout1[j++] = '\\';
				strout1[j++] = strin1[i];
				break;
			}
			break;
		default:	
			strout1[j++] = strin1[i];
			break;
		}
	}
	strout1[j] = '\0'; 
}
