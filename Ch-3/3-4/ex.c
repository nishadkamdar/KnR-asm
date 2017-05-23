#include <stdio.h>
#include <stdlib.h>

#define abs(x) ((x) < 0 ? -(x) : (x))
#define MAXLINE 1000
void itoa(int n, char s[]);
void reverse(char s[]);

char t[MAXLINE]; 
int main (void)
{
        int len = 0;

        itoa (-2147483648, t);
        printf("%s\n", t);
        /*while ((len = getline_1(t, MAXLINE)) > 0)
 *         {
 *                         expand(t, s);
 *                                         printf("%s\n", s);
 *                                                 }*/
        exit(0);
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

void itoa(int n, char s[])
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
}

