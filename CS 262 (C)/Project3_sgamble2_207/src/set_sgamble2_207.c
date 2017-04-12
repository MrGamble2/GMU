#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "set_sgamble2_207.h"
set *createset()
{
        //creates w/ demalloc() a set, initilizes its fields and returns pointi
        set *newSet=NULL;
	newSet=dmalloc(sizeof(set));
	newSet->head=NULL;	
	newSet->count=0;
	return newSet;
}
void freed(set *s)
{
	node *ptr=s->head;
	node *hold=ptr;
	while(ptr!= NULL)
	{
		hold=ptr->next;
		free(ptr->data);
		free(ptr);
		ptr=hold;
	}
}
int insert(char *str, set *s)
{
        //places new string in the set by inserting new node into linked list and increments count. The toppings will be inserted into the pizza set in alphabetical order (use strcmpi() below for this). Duplicate strings (ignoring case) will not be allowed in the set. Returns whether the insertion was successful.
	node *newNode;
	newNode=dmalloc(sizeof(node));
	char *nStr=dmalloc(sizeof(char)*(strlen(str)));
	strcpy(nStr,str);
	newNode-> data=nStr;   //may by no *
	//dmalloc(1+(strlen(*str)*sizeof(char)));
	//check if head is null
	if(s->head==NULL)
	{
		s->head=newNode;
		s->count++;
		return 1;
	}
	//search
	node *iter=s->head;
	if(strcmpi(str, iter->data)<0)
	{
		newNode->next=iter;
		s->head=newNode;
		s->count++;
		return 1;
	}
	if(strcmpi(str, iter->data)==0)
	{
		return 0;	
	}
	int found=0;
	while(iter->next!=NULL)
	{
		if(strcmpi(str, iter->next->data)==0)
                {
                        return 0;
                }
		iter=iter->next;
	}
	iter=s->head;
	while(iter->next!=NULL && found!=1)
	{
		if(strcmpi(str, iter->next->data)>0)
		{
			iter=iter->next;
		}
		else if(strcmpi(str, iter->next->data)<0)
		{
			found=1;
		}
		else if(strcmpi(str, iter->next->data)==0)
		{
			return 0;
		}	
	}
	//insert after, check if head or tail
	newNode->next=iter->next;
	iter->next=newNode;
	s->count++;
	return 1;
}


void printset(set *s)
{
	//Displays the elements of the set with each string on a new line.
	node *ptr=s->head;
	while(ptr!=NULL)
	{
		//print next
		printf("%s",ptr->data);
		ptr=ptr->next;
	}		
}

/* compares strings for alphabetical ordering */
int strcmpi(char *s, char *t)
{
   while (*s && tolower(*s) == tolower(*t))
   {
      s++;
      t++;
   }
   return tolower(*s) - tolower(*t);
}

/* allocates memory with a check for successful allocation */
void *dmalloc(int size)
{
   void *p = malloc(size);
   if (!p)
   {
      printf("memory allocation failed\n");
      exit(1);
   }
   return p;
}

