drop table TRANSCRIPT cascade constraints;
drop table PREREQ cascade constraints;
drop table  COURSE cascade constraints;
drop table  TIMESLOT                       cascade constraints;
drop table  TIMEPLACE                      cascade constraints;
drop table  STUDENT                        cascade constraints;
drop table  SECTION                        cascade constraints;
drop table  ROOM                           cascade constraints;
drop table  OFFICEHRS                      cascade constraints;
drop table  OFFICE                         cascade constraints;
drop table  HELDAT                         cascade constraints;
drop table  FACULTY                        cascade constraints;
drop table  ENROLL                         cascade constraints;
drop table  DEPARTMENT                     cascade constraints;
drop table TRANSCRIPT cascade constraints;

create table ROOM
( ROOM_NUM number(3),
  BCODE varchar2(3),
  SEATS number(3) not null,
  PRIMARY KEY (ROOM_NUM, BCODE));
create table TIMESLOT
( TSTART number(4) check (0<TSTART AND TSTART<2400),
  TEND number(4) check (0<TEND AND TEND<2400),
  TDAY varchar2(9) CHECK (TDAY IN ('Monday','Tuesday','Wednesday','Thursday','Friday','Saturday','Sunday')),
  check (TSTART<TEND),
  PRIMARY KEY(TSTART,TEND,TDAY));
create table OFFICE
( ROOM_NUM number(3),
  BCODE varchar2(3),
  AREA number(10),
  PRIMARY KEY (BCODE, ROOM_NUM));
create table DEPARTMENT
( DCODE varchar2(4) primary key,
  DNAME varchar2(30) not null unique,
  PHONE_EXT number(4) not null unique,
  OFFICE_CODE varchar2(3) not null,
  OFFICE_NUM number(3) not null,
  CHAIR_UID number(9) not null unique,
  CONSTRAINT uqtdept UNIQUE(OFFICE_CODE, OFFICE_NUM),
  FOREIGN KEY (OFFICE_CODE, OFFICE_NUM) references OFFICE(BCODE, ROOM_NUM));
create table STUDENT
( DCODE varchar2(4) references DEPARTMENT(DCODE) not null,
  SUID number(9) primary key,
  SNAME varchar2(30) not null,
  STATUS varchar2(13) not null);
create table FACULTY
( DCODE varchar2(4) references DEPARTMENT(DCODE) deferrable not null,
  SUID number(9) primary key,
  FNAME varchar2(30) not null,
  PHONE_EXT number(4) not null unique,
  RANK varchar2(19) not null,
  OFFICE_CODE varchar2(3) not null,
  OFFICE_NUM number(3) not null,
  CONSTRAINT uqtfac UNIQUE(OFFICE_CODE, OFFICE_NUM),
  FOREIGN KEY (OFFICE_CODE, OFFICE_NUM) references OFFICE(BCODE, ROOM_NUM));
alter table DEPARTMENT
add constraint HASCHAIR foreign key (CHAIR_UID) references FACULTY(SUID) deferrable
; 
create table COURSE
( TITLE varchar2(40) not null,
  CREDITS number(1) CHECK (CREDITS IN (1,2,3,4)),
  CCODE number(3),
  DCODE varchar2(4) references DEPARTMENT(DCODE),
  PRIMARY KEY (CCODE,DCODE));
create table SECTION
( DCODE varchar2(4),
  SCODE number(3),
  CCODE number(3),
  TEACH_UID number(9) references FACULTY(SUID) not null,
  FOREIGN KEY (DCODE, CCODE) references COURSE(DCODE,CCODE),
  PRIMARY KEY (DCODE, SCODE, CCODE));
create table TIMEPLACE
( ROOM_NUM number(3),
  BCODE varchar2(3),
  TSTART number(4),
  TEND number(4),
  TDAY varchar2(9),
  FOREIGN KEY (ROOM_NUM, BCODE) references ROOM(ROOM_NUM, BCODE),
  FOREIGN KEY (TSTART,TEND,TDAY) references TIMESLOT,
  PRIMARY KEY (ROOM_NUM,BCODE,TSTART,TEND,TDAY));
create table HELDAT
( DCODE varchar2(4) not null,
  SCODE number(3) not null,
  CCODE number(3) not null,  
  ROOM_NUM number(3),
  BCODE varchar2(3),
  TSTART number(4),
  TEND number(4),
  TDAY varchar2(9),
  PRIMARY KEY (ROOM_NUM,BCODE,TSTART,TEND,TDAY),
  FOREIGN KEY (ROOM_NUM, BCODE,TSTART,TEND,TDAY) references TIMEPLACE(ROOM_NUM, BCODE,TSTART,TEND,TDAY),
  FOREIGN KEY (DCODE,CCODE,SCODE) references SECTION(DCODE,CCODE,SCODE));
--alter table SECTION
--add constraint HASMEET foreign key(CCODE) references HELDAT(CCODE) deferrable
--;

create table PREREQ
( DCODE_PRE varchar2(4),
  DCODE_POST varchar2(4),
  CCODE_PRE number(3),
  CCODE_POST number(3),
  PRIMARY KEY (DCODE_PRE,DCODE_POST,CCODE_PRE,CCODE_POST),
  FOREIGN KEY (DCODE_PRE,CCODE_PRE) references COURSE(DCODE,CCODE),
  FOREIGN KEY (DCODE_POST,CCODE_POST) references COURSE(DCODE,CCODE));
create table TRANSCRIPT
( DCODE varchar(4),
  SUID number(9),
  CCODE number(3),
  GRADE CHAR(1) CHECK (GRADE IN ('A','B','C','D','F')),
  PRIMARY KEY(DCODE,SUID,CCODE),
  FOREIGN KEY(DCODE,CCODE) references COURSE(DCODE,CCODE),
  FOREIGN KEY(SUID) references STUDENT);
create table ENROLL
( SUID number(9) references STUDENT(SUID),
  DCODE varchar2(4),
  SCODE number(3),
  CCODE number(3),
  PRIMARY KEY(SUID, DCODE, SCODE, CCODE),
  FOREIGN KEY(DCODE, SCODE, CCODE) references SECTION(DCODE, SCODE, CCODE));
