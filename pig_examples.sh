
----------------------------

Targil 1 - 2
REGISTER /home/cloudera/Downloads/piggybank-0.15.0.jar
DEFINE XPath org.apache.pig.piggybank.evaluation.xml.XPath();
DATA = LOAD '/home/cloudera/Downloads/StackOverFlow/SOF_POSTS.xml' 
using org.apache.pig.piggybank.storage.XMLLoader('post') as (attribute:chararray);

ID_AND_TITLE = FOREACH DATA GENERATE 
XPath(attribute, 'post/Id') as ID, 
XPath(attribute, 'post/Title') as TITLE;

ID_AND_TITLE_2365 = FILTER ID_AND_TITLE BY ID == '2365';
DUMP ID_AND_TITLE_2365;
------------------------------------

Targil 1 -3 

REGISTER /home/cloudera/Downloads/piggybank-0.15.0.jar
DEFINE XPath org.apache.pig.piggybank.evaluation.xml.XPath();
DATA = LOAD '/home/cloudera/Downloads/StackOverFlow/SOF_POSTS.xml' 
using org.apache.pig.piggybank.storage.XMLLoader('post') as (attribute:chararray);

ID_TITLE_CREATION_DATE = FOREACH DATA GENERATE 
XPath(attribute, 'post/Id') as ID, 
XPath(attribute, 'post/Title') as TITLE,
XPath(attribute, 'post/CreationDate')  as CREATION_DATE ;

ID_TITLE_CREATION_YEAR = FOREACH ID_TITLE_CREATION_DATE GENERATE ID, TITLE, GetYear(ToDate(CREATION_DATE)) as (CREATION_YEAR:INT);

CREATED_AFTER_2012 = FILTER ID_TITLE_CREATION_YEAR BY CREATION_YEAR > 2012;
DUMP CREATED_AFTER_2012;
----------------------------------------

Targil 1- 4

REGISTER /home/cloudera/Downloads/piggybank-0.15.0.jar
DEFINE XPath org.apache.pig.piggybank.evaluation.xml.XPath();
DATA = LOAD '/home/cloudera/Downloads/StackOverFlow/SOF_POSTS.xml' 
using org.apache.pig.piggybank.storage.XMLLoader('post') as (attribute:chararray);

LOAD_DATA = FOREACH DATA GENERATE 
XPath(attribute, 'post/Id') as ID, 
XPath(attribute, 'post/Title') as TITLE,
XPath(attribute, 'post/CreationDate')  as CREATION_DATE ;

PARSED_DATA = FOREACH LOAD_DATA GENERATE ID, TITLE, 
		      ToDate('2011-11-30') as TARGET_DATE, 
			  ToDate(CREATION_DATE) as CREATION_YEAR,
			  DaysBetween(ToDate('2011-11-30'), ToDate(CREATION_DATE)) as DAYS_BETWEEN;

SAME_DATE = FILTER PARSED_DATA BY DAYS_BETWEEN == 0;

DUMP SAME_DATE;

----------------------------------------
Targil 1 - 5


REGISTER /home/cloudera/Downloads/piggybank-0.15.0.jar
DEFINE XPath org.apache.pig.piggybank.evaluation.xml.XPath();
DATA = LOAD '/home/cloudera/Downloads/StackOverFlow/SOF_POSTS.xml' 
using org.apache.pig.piggybank.storage.XMLLoader('post') as (attribute:chararray);

ID_CREATION_DATE = FOREACH DATA GENERATE 
XPath(attribute, 'post/Id') as ID, 
XPath(attribute, 'post/CreationDate')  as CREATION_DATE ;

ID_CREATION_MONTH_YEAR = FOREACH ID_CREATION_DATE GENERATE ID, GetMonth(ToDate(CREATION_DATE)) as (CREATION_MONTH:INT), GetYear(ToDate(CREATION_DATE)) as (CREATION_YEAR:INT);

GROUP_BY_YEAR_MONTH = GROUP ID_CREATION_MONTH_YEAR BY (CREATION_YEAR, CREATION_MONTH);

YEAR_MONTH_TO_COUNT = FOREACH GROUP_BY_YEAR_MONTH GENERATE group, COUNT(ID_CREATION_MONTH_YEAR.ID) as POST_COUNT;

YEAR_MONTH_TO_DESC_COUNT = ORDER YEAR_MONTH_TO_COUNT BY POST_COUNT DESC;

DUMP YEAR_MONTH_TO_DESC_COUNT;

