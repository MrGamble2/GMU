rounds=int(input("How many numbers will be entered?"))
roundstwo=0
finalnumb=0
list=[]
listtwo=[]
listthree=[]
while roundstwo<rounds:
	newnumb=int(input("next value: "))
	#new number input from user
	finalnumb=finalnumb+newnumb
	#adder for all numbers
	roundstwo=roundstwo+1
	#counter increases
	list.append(newnumb)
	#adds new number to the list
	if newnumb%2==0:
		listtwo.append(newnumb)
	#puts in list two if even
	#if newnumb%2=! 0
	#	listthree.append(newnumb)
	#puts in list three if odd	
print("sum is ", finalnumb)
evenorodd=input("Show evens, or odds?")
#if evenorodd="evens":
#	print(listtwo)
#elif evenorodd="odds":
#	print(listthree)
#else:
#	print("error")
#Syntax Errors everywhere not enough time to fix it so left as comments	