create table OFFICEHRS
( SUID number(9) references FACULTY(SUID),
  TSTART number(4),
  TEND number(4),
  TDAY varchar2(9),
  PRIMARY KEY (SUID, TSTART,TEND,TDAY),
  FOREIGN KEY (TSTART,TEND,TDAY) references TIMESLOT);
set constraint HASCHAIR deferred; 
insert into ROOM(ROOM_NUM,BCODE,SEATS) values (100, 'el', 20);
insert into ROOM(ROOM_NUM,BCODE,SEATS) values (101, 'el', 10);
insert into ROOM(ROOM_NUM,BCODE,SEATS) values (102, 'el', 20);
insert into ROOM(ROOM_NUM,BCODE,SEATS) values (103, 'el', 20);
insert into ROOM(ROOM_NUM,BCODE,SEATS) values (104, 'el', 100);
insert into ROOM(ROOM_NUM,BCODE,SEATS) values (100, 'rb', 21);
insert into ROOM(ROOM_NUM,BCODE,SEATS) values (101, 'rb', 25);
insert into ROOM(ROOM_NUM,BCODE,SEATS) values (102, 'rb', 30);
insert into ROOM(ROOM_NUM,BCODE,SEATS) values (202, 'rb', 10);
insert into ROOM(ROOM_NUM,BCODE,SEATS) values (103, 'rb', 19);
insert into ROOM(ROOM_NUM,BCODE,SEATS) values (200, 'rb', 19);
insert into ROOM(ROOM_NUM,BCODE,SEATS) values (203, 'rb', 19);
insert into ROOM(ROOM_NUM,BCODE,SEATS) values (201, 'rb', 19);
insert into ROOM(ROOM_NUM,BCODE,SEATS) values (204, 'rb', 19);
insert into ROOM(ROOM_NUM,BCODE,SEATS) values (104, 'rb', 19);
insert into ROOM(ROOM_NUM,BCODE,SEATS) values (105, 'rb', 19);
insert into ROOM(ROOM_NUM,BCODE,SEATS) values (106, 'rb', 19);
insert into ROOM(ROOM_NUM,BCODE,SEATS) values (205, 'rb', 19);
insert into ROOM(ROOM_NUM,BCODE,SEATS) values (206, 'rb', 19);
insert into ROOM(ROOM_NUM,BCODE,SEATS) values (107, 'rb', 19);
insert into ROOM(ROOM_NUM,BCODE,SEATS) values (207, 'rb', 19);
insert into ROOM(ROOM_NUM,BCODE,SEATS) values (200, 'eng', 19);
insert into ROOM(ROOM_NUM,BCODE,SEATS) values (201, 'eng', 19);
insert into ROOM(ROOM_NUM,BCODE,SEATS) values (202, 'eng', 19);
insert into ROOM(ROOM_NUM,BCODE,SEATS) values (203, 'eng', 19);
insert into ROOM(ROOM_NUM,BCODE,SEATS) values (301, 'eng', 19);
insert into ROOM(ROOM_NUM,BCODE,SEATS) values (302, 'eng', 19);
insert into ROOM(ROOM_NUM,BCODE,SEATS) values (303, 'eng', 19);
insert into ROOM(ROOM_NUM,BCODE,SEATS) values (304, 'eng', 19);
insert into ROOM(ROOM_NUM,BCODE,SEATS) values (204, 'eng', 19);
insert into ROOM(ROOM_NUM,BCODE,SEATS) values (106, 'eng', 19);

insert into OFFICE(ROOM_NUM,BCODE,AREA) values (102, 'aq', 50);
insert into OFFICE(ROOM_NUM,BCODE,AREA) values (103, 'aq', 50);
insert into OFFICE(ROOM_NUM,BCODE,AREA) values (104, 'aq', 50);
insert into OFFICE(ROOM_NUM,BCODE,AREA) values (105, 'aq', 50);
insert into OFFICE(ROOM_NUM,BCODE,AREA) values (106, 'aq', 40);
insert into OFFICE(ROOM_NUM,BCODE,AREA) values (107, 'aq', 40);
insert into OFFICE(ROOM_NUM,BCODE,AREA) values (108, 'aq', 40);
insert into OFFICE(ROOM_NUM,BCODE,AREA) values (109, 'aq', 40);
insert into OFFICE(ROOM_NUM,BCODE,AREA) values (110, 'aq', 40);
insert into OFFICE(ROOM_NUM,BCODE,AREA) values (111, 'aq', 40);
insert into OFFICE(ROOM_NUM,BCODE,AREA) values (112, 'aq', 40);
insert into OFFICE(ROOM_NUM,BCODE,AREA) values (100, 'of', 60);
insert into OFFICE(ROOM_NUM,BCODE,AREA) values (101, 'of', 70);
insert into OFFICE(ROOM_NUM,BCODE,AREA) values (102, 'of', 50);
insert into OFFICE(ROOM_NUM,BCODE,AREA) values (100, 'ph', 50);
insert into OFFICE(ROOM_NUM,BCODE,AREA) values (101, 'ph', 50);
insert into OFFICE(ROOM_NUM,BCODE,AREA) values (102, 'ph', 50);
insert into OFFICE(ROOM_NUM,BCODE,AREA) values (100, 'eng', 50);
insert into OFFICE(ROOM_NUM,BCODE,AREA) values (101, 'eng', 50);
insert into OFFICE(ROOM_NUM,BCODE,AREA) values (102, 'eng', 50);
insert into OFFICE(ROOM_NUM,BCODE,AREA) values (103, 'eng', 50);
insert into OFFICE(ROOM_NUM,BCODE,AREA) values (104, 'eng', 50);
insert into OFFICE(ROOM_NUM,BCODE,AREA) values (105, 'eng', 50);
insert into OFFICE(ROOM_NUM,BCODE,AREA) values (100, 'cx', 50);
insert into OFFICE(ROOM_NUM,BCODE,AREA) values (101, 'cx', 50);
insert into OFFICE(ROOM_NUM,BCODE,AREA) values (102, 'cx', 50);
insert into OFFICE(ROOM_NUM,BCODE,AREA) values (103, 'cx', 50);
insert into OFFICE(ROOM_NUM,BCODE,AREA) values (104, 'cx', 50);
insert into OFFICE(ROOM_NUM,BCODE,AREA) values (105, 'cx', 50);
insert into OFFICE(ROOM_NUM,BCODE,AREA) values (106, 'cx', 50);
insert into OFFICE(ROOM_NUM,BCODE,AREA) values (107, 'cx', 50);
insert into OFFICE(ROOM_NUM,BCODE,AREA) values (108, 'cx', 50);

