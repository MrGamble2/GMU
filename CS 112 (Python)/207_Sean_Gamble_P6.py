#-------------------------------------------------------------------------------
# Name: Sean Gamble
# Project 6
# Section 207
# Due Date: 11/23/2014
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
def read_annual ( filename , report=None ):
	fileopen=open(filename,'r')
	data = fileopen.readlines()
	lst=[]
	#gets file in workable form
	for line in (data):
		split=line.split('  ')
		lst.append(split)
	fixedlst=[]
	#removes many unneeded symbols and items
	for x in range(len(lst)):
		for z in range(len(lst[x])):
			smalllst=[]
			for r in range(len(lst[x][z])):
				if lst[x][z][r]==(','):
					if lst[x][z][r+1].isdigit():
						h=5
					else:
						smalllst.append(lst[x][z][r])
				elif lst[x][z][r]==('.'):
					h=5
				else:
					smalllst.append(lst[x][z][r])
		fixedlst.append(smalllst)
	finallst=[]
	for x in range(len(fixedlst)):
		listadd=[]
		fullstr=''.join(fixedlst[x])
		listadd.append(fullstr)
		finallst.append(listadd)
	for z in range(len(finallst)):
		for r in range(len(finallst[z])):
			finallst[z]=finallst[z][r].split(',')
	newfinal=[]
	for r in range(len(finallst)-1):
		addon=[]
		for c in range(3):
			finallst[r+1][c+1]=int(finallst[r+1][c+1][1:-2])
	#finished fixing list
	newpoplst=[]
	#gets file years population
	for x in range(len(finallst)):
		newpoplst.append(finallst[x][3])
	#gets all the states
	states=[]
	for x in range(len(finallst)):
		states.append(finallst[x][0])
	#makes all the numbers actual integers
	tempvar=len(newpoplst[0])
	newpoplst[0]=newpoplst[0][0:tempvar-2]
	for x in range(len(states)):
		tempvar=len(states[x])
		states[x]=states[x][1:tempvar-1]
	tempvar=len(newpoplst[0])
	newpoplst[0]=int(newpoplst[0][1:tempvar])
	#either makes a new dictionary, or add to the previous
	if report==None:
		for x in range(len(newpoplst)):
			newpoplst[x]=[newpoplst[x]]
		report={}
		for x in range(len(states)):
			report[states[x]]=newpoplst[x]
	else:
		for x in range(len(states)):
			report[states[x]].append((newpoplst[x]))
		#order the report dates
		reportlst=[]
		for key, value in report.items():
			temp = [key,value]
			reportlst.append(temp)
		for x in range(len(reportlst)):
			if reportlst[x][0]==('State'):
				headloc=x
		for xu in range(len(reportlst[headloc][1])):
			for ri in range(len(reportlst[headloc][1])-1):
				if reportlst[headloc][1][ri]>reportlst[headloc][1][ri+1]:
					for gu in range(len(reportlst)):
						reportlst[gu][1][ri], reportlst[gu][1][ri+1]=\
						reportlst[gu][1][ri+1], reportlst[gu][1][ri]
		report=dict(reportlst)
	fileopen.close()
	return report
def build_rate ( report ) :
	reportlst=[]
	for key, value in report.items():
		temp = [key,value]
		reportlst.append(temp)
	for x in range(len(reportlst)):
		if reportlst[x][0]==('State'):
			headloc=x
	ratelst=[]
	reportlst.pop(headloc)
	for ar in range(len(reportlst)):
		newrate=[]
		newrate.append(reportlst[ar][0])
		firstnum=reportlst[ar][1][0]
		secondnum=reportlst[ar][1][-1]
		rateeq=((secondnum-firstnum)/firstnum)
		newrate.append(rateeq)
		ratelst.append(newrate)
	statdic=dict(ratelst)
	return statdic
