//Sean Gamble G00892005
//CS 262, lab Section 207
//Lab 2/
#include <stdio.h>
#include <stdlib.h>

int main()
{
	double agi;
	int rate;
	double owed;
	double rateD;
	double netIncome;

        printf("Input AGI");
        scanf("%lf", &agi);
	if(agi<0)
	{
		printf("we dont accept negative values");
		return 0;
	}

        printf("Input tax rate");
        scanf("%d", &rate);
	if(rate<0)
	{
		printf("we dont accept negative values");
		return 0;
	}

	rateD=(double) rate;
        rateD=rateD/100;
        owed=rateD*agi;
        netIncome=agi-owed;
        printf("AGI %.2f, Tax Rate %d, Owed %.2f, Net Income %.2f \n", agi,rate,owed,netIncome);
	return 0;
}