insert into TIMESLOT(TSTART,TEND,TDAY) values (600, 700, 'Monday');
insert into TIMESLOT(TSTART,TEND,TDAY) values (700, 800, 'Monday');
insert into TIMESLOT(TSTART,TEND,TDAY) values (800, 900, 'Monday');
insert into TIMESLOT(TSTART,TEND,TDAY) values (900, 1000, 'Monday');
insert into TIMESLOT(TSTART,TEND,TDAY) values (1100, 1200, 'Monday');
insert into TIMESLOT(TSTART,TEND,TDAY) values (1000, 1100, 'Monday');
insert into TIMESLOT(TSTART,TEND,TDAY) values (2100, 2200, 'Monday');
insert into TIMESLOT(TSTART,TEND,TDAY) values (600, 700, 'Tuesday');
insert into TIMESLOT(TSTART,TEND,TDAY) values (700, 800, 'Tuesday');
insert into TIMESLOT(TSTART,TEND,TDAY) values (800, 900, 'Tuesday');
insert into TIMESLOT(TSTART,TEND,TDAY) values (900, 1000, 'Tuesday');
insert into TIMESLOT(TSTART,TEND,TDAY) values (1000, 1100, 'Tuesday');
insert into TIMESLOT(TSTART,TEND,TDAY) values (1100, 1200, 'Tuesday');
insert into TIMESLOT(TSTART,TEND,TDAY) values (1200, 1300, 'Tuesday');
insert into TIMESLOT(TSTART,TEND,TDAY) values (1300, 1400, 'Tuesday');
insert into TIMESLOT(TSTART,TEND,TDAY) values (1300, 1500, 'Tuesday');
insert into TIMESLOT(TSTART,TEND,TDAY) values (2000, 2100, 'Tuesday');
insert into TIMESLOT(TSTART,TEND,TDAY) values (1000, 1100, 'Wednesday');
insert into TIMESLOT(TSTART,TEND,TDAY) values (1100, 1200, 'Wednesday');
insert into TIMESLOT(TSTART,TEND,TDAY) values (1200, 1300, 'Wednesday');
insert into TIMESLOT(TSTART,TEND,TDAY) values (2000, 2100, 'Wednesday');
insert into TIMESLOT(TSTART,TEND,TDAY) values (1100, 1200, 'Thursday');
insert into TIMESLOT(TSTART,TEND,TDAY) values (2100, 2200, 'Thursday');
insert into TIMESLOT(TSTART,TEND,TDAY) values (2200, 2300, 'Thursday');
insert into TIMESLOT(TSTART,TEND,TDAY) values (2200, 2300, 'Friday');
insert into TIMESLOT(TSTART,TEND,TDAY) values (800, 900, 'Friday');
insert into TIMESLOT(TSTART,TEND,TDAY) values (900, 1000, 'Friday');

insert into DEPARTMENT(DCODE,DNAME,PHONE_EXT,OFFICE_CODE,OFFICE_NUM,CHAIR_UID) values ('cs', 'compsci', 123, 'aq', 102, 1000);
insert into DEPARTMENT(DCODE,DNAME,PHONE_EXT,OFFICE_CODE,OFFICE_NUM,CHAIR_UID) values ('ee', 'eletricalengineer', 124, 'aq', 103, 1001);
insert into DEPARTMENT(DCODE,DNAME,PHONE_EXT,OFFICE_CODE,OFFICE_NUM,CHAIR_UID) values ('me', 'mechengineer', 125, 'aq', 104, 1002);
insert into DEPARTMENT(DCODE,DNAME,PHONE_EXT,OFFICE_CODE,OFFICE_NUM,CHAIR_UID) values ('phil', 'philosophy', 126, 'aq', 105, 1003);
insert into DEPARTMENT(DCODE,DNAME,PHONE_EXT,OFFICE_CODE,OFFICE_NUM,CHAIR_UID) values ('psyc', 'psycology', 127,'aq', 106, 1004);
insert into DEPARTMENT(DCODE,DNAME,PHONE_EXT,OFFICE_CODE,OFFICE_NUM,CHAIR_UID) values ('astr', 'astronomy', 128,'aq', 107, 1012);
insert into DEPARTMENT(DCODE,DNAME,PHONE_EXT,OFFICE_CODE,OFFICE_NUM,CHAIR_UID) values ('bio', 'biology', 129,'aq', 108, 1013);
insert into DEPARTMENT(DCODE,DNAME,PHONE_EXT,OFFICE_CODE,OFFICE_NUM,CHAIR_UID) values ('hlth', 'health', 130,'aq', 109, 1014);
insert into DEPARTMENT(DCODE,DNAME,PHONE_EXT,OFFICE_CODE,OFFICE_NUM,CHAIR_UID) values ('hist', 'history', 131,'aq', 110, 1015);
insert into DEPARTMENT(DCODE,DNAME,PHONE_EXT,OFFICE_CODE,OFFICE_NUM,CHAIR_UID) values ('arb', 'arbology', 132,'aq', 111, 1016);
insert into DEPARTMENT(DCODE,DNAME,PHONE_EXT,OFFICE_CODE,OFFICE_NUM,CHAIR_UID) values ('art', 'art', 133,'aq', 112, 1017);

