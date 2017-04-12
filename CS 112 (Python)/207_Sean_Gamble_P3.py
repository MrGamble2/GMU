#-------------------------------------------------------------------------------
# Name: Sean Gamble
# Project 4
# Section 207
# Due Date: 9/28/2014
#-------------------------------------------------------------------------------
# Honor Code Statement: I received no assistance on this assignment that
# violates the ethical guidelines set forth by professor and class syllabus.
#-------------------------------------------------------------------------------
# References: Slide from lab 4
#-------------------------------------------------------------------------------
# Comments and assumptions: A note to the grader as to any problems or 
# uncompleted aspects of the assignment, as well as any assumptions about the
# meaning of the specification.
#-------------------------------------------------------------------------------
# NOTE: width of source code should be <= 80 characters to facilitate printing.
#2345678901234567890123456789012345678901234567890123456789012345678901234567890
# 10 20 30 40 50 60 70 80
#-------------------------------------------------------------------------------
menu='''
0 – enter a number
1 – display current number
2 – divisibility checking
3 – perfect checking
4 – triangular checking
5 – quit
'''
menuoption=-1
while menuoption!=5:
	menuoption=input(menu)
	menuoption=int(menuoption)
	#Menu option one, just takes an input for the number to be used
	#in the other options
	if menuoption==0:
		number=input("What is your number?")
		number=int(number)
		while number<0:
			number=int(input("Must be positive, please!"))
	#menu option one, just prints out the number unless there is no number in
	#in which case it asks for one
	elif menuoption==1:
		if number>0:
			print(number)
		else:
			print("Please input a number first")
	#option two uses formula to find if value is divisible by three
	elif menuoption==2:
		if number>0:
			#sets up new variables so number is not overwritten
			#while used in the loops, and sets up a counter that 
			#will add up all the values
			originalnumber=number
			originalnumbertwo=number
			counter=0
			while originalnumber>0:
				#Gets current final digit and adds it to counter 
				counter=counter+(number%10)
				#removes final digit so it isn't pulled again
				originalnumber=originalnumber/10
				#int removes decimal 
				originalnumber=int(originalnumber)
			#Checks if the values added up are divisible by three
			if counter%3==0:
				print(originalnumbertwo, "is divisible by 3")
			else:
				print(originalnumbertwo, "is not divisible by 3")	
		else:
			print("Please input a number first")
	#Option 3, adds up the factors
	elif menuoption==3:
		#Sets up values and variables for use in loops
		factoradd=0
		checker=1
		if number>0:
			newone=number
			while checker<newone: 
				#if its a factor, add it to the factoradd which
				#keeps track of it
				if newone%checker==0:
					factoradd=factoradd+checker
					checker=checker+1
				#if not a factor, check next number
				else:
					checker=checker+1
			if factoradd<number:
				print(number, "is deficient number")
			if factoradd>number:
				print(number, "is an abundant number")
			if factoradd==number:
				print(number, "is a perfect number")
		else:
			print("Please input a number first")
	#option 4, triangular number
	elif menuoption==4:
		countertwo=0
		tracker=0
		while countertwo<=(number-tracker-1):
			#tracker keeps adding itself to counter as long
			#as the next time it loops it won't exceed the nubmer
			tracker=tracker+1
			countertwo=countertwo+tracker
		print(number,": covered by triangular number #",tracker)
	elif menuoption==5:
		print("Goodbye!")
	else: 
		print("I didn't understand, please try again.")
	
	