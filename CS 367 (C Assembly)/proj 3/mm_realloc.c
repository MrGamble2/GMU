#include <stdio.h>
#include <stdlib.h>

#include "memory.h"

extern mem_ptr Heap;


mem_ptr mm_realloc(mem_ptr m, int size) {
  /* Input: pointer to a mem_rec, new size of the block needed
     Output: 
       If the input pointer is null, call error_msg(2) and return

       Return a pointer to a mem_rec of the appropriate size (new_size).
       This block should be chosen as follows:
          if the new size is less than the current size of the block, 
            use the current block after moving the excess back to the free
            list
          if the new block size is larger than the current size, 
            first see if there is enough space after the current block
              to expand.  
            If this will not work, you will need to free the current block
              and find a location for this larger block using first-fit.
       If there is nowhere to place a block of the given size, print
          call error_msg(1) and return a NULL pointer
  */
	int new_size = ALIGN(size);
	if(m==NULL){error_msg(2);}
	//find free space after if any
	mem_ptr heapptr=Heap;
	mem_ptr tempheap=NULL;
	while(heapptr!=NULL)
	{
		if(heapptr->address==(m->address+m->size))
		{
			break;
		}
		tempheap=heapptr;
		heapptr=heapptr->next;
	}
	//if shrinking	
	if(new_size<m->size){
		//existing free space to expand
		if(heapptr!=NULL)
		{
			heapptr->size=(heapptr->size+(m->size-new_size));
			heapptr->address=(heapptr->address-(m->size-new_size));
		}
		//no freespace to expand, must add to list
		else if(heapptr==NULL)
		{	
			mem_ptr newmem=malloc(sizeof(mem_rec));
			newmem->size=m->size-new_size;
			newmem->address=m->address+new_size;
			insert_mem(Heap,newmem);			
		}
	}
	//expanding the size
	if(new_size>m->size){
		//existing freespace, check if fit, remove if size equals
		if(heapptr!=NULL && (new_size-m->size) <= heapptr->size)
		{
			heapptr->size=(heapptr->size-(new_size-m->size));
			heapptr->address=(heapptr->address+(new_size-m->size));
			//size is equal, no more freespace
			if(heapptr->size==0){
				if(heapptr->previous==NULL){
					Heap=heapptr->next;
				}
				else if(heapptr->next==NULL){
					heapptr->previous->next==NULL;
				}
				else{
					heapptr->previous->next= heapptr->next;
					heapptr->next->previous=heapptr->previous;
				}
				free(heapptr);
			}
		}
		//no room to fit, must remove then readd
		if(heapptr==NULL){
			mm_free(m); 
			mem_ptr ret=mm_malloc(new_size);
			return ret;
		}
	}
	m->size=new_size;
	return m;
}	

//normal 2d insert
void insert_mem(mem_ptr head, mem_ptr in){
        mem_ptr temp=head;
        mem_ptr temp2=NULL;
	//no head
        if(head==NULL){
                Heap=in;
                return;
        }
	//before head
	if(temp->address>in->address){
		in->next=head;
		head->previous=in;
		Heap=in;
	}
	//everywhere else
        else
	{
		while(temp!=NULL && temp->address<in->address){
			temp2=temp;
			temp=temp->next;
		}
		in->next=temp;
		in->previous=temp2;
		temp2->next = in;
		//check tail
		if(temp!=NULL)
		{
			temp->previous=in;
		}
	}
}