insert into STUDENT(DCODE,SUID,SNAME,STATUS) values ('cs',2000, 'jhon', 'good');
insert into STUDENT(DCODE,SUID,SNAME,STATUS) values ('cs',2001, 'sam', 'good');
insert into STUDENT(DCODE,SUID,SNAME,STATUS) values ('ee',2002, 'jhon', 'bad');
insert into STUDENT(DCODE,SUID,SNAME,STATUS) values ('ee',2003, 'steve', 'good');
insert into STUDENT(DCODE,SUID,SNAME,STATUS) values ('me',2004, 'hannah', 'good');
insert into STUDENT(DCODE,SUID,SNAME,STATUS) values ('me',2005, 'erik', 'bad');
insert into STUDENT(DCODE,SUID,SNAME,STATUS) values ('phil',2006, 'julian', 'good');
insert into STUDENT(DCODE,SUID,SNAME,STATUS) values ('phil',2007, 'henry', 'good');
insert into STUDENT(DCODE,SUID,SNAME,STATUS) values ('psyc',2008, 'cat', 'bad');
insert into STUDENT(DCODE,SUID,SNAME,STATUS) values ('psyc',2009, 'bill', 'good');
insert into STUDENT(DCODE,SUID,SNAME,STATUS) values ('cs',2010, 'matt', 'good');
insert into STUDENT(DCODE,SUID,SNAME,STATUS) values ('psyc',2011, 'jhon', 'good');
insert into STUDENT(DCODE,SUID,SNAME,STATUS) values ('phil',2012, 'alfred', 'good');
insert into STUDENT(DCODE,SUID,SNAME,STATUS) values ('me',2013, 'matt', 'good');
insert into STUDENT(DCODE,SUID,SNAME,STATUS) values ('ee',2014, 'damon', 'bad');
insert into STUDENT(DCODE,SUID,SNAME,STATUS) values ('cs',2015, 'hillary', 'good');

insert into FACULTY(DCODE,SUID,FNAME,PHONE_EXT,RANK,OFFICE_CODE,OFFICE_NUM) values ('cs',1000,'Bill',232,'head','of',100);
insert into FACULTY(DCODE,SUID,FNAME,PHONE_EXT,RANK,OFFICE_CODE,OFFICE_NUM) values ('ee',1001,'Jill',233,'head','of',101);
insert into FACULTY(DCODE,SUID,FNAME,PHONE_EXT,RANK,OFFICE_CODE,OFFICE_NUM) values ('me',1002,'Mat',234,'head','of',102);
insert into FACULTY(DCODE,SUID,FNAME,PHONE_EXT,RANK,OFFICE_CODE,OFFICE_NUM) values ('phil',1003,'Henry',235,'head','ph',100);
insert into FACULTY(DCODE,SUID,FNAME,PHONE_EXT,RANK,OFFICE_CODE,OFFICE_NUM) values ('psyc',1004,'Bob',236,'head','ph',101);
insert into FACULTY(DCODE,SUID,FNAME,PHONE_EXT,RANK,OFFICE_CODE,OFFICE_NUM) values ('cs',1005,'Kathy',237,'prof','ph',102);
insert into FACULTY(DCODE,SUID,FNAME,PHONE_EXT,RANK,OFFICE_CODE,OFFICE_NUM) values ('ee',1006,'Garm',238,'prof','eng',100);
insert into FACULTY(DCODE,SUID,FNAME,PHONE_EXT,RANK,OFFICE_CODE,OFFICE_NUM) values ('me',1007,'Cheese',239,'adjunc','eng',101);
insert into FACULTY(DCODE,SUID,FNAME,PHONE_EXT,RANK,OFFICE_CODE,OFFICE_NUM) values ('phil',1008,'Blu',240,'prof','eng',102);
insert into FACULTY(DCODE,SUID,FNAME,PHONE_EXT,RANK,OFFICE_CODE,OFFICE_NUM) values ('psyc',1009,'Bill',241,'prof','eng',103);
insert into FACULTY(DCODE,SUID,FNAME,PHONE_EXT,RANK,OFFICE_CODE,OFFICE_NUM) values ('me',1010,'Bonny',242,'prof','eng',104);
insert into FACULTY(DCODE,SUID,FNAME,PHONE_EXT,RANK,OFFICE_CODE,OFFICE_NUM) values ('cs',1011,'Baxter',243,'prof','eng',105);
insert into FACULTY(DCODE,SUID,FNAME,PHONE_EXT,RANK,OFFICE_CODE,OFFICE_NUM) values ('astr',1012,'arnold',244,'head','cx',100);
insert into FACULTY(DCODE,SUID,FNAME,PHONE_EXT,RANK,OFFICE_CODE,OFFICE_NUM) values ('bio',1013,'palmer ',245,'head','cx',101);
insert into FACULTY(DCODE,SUID,FNAME,PHONE_EXT,RANK,OFFICE_CODE,OFFICE_NUM) values ('hlth',1014,'Rob',246,'head','cx',102);
insert into FACULTY(DCODE,SUID,FNAME,PHONE_EXT,RANK,OFFICE_CODE,OFFICE_NUM) values ('hist',1015,'Motro',247,'head','cx',103);
insert into FACULTY(DCODE,SUID,FNAME,PHONE_EXT,RANK,OFFICE_CODE,OFFICE_NUM) values ('arb',1016,'Andrew',248,'head','cx',104);
insert into FACULTY(DCODE,SUID,FNAME,PHONE_EXT,RANK,OFFICE_CODE,OFFICE_NUM) values ('art',1017,'Snyder',249,'head','cx',105);

