#include <stdlib.h>
#include <string.h>
#include <stdio.h>


typedef struct{
	char locName[15];
	char des[50];
	float lat;
	float lng;
} hold;
int resizeArray(hold **locArray, int aCur)
{
	*locArray= realloc(*locArray, 2*aCur*sizeof(hold));
	if(locArray== NULL)
	{
		printf("Too many locations, out of memory\n");
		exit(0);	
	}
	return 0;
}	
int addLoc(hold** locArray, int aCur)
{	
	char name[20];
	char dest[20];
	char logs[10];
	char lats[10];
	char temp[20];

	hold newH;
	getchar();

	printf("please give location name\n");
	fgets(name, 20, stdin);
	strcpy(temp,strtok(name,"\n"));
	strcpy(newH.locName,temp);

	printf("please give description\n");
        fgets(dest, 20, stdin);
	strcpy(temp,strtok(name,"\n"));
	strcpy(newH.des, temp);

	printf("please give longitude\n");
        fgets(logs, 20, stdin);
	newH.lng = atof(logs); 
	
	printf("please give latitude\n");
        fgets(lats, 20, stdin);	
	newH.lat=atof(lats);
	
	//add to array
	locArray[aCur] = &newH;
	return 1;
}

int main(){
	hold* locArray=NULL;	
	int aSize,y, aCur;
	aCur=0;
	printf("How many locations are there\n");
	scanf(" %d", &aSize);
	fflush(stdin);
	locArray=malloc((sizeof(hold)*aSize)+1);
	int t=1;
	//menu
	while(t==1)
	{
		fflush(stdin);
		printf("What to do:\nadd location: 1\nPrint current list of locations: 2\nQuit: 3\n");
		scanf("%d",&y);
		switch(y)
		{
			case 1:
				if(aSize==aCur)
				{
					aSize=aSize*2;
					resizeArray(&locArray, aCur);
				}
				addLoc(&locArray, aCur);
				aCur++;
				break;
			case 2:
				//print locations
				;
				int i;
				for(i=0; i<aCur; i++)
				{	
					hold ptr=locArray[i];
					printf("Location: %s, Description: %s, Latitude: %f, Longitude: %f\n", ptr.locName, ptr.des,ptr.lat,ptr.lng);
				}
				break;
			case 3:
				return 1;
			
		}
	}
return 1;
} 
