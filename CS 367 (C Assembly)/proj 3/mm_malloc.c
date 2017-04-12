#include <stdio.h>
#include <stdlib.h>

#include "memory.h"

extern mem_ptr Heap;


mem_ptr
mm_malloc(int size) {
  /* Input: size of the block needed
     Output: 
       Return a pointer to a mem_rec of the appropriate size (new_size).
       This block should be found using first-fit.     
       If there is nowhere to place a block of the given size, call error_msg(1) 
          and return a NULL pointer
  */
	int new_size = ALIGN(size);
	mem_ptr heapptr = Heap;
	int found=0;
	//find free space with size large enough
	while(heapptr!=NULL)
	{
		if(heapptr->size>=new_size)
		{
			found=1;
			break;
		}
		heapptr=heapptr->next;
	}
	if(found==0){error_msg(1); return NULL;}
	//create a new member and set all of its fields, even if its not used
	mem_ptr new_mem=malloc(sizeof(mem_rec));
	new_mem->next=NULL;
	new_mem->previous=NULL;
	new_mem->address=heapptr->address;
	new_mem->size=new_size;
	//if not a perfect fit, shrink the node
	if(heapptr->size!=new_size)
	{
		heapptr->size=heapptr->size-new_size;
		heapptr->address=heapptr->address+new_size;
	}
	//if there is only one node and it will be a perfect fit, free
	//the node 
	else if(heapptr->previous==NULL && heapptr->next==NULL)
	{
		free(heapptr);
		Heap=NULL;
	}
	//perfect fit and head of list
	else if(heapptr->previous==NULL)
	{
		heapptr->next->previous=NULL;
		Heap=heapptr->next;
		free(heapptr);
	}
	//perfect fit and tail
	else if(heapptr->next==NULL)
	{	
		heapptr->previous->next=NULL;
		free(heapptr);
	}
	//perfect fit and in middle of list.
	else
	{
		heapptr->previous->next=heapptr->next;
		heapptr->next->previous=heapptr->previous;
		free(heapptr);
	}
	return new_mem;						
}