insert into COURSE(TITLE, CREDITS,CCODE,DCODE) values ('intro',3,100,'cs');
insert into COURSE(TITLE, CREDITS,CCODE,DCODE) values ('higher',3,200,'cs');
insert into COURSE(TITLE, CREDITS,CCODE,DCODE) values ('highest',3,300,'cs');
insert into COURSE(TITLE, CREDITS,CCODE,DCODE) values ('into2',3,100,'ee');
insert into COURSE(TITLE, CREDITS,CCODE,DCODE) values ('higher2',3,200,'ee');
insert into COURSE(TITLE, CREDITS,CCODE,DCODE) values ('highest2',3,300,'ee');
insert into COURSE(TITLE, CREDITS,CCODE,DCODE) values ('intro3',3,100,'me');
insert into COURSE(TITLE, CREDITS,CCODE,DCODE) values ('higher31',3,210,'me');
insert into COURSE(TITLE, CREDITS,CCODE,DCODE) values ('higher32',3,200,'me');
insert into COURSE(TITLE, CREDITS,CCODE,DCODE) values ('highest3',4,300,'me');
insert into COURSE(TITLE, CREDITS,CCODE,DCODE) values ('intro4',2,100,'phil');
insert into COURSE(TITLE, CREDITS,CCODE,DCODE) values ('intro5',1,100,'psyc');
insert into COURSE(TITLE, CREDITS,CCODE,DCODE) values ('astr1',1,100,'astr');
insert into COURSE(TITLE, CREDITS,CCODE,DCODE) values ('astr2',1,200,'astr');
insert into COURSE(TITLE, CREDITS,CCODE,DCODE) values ('bio1',1,100,'bio');
insert into COURSE(TITLE, CREDITS,CCODE,DCODE) values ('bio2',1,200,'bio');
insert into COURSE(TITLE, CREDITS,CCODE,DCODE) values ('hlth1',1,100,'hlth');
insert into COURSE(TITLE, CREDITS,CCODE,DCODE) values ('hlth2',1,200,'hlth');
insert into COURSE(TITLE, CREDITS,CCODE,DCODE) values ('hist1',2,100,'hist');
insert into COURSE(TITLE, CREDITS,CCODE,DCODE) values ('hist2',4,200,'hist');
insert into COURSE(TITLE, CREDITS,CCODE,DCODE) values ('hist31',3,300,'hist');
insert into COURSE(TITLE, CREDITS,CCODE,DCODE) values ('hist32',2,310,'hist');

insert into PREREQ(DCODE_PRE,DCODE_POST,CCODE_PRE,CCODE_POST) values ('cs','cs',100,200);
insert into PREREQ(DCODE_PRE,DCODE_POST,CCODE_PRE,CCODE_POST) values ('cs','cs',200,300);
insert into PREREQ(DCODE_PRE,DCODE_POST,CCODE_PRE,CCODE_POST) values ('ee','ee',100,200);
insert into PREREQ(DCODE_PRE,DCODE_POST,CCODE_PRE,CCODE_POST) values ('ee','ee',200,300);
insert into PREREQ(DCODE_PRE,DCODE_POST,CCODE_PRE,CCODE_POST) values ('me','me',100,200);
insert into PREREQ(DCODE_PRE,DCODE_POST,CCODE_PRE,CCODE_POST) values ('me','me',100,210);
insert into PREREQ(DCODE_PRE,DCODE_POST,CCODE_PRE,CCODE_POST) values ('me','me',200,300);
insert into PREREQ(DCODE_PRE,DCODE_POST,CCODE_PRE,CCODE_POST) values ('me','me',210,300);
insert into PREREQ(DCODE_PRE,DCODE_POST,CCODE_PRE,CCODE_POST) values ('astr','astr',100,200);
insert into PREREQ(DCODE_PRE,DCODE_POST,CCODE_PRE,CCODE_POST) values ('bio','bio',100,200);
insert into PREREQ(DCODE_PRE,DCODE_POST,CCODE_PRE,CCODE_POST) values ('hlth','hlth',100,200);
insert into PREREQ(DCODE_PRE,DCODE_POST,CCODE_PRE,CCODE_POST) values ('hist','hist',100,200);
insert into PREREQ(DCODE_PRE,DCODE_POST,CCODE_PRE,CCODE_POST) values ('hist','hist',200,300);
insert into PREREQ(DCODE_PRE,DCODE_POST,CCODE_PRE,CCODE_POST) values ('hist','hist',200,310);

insert into SECTION(DCODE,CCODE,SCODE,TEACH_UID) values ('astr',100,001,1012);
insert into SECTION(DCODE,CCODE,SCODE,TEACH_UID) values ('bio',100,001,1013);
insert into SECTION(DCODE,CCODE,SCODE,TEACH_UID) values ('hlth',100,001,1014);
insert into SECTION(DCODE,CCODE,SCODE,TEACH_UID) values ('hist',200,001,1016);
insert into SECTION(DCODE,CCODE,SCODE,TEACH_UID) values ('hist',310,001,1015);
insert into SECTION(DCODE,CCODE,SCODE,TEACH_UID) values ('hist',300,001,1015);
insert into SECTION(DCODE,CCODE,SCODE,TEACH_UID) values ('me',300,002,1011);
insert into SECTION(DCODE,CCODE,SCODE,TEACH_UID) values ('psyc',100,002,1011);
insert into SECTION(DCODE,CCODE,SCODE,TEACH_UID) values ('ee',200,002,1010);
insert into SECTION(DCODE,CCODE,SCODE,TEACH_UID) values ('me',210,002,1010);
insert into SECTION(DCODE,CCODE,SCODE,TEACH_UID) values ('cs',100,001,1000);
insert into SECTION(DCODE,CCODE,SCODE,TEACH_UID) values ('cs',200,001,1005);
insert into SECTION(DCODE,CCODE,SCODE,TEACH_UID) values ('cs',300,001,1005);
insert into SECTION(DCODE,CCODE,SCODE,TEACH_UID) values ('ee',100,001,1001);
insert into SECTION(DCODE,CCODE,SCODE,TEACH_UID) values ('ee',200,001,1006);
insert into SECTION(DCODE,CCODE,SCODE,TEACH_UID) values ('me',100,001,1002);
insert into SECTION(DCODE,CCODE,SCODE,TEACH_UID) values ('me',200,001,1007);
insert into SECTION(DCODE,CCODE,SCODE,TEACH_UID) values ('me',210,001,1002);
insert into SECTION(DCODE,CCODE,SCODE,TEACH_UID) values ('me',300,001,1007);
insert into SECTION(DCODE,CCODE,SCODE,TEACH_UID) values ('me',100,002,1002);
insert into SECTION(DCODE,CCODE,SCODE,TEACH_UID) values ('phil',100,001,1008);
insert into SECTION(DCODE,CCODE,SCODE,TEACH_UID) values ('phil',100,002,1003);
insert into SECTION(DCODE,CCODE,SCODE,TEACH_UID) values ('psyc',100,001,1009);

