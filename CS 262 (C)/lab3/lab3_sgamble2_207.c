//Sean Gamble G00892005
//CS 262 Lab Section 207
//Lab 3

#include<stdio.h>

char enterChar()
{
	char cin;
	printf("ey b0ss, enter a char pls\n");
	//fgets(cin, 10, stdin);
	scanf(" %c",&cin);
	return cin;
}

int enterInt()
{
	int N=0;

	printf("enter a number 1-15\n");
	while(1)
	{
		scanf(" %d", &N);
		if(N>15 || N<1)
		{
			printf("please enter a valid number\n");
		}
		else
		{
			break;
		}
	}
	return N;	 
}
void printRecA(int N, char C)
{
	int i;
	int j;
	for(i=0; i<N; i=i+1)
	{
		for(j=0; j<N; j=j+1)
		{
			printf("%c",C);
		}
		printf("\n");
	}
	return;
}

void printRecB(int N, char C)
{
	int i;
	int j;
	for(i=0; i<N; i=i+1)
	{
		for(j=0; j<N; j=j+1)
		{
			if(i==0 || i==(N-1) || j==0 || j==(N-1))
			{
				printf("%c",C);
			}
			else
			{
				printf(" ");
			}
		}
		printf("\n");
	}
	return;
}
	
int main()
{	
	char input;
        char C= ' ';
        int N=0;
	while(1){
	
		printf("Enter/Change Character: 'C' or 'c'\n Enter/Change Number		: 'N' or 'n'\n Print Rectangle Type 1 (Border Only): '1'\n Print 		Rectangle Type 2 (Filled in): '2'\n Quit Program: 'Q' or 'q'\n")		;
	
		scanf(" %c", &input);
		switch(input)
		{
			case 'C':
			case 'c':
				C=enterChar();
				break;	
			case 'N':		
			case 'n':
				N=enterInt();
				break;	
			case '1':
				printRecB(N,C);
				break;
			case '2':
				printRecA(N,C);
				break;
			case 'Q':			
			case 'q':
				return 0;
			default:
				printf("invalid character\n");
		}
	}
}
			


