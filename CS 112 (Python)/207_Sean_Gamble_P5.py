#-------------------------------------------------------------------------------
# Name: Sean Gamble
# Project 5
# Section 207
# Due Date: MM/DD/YYYY
#-------------------------------------------------------------------------------
# Honor Code Statement: I received no assistance on this assignment that
# violates the ethical guidelines set forth by professor and class syllabus.
#-------------------------------------------------------------------------------
# References: (list any lecture slides, text book pages, any other resources)
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
def mersenne(n):
	#preform function
    stuffs=(2**n)-1
    return stuffs
def triangle_number (n):
    counter=0
    tracker=0
    while counter<=(n-tracker-1):
        tracker=tracker+1
        counter=counter+tracker
    return counter
#gcd
def gcd(a, b):
    lstofa=[]
	#factors of one
    for x in range(1,a+1):
        if a%x==0:
            lstofa.append(x)
    lstofb=[]
	#factors of the other
    for z in range(1,b+1):
        if b%z==0:
            lstofb.append(z)
    if len(lstofa)>len(lstofb):
        longer=lstofa
        shorter=lstofb
    else:
        longer=lstofb
        shorter=lstofa
    shared=[]
	#finds the biggest
    for z in range(len(longer)):
        if longer[z] in shorter:
            shared.append(longer[z])
    if a==0:
        return b
    if b==0:
        return a
    return max(shared)
def product(xs):
    finalval=1
	#multiplys all together
    for x in range(len(xs)):
        finalval=finalval*xs[x]
    return finalval
#prime factors    
def prime_factors(n):
    prime=[]
    x=2
    #checks 2, then 3, then 4 etc. doesn't matter when
    #it checks 4 since when checking 2 the remainder won't be
    #divisable by 4 or so on
    while n>= x**2:
        #if n is exceeded that means the remaining
        #amount is either 1 or a prime number
        while n%x==0:
            prime.append(x)
            n=n/x
        x=x+1
    if n > 1:
       prime.append(int(n))
    return prime
def subsequence_index(xs, ys):
    lst=[]
	#Checks till it finds the start of a match then checks after to make sure match is full
    for x in range(len(ys)):
        if ys[x]==xs[0]:
            fullmatch=True
            for b in range(len(xs)):
                if ys[x+b]!=xs[b]:
                    fullmatch=False
                    break
                elif b==len(xs)-1:
                    lst.append(x)
                    break
    if fullmatch==False:
        return("none")
    else:
        return lst[0]
def collatz(n):
	#collatz funtion
    nextnumb=n
    lst=[n]
    while nextnumb!=1:
        if nextnumb%2==0:
            nextnumb=nextnumb/2
        else:
            nextnumb=(3*nextnumb)+1
        lst.append(int(nextnumb))
    return lst
def is_rectangular(xss):
    rectangle=True
    for x in range(len(xss)):
        if x!=len(xss):
            if len(xss[x])!=len(xss[0]):
                rectangle=False
    return rectangle
def is_square(xss):
	#is rectangle with extra condition
    rectangle=True
    if len(xss)==0:
        return True
    for x in range(len(xss)):
        if x!=len(xss):
            if len(str(xss[x]))!=len(str(xss[0])):
                rectangle=False
    if rectangle is False:
        return False
    if len((xss))==len((xss[0])):
        return True
    else:
        return False
def diagonal_vals(xss):
	#find the diagonals
    square=is_square(xss)
    if square==True:
        lst=[]
        for x in range(len(xss)):
            newone=xss[x][x]
            lst.append(newone)
        return lst
def is_triangular_matrix(xss):
    square=is_square(xss)
    if square==True:
        below=True
        above=True
        #check below
        for x in range(len(xss)):
            if below==False:
                break
            for b in range(len(xss)):
                if (x+b+1)<len(xss):
                    if xss[x+b+1][x]==0:
                        below=True
                    else:
                        below=False
                        break
        #check above
        for x in range(len(xss)):
            if above==False:
                break
            for b in range(len(xss)):
                if (x+b+1)<len(xss):
                    if xss[x][x+b+1]==0:
                        above=True
                    else:
                        above=False
                        break
        if above==True:
            return True
        if below==True:
            return True
        else:
            return False
                
        return istriangle
    else:
        return False
