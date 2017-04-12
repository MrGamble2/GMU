#include <stdlib.h>
#include<stdio.h>
#include<string.h>
#include <ctype.h>
void openKey(char** array,int *numW)
{
	char fileI[20]; 
	FILE *keyFile= NULL;
	char *token=NULL;
	char *token2=NULL;
	
	//get and open file
	printf("please give file name\n");
	fgets(fileI,20, stdin);
	token=strtok(fileI, "\n");
	keyFile=fopen(token, "r");
	
	//start of reading in
	char token3[17];
	char* tempHold;
	int wordNumx=0;
	token=NULL;
	token=malloc((50000)*sizeof(char));
	
	//read up to 5000 words from keyfile, read the first line
	while(wordNumx<5001 && fgets(token, 500, keyFile)!=NULL)
	{
		int lensS=0;
		tempHold=token;
		//split line by spaces
		token2=strtok(tempHold, " ");
		while(token2!=NULL)
		{	
			lensS=strlen(token2);
			int i;
			//remove newlines and make it lowercase
			for(i=0; i<lensS; i++)
			{
				if(token2[i]!='\n')
				{
 					token3[i] = tolower(token2[i]);
				}
			}
			//if it was a lone newline character, which got removed ignore it
			if(strcmp(token3,"")!=0)
			{
				//set in array
				strcpy(array[wordNumx], token3);
				//clear token3 array
				memset(token3, 0, (17*sizeof(char)));
				wordNumx++;
			}
			else
			{
				//clear token3 array
				memset(token3, 0, (17*sizeof(char)));
			}
			token2=strtok(NULL," ");
		}	
		//lineNum++;
	}
	//clean up and setting the number of words
	*numW=wordNumx;
	free(token);
	fflush(stdin);
	fclose(keyFile);	
}

void encode(char **array, int *numWords)
{
	char curr;
	char* message=malloc(sizeof(char)*101);
	int loopR;
	char* encoded=NULL;

	//check array and make sure cipher is there, if not get one
	if(array[0][0]==0)
	{
		printf("You need to open a text first\n"); 
		openKey(array, numWords);
                fflush(stdin);
	}

	//get message
	printf("please enter a message to encode\n");
	fgets(message, 100, stdin);
	message=strtok(message, "\n");
	
	encoded=malloc(sizeof(char)*(12*strlen(message)));
	//empty encoded
	int t;
	for(t=0; t<(12*strlen(message));t++)
	{
		encoded[t]=0;
	}
	int prevWasSpace=0;
	int i;
	
	//loop through string
	for(i=0; i<=strlen(message)-1; i++)
	{
		//get char, convert to lower, go to randomth instance array	
		curr=tolower(message[i]);
		loopR=random()%10;
		int y=-1;
		int found=0;
		int word=0;
		int cart=0;
		int word2=0;
		int cart2=0;
		
		//at spaces make it so that there are commas inbewteen letters but not word, and that the loop doesnt run on spaces
		if(curr==' ')
		{
			encoded=strcat(encoded, " ");
			loopR=-2;
			prevWasSpace=1;
		}
		else if(i!=0 && prevWasSpace==0)
		{
			encoded=strcat(encoded, ",");
		}
		if(loopR!=-2)
		{
			prevWasSpace=0;
		}
		
		//loop till an instance of char is found for the xth time or end of the array and no proper char was found
		while(y<=loopR)
		{
			if(curr==array[word][cart])
			{
				y++;
				cart2=cart;
				word2=word;
				found=1;
			}
			cart++;
			if(cart>=strlen(array[word]))
			{
				cart=0;
				word++;
			}
			if(word>=*numWords)
			{
				if(found==0)
				{
					printf("%c not found\n", curr);	
					encoded=strcat(encoded, "#");
					y=loopR+1;
				}
				cart=0;
				word=0;
			}
		}

		//if char is found encoded it using the cordinates 
		if(found==1)
		{	
			char newVal[10];
			snprintf(newVal, sizeof(newVal), "%d,%d", word2, cart2);
			encoded=strcat(encoded, newVal);
			memset(newVal, 0, (sizeof(newVal)));
		} 
	}

	//clean up and outputing to file
	printf("where do you want to save this?\n");
	char fileI[20];
	fgets(fileI,20, stdin);
        char* token=strtok(fileI, "\n");
        FILE* out=fopen(token, "w");
	fprintf(out, encoded);
	fclose(out);
}
void decode(char **array, int *numWords)
{
        //check if array is empty and get file if it is
	if(array[0][0]==0)
        {
		printf("Need to open a cipher file first\n");
                openKey(array, numWords);
                fflush(stdin);
        }

	//readin file
	printf("please give file location?\n");
	char fileI[30];
        fgets(fileI,30, stdin);
        char* token=strtok(fileI, "\n");
        FILE* fin=fopen(token, "r");
	
	//initilize everything
	char token2[200];
	int t;
	for(t=0; t<200;t++)
	{
		token[t]=0;
	}
	char* token3;
	char* token4;
	int word;
	int car;
	//do the same as token2 for final
	char* final;
	final=malloc(300*sizeof(char));
	for(t=0; t<299;t++)
        {
                final[t]=0;
        }
	char decoCar;
	char toStr[5];
	memset(toStr, 0, (5*sizeof(char)));
	char* tempHold=malloc(500*sizeof(char));
	int wordis=0;
	char* tempHold2=malloc(300*3*sizeof(char));
	
	//loop over words, save a clean input in tempHold2	
	fgets(token2, 511, fin);	
	strcpy(tempHold2,token2);
	token3=strtok(token2, " ");
	wordis++;
	while(token3 != NULL)
	{
		//loop over each pair
		strcpy(tempHold,token3);
		token4=strtok(tempHold, ",");
		while(token4!=NULL)
		{
			if(strcmp(token4, "#")!=0)
			{
				word=atoi(token4);
				token4=strtok(NULL,",");
				car=atoi(token4);
				decoCar=array[word][car];
			}
			else
			{
				decoCar='#';
			}
			//add pair to final
			toStr[0]=decoCar;
			final=strcat(final, toStr);
			token4=strtok(NULL, ",");
		}	
		final=strcat(final, " ");
		//bring back in the temp to make token2 good again
		strcpy(token2,tempHold2);
		token3=strtok(token2, " ");
		//tokenize till the correct word is reached
        	int z;
		for(z=0; z<wordis; z++)
		{
			token3=strtok(NULL, " ");
		}
		wordis++;
	}
	printf("%s\n", final);
	fclose(fin);
}		
int main()
{
	char** array=malloc(5002*sizeof(char*));
	int t;
	for(t=0; t<5001; t++)
	{
		array[t]=malloc(sizeof(char)*110);
	}
	array[0][0]=0;
	int numWords=0;
	int input;
	srandom(2005);
	//menu
	while(1)
	{
		printf("1) Give key file name \n2) Create cipher \n3) Decode an existing cipher\n 4) Exit the program\n");
		scanf(" %d", &input);
		//take input and use switchcase to get proper item
		getchar();
		fflush(stdin);
		switch(input)
		{
			case 1:
				openKey(array, &numWords);
				break;
			case 2:
				encode(array, &numWords);
				break;
			case 3:
				decode(array, &numWords);
				break;
			case 4:	
		 		return 1;
		}
	}
}