((2014,6),806)
((2014,3),739)
((2014,8),672)
((2013,12),653)
((2012,12),643)
((2014,5),640)
((2014,7),614)
((2014,1),597)
((2013,9),596)
((2013,8),581)
((2013,10),556)
((2013,1),554)
((2011,12),541)
((2014,4),512)
((2013,11),482)
((2013,5),470)
((2013,7),469)
((2014,2),467)
((2013,6),453)
((2012,11),422)
((2013,3),412)
((2012,7),411)
((2013,2),404)
((2012,6),393)
((2012,9),382)
((2012,8),367)
((2012,10),348)
((2012,5),343)
((2012,1),342)
((2013,4),333)
((2012,4),296)
((2012,2),252)
((2014,9),245)
((2012,3),242)
((2011,11),34)
((2011,10),2)

----------------------------------------
Targil 1 - 6

REGISTER /home/cloudera/Downloads/piggybank-0.15.0.jar
DEFINE XPath org.apache.pig.piggybank.evaluation.xml.XPath();
DATA = LOAD '/home/cloudera/Downloads/StackOverFlow/SOF_POSTS.xml' 
using org.apache.pig.piggybank.storage.XMLLoader('post') as (attribute:chararray);

ID_TITLE = FOREACH DATA GENERATE 
XPath(attribute, 'post/Id') as ID, 
XPath(attribute, 'post/Title')  as TITLE ,
XPath(attribute, 'post/CreationDate') as CREATION_DATE,
XPath(attribute, 'post/ViewCount') as VIEW_COUNT;

LORD_OF_THE_RINGS = FILTER ID_TITLE BY (UPPER(TITLE) matches '.*LORD OF THE RINGS.*' OR UPPER(TITLE) matches '.*LOTR.*');

DUMP LORD_OF_THE_RINGS;

(2736,Do Frodo and Bilbo live forever at the end of the Lord of the Rings trilogy?,2012-06-09T00:54:21.303,34759)
(8685,Did George Lucas try to acquire the rights to 'The Lord Of The Rings' / 'The Hobbit'?,2012-12-15T21:27:42.633,833)
(17402,Is there any relation between the head-butting in LotR and the Hobbit?,2014-02-19T20:03:53.787,161)
(17953,Was the Lord of the Rings trilogy the first film series to be shot concurrently?,2014-03-13T17:50:32.970,943)
(19824,Did Pippin die in Lord Of The Rings?,2014-05-30T18:47:17.563,160)
---------------------------------------

Targil 1 - 7

REGISTER /home/cloudera/Downloads/piggybank-0.15.0.jar
DEFINE XPath org.apache.pig.piggybank.evaluation.xml.XPath();
LOAD_DATA = LOAD '/home/cloudera/Downloads/StackOverFlow/SOF_POSTS.xml' 
using org.apache.pig.piggybank.storage.XMLLoader('post') as (attribute:chararray);

DATA = FOREACH LOAD_DATA GENERATE 
XPath(attribute, 'post/Id') as ID, 
XPath(attribute, 'post/Title')  as TITLE ,
XPath(attribute, 'post/CreationDate') as CREATION_DATE,
XPath(attribute, 'post/ViewCount') as VIEW_COUNT,
XPath(attribute, 'post/CommentCount') as COMMENT_COUNT;

CONVERTED_TO_INT_DATA = FOREACH DATA GENERATE ID,  TITLE , CREATION_DATE, (int)VIEW_COUNT , COMMENT_COUNT;

DATA_ORDERED_BY_VIEW = ORDER CONVERTED_TO_INT_DATA BY VIEW_COUNT DESC;

TOP_10_VIEW = LIMIT DATA_ORDERED_BY_VIEW 10 ;

DUMP TOP_10_VIEW;

