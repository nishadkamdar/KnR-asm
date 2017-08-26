#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <string.h>

int daytab[2][13] = {
	{0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31},
	{0, 31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31}
};

int day_of_year (int year, int month, int day);
void month_and_day (int year, int yearday, int *month, int *day);
char *month_name (int idx);

int main(void) {
	
	int dayinyr;
	int month, day;
	dayinyr = day_of_year (2004,2, 23);
	printf ("Year: 2004, Month: Feb, Day: 23 : %d \n", dayinyr);
	
	month_and_day (2004, dayinyr, &month, &day);
	printf ("Year: 2004, Dayinyr: %d, Month: %d, Day_in_month: %d\n", dayinyr, month, day);
	
	char *name = month_name(month);
	printf("Month name is: %s\n", name);
	exit (0);
}

int day_of_year (int year, int month, int day) {
	int i, leap;
	leap = year%4 == 0 && year%100 != 0 || year % 400 == 0;
	if (month < 1 || month > 12)
		return -1;
	if (day < 1 || day > daytab[leap][month] )
		return -1;
	for (i = 0; i < month; i++)
		day += daytab[leap][i];
	return day;
}

void month_and_day (int year, int yearday, int *month, int *day) {
	int i, leap;
	leap = year%4 == 0 && year%100 != 0 || year % 400 == 0;
	
	for (i = 0; i <=12 && yearday > daytab[leap][i]; i++) {
		yearday -= daytab[leap][i];	
	}
	if (i > 12 && yearday > daytab[leap][12]) {
		*month = -1;
		*day = -1;
	}
	*month = i;
	*day = yearday;
}

char *month_name (int idx) {
	
	static char *name[] = {
		"Illegal month", "Jan", "Feb", "Mar", "April", "May", "June", "July", "August", "Sept", "Oct", "Nov", "Dec"
	};

	return (idx < 1 || idx > 12) ? name[0]: name[idx];
}
