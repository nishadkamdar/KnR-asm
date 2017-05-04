#include <stdio.h>
#include <stdlib.h>

int ovfl;
char s1[100] = "Hello";
char s2[100] = "l";

char *any(char s1[], char s2[])
{
	int i, j, k;
	
	for (i = 0, k = 0; s1[i] != '\0'; i++)
	{
		
		
		for(j = 0; s1[i] != s2[j]; j++)
		{
			if(s2[j] == '\0')
				{
					ovfl = 1;
					break;
				}
		}
		if (ovfl == 0)
			return (&s1[i]);
		ovfl = 0;
	}
}
int main(void)
{
	char *c;
	c = any(s1, s2);
	printf("Matching char found at: %c\n", *c);
	exit(0);
}
