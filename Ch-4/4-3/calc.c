#include <stdio.h>
#include <stdlib.h>

#define NUMBER 0
#define MAXOP 100

void ungetch(char c);
char getch(void);
void push(double f);
double pop(void);
int getop(char s[]);

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

int getop(char s[])
{
	int c, c1;
	int sign = 0;
	int i;
	while((s[0] = c = getch()) == ' ' || c == '\t')
		;
	printf("C = %d", c);
	s[1] = '\0';
	if (!isdigit(c) && c != '.')
	{
		if(c == '-' || c == '+')
		{
			if(isdigit(c1 = getch()))
			{
				sign = 1;
				c = c1;
				s[1] = c;
			}
			else
			{
				ungetch(c1);
				return c;
			}
		}
		else 
			return c;
	}
	if (sign == 1)
		i = 1;
	else 
		i = 0;
	if(isdigit(c))
		while(isdigit(s[++i] = c = getch()))
			;
	if (c == '.')
		while(isdigit(s[++i] = c = getch()))
			;
	s[i] = '\0';
	printf("hello\n");
	if(c != EOF)
		ungetch(c);
	return (NUMBER);
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
