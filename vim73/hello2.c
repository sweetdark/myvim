#include <stdio.h>
#include <string.h>
#include <stdlib.h>

char* upcase(char *str)
{
  if (NULL == str)
  {
    return str;
  }

  char *ptr = str;
  while(*str != '\0')
  {
    if(*str >= 97)
      *str -= 32;
    str++;
  }
  return ptr;
}

int main(int args, char *argv[])
{
  printf("please input your name\n");
  char *name = (char*)malloc(128);
  scanf("%s", name);
  upcase(name);
  printf("upcase name is %s\n", name);
  if (strcmp(name, "ALICE") != 0 && strcmp(name, "BOB") != 0)
  {
    printf("sorry you are not Alice or Bob\n");	
  }
  else
    printf("hello %s\n", name);
  free(name);
  return 0;
}