def show2d(xss):
    line=("")
    if is_rectangular(xss)==True:
        for x in range(len(xss)):
            for r in range(len(xss[0])):
                longest=0
                for b in range(len(xss)):
                    if len(str(xss[b][r]))>int(longest):
                        longest=len(str(xss[b][r]))
				#a bunch of appending for formatting
                if r==len(xss[0])-1:
                    line=line+str(xss[x][r])
                    line=line+("\n")
                else:
                    length=len(str(xss[x][r]))
                    addedspaces=longest-length
                    line=line+((" ")*addedspaces)
                    line=line+str(xss[x][r])
                    line=line+("  ")
        return line
def flip(xss):
	finallst=[]
	if len(xss):
		for x in range(len(xss[0])):
			newlst=[]
			for b in range(len(xss)):
				newlst.append(xss[b][x])
			finallst.append(newlst)
	return finallst
def uniques(xs):
    lst=[]
    for x in range(len(xs)):
        if xs[x] not in lst:
            lst.append(xs[x])
    return lst
def zip (xs, ys):
    finallst=[]
    if len(xs)>=len(ys):
        for x in range(len(ys)):
            lst=[]
            lst.append(xs[x])
            lst.append(ys[x])
            finallst.append(lst)
    else:
        for x in range(len(xs)):
            lst=[]
            lst.append(xs[x])
            lst.append(ys[x])
            finallst.append(lst)
    return finallst
def unzip(pairs):
	finallst=[]
	#Hard code, which I dont think I need but whatever
	if len(pairs)==0:
	    return ([],[])
	#actually unzip
	for x in range(len(pairs[0])):
		newlst=[]
		for b in range(len(pairs)):
			newlst.append(pairs[b][x])
		finallst.append(newlst)
	return finallst
def remove(v, xs, limit=None):
    limitcounter=0
    poscounter=0
    while (limit!=limitcounter):
        if poscounter>=len(xs):
            break
        if v==xs[poscounter]:
            xs.pop(poscounter)
            limitcounter=limitcounter+1
        poscounter+=1
    return xs
def counts(xs):
	finallst=[]
	usedlst=[]
	for x in range(len(xs)):
		if xs[x] not in usedlst:
			usedlst.append(xs[x])
			ammount=xs.count(xs[x])
			newvalue=[]
			newvalue.append(xs[x])
			newvalue.append(ammount)
			newvalue=(newvalue)
			finallst.append(newvalue)
	return finallst
def mode(xs):
    lst=counts(xs)
	#orders
    for x in range(len(lst)):
        for b in range(len(lst)-1):
                if (len(lst)-1)!=x:
                    if lst[b][1]>lst[b+1][1]:
                        lst[b], lst[b+1]=lst[b+1], lst[b]
    checker=(len(lst))
    finallst=[]
    for r in range(len(lst)):
        if lst[checker-r-1][1]==lst[checker-r-2][1]:
            finallst.append(lst[checker-r-1][0])
        elif lst[checker-r-1][1]==lst[checker-1][1]:
            finallst.append(lst[checker-r-1][0])
        else:
            break
    finallst=finallst[::-1]
    return finallst
def popularity(xs):
    lst=counts(xs)
    finallst=[]
    finalref=[]
	#orders
    for x in range(len(lst)):
        for b in range(len(lst)-1):
                if (len(lst)-1)!=b:
                    if lst[b][1]>lst[b+1][1]:
                        lst[b], lst[b+1]=lst[b+1], lst[b]
    for x in range(len(lst)):
        loca=len(lst)-1
        new=loca-x
        finallst.append(lst[new][0])
    for x in range(len(lst)):
        loca=len(lst)-1
        new=loca-x
        finalref.append(lst[new][1])
	#does like ordering, switchs positions
    for x in range(len(finallst)):
        for b in range(len(finallst)-1):
            if (len(finallst))!=b:
                if finalref[b]==finalref[b+1]:
                    if xs.index(finallst[b])>xs.index(finallst[b+1]):
                        finallst[b],finallst[b+1]=finallst[b+1], finallst[b]
                        finalref[b],finalref[b+1]=finalref[b+1], finalref[b]
    return finallst