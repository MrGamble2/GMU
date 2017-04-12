def divisors(n):
	#finds all the divisors of a number
	divisor=[]
	for x in range(1,n):
		if n%x==0:
			divisor.append(x)
	return divisor
def num_occurrences(v,xs):
	#finds how many times and item is in a list
	occurrences=0
	for c in range(len(xs)):
		if xs[c]==v:
			occurrences=occurrences+1
	return occurrences
def num_divisables(v,xs):
	#combines the two
	divisables=0
	dividers=divisors(v)
	for b in range(len(xs)):
		
		numoccurrences=num_occurrences(xs[b],dividers)
		#Checks if its in the list
		if numoccurrences>0:
			divisables=divisables+1
	return divisables