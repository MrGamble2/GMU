integerinput=input("Please give me an integer:")
integerinput=int(integerinput)
#Gets integer input and makes it an integer
if integerinput==0:
	print("This is zero")
#Checks if the integer is zero
if integerinput>0:
	print("This is a positive number")
#Checks if the integer is positive
if integerinput<0:
	print("This is a negative number")
integertwo=(integerinput%2)
#Checks if its negative
if integertwo!=0:
	print("It is also odd")
#Checks if there is a remainder when divided by two, if there is then its odd