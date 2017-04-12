#ifndef SET_SGAMBLE2_207_H
#define SET_SGAMBLE2_207_H

typedef struct node
{
        char *data;
        struct node *next;
}node;

typedef struct
{
	node *head;
	int count;
}set;  

set *createset(void);
void freed(set *s);
int strcmpi(char *s,char *t);
void *dmalloc(int size);
int insert(char *str, set *s);
void printset(set *s);

#endif
