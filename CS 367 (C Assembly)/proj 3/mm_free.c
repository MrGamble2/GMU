#include <stdlib.h>

#include "memory.h"

extern mem_ptr Heap;


void mm_free(mem_ptr m) {
  /* Input: pointer to a mem_rec 
     Output:  None
        You must coalesce this block with adjacent blocks if appropriate. 
        If the input pointer is null, call error_msg(2) and return 
  */
	if(m==NULL){
		error_msg(2);
		return;
	}
	//find if there is any free space after the object being freed
	mem_ptr heapptr=Heap;
	mem_ptr tempheap=NULL;
	while(heapptr!=NULL){
		if(heapptr->address==(m->address+m->size)){
			break;
		}
		tempheap=heapptr;
                heapptr=heapptr->next;
        }
	//if there is space after expand it to fill in the newly free area 
	if(heapptr!=NULL)
	{
		heapptr->size=(heapptr->size+m->size);
                heapptr->address=(heapptr->address-(m->size));
		free(m);
	}
	//if there is nothing after to expand add a new node
	else if(heapptr==NULL)
        {
                insert_mem(Heap,m);
        }
	//check if list condenses, that is if there was freespace before the
	//object it can all be combined into one node
	heapptr=Heap;
	tempheap=NULL;
	while(heapptr!=NULL && heapptr->next!=NULL){
		//if two nodes overlap
		if(heapptr->next->address==heapptr->address+heapptr->size){
			//combine
			tempheap=heapptr->next;
			heapptr->next=heapptr->next->next;
			if(heapptr->next!=NULL){
				heapptr->next->previous=heapptr;
			}
			heapptr->size=heapptr->size+tempheap->size;
			free(tempheap);
		}
		heapptr=heapptr->next;
	}
	return;
}