insert into TIMEPLACE(ROOM_NUM,BCODE,TSTART,TEND,TDAY) values(100, 'el', 1100, 1200, 'Monday');
insert into TIMEPLACE(ROOM_NUM,BCODE,TSTART,TEND,TDAY) values(100, 'el', 2100, 2200, 'Monday');
insert into TIMEPLACE(ROOM_NUM,BCODE,TSTART,TEND,TDAY) values(101, 'el', 1100, 1200, 'Monday');
insert into TIMEPLACE(ROOM_NUM,BCODE,TSTART,TEND,TDAY) values(102, 'el', 1100, 1200, 'Monday');
insert into TIMEPLACE(ROOM_NUM,BCODE,TSTART,TEND,TDAY) values(202, 'rb', 2200, 2300, 'Thursday');
insert into TIMEPLACE(ROOM_NUM,BCODE,TSTART,TEND,TDAY) values(102, 'rb', 1100, 1200, 'Monday');
insert into TIMEPLACE(ROOM_NUM,BCODE,TSTART,TEND,TDAY) values(102, 'rb', 1000, 1100, 'Monday');
insert into TIMEPLACE(ROOM_NUM,BCODE,TSTART,TEND,TDAY) values(103, 'rb', 1100, 1200, 'Thursday');
insert into TIMEPLACE(ROOM_NUM,BCODE,TSTART,TEND,TDAY) values(104, 'el', 1100, 1200, 'Monday');
insert into TIMEPLACE(ROOM_NUM,BCODE,TSTART,TEND,TDAY) values(103, 'el', 1100, 1200, 'Tuesday');
insert into TIMEPLACE(ROOM_NUM,BCODE,TSTART,TEND,TDAY) values(103, 'rb', 1100, 1200, 'Tuesday');
insert into TIMEPLACE(ROOM_NUM,BCODE,TSTART,TEND,TDAY) values(103, 'rb', 900, 1000, 'Tuesday');
insert into TIMEPLACE(ROOM_NUM,BCODE,TSTART,TEND,TDAY) values(202, 'rb', 1100, 1200, 'Thursday');
insert into TIMEPLACE(ROOM_NUM,BCODE,TSTART,TEND,TDAY) values(101, 'rb', 2100, 2200, 'Thursday');
insert into TIMEPLACE(ROOM_NUM,BCODE,TSTART,TEND,TDAY) values(102, 'rb', 2200, 2300, 'Thursday');
insert into TIMEPLACE(ROOM_NUM,BCODE,TSTART,TEND,TDAY) values(103, 'rb', 2200, 2300, 'Friday');
insert into TIMEPLACE(ROOM_NUM,BCODE,TSTART,TEND,TDAY) values(203, 'rb', 2200, 2300, 'Friday');
insert into TIMEPLACE(ROOM_NUM,BCODE,TSTART,TEND,TDAY) values(204, 'rb', 800, 900, 'Monday');
insert into TIMEPLACE(ROOM_NUM,BCODE,TSTART,TEND,TDAY) values(204, 'rb', 700, 800, 'Monday');
insert into TIMEPLACE(ROOM_NUM,BCODE,TSTART,TEND,TDAY) values(204, 'rb', 600, 700, 'Monday');
insert into TIMEPLACE(ROOM_NUM,BCODE,TSTART,TEND,TDAY) values(204, 'rb', 700, 800, 'Tuesday');
insert into TIMEPLACE(ROOM_NUM,BCODE,TSTART,TEND,TDAY) values(204, 'rb', 600, 700, 'Tuesday');
insert into TIMEPLACE(ROOM_NUM,BCODE,TSTART,TEND,TDAY) values(204, 'rb', 800, 900, 'Tuesday');
insert into TIMEPLACE(ROOM_NUM,BCODE,TSTART,TEND,TDAY) values(201, 'rb', 800, 900, 'Tuesday');
insert into TIMEPLACE(ROOM_NUM,BCODE,TSTART,TEND,TDAY) values(201, 'rb', 700, 800, 'Tuesday');
insert into TIMEPLACE(ROOM_NUM,BCODE,TSTART,TEND,TDAY) values(201, 'rb', 600, 700, 'Tuesday');