Output:
(10581,What happened to the bodies in American Psycho?,2013-03-20T05:51:19.240,284578,6)
(3234,What really happened in Memento?,2012-07-10T14:31:43.597,184124,3)
(8931,What does "Zero Dark Thirty" mean?,2012-12-23T11:06:12.760,161555,1)
(3404,Why does Bane wear the mask?,2012-07-22T02:07:26.080,144715,4)
(11130,Why did Gus kill Victor in Breaking Bad?,2013-04-27T13:31:26.807,139630,2)
(5629,What did Charlie's aunt do?,2012-10-15T23:11:57.383,137400,0)
(11198,Why don't they show subtitles for the Spanish dialogues?,2013-05-01T09:28:27.410,135974,11)
(9741,Is the film "Flight" based on a true story?,2013-01-29T20:51:23.367,127360,1)
(18848,Are the events depicted in FX's Fargo TV series really true?,2014-04-20T08:00:10.643,121188,2)
(2283,What happened at the end of The Grey?,2012-05-09T19:27:49.470,111748,3)

----------------------------------------------
Targil 1 -8

REGISTER /home/cloudera/Downloads/piggybank-0.15.0.jar
DEFINE XPath org.apache.pig.piggybank.evaluation.xml.XPath();
LOAD_DATA = LOAD '/home/cloudera/Downloads/StackOverFlow/SOF_POSTS.xml' 
using org.apache.pig.piggybank.storage.XMLLoader('post') as (attribute:chararray);

DATA = FOREACH LOAD_DATA GENERATE 
XPath(attribute, 'post/Title')  as TITLE , 
XPath(attribute, 'post/CreationDate') as CREATION_DATE, 
XPath(attribute, 'post/FavoriteCount') as FAVORITE_COUNT;

PARSED_DATA = FOREACH DATA GENERATE  TITLE , 
			  GetYear(ToDate(CREATION_DATE)) as CREATION_YEAR, 
		      (int)FAVORITE_COUNT ;

DATA_BY_YEAR = GROUP PARSED_DATA BY CREATION_YEAR;

TOP_3_FAVORITE = FOREACH DATA_BY_YEAR 
{ 
	FAVORITE_DATA = ORDER PARSED_DATA BY FAVORITE_COUNT DESC;
	TOP_3_BY_YEAR = LIMIT FAVORITE_DATA 3 ;
	GENERATE group, TOP_3_BY_YEAR;
}
DUMP TOP_3_FAVORITE;

Output:
(2011,{(Can someone explain the sequence of events in 'Primer'?,2011,7),(Why is the bride's name bleeped in Kill Bill Vol 1?,2011,6),(Is there any definitive evidence that Teddy was or was not crazy?,2011,6)})
(2012,{(How do they film the mirror scenes in movies?,2012,13),(Why do British sitcoms have so many fewer episodes than American ones?,2012,11),(First movie with product placement?,2012,8)})
(2013,{(How did Marty McFly and “Doc” Brown first meet?,2013,12),(How can I find tv shows/films similar to one I like?,2013,9),(Why is the movie titled "Eternal Sunshine of the Spotless Mind"?,2013,7)})
(2014,{(Why do Disney parents usually die?,2014,9),(How far back do I need to watch Doctor Who for it to still make sense?,2014,8),(Why does Batman talk to himself in the batvoice?,2014,6)})


--------------------------------------------
Targil 1 - 9

REGISTER /home/cloudera/Downloads/piggybank-0.15.0.jar
DEFINE XPath org.apache.pig.piggybank.evaluation.xml.XPath();
LOAD_DATA = LOAD '/home/cloudera/Downloads/StackOverFlow/SOF_POSTS_100.xml' 
using org.apache.pig.piggybank.storage.XMLLoader('post') as (attribute:chararray);

DATA = FOREACH LOAD_DATA GENERATE 
XPath(attribute, 'post/Title')  as TITLE , 
XPath(attribute, 'post/CreationDate') as CREATION_DATE, 
XPath(attribute, 'post/ClosedDate') as CLOSED_DATE; 

PARSED_DATA = FOREACH DATA GENERATE  TITLE , 
			  ToDate(CREATION_DATE) as CREATION_DATE, 
		      ToDate(CLOSED_DATE) AS CLOSED_DATE,
		      DaysBetween(ToDate(CLOSED_DATE), ToDate(CREATION_DATE)) as DAYS_BETWEEN;;


ORDERED_DATA = ORDER PARSED_DATA BY DAYS_BETWEEN DESC;

TOP_3_POST = LIMIT ORDERED_DATA 3 ;

DUMP TOP_3_POST;

(Evaluating characters by means of description,2011-11-30T19:41:14.960-08:00,2014-11-28T10:47:57.003-08:00,1093)
(Was the original "Pink Panther" movie intended to be a comedy?,2011-11-30T19:42:45.470-08:00,2014-11-28T10:47:57.003-08:00,1093)
(What does the ending of The Tree of Life mean?,2011-11-30T19:44:55.593-08:00,2014-11-28T10:47:57.003-08:00,1093)

---------------------------------------------

Weather

LOAD_DATA = LOAD '/home/cloudera/Downloads/Weather' 
USING PigStorage(',')
as (year:int,
	atmospheric_pressure:int,
	rainfall:int,
	wind_speed:float,
	wind_direction:int,
	surface_temperature:float,
	relative_humidity:float,
	solar_flux:float,
	battery:int);

LIMITED_DATA = FOREACH LOAD_DATA GENERATE year, surface_temperature;

GROUP_BY_YEAR = GROUP LIMITED_DATA BY year;

AVR_TEMP_BY_YEAR = FOREACH GROUP_BY_YEAR GENERATE group,  AVG(LIMITED_DATA.surface_temperature);

dump AVR_TEMP_BY_YEAR;

Output:
(2006,11.623961579554127)
(2007,9.090383928056102)
(2008,8.60655212456947)
(2009,8.930528595503604)
(2010,7.704199669127694)
(2011,8.823874354484662)
(2012,8.225056983910608)
(2013,8.473727477906415)



