print("Welcome to Weasleys’ Wizard Wheezes!")
name= input("What is your name?")
hatNumber= input ("How many Headless Hats do you want to buy, at 2 galleons \
each?")
boxingTelescopes= input("How many Boxing Telescopes do you want to buy, \
at 12 sickles 26 knuts each?")
canaryCreams= input("How many Canary Creams do you want to buy, at 7 sickles\
 each?")
hat=int(hatNumber)
box=int(boxingTelescopes)
cream=int(canaryCreams)
total=(hat*986+box*374+cream*203)
print("You're total is:", total, "Knuts.")
payment= input ("How many knuts are you paying with?")
pay=int(payment)
remainder= pay - total
print("Your change is ", remainder, " Knuts, paid as") 
galleons=remainder//493
print(galleons, " galleons")
amount2 = remainder%493
sickles=amount2//29
print(sickles, " sickles")
knutschange= amount2%29
print(knutschange, " Knuts")
print("Thank you,", name)


#-------------------------------------------------------------------------------
# Name: Sean Gamble
# Project 1
# Section 002
# Due Date:9/7/2014
#-------------------------------------------------------------------------------
# Honor Code Statement: I received no assistance on this assignment that
# violates the ethical guidelines set forth by professor and class syllabus.
#-------------------------------------------------------------------------------
# References: Slides from Lab 2
#-------------------------------------------------------------------------------
# Comments and assumptions: A note to the grader as to any problems or 
# uncompleted aspects of the assignment, as well as any assumptions about the
# meaning of the specification.
#-------------------------------------------------------------------------------
# NOTE: width of source code should be <= 80 characters to facilitate printing.
#2345678901234567890123456789012345678901234567890123456789012345678901234567890
# 10 20 30 40 50 60 70 80
#---------------------------------------------------------------------