insert into HELDAT(DCODE,CCODE,SCODE,ROOM_NUM,BCODE,TSTART,TEND,TDAY) values('cs',100,001,100, 'el', 1100, 1200, 'Monday');
insert into HELDAT(DCODE,CCODE,SCODE,ROOM_NUM,BCODE,TSTART,TEND,TDAY) values('cs',100,001,103, 'rb', 2200, 2300, 'Friday');
insert into HELDAT(DCODE,CCODE,SCODE,ROOM_NUM,BCODE,TSTART,TEND,TDAY) values('cs',200,001,100, 'el', 2100, 2200, 'Monday');
insert into HELDAT(DCODE,CCODE,SCODE,ROOM_NUM,BCODE,TSTART,TEND,TDAY) values('cs',300,001,101, 'el', 1100, 1200, 'Monday');
insert into HELDAT(DCODE,CCODE,SCODE,ROOM_NUM,BCODE,TSTART,TEND,TDAY) values('ee',100,001,102, 'el', 1100, 1200, 'Monday');
insert into HELDAT(DCODE,CCODE,SCODE,ROOM_NUM,BCODE,TSTART,TEND,TDAY) values('ee',200,001,202, 'rb', 2200, 2300, 'Thursday');
insert into HELDAT(DCODE,CCODE,SCODE,ROOM_NUM,BCODE,TSTART,TEND,TDAY) values('me',100,001,102, 'rb', 1000, 1100, 'Monday');
insert into HELDAT(DCODE,CCODE,SCODE,ROOM_NUM,BCODE,TSTART,TEND,TDAY) values('me',200,001,103, 'rb', 1100, 1200, 'Thursday');
insert into HELDAT(DCODE,CCODE,SCODE,ROOM_NUM,BCODE,TSTART,TEND,TDAY) values('me',210,001,104, 'el', 1100, 1200, 'Monday');
insert into HELDAT(DCODE,CCODE,SCODE,ROOM_NUM,BCODE,TSTART,TEND,TDAY) values('me',300,001,103, 'rb', 900, 1000, 'Tuesday');
insert into HELDAT(DCODE,CCODE,SCODE,ROOM_NUM,BCODE,TSTART,TEND,TDAY) values('me',100,002,103, 'el', 1100, 1200, 'Tuesday');
insert into HELDAT(DCODE,CCODE,SCODE,ROOM_NUM,BCODE,TSTART,TEND,TDAY) values('phil',100,002,202, 'rb', 1100, 1200, 'Thursday');
insert into HELDAT(DCODE,CCODE,SCODE,ROOM_NUM,BCODE,TSTART,TEND,TDAY) values('phil',100,001,101, 'rb', 2100, 2200, 'Thursday');
insert into HELDAT(DCODE,CCODE,SCODE,ROOM_NUM,BCODE,TSTART,TEND,TDAY) values('psyc',100,001,102, 'rb', 2200, 2300, 'Thursday');
insert into HELDAT(DCODE,CCODE,SCODE,ROOM_NUM,BCODE,TSTART,TEND,TDAY) values('astr',100,001, 204, 'rb', 800, 900, 'Monday');
insert into HELDAT(DCODE,CCODE,SCODE,ROOM_NUM,BCODE,TSTART,TEND,TDAY) values('bio',100,001,204, 'rb', 700, 800, 'Monday');
insert into HELDAT(DCODE,CCODE,SCODE,ROOM_NUM,BCODE,TSTART,TEND,TDAY) values('hlth',100,001,204, 'rb', 600, 700, 'Monday');
insert into HELDAT(DCODE,CCODE,SCODE,ROOM_NUM,BCODE,TSTART,TEND,TDAY) values('hist',200,001,204, 'rb', 700, 800, 'Tuesday');
insert into HELDAT(DCODE,CCODE,SCODE,ROOM_NUM,BCODE,TSTART,TEND,TDAY) values('hist',310,001,204, 'rb', 600, 700, 'Tuesday');
insert into HELDAT(DCODE,CCODE,SCODE,ROOM_NUM,BCODE,TSTART,TEND,TDAY) values('hist',300,001,204, 'rb', 800, 900, 'Tuesday');
insert into HELDAT(DCODE,CCODE,SCODE,ROOM_NUM,BCODE,TSTART,TEND,TDAY) values('me',300,002,203, 'rb', 2200, 2300, 'Friday');
insert into HELDAT(DCODE,CCODE,SCODE,ROOM_NUM,BCODE,TSTART,TEND,TDAY) values('psyc',100,002,201, 'rb', 800, 900, 'Tuesday');
insert into HELDAT(DCODE,CCODE,SCODE,ROOM_NUM,BCODE,TSTART,TEND,TDAY) values('ee',200,002,201, 'rb', 700, 800, 'Tuesday');
insert into HELDAT(DCODE,CCODE,SCODE,ROOM_NUM,BCODE,TSTART,TEND,TDAY) values('me',210,002,201, 'rb', 600, 700, 'Tuesday');

insert into ENROLL(SUID,DCODE,CCODE,SCODE) values(2000, 'cs',100,001);
insert into ENROLL(SUID,DCODE,CCODE,SCODE) values(2000, 'ee',200,001);
insert into ENROLL(SUID,DCODE,CCODE,SCODE) values(2001, 'cs',200,001);
insert into ENROLL(SUID,DCODE,CCODE,SCODE) values(2001, 'me',100,002);
insert into ENROLL(SUID,DCODE,CCODE,SCODE) values(2002, 'cs',100,001);
insert into ENROLL(SUID,DCODE,CCODE,SCODE) values(2002, 'phil',100,001);
insert into ENROLL(SUID,DCODE,CCODE,SCODE) values(2003, 'me',200,001);
insert into ENROLL(SUID,DCODE,CCODE,SCODE) values(2003, 'ee',200,001);
insert into ENROLL(SUID,DCODE,CCODE,SCODE) values(2004, 'me',200,001);
insert into ENROLL(SUID,DCODE,CCODE,SCODE) values(2004, 'me',210,001);
insert into ENROLL(SUID,DCODE,CCODE,SCODE) values(2005, 'me',100,002);
insert into ENROLL(SUID,DCODE,CCODE,SCODE) values(2005, 'phil',100,001);
insert into ENROLL(SUID,DCODE,CCODE,SCODE) values(2006, 'phil',100,001);
insert into ENROLL(SUID,DCODE,CCODE,SCODE) values(2006, 'cs',300,001);
insert into ENROLL(SUID,DCODE,CCODE,SCODE) values(2007, 'phil',100,002);
insert into ENROLL(SUID,DCODE,CCODE,SCODE) values(2007, 'me',300,001);
insert into ENROLL(SUID,DCODE,CCODE,SCODE) values(2008, 'psyc',100,001);
insert into ENROLL(SUID,DCODE,CCODE,SCODE) values(2008, 'ee',100,001);
insert into ENROLL(SUID,DCODE,CCODE,SCODE) values(2009, 'psyc',100,001);
insert into ENROLL(SUID,DCODE,CCODE,SCODE) values(2009, 'phil',100,002);
insert into ENROLL(SUID,DCODE,CCODE,SCODE) values(2009, 'cs',300,001);
insert into ENROLL(SUID,DCODE,CCODE,SCODE) values(2010, 'astr',100,001);
insert into ENROLL(SUID,DCODE,CCODE,SCODE) values(2010, 'bio',100,001);
insert into ENROLL(SUID,DCODE,CCODE,SCODE) values(2010, 'me',300,002);
insert into ENROLL(SUID,DCODE,CCODE,SCODE) values(2011, 'hlth',100,001);
insert into ENROLL(SUID,DCODE,CCODE,SCODE) values(2011, 'hist',310,001);
insert into ENROLL(SUID,DCODE,CCODE,SCODE) values(2012, 'hist',300,001);
insert into ENROLL(SUID,DCODE,CCODE,SCODE) values(2012, 'hist',310,001);
insert into ENROLL(SUID,DCODE,CCODE,SCODE) values(2012, 'ee',200,002);
insert into ENROLL(SUID,DCODE,CCODE,SCODE) values(2012, 'astr',100,001);
insert into ENROLL(SUID,DCODE,CCODE,SCODE) values(2013, 'hlth',100,001);
insert into ENROLL(SUID,DCODE,CCODE,SCODE) values(2013, 'me',210,002);
insert into ENROLL(SUID,DCODE,CCODE,SCODE) values(2013, 'psyc',100,001);
insert into ENROLL(SUID,DCODE,CCODE,SCODE) values(2014, 'me',100,001);
insert into ENROLL(SUID,DCODE,CCODE,SCODE) values(2014, 'ee',100,001);

