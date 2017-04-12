#include <stdio.h>
#include <stdlib.h>
#include "set_sgamble2_207.h"
#include <string.h>
typedef struct deliverynode
{
   set *data;
   struct deliverynode *next;
} deliverynode;

void main()
{
	deliverynode *head;
        head=dmalloc(sizeof(deliverynode));
        head->next=NULL;
        head->data=NULL;
	while(1)
	{
		int x=0;
		char input[200];
		while(x==0)
		{
			printf("Do you wanna build a pizza? y/n\n");
			fflush(stdin);
			fflush(stdout);
			fgets(input, 200, stdin);
			if(strlen(input)==2)
			{
				if(input[0]=='y'){x=1;}
				if(input[0]=='n'){x=2;}
			}
			//empty string
			memset(input,0,strlen(input)-1);
		}
		if(x==1)
		{
			addPizza(&head);
		}
		if(x==2)
		{
			//print
			printf("Deliveries:\n");
			int loop=1;
			deliverynode *ptr= head;
			deliverynode *ptr2;
			while(ptr!=NULL)
			{
				printf("pizza %d has %d topping(s)\n", loop, ptr->data->count);
				printset(ptr->data);
				ptr2=ptr->next;
				freed(ptr->data);
				free(ptr->data);
				free(ptr);
				ptr=ptr2;
				loop++;
			}
			exit(1);	
		}
	}
}


int addPizza(deliverynode **head)
{
	set *newSet=createset();
	char input[200];
	int x=0;
	int test;
	while(x==0)
	{
		printf("please input topping\n");
		fgets(input, 200, stdin);
		if(strcmp(input,"\n")==0)
		{
			x=1;
			continue;
		}
		test=insert(input,newSet);
		if(test==0)
		{
			printf("could not add\n");
		}
		memset(input,0,strlen(input)-1);
	}
	if((*head)->data==NULL)
	{
		(*head)->data=newSet;
		return 1;
	}
	deliverynode *new=dmalloc(sizeof(deliverynode));
	new->data=newSet;
	new->next=*head;
	*head=new;		
}
