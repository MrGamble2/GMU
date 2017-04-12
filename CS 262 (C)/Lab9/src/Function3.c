#include <stdio.h>
#include <stdlib.h>

#include "Function3.h"
#include "Lab9.h"
void Function3()
{
        int i = 0;
        int *p = (int *) malloc(sizeof(int) * ARRAY_SIZE);
        if (p == NULL)
        {
                fprintf(stderr, "Function3(): Error allocating p\n");
                exit(1);
        }

        printf("In Function3()...\n");

        for (i=0; i<ARRAY_SIZE; i++)
        {
                p[i]=i;
        }

        for (i=0; i<PARTIAL_SIZE; i++)
        {
                printf("Function3(): %s = %d,%s = %d ", PR(i),i,PR(p[i]), p[i]);
                printf("\n");
        }

        free(p);
}
