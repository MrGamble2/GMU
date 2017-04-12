#include <stdio.h>
#include <stdlib.h>

int main()
{
  //int i, count
  int i, count;
  //int sum = 0;
  int sum;

  printf("Enter an integer -> ");
  //scanf("%d", count);
  scanf("%d", &count);
  
  //for (i == 0; i < count; i++);
  //for (i = 0; i < count; i++);
  //for (i = 0; i < count; i++)
  for (i = 0; i <= count; i++)
  {
    //sum = count;
    sum += i;
    printf("i = %d sum = %d\n", i, sum);
  }

  printf("The sum of integers 0 to %d is: %d\n", count, sum);

  return 0;
}
