#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>

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
	char s[MAXOP];

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
	static int c;
	int c1; 
	static int flag;
	int sign = 0;
	int i;

	if (flag == 0)
		c = getchar();

	while((s[0] = c) == ' ' || c == '\t')
		c = getchar();
	s[1] = '\0';
	if (!isdigit(c) && c != '.')
	{
		//if(c == '\n')
			flag = 0;
		//else 
		//	flag = 1;
		return c;
	}
	i = 0;
	if(isdigit(c))
	{//while(isdigit(s[++i] = c = getchar()))
	//	;
		++i;
		while(isdigit(c = getchar()))
			s[i] = c;
	}
	if (c == '.')
		while(isdigit(s[++i] = c = getchar()))
			;
	s[i] = '\0';
	flag = 1;
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
