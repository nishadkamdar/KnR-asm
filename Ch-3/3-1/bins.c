#include <stdio.h>
#include <stdlib.h>

int v[10] = {21, 32, 42, 53, 64, 72, 77, 83, 94, 111};

int binsearch(int x, int a[], int n)
{
	int low, high, mid;
	low = 0;
	high = n-1;
	mid = (low + high)/2;
	while (low <= high && x != a[mid])
	{
		if (x < v[mid])
			high = mid - 1;
		else 
			low = mid + 1;
		mid = (high + low) / 2;
	}
	if (x == a[mid])
		return mid;
	else 
		return -1;	
}

int main(void)
{
	int result = 0;
	
	result = binsearch(111, v, 10);
	if (result != -1)
		printf ("Element found at position %d\n", result);
	else
		printf("Element not found\n");
	exit(0);
}