insert into TRANSCRIPT(DCODE,CCODE,SUID, GRADE) values('ee',100,2000,'B');
insert into TRANSCRIPT(DCODE,CCODE,SUID, GRADE) values('cs',100,2001,'A');
insert into TRANSCRIPT(DCODE,CCODE,SUID, GRADE) values('me',100,2003,'B');
insert into TRANSCRIPT(DCODE,CCODE,SUID, GRADE) values('ee',100,2003,'C');
insert into TRANSCRIPT(DCODE,CCODE,SUID, GRADE) values('me',100,2004,'A');
insert into TRANSCRIPT(DCODE,CCODE,SUID, GRADE) values('cs',100,2006,'C');
insert into TRANSCRIPT(DCODE,CCODE,SUID, GRADE) values('cs',200,2006,'A');
insert into TRANSCRIPT(DCODE,CCODE,SUID, GRADE) values('me',100,2007,'B');
insert into TRANSCRIPT(DCODE,CCODE,SUID, GRADE) values('me',200,2007,'B');
insert into TRANSCRIPT(DCODE,CCODE,SUID, GRADE) values('me',210,2007,'B');
insert into TRANSCRIPT(DCODE,CCODE,SUID, GRADE) values('cs',100,2009,'A');
insert into TRANSCRIPT(DCODE,CCODE,SUID, GRADE) values('cs',200,2009,'C');
insert into TRANSCRIPT(DCODE,CCODE,SUID, GRADE) values('ee',100,2009,'B');
insert into TRANSCRIPT(DCODE,CCODE,SUID, GRADE) values('phil',100,2005,'F');
insert into TRANSCRIPT(DCODE,CCODE,SUID, GRADE) values('me',100,2010,'A');
insert into TRANSCRIPT(DCODE,CCODE,SUID, GRADE) values('me',200,2010,'B');
insert into TRANSCRIPT(DCODE,CCODE,SUID, GRADE) values('me',210,2010,'B');
insert into TRANSCRIPT(DCODE,CCODE,SUID, GRADE) values('hlth',100,2011,'F');
insert into TRANSCRIPT(DCODE,CCODE,SUID, GRADE) values('hist',100,2011,'B');
insert into TRANSCRIPT(DCODE,CCODE,SUID, GRADE) values('hist',200,2011,'A');
insert into TRANSCRIPT(DCODE,CCODE,SUID, GRADE) values('hist',100,2012,'C');
insert into TRANSCRIPT(DCODE,CCODE,SUID, GRADE) values('hist',200,2012,'B');
insert into TRANSCRIPT(DCODE,CCODE,SUID, GRADE) values('ee',100,2012,'A');
insert into TRANSCRIPT(DCODE,CCODE,SUID, GRADE) values('me',100,2013,'F');

insert into OFFICEHRS(SUID,TSTART,TEND,TDAY) values(1000,800, 900, 'Friday');
insert into OFFICEHRS(SUID,TSTART,TEND,TDAY) values(1001,800, 900, 'Friday');
insert into OFFICEHRS(SUID,TSTART,TEND,TDAY) values(1002,800, 900, 'Friday');
insert into OFFICEHRS(SUID,TSTART,TEND,TDAY) values(1003,800, 900, 'Friday');
insert into OFFICEHRS(SUID,TSTART,TEND,TDAY) values(1004,800, 900, 'Friday');
insert into OFFICEHRS(SUID,TSTART,TEND,TDAY) values(1005,800, 900, 'Friday');
insert into OFFICEHRS(SUID,TSTART,TEND,TDAY) values(1006,800, 900, 'Friday');
insert into OFFICEHRS(SUID,TSTART,TEND,TDAY) values(1007,800, 900, 'Friday');
insert into OFFICEHRS(SUID,TSTART,TEND,TDAY) values(1008,900, 1000, 'Friday');
insert into OFFICEHRS(SUID,TSTART,TEND,TDAY) values(1009,900, 1000, 'Friday');
insert into OFFICEHRS(SUID,TSTART,TEND,TDAY) values(1010,900, 1000, 'Friday');
insert into OFFICEHRS(SUID,TSTART,TEND,TDAY) values(1011,900, 1000, 'Friday');
insert into OFFICEHRS(SUID,TSTART,TEND,TDAY) values(1012,900, 1000, 'Friday');
insert into OFFICEHRS(SUID,TSTART,TEND,TDAY) values(1013,900, 1000, 'Friday');
insert into OFFICEHRS(SUID,TSTART,TEND,TDAY) values(1014,900, 1000, 'Friday');
insert into OFFICEHRS(SUID,TSTART,TEND,TDAY) values(1015,900, 1000, 'Friday');
insert into OFFICEHRS(SUID,TSTART,TEND,TDAY) values(1016, 900, 1000, 'Friday');
--cant show credits, teachers hours could overlapi
set constraint all immediate;
