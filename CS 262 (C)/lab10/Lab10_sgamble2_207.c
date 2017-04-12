#include <stdio.h>
#include <stdlib.h>

typedef struct Node
{
	int value;
	struct Node *next;	
}node;

void insertNodeSorted(node **dummy, int tvalue)
{                       
        node *newNode=malloc(sizeof(node));
        newNode->value=tvalue;
	newNode->next=NULL;

	node *ptr=*dummy;
        int test=0;
        while(ptr->next!=NULL && test!=1)
        {
                if(ptr->next->value >= tvalue)
                {
                        test=1;
                }
                else
                {
                        ptr=ptr->next;
                }
        }
        //insert
       	newNode->next=ptr->next;
        ptr->next=newNode;
}


	
void printList(node **dummy)
{
	node* ptr=*dummy;
	ptr=ptr->next;
	while(ptr!=NULL)
	{
		printf("%d ",ptr->value);
		ptr=ptr->next;
	}		
}

void deleteList(node **dummy)
{	
	node* tempP=*dummy;
	node* ptr=*dummy;
	while(ptr!=NULL)
	{
		tempP=ptr->next;
		free(ptr);
		ptr=tempP;
	}	
}

int main(int argc, char *argv[])
{
        node* head=NULL;
        head=malloc(sizeof(node));
	head->next=NULL;
	head->value=0;
        srandom(atoi(argv[1]));
        int i;
        int maxRan=atoi(argv[3]);
        for(i=0;i<atoi(argv[2]);i++)
        {
                int new=random()%(maxRan+1);
                insertNodeSorted(&head, new);
        }
	printList(&head);
	deleteList(&head);
	return 1;
}				
