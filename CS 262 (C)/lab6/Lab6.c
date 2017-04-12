//Sean Gamble G00892005
//CS 262, SEction 
#include<stdio.h>
#include<stdlib.h>
#include<string.h>

void main(){
	char fileL[256], fileN[50], newStr[256], remStr[256];
	char *token;
	char *token2;
	int locR;
	int locC;

	strcpy(fileN, "Lab6_bad.txt");
	printf("Please give file location\n");
	fgets(fileL, sizeof(fileL), stdin);
	token= strtok(fileL, "\n");
	strcat(token, "/");
	strcat(token, fileN);
	FILE *in=fopen(token, "r");
	
	printf("Please give output file\n");
	fgets(fileL, sizeof(fileL), stdin);
	token2= strtok(fileL, "\n");
	FILE *out = fopen(token2, "w");

	//token= strtok(in, "\n");
	//loops through each line of input
	while( fgets(fileL, 105, in)!= NULL)
	{
		printf("%s\n", fileL);
		printf("Enter position of word to delete (Start counting at 0). Enter -1 to skip deletion:\n");
		scanf(" %d", &locR);
		
		strcpy(newStr, "");
		token2= strtok(fileL, " ");
		locC=0;
		//creates new string including all but removed word
		while(token2 != NULL)
		{	
			if(locC=!locR)	
			{
				strcat(newStr,token2);
			}
			else
			{
				strcat(remStr,token2);
			}
			token2=strtok(NULL, " ");
		}
		//print to file
		fprintf(out, " %s",newStr);
	}
	printf(" %s", remStr);	
        fclose(in);
        fclose(out);	
}
