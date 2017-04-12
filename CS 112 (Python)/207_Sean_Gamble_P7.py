#-------------------------------------------------------------------------------
# Name: Sean Gamble
# Project 7
# Section 207
# Due Date: 12/5/2014
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
class Moment:
	def __init__(self,	year=0,	month=0,	day=0,	hour=0,	minute=0):
		#check if all integers
		try:
			year=int(year)
		except:
			raise TimeError('Year not int')
		try:
			month=int(month)
		except:
			raise TimeError('Month not int')
		try:
			day=int(day)
		except:
			raise TimeError('Day not int')
		try:
			hour=int(hour)
		except:
			raise TimeError('Hour not int')
		try:
			minute=int(minute)
		except:
			raise TimeError('Minute not int')
		#Year can be anything
		self.year=year
		#Check if month in range 
		if (1<=month<=12)==False:
			raise TimeError('Month not in range')
		else:
			self.month=month
		#Find last day of month
		if month==1 or 3 or 5 or 7 or 8 or 10 or 12:
			lastday=31
		if month==2:
			if year%4==0:
				if year%100!=0:
					lastday=29
				elif year%400==0:
					lastday=29
				else:
					lastday=28
			else:
				lastday=28
		if month==4 or month==6 or month==9 or month==11:
			lastday=30
		#Check Day in range
		if 1<=day<=lastday==False:
			raise TimeError('Day not in range')
		else:
			self.day=day
		#Check hour in range
		if  (0 <= hour <= 23)==False:
			raise TimeError('Hour not in range')
		else:
			self.hour=hour
		#Check in minute in range
		if 0 <= minute<= 59==False:
			raise TimeError('Minute not in range')
		else:
			self.minute=minute
	def __str__(self):
		return('%d/%.2d/%.2d-%.2d:%.2d'%(self.year,self.month,self.day,self.hour,self.minute))
	def __repr__(self):
		return('Moment(%d, %d, %d, %d, %d)'%(self.year,self.month,self.day,self.hour,self.minute))
	def before(self, other):
		if self.year<other.year:
			return True
		elif self.year==other.year:
			if self.month<other.month:
				return True
			elif self.month==other.month:
				if self.day<other.day:
					return True
				elif self.day==other.day:
					if self.hour<other.hour:
						return True
					elif self.hour==other.hour:
						if self.minute<other.minute:
							return True
						else:
							return False
					else:
						return False		
				else:
					return False
			else:
				return False
		else:
			return False		
	def after(self,	other):
		if self.year>other.year:
			return True
		elif self.year==other.year:
			if self.month>other.month:
				return True
			elif self.month==other.month:
				if self.day>other.day:
					return True
				elif self.day==other.day:
					if self.hour>other.hour:
						return True
					elif self.hour==other.hour:
						if self.minute>other.minute:
							return True
						else:
							return False
					else:
						return False		
				else:
					return False
			else:
				return False
		else:
			return False	
	def delta(self,	year=0, month=0,	day=0,	hour=0,	minute=0):
		self.minute=self.minute+minute
		carrymin=0
		while self.minute>59:
			carrymin+=1
			self.minute+=(-60)
		while self.minute<0:
			carrymin+=(-1)
			self.minute+=60
		hour+=carrymin
		self.hour+=hour
		carryhour=0
		while self.hour>23:
			carryhour+=1
			self.hour+=(-60)
		while self.hour<0:
			carryhour+=(-1)
			self.hour+=(60)
		day+=carryhour
		self.day+=day
		
		self.month+=month
		monthcarry=0
		while self.month>12:
			self.month+=(-12)
			monthcarry+=1
		while self.month<0:
			self.month+=12
			monthcarry+=(-1)
		
		monthref=self.month

		#find last day of month
		if monthref==1 or monthref==3 or monthref==5 or monthref==7 or monthref==8 or monthref==10 or monthref==12:
			lastday=31
		if monthref==2:
			if year%4==0:
				if year%100!=0:
					lastday=29
				elif year%400==0:
					lastday=29
				else:
					lastday=28
			else:
				lastday=28
		if monthref==4 or monthref==6 or monthref==9 or monthref==11:
			lastday=30
		carryday=0
		#fixing for month
		while self.day>lastday:
			monthref+=(-1)
			#Find Last day of current month
			if monthref==1 or monthref==3 or monthref==5 or\
				monthref==7 or monthref==8 or monthref==10 or monthref==12:
				lastday=31
			if monthref==2:
				if year%4==0:
					if year%100!=0:
						lastday=29
					elif year%400==0:
						lastday=29
					else:
						lastday=28
				else:
					lastday=28
			if monthref==4 or monthref==6 or monthref==9 or monthref==11:
				lastday=30
			self.day+=(-(lastday))
			carryday+=1
			
		#fixing for month
		while self.day<1:
			#Find Last day of current month
			monthref-=(1)
			if monthref==1 or monthref==3 or monthref==5 or monthref==7 or monthref==8 or monthref==10 or monthref==12:
				lastday=31
			if monthref==2:
				if year%4==0:
					if year%100!=0:
						lastday=29
					elif year%400==0:
						lastday=29
					else:
						lastday=28
				else:
					lastday=28
			if monthref==4 or monthref==6 or monthref==9 or monthref==11:
				lastday=30
			carryday+=(-1)
			self.day+=lastday	
		#add months
		self.month+=carryday
		#add years
		year+=monthcarry
		self.year+=year
