#include <stdio.h>
#include <stdlib.h>

#define NUMBER 0
#define MAXOP 100

void ungetch(char c);
char getch(void);
void push(double f);
double pop(void);
int getop(char s[]);
int getline_1(char s[], int lim);

int main()
{
	int type, op2;
	double op1;
	char s[MAXOP] = {0};

	while((type = getop(s)) != EOF)
	{
		printf("value of type is %d\n", type);
		switch(type){
			case NUMBER:
				printf("Floating val %f\n", atof(s));
				push(atof(s));
				break;
			case '+':
				push(pop() + pop());
				break;
			case '*':
				push(pop() * pop());
				break;
			case '-':
				op1 = pop();
				push(pop() - op1);
				break;
			case '/':
				op1 = pop();
				push(pop() / op1);
				break;
			case '%':
				op2 = pop();
				push((int)pop() % op2);
				break;
			case '\n':
				printf("The result is %f\n", pop());
				break;
			default:
				printf("Invalid operand %s\n", s);
				break;
		}
	}
	exit(0);
}

#define MAXDPT 1000
int sp;
double val[MAXDPT];

void push(double f)
{
	if(sp < MAXDPT)
		val[sp++] = f;
	else
		printf("Stack Overflow\n");
}

double pop(void)
{
	if(sp > 0)
		return(val[--sp]);
	else
	{
		printf("Stack Empty\n");
		return 0.0;
	}
}

#define MAXLINE 1000
char line[MAXLINE];
int li = 0;

int getop(char s[])
{
	int i, c;

	if(line[li] == '\0')
		if(getline_1(line, MAXLINE) == 0)
			return EOF;
		else 
			li = 0;
	while ((s[0] = c = line[li++]) == ' ' || c == '\t')
		;
	s[1] = '\0';
		if(!isdigit(c) && c != '.')
			return c;
	i = 0;
		if(isdigit(c))
			while(isdigit(s[++i] = c = line[li++]))
				;
		if(c == '.')
			while(isdigit(s[++i] = c = line[li++]))
				;
		s[i] = '\0';
		li--;
		return NUMBER;
}

int getline_1(char s[], int lim)
{
	int i, c;
	int j = 0;
	for(i = 0; i < (lim -2) && (c = getchar()) != EOF && c != '\n'; i++)
	{
		s[j] = c;
		j++;
	}
	if (c == '\n')
	{
		s[j] = c;
		i++;
		j++;
	}
	s[j] = '\0';
	return i;
}

#define MAXCH 100
char get[MAXCH];
int cp;

char getch(void)
{
	return(cp > 0)	? get[--cp] : getchar();
}

void ungetch(char c)
{
	if (cp >= MAXCH)
		printf("Character overflow\n");
	else
		get[cp++] = c;
}
