//Sean Gamble G00892005
//CS 262, SEction 
#include<stdio.h>
#include<stdlib.h>
#include<string.h>

void main(){
	char fileL[256], fileO[256], strRd[120], fileN[50], newStr[256], remStr[256];
	char *token;
	char *token2;
	int locR;
	int locC;

	printf("Please give file location\n ");
	fgets(fileL, 50, stdin);
	token= strtok(fileL, "\n");
	FILE *in=fopen(token, "r");
		
	printf("Please give output file\n ");
	fgets(fileO, 50, stdin);
	token2= strtok(fileO, "\n");
	FILE *out = fopen(token2, "w");
	
	//token= strtok(in, "\n");
	//loops through each line of input
	while( fgets(strRd, 200, in)!= NULL)
	{
		printf("%s\n", strRd);
		printf("Enter position of word to delete (Start counting at 0). Enter -1 to skip deletion:\n");
		scanf(" %d", &locR);
		
		strcpy(newStr, "");
		token2= strtok(strRd, " ");
		locC=0;
		//creates new string including all but removed word
		while(token2 != NULL)
		{	
			if(locC!=locR)	
			{
				strcat(newStr,token2);
				strcat(newStr, " ");
			}
			else
			{
				strcat(remStr,token2);
				strcat(remStr, " ");
			}
			token2=strtok(NULL, " ");
			locC++;
		}
		//print to file
		fprintf(out, "%s\n",newStr);
	}
	printf(" %s", remStr);	
        fclose(in);
        fclose(out);	
}
