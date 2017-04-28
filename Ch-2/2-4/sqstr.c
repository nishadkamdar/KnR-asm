#include <stdio.h>
#include <stdlib.h>

char s1[100] = "Hello";
char s2[100] = "He";

void squeeze(char s1[], char s2[])
{
	int i, j, k;
	
	for (i = 0, k = 0; s1[i] != '\0'; i++)
		for(j = 0; s1[i] != s2[j]; j++)
			if(s2[j] == '\0')
				{
					s1[k++] = s1[i];
					break;
				}
	s1[k] = '\0';	
}
int main(void)
{
	squeeze(s1, s2);
	printf("Truncated string: %s", s1);
	exit(0);
}
