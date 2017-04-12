
def compute(filename):
	x=open(filename)
	full=x.read()
	liner=x.readline()
	lst=[]
	usedlst=[]
	for x in range(len(full)):
		next=liner
		if next not in usedlst:
			usedlst.append(next)
			ammount=full.count(next)
			newvalue=[]
			newvalue.append(next)
			newvalue.append(ammount)
			lst.append(newvalue)
	return dict(lst)
def show_dictionary(d, limit=0):
	finallst=[]
	for k, v in d.items():
		newitem=[]
		if v>=limit:
			newitem.append(k)
			newitem.append(v)
			finallst.append(newitem)
	for b in range(len(finallst)):
		for h in range(len(finallst)):
			if h!=len(finallst):
				if finallst[h][0]>finallst[h+1][0]:
					finallst[h], finallst[h+1] = finallst[h+1], finallst[h]
	return dict(finallst)