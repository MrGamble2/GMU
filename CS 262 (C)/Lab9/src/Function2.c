#include <stdio.h>
#include <stdlib.h>

#include "Function2.h"
#include "Lab9.h"
void Function2()
{
        int i = 0;
        int *p = (int *) malloc(sizeof(int) * ARRAY_SIZE);
        if (p == NULL)
        {
                fprintf(stderr, "Function2(): Error allocating p\n");
                exit(1);
        }

        printf("In Function2()...\n");

        for (i=0; i<ARRAY_SIZE; i++)
        {
                p[i]=i;
        }

        for (i=0; i<PARTIAL_SIZE; i++)
        {
                printf("Function2(): %s = %d,%s = %d ", PR(i),i,PR(p[i]), p[i]);
                printf("\n");
        }

        free(p);
}