class TimeSpan:
	def __init__(self,	start,	stop):
		if stop.before(start):
			raise TimeError('Stop time before Start time')
		else:
			self.start=start
			self.stop=stop
	def __str__(self):
		return('TimeSpan(%d/%.2d/%.2d-%.2d:%.2d, %d/%.2d/%.2d-%.2d:%.2d)'%(\
		self.start.year,self.start.month,self.start.day,self.start.hour,\
		self.start.minute, self.stop.year,self.stop.month,\
		self.stop.day,self.stop.hour,self.stop.minute))
	def __repr__(self):
		return('TimeSpan(Moment(%d, %.2d, %.2d, %.2d, %.2d), Moment\
		(%d, %.2d, %.2d, %.2d, %.2d))'%(self.start.year,self.start.month,\
		self.start.day,self.start.hour,self.start.minute, self.stop.year,\
		self.stop.month,self.stop.day,self.stop.hour,self.stop.minute))
	def during_moment(self,moment):
		if moment.before(self.start):
			return False
		if moment.after(self.stop):
			return False
		else:
			return True
	def overlaps(self,	other):
		if other.start.before(self.stop):
			if other.start.before(self.start)==False:
				return True
		if self.start.before(other.stop):
			if self.start.before(other.start)==False:
				return True
		if other.start.year==self.stop.year:
			if other.start.month==self.stop.month:
				if other.start.day==self.stop.day:
					if other.start.hour==self.stop.hour:
						if other.start.minute==self.stop.minute:
							return True
		if other.stop==self.start:
			return True
		if other.stop==self.stop:
			return True
		if other.start==self.start:
			return True
		else:
			return False
	def set_duration(self,	year=0,	month=0,	day=0,	hour=0,	minute=0):
		#puts in holder
		tempholdy=self.start.year
		tempholdm=self.start.month
		tempholdd=self.start.day
		tempholdh=self.start.hour
		tempholdmi=self.start.minute
		#resets stop
		self.stop.year=tempholdy
		self.stop.month=tempholdm
		self.stop.day=tempholdd
		self.stop.hour=tempholdh
		self.stop.minute=tempholdmi
		self.stop.delta(year, month, day, hour, minute)
		if self.stop.before(self.start):
			raise TimeError('Stop before start')
class Event:
	def __init__(self,	title,	location,	timespan):
		self.title=title
		self.location=location
		self.timespan=timespan
	def __str__(self):
		return('Event: %s. Location: %s. %s, %s'%(self.title,self.location,\
		self.timespan.start,self.timespan.stop))
	def __repr__(self):
		return('Event("%s", "%s", %s, %s)'%(self.title,self.location,self.\
		timespan.start.__repr__(),self.timespan.stop.__repr__()))
class TimeError(Exception):
	def __init__(self,	msg):
		self.msg=msg
	def __str__(self):
		return str(self.msg)
	def __repr__(self):
		return repr(self.msg)
class ScheduleConflictError(Exception):
	def __init__(self,	msg):
		self.msg=msg
	def __str__(self) :
		return str(self.msg)
	def __repr__(self) :
		return str(self.msg)
class EventPlanner:
	def __init__	(self,	owner,	events=None):
		if events==None:
			self.events=[]
		else:
			self.events=events
		self.owner=owner
	def __str__(self):
		return('EventPlanner("%s", %s)' %(self.owner, self.events))
	def __repr__(self):
		return('EventPlanner("%s", %s)' %(self.owner, self.events))
	def add_event(self,	event):
		for ri in range(len(self.events)):
			if self.events[ri].timespan.overlaps(event.timespan):
				raise ScheduleConflictError("Can't add date,\
				conflicting Timespans")
		self.events.append(event)
		return None
	def add_events(self,events):
		counter=0
		for zi in range(len(events)):
			try:
				self.add_event(events[zi])
			except:
				counter+=1
		return counter
	def available_at(self,moment):
		for xi in range(len(self.events)):
			if self.events[xi].timespan.during_moment(moment)==True:
				return False
			else:
				return True
	def available_during(self,timespan):
		for f in range(len(self.events)):
			if self.events[f].timespan.overlaps(timespan):
				return False
		return True
	def can_attend(self,event):
		for ch in range(len(self.events)):
			if self.events[ch].timespan.overlaps(event.timespan):
				return False
		return True
