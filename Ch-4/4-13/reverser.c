#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void reverser(char s[], int i, int len);
char s[100] = "Hello World!!";

int main()
{
	reverser(s, 0, strlen(s));
	printf("The ascii value is %s\n", s);
}

void reverser(char s[], int i, int len)
{
	int j = len - 1 -i;
	int temp; 

	if( i < j )
	{
		temp = s[i];
		s[i] = s[j];
		s[j] = temp;
		reverser(s, ++i, len);
	}

}
