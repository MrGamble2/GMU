#include <stdio.h>
#include <stdlib.h>

//generates two dice values, printing them out and returning the result
int rollDice()
{
	int dieOne;
	int dieTwo;
	
	dieOne=(random()%6)+1;
	dieTwo=(random()%6)+1;
	printf("first die %d\n", dieOne);
	printf("second die %d\n",dieTwo);
	return (dieOne+dieTwo);
}
//newgame function, asks the player if they want to let it ride, for use in playGame
int newGameF()
{
	int newGame;
	while(1)
	{
		scanf("%d",&newGame);
		if(newGame==1||newGame==2)
		{
			return newGame;
		}
		else
		{
			printf("Invalid number try again");
		}
	}
}	
int playGame(int current)
{
	int bet;
	int loop=1;
	int howBet;
	int rollTotal;
	char startRoll;
	int point;
	int newGame;
	int winnings=0;
	int choices;
	int potentialLoss;

	//prompt and checking for how much the player wants to bet
	printf("how much would you like to bet, bewteen 5 and your current wealth\n");
	while(loop==1)
	{
		scanf(" %d",&bet);
		if(bet>current)
		{
			printf("you dont have enough to do that please enter new number\n");
		}
		else if(bet<5){
			printf("That bet is too low enter a new one");
		}
		else
		{
			potentialLoss=bet;
			loop=2;
		}
	}
	printf("Is this for(1) or against(2) you?\n");
	//prompt for how they want to bet, checking for invalid inputs
	while(1)
	{
		scanf(" %d",&howBet);
		if(howBet==1||howBet==2)
		{
			break;
		}
		else
		{
			printf("invalid, please try again");
		}
	}
	//main chunk of game loop. continues till the player loses or chooses to quit
	while(loop<4)
	{	
		if(loop==3)
		{
			printf("the point is: %d\n",point);
		}
		printf("press any char to roll dice\n");
		scanf(" %c", &startRoll);
		rollTotal=rollDice();
		printf("the total is %d\n",rollTotal);
		//first roll and betting for oneself
		if(loop==2 && howBet==1)
		{
			switch(rollTotal)
			{
				case 7:
				case 11:
					printf("You win! Would you like to let it ride? Yes(1)/No(2)\n");
					newGame=newGameF();
					if(newGame==1)
					{
						winnings=bet;
						bet=winnings+bet;
						loop=2;
					}
					else
					{
						winnings=bet;
						return winnings;
					}
					break;
				case 2:
				case 3:
				case 12:
					printf("you lose\n");
					winnings=0-potentialLoss;
					return winnings;
					break;

				default:
					loop=3; 
					printf("nada, would you like to double bet Y(1)/N(2)\n");
					scanf(" %d",&choices);
					if(choices==1 && (potentialLoss+bet)<=current)
					{
						potentialLoss=potentialLoss+bet;
						bet=bet*2;
					}
					else if(choices==1)
					{
						printf("Sorry you dont have enough to double the bet\n");
					}
					point=rollTotal;		
					break;
			}
			
		}
		//not the first roll and betting for self			
		else if(howBet==1 && loop==3)
		{
			if(rollTotal==point)
			{
				printf("You win! Would you like to let it ride? Yes(1)/No(2)\n");
				newGame=newGameF();
				if(newGame==1)
				{
					winnings=bet;
					bet=winnings+bet;
					loop=2;
				}
				else
				{
					return bet;
				}
			}
			else if(rollTotal==7)
			{
				printf("you lose\n");
				return(0-potentialLoss);
			}
			else
			{
				loop=3; 
				printf("nada\n");
			}
		}
		//first roll and betting against self
		if(loop==2 && howBet==2)
                {
                       	switch(rollTotal)
                        {
                                case 2:
				case 3:
                                case 12:
                                        printf("You win! Would you like to let it ride? Yes(1)/No(2)\n");
					newGame=newGameF();
					if(newGame==1)
                                        {
						winnings=bet;
                                                bet=winnings+bet;
						loop=2;
                                        }
                                        else
                                        {
                                                return bet;
                                        }
                                        break;
                                case 7:
                                case 11:
                                        printf("you lose\n");
                                        return(0-potentialLoss);
                                        break;
                                default:
                                        loop=3;
                                        printf("nada, would you like to double bet Y(1)/N(2)\n");
                                        scanf(" %d",&choices);
                                        if(choices==1 && (bet+potentialLoss)<=current)
                                        {       
						potentialLoss=potentialLoss+bet;
                                                bet=bet*2;
                                        }
                                        else if(choices==1)
                                        {
                                                printf("Sorry you dont have enough to double the bet\n");
                                        }
                                        point=rollTotal;
 			                break;
			}
		}
		//not the first roll and betting against self
		else if(howBet==2 && loop==3)
                {
                        if(rollTotal==7)
                        {
				printf("You win! Would you like to let it ride? Yes(1)/No(2)\n");
                                newGame=newGameF();
				if(newGame==1)
                                {
                                        winnings=bet;
                                        bet=winnings+bet; 
					loop=2;
                                }
                                else
                                {
                                        return bet;
                              	}
			}
			else if(rollTotal==point)
			{
				printf("you lose\n");
				return(0-potentialLoss);
			}
                        else
			{
				loop=3;
                                printf("nada\n");
                        }
               	}
	}
	return 0;
}
int main()
{	
	int i;
	int money = 100;
	int moneyChange;
	int contG=1;
	int again;
	
	printf("welcome to craps, please enter a random number seed\n");
	scanf(" %d", &i);
	srandom(i);
	//loop that goes till out of money or till player doesnt want to play anymore
	while(contG==1)
	{
		moneyChange=playGame(money);
		printf("winnings %d\n", moneyChange);
		money=money+moneyChange;
		printf("total money %d\n", money);
		//quits if out of money
		if(money==0)
		{
			printf("You are broke now, quiting game");
			return 1;
		}
		printf("play again? Y(1)/N(2)");
		scanf(" %d", &again);
		contG=again; 
	}	
	return 1;
}

