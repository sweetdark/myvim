#include <stdio.h>

int main(int args, char *argv[])
{
	printf("please input your name\n");
	char name[128] = {0,};
	scanf("%s", name);
	printf("hello %s\n", name);
	return 0;
}
