#-------------------------------------------------------------------------------
# Name: George Mason.
# Project 4
# Section 207
# Due Date: 10/19/2014
#-------------------------------------------------------------------------------
# Honor Code Statement: I received no assistance on this assignment that
# violates the ethical guidelines set forth by professor and class syllabus.
#-------------------------------------------------------------------------------
# References: (list any lecture slides, text book pages, any other resources)
# Note: you may not use code from websites, so don't bother looking any up.
#-------------------------------------------------------------------------------
# Comments and assumptions: Project was way too hard even for the given 
#time, multiple all nighters and neglecting every other class to figure
#this stuff out with only vague help on piazza due to you're 'honor code'
#-------------------------------------------------------------------------------
# NOTE: width of source code should be <= 80 characters to facilitate printing.
#2345678901234567890123456789012345678901234567890123456789012345678901234567890
# 10 20 30 40 50 60 70 80
#-------------------------------------------------------------------------------
checker=("")
nextword=("t")
lst=[]
gridlist=[]
print("enter all lines of the board; end with blank line.")
#gets user input
while checker is not nextword:
	nextword=input()
	if nextword is not checker:
		lst.append(nextword)
#Check if first line empty
if not lst:
	print("bad board - first line empty")
	quit()
#makes 2-d array
for x in range(len(lst)):
    wordmap=list(lst[x])
    gridlist.append(wordmap)
forlength=len(lst)
length=len(lst[0])
#Checks length
for i in range(forlength):
	lengthtwo=len(lst[i])
	if lengthtwo<length:
		print("bad board - line #", i+1," has too many characters")
		quit()
	if lengthtwo>length:
		print("bad board - line #", i+1," has too few characters") 
		quit()
#Checks valid characters
for x in range(len(lst)):
	for b in range(len(lst[0])):
		if gridlist[x][b] is not ("."):
			if (97<=ord(gridlist[x][b])<=122)==False:
				print("bad board - line #",x+1,"contains\
				unexpected character'",gridlist[x][b],"'")
				quit()
from valid_words import official_words
newlst=[]
for x in range(len(lst)):
    word=list(lst[x])
    for z in range(len(lst[0])):
        if lst[x][z] is ("."):
	        word[z]=(" ")
    word="".join(word)
    newlst.append(word)
horwords=[]
#Checks all horizontal words and sets up list
for x in range(len(newlst)):
	newstring=newlst[x].split()
	for c in range(len(newstring)):
		if len(newstring[c])>1:
			horwords.append(newstring[c])
			if newstring[c] not in official_words:
				#backslash screws up print, 80 column limit bad
				print("bad board – horizontal word '",newstring[c],"' is \
				unrecognized")
				quit()
allvert=[]
#Checks all vertical words and sets up list of them
for i in range(len(newlst)):
	vertlst=[]
	for e in range(len(newlst)):
		newletter=newlst[e][i]
		vertlst.append(newletter)
	final_vert_lst=("")
	for g in range(len(vertlst)):
		final_vert_lst=final_vert_lst+vertlst[g]
	finalvert=final_vert_lst.split()
	if len(finalvert[0])>1:
	    allvert.append(finalvert)
	for x in range(len(finalvert)):
		if len(finalvert[x])>1:
			if finalvert[x] not in official_words:
				print("bad board – vertical word '",finalvert[x],"' is\
				unrecognized")
				quit()
#Checks horizontally for connectedness, if there's more than two. 
#Checks above and below for letters
if len(lst)>1:
	for x in range(len(lst)):
		connect=False
		for r in range(len(lst[0])):
			if gridlist[x][r].isalpha():
				if connect==False:
					if x==0:
						if gridlist[x+1][r].isalpha():
								connect=True
					elif 0<x<len((lst))-1:
						if [gridlist[x]]!=len(lst):
							if gridlist[x+1][r].isalpha() or \
							gridlist[x-1][r].isalpha():
								connect=True
					else:
						if gridlist[x-1][r].isalpha():
							connect=True
					if r==(len(lst[0])-1) and connect==False:
						print("bad board - tiles not connected")
						quit()
					elif r!=(len(lst[0])-1):
						if gridlist[x][r+1]==(".") and connect==False:
							print("bad board - tiles not connected")
							quit()
			else:
				connect=False
#Checks if connected vertically, doesn't work though for 
#some instances and I have bugs to work out but its due soon
#Checks to the left and right for letters
if len(allvert)>1 and len(lst)>1:
	for x in range(len(lst[0])):
		connect=False
		for r in range(len(lst)):
			if gridlist[r][x].isalpha():
				if connect==False:
					if x==0:
						if gridlist[r][x+1].isalpha():
							connect=True
					elif 0<x<len(lst[0])-1:
						#check if its not on last line
						if r!=len(lst[0]):
							if lst[r][x+1].isalpha() or \
							gridlist[r][x-1].isalpha():
								connect=True
					else:
						if gridlist[r][x-1].isalpha():
							connect=True
					if r==(len(lst[0])-1) and connect==False:
						print("bad board - tiles not connected")
						quit()
					elif r!=(len(lst[0])-1):
						if gridlist[x][r+1]==(".") and connect==False:
							print("bad board - tiles not connected")
							quit()
			else:
				connect=False
print("valid board")
print("horizontal words:")
#print horizontal
for v in range(len(horwords)):
	print(horwords[v])
print("vertical words:")
#prints vertical
for c in allvert:
	print(allvert[c])