def build_statistics ( report , rate ) :
	samplestatlst=[]
	reportlst=[]
	ratelst=[]
	#makes a list of both dictionaries
	for key, value in report.items():
		temp = [key,value]
		reportlst.append(temp)
	for key, value in rate.items():
		temp=[key,value]
		ratelst.append(temp)
	#gets rid of header
	for x in range(len(reportlst)):
		if reportlst[x][0]==('State'):
			headloc=x
	reportlst.pop(headloc)
	totalincrease=0
	#finds total increase
	for xi in range(len(reportlst)):
		first=reportlst[xi][1][0]
		second=reportlst[xi][1][(len(reportlst[0][1]))-1]
		newchange=second-first
		totalincrease+=newchange
	newstat=["total increase"]
	newstat.append(totalincrease)
	samplestatlst.append(newstat)
	#Finds most populous
	mostpop=reportlst[0][1][-1]
	mostpopname=reportlst[0][0]
	for xi in range(len(reportlst)):
		if(reportlst[xi][1][-1])>mostpop:
			mostpop=reportlst[xi][1][-1]
			mostpopname=reportlst[xi][0]
	newstat=["most populous"]
	newstat.append(mostpopname)
	samplestatlst.append(newstat)
	#finds least populous
	leastpop=reportlst[0][1][-1]
	leastpopname=reportlst[0][0]
	for xi in range(len(reportlst)):
		if(reportlst[xi][1][-1])<leastpop:
			leastpop=reportlst[xi][1][-1]
			leastpopname=reportlst[xi][0]
	newstat=["least populous"]
	newstat.append(leastpopname)
	samplestatlst.append(newstat)
	#gets largest increase
	newstat=["largest increase"]
	newvar=(reportlst[0][1][-1]-reportlst[0][1][0])
	largestincrease=reportlst[0][0]
	for xi in range(len(reportlst)):
		first=reportlst[xi][1][0]
		second=reportlst[xi][1][-1]
		newchange=second-first
		if newchange>newvar:
			newvar=newchange
			largestincrease=reportlst[xi][0]
	newstat.append(largestincrease)
	samplestatlst.append(newstat)
	#fastest growing states
	fastgrownum=max(rate.values())
	for x, y in rate.items():
		if y==fastgrownum:
			fastgrowname=x
			break
	newstat=["fastest growing"]
	newstat.append(fastgrowname)
	samplestatlst.append(newstat)
	#gets decreasing states
	decreasing=[]
	for hi in range(len(ratelst)):
		if ratelst[hi][1]<0:
			decreasing.append(ratelst[hi][0])
	decreasing=sorted(decreasing)
	newstat=["decreasing"]
	newstat.append(decreasing)
	samplestatlst.append(newstat)
	samplestatdict=dict(samplestatlst)
	return samplestatdict
def write_report ( r , filename ) :	
	file=open(filename, 'w')
	report=r
	reportlst=[]
	#make list
	for key, value in report.items():
		temp = [key,value]
		reportlst.append(temp)
	for zf in range(len(reportlst)):
		if reportlst[zf][0]==('State'):
			headlock=zf
	head=reportlst[headlock]
	reportlst.pop(headlock)
	newlst=[]
	headline=[]
	headline.append(head[0])
	for xc in range(len(head[1])):
		headline.append(head[1][xc])		
	counter=len(reportlst[0][1])
	for zx in range(len(reportlst)):
		newline=[]
		newline.append(reportlst[zx][0])
		for cv in range(len(reportlst[0][1])):
			newline.append(reportlst[zx][1][cv])
		newlst.append(newline)
	#sort by first value
	newlst.sort(key=lambda x : x[0])
	newlst.insert(0,headline)
	#writing it all
	quotes='"'
	for kf in range(len(newlst)):
		for fg in range(len(newlst[0])):
			newitem=str(newlst[kf][fg])
			newitem=quotes+newitem+quotes
			newlst[kf][fg]=newitem
	for gj in range(len(newlst)):
		for bd in range(len(newlst[0])):
			if bd==(len(newlst[0])-1):
				newlst[gj][bd]=(newlst[gj][bd]+'\n')
			else:
				newlst[gj][bd]=(newlst[gj][bd]+(','))
	for gj in range(len(newlst)):
		for bd in range(len(newlst[0])):
			file.write(newlst[gj][bd])
	file.close()
def write_statistics ( stats ,filename ) :
	file=open(filename, 'w')
	statlst=[]
	quotes='"'
	for key, value in stats.items():
		temp = [key,value]
		statlst.append(temp)
	#just writing everything down
	file.write('"Statistic","Value"\n')
	file.write('"total increase",')
	nextval=str(stats['total increase'])
	nextval=quotes+nextval+quotes
	file.write(nextval)
	file.write('\n')
	file.write('"most populous",')
	nextval=str(stats["most populous"])
	nextval=quotes+nextval+quotes
	file.write(nextval)
	file.write('\n')
	file.write('"least populous",')
	nextval=str(stats["least populous"])
	nextval=quotes+nextval+quotes
	file.write(nextval)
	file.write('\n')
	file.write('"largest increase",')
	nextval=str(stats["largest increase"])
	nextval=quotes+nextval+quotes
	file.write(nextval)
	file.write('\n')
	file.write('"fastest growing",')
	nextval=str(stats["fastest growing"])
	nextval=quotes+nextval+quotes
	file.write(nextval)
	file.write('\n')
	file.write('"decreasing",')
	nextval=str(stats["decreasing"])
	nextval=quotes+nextval+quotes
	file.write(nextval)
	file.write('\n')
	file.close()

