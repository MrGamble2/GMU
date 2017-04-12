integerone=input("Integer one")
integertwo=input("Integer two")
integerthree=input("Integer three")
intone=int (integerone)
inttwo=int (integertwo)
intthree=int (integerthree)
onetwo=(intone==inttwo)
onethree=(intone==intthree)
twothree=(inttwo==intthree)
have_duplicates= onetwo or onethree or twothree
print(have_duplicates)
intonetwox=(intone==inttwo>=intthree)
intonethreex=(intone==intthree>=inttwo)
inttwothreex=(inttwo==intthree>=intone)
tie_for_first=intonetwox or intonethreex or inttwothreex
print(tie_for_first)
year=input("Calendar Year")
year=int (year)
yeartwo=year%4
yearthree=year%100
yearfour=year%400
leapone=(yearthree==0)
leapfour=(yearfour==0)
leaptwo=(yeartwo==0)
leapyearone=leapfour and leapone 
is_leap_year=leapyearone and  leaptwo
print(is_leap_year)
