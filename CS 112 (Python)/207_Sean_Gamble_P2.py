#-------------------------------------------------------------------------------
# Name: Sean Gamble.
# Project 2
# Section 002
# Due Date: 9/21/2014
#-------------------------------------------------------------------------------
# Honor Code Statement: I received no assistance on this assignment that
# violates the ethical guidelines set forth by professor and class syllabus.
#-------------------------------------------------------------------------------
# References: Slide 3, control structures 
# Note: you may not use code from websites, so don't bother looking any up.
#-------------------------------------------------------------------------------
# Comments and assumptions: A note to the grader as to any problems or 
# uncompleted aspects of the assignment, as well as any assumptions about the
# meaning of the specification.
#-------------------------------------------------------------------------------
# NOTE: width of source code should be <= 80 characters to facilitate printing.
#2345678901234567890123456789012345678901234567890123456789012345678901234567890
# 10 20 30 40 50 60 70 80
#-------------------------------------------------------------------------------
playerone=input("Player one's name")
playeronescore=input("Player one's score")
playertwo=input("Player two's name")
playertwoscore=input("Player two's score")
playerthree=input("Player three's name")
playerthreescore=input("Player three's score")
#Gathering scores and names
bye=("Goodbye!")
#for later in the code
howtoprint=input("would you like, (1) alphabetic order (2)\
increasing score order, or (3) decreasing score order")
howtoprint=int(howtoprint)
onew=(howtoprint==1)
twow=(howtoprint==2)
threew=(howtoprint==3)
four=(onew or twow or threew)
#Using booleans to make sure a correct option was chosen 
if four== False:
    print("Sorry that wasn't an option")
    print(bye)
if howtoprint==1:
    playerone=(playerone,   playeronescore)
    playertwo=(playertwo,   playertwoscore)
    playerthree=(playerthree,   playerthreescore)
    abcd=(playerone, playertwo, playerthree)
    abcd=sorted(abcd)
    print(abcd)
#Sorts alphabetically using sort then prints it
if howtoprint==2:
    playerone=(playeronescore,   playerone)
    playertwo=(playertwoscore,   playertwo)
    playerthree=(playerthreescore,   playerthree) 
    ascending=(playerone, playertwo, playerthree)
    ascending=sorted(ascending)
    print(ascending)
#Same thing as alphabetically but the number goes in front so that 
#it sorts by number. The only issue is it doesn't look nice when printed
if howtoprint==3:
    playerone=(playeronescore,   playerone)
    playertwo=(playertwoscore,   playertwo)
    playerthree=(playerthreescore,   playerthree) 
    descending=(playerone, playertwo, playerthree)
    descending=sorted(descending, reverse=True)
    print(descending)
threetie=(playeronescore==playertwoscore==playerthreescore)
if threetie== True:
    print("There is a threeway tie")
#Checks for three way tie
tieone=(playeronescore==playertwoscore!=playerthreescore)
tietwo=(playeronescore==playerthreescore!=playertwoscore)
tiethree=(playertwoscore==playerthreescore!=playeronescore)
istrue=tieone or tietwo or tiethree
if (istrue==True):
    print("There is one tie")
#Checks for 2 way tie
if four== True:
    print("Goodbye")