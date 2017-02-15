
libname pretlib "C:\Users\Geoffrey\Dropbox\CBMP data analysis\CBMP dataset new" ;
proc import datafile='C:\Users\Geoffrey\Dropbox\CBMP data analysis\CBMP dataset new/CBMP Data PC1 dataset.xlsx' DBMS=xlsx out=CBMP; 
run ;

proc format ;

value race1f
3="American Indian/Alaskann Native"
1="White"
2="Black/African American" 
4="Asian"
5="Native Hawaiin/Other Pacific Islander" 
6="More than one Race" 
.= "Missing" 
; 

value age1f 
1="14-17" 
2="18-20" 
3="21-24"
 
;
value sexf
3="Transgender (Female to Male)"
0="Female"
1="Male"
4="Transgender (Male to Female)"
;
value subproblemf 
1= "0-1" 
2= "1-2" 
3= "2-3" 
4= "3-4" ;

value tobacfreqf
4="Daily"  
1="1-10"
2="11-20"
3="21-29"
;

value alcoholfreqf
4="Daily"  
1="1-10"
2="11-20"
3="21-29"
;

value marijuanafreqf
4="Daily"  
1="1-10"
2="11-20"
3="21-29"
;
run ;


data pretlib.CBMP ;
set CBMP ;
keep BHSSA01 
     BHSSA01a 
     BHSSA01b 
     BHSSA02 
     BHSSA02a 
     BHSSA03 
     BHSSA03a 
     BHSSA04 
     BHSSA08
	 BHSSX02a
	 SX02ai
	 SX02aii
	 SX02aiii
	 SX02Aiv
	 BHSSX02b
	 BHSSX03a
	 BHSSX01
	 BHSSX04
	 BHSSX05
	 BHSSX06
	 BHSED02
	 BHSED03a
	 BHSED04
	 BHSED05
	 BHSED06
	 BHSED07
	 BHSSC01
	 BHSSC05
	 TraumaticDistressScore
	 SubstanceAbuseScore
	 EatingDisorderScore
	 SuicideLifetimeScore
	 DepressionScore
	 DateofBirth
	 AgeAtScreen
	 Language
	 SuicideCurrentScore
	 Gender
	 Hispan
	 Race
	 currsuiciderisk
	 age
	 age1
	 subabuseproblem
	 eatingproblem
	 rac
	 sex1
	 race1 
	 sex
	 FacilityName
	 BHSSU04
	 BHSSU02
	 liferisk
	 ideation
	 abusescore
	 subabuse
	 subproblem
	 tobaccouse
	 tobacfreq
	 marijuanause
	 marijuanafreq
	 alcoholuse
	 alcoholfreq
	 highrisk
	 druguse
	 depress
	 cig 
	 ciguse
; 
label
	 BHSSC05="Do you currently have a job?" 
	 BHSSC01="Are you currently attending school or planning to return in the fall?"
     BHSSA01="Ever Used Tobacco Products Once in Your Whole life"
     BHSSA01a="In the Past 30 days how many days have you used tobacco?" 
     BHSSA01b="On Average How many cigarettes do you smoke a day?" 
     BHSSA02="Have you ever in your whole life even once used alcohol?" 
     BHSSA02a="In the Past 30 days how many days have you used Alcohol?" 
     BHSSA03="Have you ever in your whole life even once used marijuana?"
     BHSSA03a="In the Past 30 days how many days have you used Alcohol?"
     BHSSA04="Have you ever used any type of other medical substance to get high or relax?" 
     BHSSA08="During the past year have you kept using alcohol or drugs even though it has caused problems in your relationships?"
	 BHSSX02a="Have you ever had vaginal sex?"
	 SX02ai="At what age did you first have vaginal sex?"
	 SX02aii="When was the last time you had sex?"
	 SX02aiii="The last time you had sex did you or your partner use something to prevent pregnancy?"
	 SX02Aiv="Have you ever been pregnant?"
	 BHSSX02b="Have you ever had anal sex?"
	 BHSSX03a="At what age did you first have oral sex?"
	 BHSSX01="When you think of who you are sexually or physically attracted to, are you attracted to:?"
	 BHSSX04="How many sexual partners have you had in your life?"
	 BHSSX05="When you have sex, how often are you using a condom?"
	 BHSSX06="During your life who have you engaged in sexual activities with?"
	 BHSED02="On average how many hours per week have you exercised hard enough to sweet and breath hard?"
	 BHSED03a="Are you preoccupied with gaining or losing weight?"
	 BHSED04="How often do you think that you are fat even though some people think you are skinny"
	 BHSED05="How often do you try to control your weight by skipping meals?"
	 BHSED06="How often do you try to control your weight by throwing up?"
	 BHSED07="How often do you have trouble stopping eating once you have started?"
     BHSF03="How often do you talk with an adult family member about things that are bothering you?"
	 BHSF04A="Are you concerned about someone in your family because they use alcohol, tobacco, marijuana, or other drugs regularly?"
     BHSF05="How critical do you think your parents are of you?"
	 BHSSF08="During the past year, how often have you worn a seat belt when you were riding in the car?"
	 BHSSF10="During the past year, how often have you been in a car whenyou or the driver had been using alcohol, marijuana(i.e.,weed,pot,blunts)or other drugs?"
     BHSSA01="Ever Used Tobacco Products Once in Your Whole life"
     BHSSA01a="In the Past 30 days how many days have you used tobacco?" 
     BHSSA01b="On Average How many cigarettes do you smoke a day?" 
     BHSSA02="Have you ever in your whole life even once used alcohol?" 
     BHSSA02a="In the Past 30 days how many days have you used Alcohol?" 
     BHSSA03="Have you ever in your whole life even once used marijuana?"
     BHSSA03a="In the Past 30 days how many days have you used Marijuana?"
     BHSSA04="Have you ever used any type of other medical substance to get high or relax?" 
     BHSSA08="During the past year have you kept using alcohol or drugs even though it has caused problems in your relationships?"
	 BHSED02="On average how many hours per week have you exercised hard enough to sweet and breath hard?"
	 BHSED03a="Are you preoccupied with gaining or losing weight?"
	 BHSED04="How often do you think that you are fat even though some people think you are skinny"
	 BHSED05="How often do you try to control your weight by skipping meals?"
	 BHSED06="How often do you try to control your weight by throwing up?"
	 BHSED07="How often do you have trouble stopping eating once you have started?"
	 BHSSU01="Have you ever felt that life is not worth living?"
	 BHSSU01A="In the past week, including today, have you felt that life is not worth living?"
     BHSSU02="Have you ever thought about killing yourself?"
     BHSSU02A="In the past week, including today, have you thought about killing yourself?"
     BHSSU03="Did you ever make a plan to kill yourself?"
     BHSSU03A="In the past week, including today, did you plan to kill yourself?"
     BHSSU04="Have you ever tried to kill yourself?"
     BHSSU04A="In the past week, including today, have you tried to kill yourself?"
     BHSSU05="Have you ever done anything to physically hurt yourself even though you had no plan to kill yourself (forexample, cutting)?"
     BHSSU05A="In the past week including today,have you ever done anything to physically hurt yourself even though you had no plan to kill yourself (forexample, cutting)?"
     BHSB01="During free time at school, how often do you spend time with friends or are you mostly alone?"
     BHSB02="How often do you feel kids tease you, make fun of you, or ignore you?"
     BHSB03="How often do kids physically hurt you or threaten to hurt you?"
     BHSB04="How often are you cyber bullied (chat rooms,Facebook, Instant messaging, text messaging)"
     BHSB04A="You said that you were at least sometimes(alone, teased, physically threatened, or cyber bullied).How upsetting are these kinds of experiences for you?"
     BHSSAT07="If you have come here today with a parent, guardian, or other adult, is it ok for them to be in the room when we go over your answers with you?"
	 ;     

*RECODE VARIABLES ;
 if BHSED07=2 then BHSED07=1 ;
 if BHSED07=4 then BHSED07=2 ;
 if BHSED07 in(-999,-888,-666) then BHSED07=3;

 if BHSED06=2 then BHSED06=1 ;
 if BHSED06=4 then BHSED06=2 ;
 if BHSED06 in(-999,-888,-666) then BHSED06=3 ;

 if BHSED05=2 then BHSED05=1 ;
 if BHSED05=4 then BHSED05=2 ;
 if BHSED05 in(-999,-888,-666) then BHSED05=3 ;
 
 if BHSED04=2 then BHSED04=1 ;
 if BHSED04=4 then BHSED04=2 ;
 if BHSED04 in(-999,-888,-666) then BHSED04=3 ;

if BHSED03A in ("-999,-888") then BHSED03A= "3" ;




 
 if BHSSX0X4=2 then BHSSX0X4=1 ;
 if BHSSX0X4=4 then BHSSX0X4=2 ;
 if BHSSX0X4 in(-999,-888,-666) then BHSSX0X4=3 ;
 if BHSSX05  in(-999,-888,-666) then BHSSX05=3 ;
 if BHSSX06  in(-999,-888,-666) then BHSSX06=3 ;
 if BHSSX01  in(-999,-888,-666) then BHSSX01=3 ;


if	BHSSA01=4	then 	BHSSA01=1 ;
if BHSSA01 in(-999,-888,-666) then BHSSA01=3 ;
if	BHSSA02=4	then 	BHSSA02=1 ;
if BHSSA02 in(-999,-888,-666) then BHSSA02=3 ;
if	BHSSA03=4	then 	BHSSA03=1 ;
if BHSSA03 in(-999,-888,-666) then BHSSA03=3 ;
if	BHSSA04=4	then 	BHSSA04=1 ;
if BHSSA04 in(-999,-888,-666) then BHSSA04=3 ;
if	BHSSA08=4	then 	BHSSA08=1 ;
if BHSSA08 in(-999,-888,-666) then BHSSA08=3 ;

if BHSSC01=4 then BHSSC01=1 ;
if BHSSC01 in(-999,-888,-666) then BHSSC01=. ;


*CURRENT TOBACCO USE ;
if BHSSA01A eq 0 then BHSSA01A= . ;
if BHSSA01A in(-999,-888,-666) then BHSSA01A= . ;
if BHSSA01A gt 30 then BHSSA01A= . ;

*RECODE ;

if BHSSA01A ge 1 and BHSSA01A le 10 then tobaccouse=1 ;
if tobaccouse=1 then tobacfreq="1-10" ;
if BHSSA01A ge 11 and BHSSA01A le 20 then tobaccouse=2 ;
if tobaccouse=2 then tobacfreq="11-20" ;
if BHSSA01A ge 21 and BHSSA01A le 29 then tobaccouse=3 ;
if tobaccouse=3 then tobacfreq="21-29" ;
if BHSSA01A eq 30 then tobaccouse=4 ;
if tobaccouse=4 then tobacfreq="Daily" ;


*CURRENT ALCOHOL USE ;
if BHSSA02A eq 0 then BHSSA02A= . ;
if BHSSA02A in(-999,-888,-666) then BHSSA02A= . ;
if BHSSA02A gt 30 then BHSSA02A= . ;

*RECODE ;
if BHSSA02A ge 1 and BHSSA02A le 10 then alcoholuse=1 ;
if alcoholuse=1 then alcoholfreq="1-10" ;
if BHSSA02A ge 11 and BHSSA02A le 20 then alcoholuse=2 ;
if alcoholuse=2 then alcoholfreq="11-20" ; 
if BHSSA02A ge 21 and BHSSA02A le 29 then alcoholuse=3 ;
if alcoholuse=3 then alcoholfreq="21-29" ; 
if BHSSA02A eq 30 then alcoholuse=4 ; 
if alcoholuse=4 then alcoholfreq="Daily" ;

*CURRENT MARIJUANA USE ;
if BHSSA03A eq 0 then BHSSA03A= . ;
if BHSSA03A in(-999,-888,-666) then BHSSA03A= . ;
if BHSSA03A gt 30 then BHSSA03A= . ;

*RECODE ;
if BHSSA03A ge 1 and BHSSA03A le 10 then marijuanause=1 ;
if marijuanause=1 then marijuanafreq="1-10" ;
if BHSSA03A ge 11 and BHSSA03A le 20 then marijuanause=2 ;
if marijuanause=2 then marijuanafreq="11-20" ; 
if BHSSA03A ge 21 and BHSSA03A le 29 then marijuanause=3 ;
if marijuanause=3 then marijuanafreq="21-29" ; 
if BHSSA03A eq 30 then marijuanause=4 ; 
if marijuanause=4 then marijuanafreq="Daily" ;


*RECODE CIGARETTES ;



if	BHSSX02a=4 	then	BHSSX02a=1 ;
if 	BHSSX02a in(-999,-888,-666) then 	BHSSX02a=3 ;
if 	SX02aii in(-999,-888,-666) then 	SX02aii=3 ;
if	 SX02aiii=4	then	 SX02aiii=1 ;
if 	SX02aiii in(-999,-888,-666) then 	SX02aiii=3 ;
if	SX02AIV="4" 	then	SX02AIV="1" ;
if	 BHSSX02b=4 then	 BHSSX02b=1 ;
if 	BHSSX02b in(-999,-888,-666) then 	BHSSX02b=3 ;

if  SX02AI in(-999,-888,-666) then SX02AI=. ;

if BHSED02 in(-999,-888,-666)then BHSED02=. ;
if BHSSX03A in(-999,-888,-666)then BHSSX03A= . ; 
if  BHSSX04 in(-999,-888,-666)then BHSSX04= . ;
if SX02AIV in ("-999 -888 -666") then SX02AIV= "3" ;





*RECODE RACE ;
if race in(-999,-888,-666) then race=. ;
if gender in(-999,-888,-666) then gender=. ;
if Hispan in(-999,3,-888,-666) then Hispan=. ;
if Hispan eq 2 then Hispan=0 ;
if gender eq 1 then gender=0;
if gender eq 2 then gender=1 ; 

*RECODE SUICIDECURRENTSCORE ;
if SuicideCurrentScore gt "0" then currsuiciderisk=1 ;
else currsuiciderisk=0 ;

*RECODE SUICIDELIFETIMESCORE ;
if SuicideLifetimeScore gt "0"  then liferisk=1 ;
else liferisk=0 ; 

abusescore= input(SubstanceAbuseScore, 5.0) ;

if BHSSU04 eq 0 and liferisk=1 then ideation=1 ;
else ideation=0 ;

*RECODE SUBSTANCE ABUSE SCORE ;
if SubstanceAbuseScore ge "1.0001" then subabuseproblem=1 ;
else subabuseproblem=0 ;

if SubstanceAbuseScore ge 0 and SubstanceAbuseScore le 1 then subabuse=1 ;
if subabuse=1 then subproblem="0-1" ;
if SubstanceABuseScore gt 1 and SubstanceAbuseScore le 2 then subabuse=2 ;
if subabuse=2 then subproblem="1-2" ;
if SubstanceAbuseScore gt 2 and SubstanceAbuseScore le 3 then subabuse=3 ;
if subabuse=3 then subproblem="2-3" ;
if SubstanceAbuseScore gt 3 and SubstanceAbuseScore le 4 then subabuse=4 ;
if subabuse=4 then subproblem="3-4" ;

*RECODE EATING DISORDER SCORE ;
if EatingDisorderScore ge "2.046" then eatingproblem=1 ;
else eatingproblem=0 ;

*RECODE VARIABLES ; 

if BHSSC05 in(-999,-888,-666) then BHSSC05= . ;

if BHSSC05=4 then BHSSC05=1 ;

*RECODE AGEATSCREEN ;
if AgeAtScreen ge 14 and AgeAtScreen le 17 then age=1 ;
if age=1 then age1="14-17" ;
else if AgeAtScreen ge 18 and AgeAtScreen le 20 then age=2 ;
if age=2 then age1="18-20" ;
else if AgeAtScreen ge 21 and AgeAtScreen le 24 then age=3 ;
if age=3 then age1="21-24" ;

*FORMAT VARIABLES ;
if gender=0 then sex1=0 ; 
if sex1=0 then sex="Female";
if gender=1 then sex1=1 ;
if sex1=1 then sex="Male" ;
if gender=3 then sex1=3 ; 
if sex1=3 then sex="Transgender (Female to Male)";
if gender=4 then sex1=4 ;
if sex1=4 then sex="Transgender (Male to Female)" ;


if race=1 then rac=1 ;
if rac=1 then race1="White" ;
if race=2 then rac=2 ;
if rac=2 then race1="Black/African American" ;
if race=3 then rac=3 ;
if rac=3 then race1="American Indian/Alaskann Native" ;
if race=4 then rac=4 ;
if rac=4 then race1="Asian" ;
if race=5 then rac=5 ;
if rac=5 then race1= "Native Hawaiin/Other Pacific Islander" ;
if race=6 then rac=6 ;
if rac=6 then race1= "More than one Race" ;

if BHSSU04=4 then BHSSU04=1 ;
if BHSSU04 in(-999,-888,-666) then BHSSU04= . ;

if BHSSU02=4 then BHSSU02=1 ;
if BHSSU02 in(-999,-888,-666) then BHSSU02= . ;

if BHSSA01b in(-999,-888,-666)then BHSSA01b= . ;
if BHSSA01b ge 15 and BHSSA01b le 24 then cig=3;
if cig=3 then ciguse="15-24" ;
if BHSSA01b ge 1 and BHSSA01b le 4 then cig=1 ;
if cig=1 then ciguse="1-4" ;
if BHSSA01b ge 5 and BHSSA01b le 14 then cig=2 ;
if cig=2 then ciguse= "5-14" ;
if BHSSA01b ge 15 and BHSSA01b le 24 then cig=3;
if cig=3 then ciguse="15-24" ;
if BHSSA01b ge 25 then cig=4 ;
if cig=4 then ciguse="25+" ;



if subabuseproblem=1 and liferisk=1 then highrisk=1 ;
else highrisk=0 ;

if BHSSA01=1 or BHSSA02=1 or BHSSA03=1 or BHSSA04=1 then druguse=1 ;
else druguse=0 ;
 
depress=input (DepressionScore, 5.0) ;

run ;

proc contents data=pretlib.CBMP varnum ;
run ;

proc freq data=pretlib.CBMP ;
tables BHSSA01a BHSSA02a BHSSA03a DepressionScore ;
run ;

proc freq data=pretlib.CBMP ;
tables tobacfreq marijuanafreq alcoholfreq highrisk druguse ;
run ;

*ATTEMPT vs IDEATION vs NOIDEATION ;
proc freq data=pretlib.CBMP ;
tables BHSSU04 liferisk ideation ;
run ;

*proc print data=pretlib.CBMP 
run ;

ods listing gpath="c:\temp";
proc univariate data=pretlib.CBMP ;
var AgeAtScreen SX02AI  ;
histogram ;
run ;
proc freq data=pretlib.CBMP ;
tables BHSED02 ;
run ; 

proc univariate data=pretlib.CBMP ;
var BHSED02 ;
histogram ;
run ;

proc freq data=pretlib.CBMP ;
table BHSSC01 BHSSC05 ;
run ;

proc freq data=pretlib.CBMP ;
tables FacilityName ;

run ;

*SEXUAL VARIABLES 
proc freq data=pretlib.CBMP 
tables BHSSX02a 
	   SX02ai 
       SX02aii 
       SX02aiii 
       SX02Aiv 
       BHSSX02b 
       BHSSX03a 
       BHSSX01 
       BHSSX04 
       BHSSX05 
       BHSSX06 
run ;

*NUTRITION AND DIET VARIABLES 
proc freq data=pretlib.CBMP 
tables BHSED02
	   BHSED03a
	   BHSED04
	   BHSED05
	   BHSED06
	   BHSED07
	   
run ; 

*DEMOGRAPHIC VARIABLES 
proc freq data=pretlib.CBMP 
tables gender 
       Hispan
	   Race 
	   Language
	   
run ;

*DEMOGRAPHIC TABLE1 
proc freq data=pretlib.CBMP 
tables (gender race Language age)*liferisk /   
run 


*SUBSTANCE ABUSE TABLE 
proc freq data=pretlib.CBMP 
tables ( BHSSA01 BHSSA02 BHSSA03 BHSSA04 BHSSA08)*subabuseproblem / chisq  
run 

proc freq data=pretlib.CBMP 
tables ( BHSSA01 BHSSA02 BHSSA03 BHSSA04 BHSSA08)*liferisk / chisq  
run ;

*EATING DISORDER TABLE 
proc freq data=pretlib.CBMP 
tables (BHSED04 BHSED05 BHSED06 BHSED07)*currsuiciderisk /chisq exact 
run 

proc freq data=pretlib.CBMP 
tables (BHSED04 BHSED05 BHSED06 BHSED07)*eatingproblem /chisq exact  
run ;

*SEXUAL ABUSE TABLE 

proc freq data=pretlib.CBMP 
tables (BHSSX02a SX02aiii BHSSX02b BHSSX01  BHSSX05 BHSSX06)*currsuiciderisk /chisq exact 
run ;

*MODEL FOR EATING DISORDER 

proc logistic data=pretlib.CBMP 
model currsuiciderisk(event="1")= BHSED04 BHSED05 BHSED06 BHSED07 
run ;

*ADJUSTING FOR DEMOGRAPHICS 
proc logistic data=pretlib.CBMP 
model currsuiciderisk(event="1")= BHSED04 BHSED05 BHSED06 BHSED07 gender race age 
run ;

*MODEL FOR SEXUAL BEHAVIOR 
proc logistic data=pretlib.CBMP 
model currsuiciderisk(event="1")=BHSSX02a SX02aiii BHSSX02b BHSSX01  BHSSX05 BHSSX06   
run ;

*AFTER ADJUSTING FOR DEMOGRAPHICS 
proc logistic data=pretlib.CBMP 
model currsuiciderisk(event="1")=BHSSX02a SX02aiii BHSSX02b BHSSX01  BHSSX05 BHSSX06 gender race age   
run ;

proc freq data=pretlib.CBMP ;
tables abusescore*(liferisk ideation BHSSU04) ;
run ; 

proc freq data=pretlib.CBMP ;
tables ciguse ;
run ; 


*SUBSTANCE ABUSE VARIABLES ;
proc freq data=pretlib.CBMP ;
tables BHSSA01 
       BHSSA01a 
       BHSSA01b 
       BHSSA02 
       BHSSA02a 
       BHSSA03 
       BHSSA03a 
       BHSSA04 
       BHSSA08
	   ;
run ;

*DATA ANALYSIS ; 

proc freq data=pretlib.CBMP ;
tables liferisk SubstanceAbuseScore ;
run ;

*Table 1 SIMPLE DEMOGRPHICS ;

proc freq data=pretlib.CBMP ;
tables sex 
	   Race1 
	   Language
	   age1
	   BHSSC01
	   BHSSC05
;
run ;

*TABLE2 DEMOGRAPHICS SPLIT INTO DIFFERENT GROUPS ATTEMPT IDEATION AND NO IDEATION;
*SUBSTANCE ABUSE SCORE ;
*Means for Attempt ;
proc means data=pretlib.CBMP ;
class BHSSU04 ;
var  abusescore  ;
run ;

*Means for liferisk ;
proc means data=pretlib.CBMP ;
class liferisk ;
var  abusescore  ;
run;

*Means for ideation ;
proc means data=pretlib.CBMP ;
class ideation ;
var  abusescore  ;
run ;

*AGE ;
*ATTEMPT ;
proc means data=pretlib.CBMP ;
class BHSSU04 ;
var  AgeAtScreen ;
run ;

*IDEATION ;
proc means data=pretlib.CBMP ;
class ideation ;
var  AgeAtScreen ;
run ;

*LIFERISK ;
proc means data=pretlib.CBMP ;
class liferisk ;
var  AgeAtScreen ;
run ;

*GENDER ;
*ATTEMPT ;
data attempt ;
set pretlib.CBMP ;
where BHSSU04=1 ;
run ;

proc freq data=attempt ;
tables gender /norow nocum ;
run ;

*IDEATION ;
data ideation ;
set pretlib.CBMP ;
where ideation=1 ;
run ;

proc freq data=ideation ;
tables gender /norow nocum ;
run ;

*NO IDEATION ;
data noideation ;
set pretlib.CBMP ;
where liferisk=0 ;
run ;

proc freq data=noideation ;
tables gender /norow nocum ;
run ;


*RACE ;

*ATTEMPT ;
data attempt ;
set pretlib.CBMP ;
where BHSSU04=1 ;
run ;

proc freq data=attempt ;
tables race /norow nocum ;
run ;

*IDEATION ;
data ideation ;
set pretlib.CBMP ;
where ideation=1 ;
run ;

proc freq data=ideation ;
tables race /norow nocum ;
run ;

*NO IDEATION ;
data noideation ;
set pretlib.CBMP ;
where liferisk=0 ;
run ;

proc freq data=noideation ;
tables race /norow nocum ;
run ;

*TABLE 3 SUBSTANCE ABUSE SCORE ;
proc freq data=pretlib.CBMP ;
tables subabuse*liferisk /chisq exact ;
format subabuse subproblemf. ;
run ; 

*SPLIT INTO DIFFERENT LIFE RISK GROUPS ;
proc freq data=attempt ;
tables subabuse  ;
format subabuse subproblemf. ;
run ;

proc freq data=ideation ;
tables subabuse  ;
format subabuse subproblemf. ;
run ;

proc freq data=noideation ;
tables subabuse  ;
format subabuse subproblemf. ;
run ;

*TABLE 4 DIFFERENT DRUG USAGE VS LIFETIME SCORE ;
proc freq data=pretlib.CBMP ;
tables ( alcoholfreq marijuanafreq tobacfreq ciguse BHSSA01 BHSSA02 BHSSA03 BHSSA04 BHSSA08)*liferisk /chisq exact ;
run ; 

*SPLIT INTO DIFFERENT GROUPS ;
proc freq data=attempt ;
tables alcoholfreq marijuanafreq tobacfreq BHSSA01 BHSSA02 BHSSA03 BHSSA04 BHSSA08 ;
run ;

proc freq data=ideation ;
tables alcoholfreq marijuanafreq tobacfreq BHSSA01 BHSSA02 BHSSA03 BHSSA04 BHSSA08 ;
run ;

proc freq data=noideation ;
tables alcoholfreq marijuanafreq tobacfreq BHSSA01 BHSSA02 BHSSA03 BHSSA04 BHSSA08 ;
run ;

*TABLE 5 DIFFERENT RACE GROUPS SUBSTANCE IDEATION AND RISK ;
data substance ;
set pretlib.CBMP ;
where druguse=1 ;
run ;

proc freq data=substance ;
tables (Race1 Hispan)*liferisk / chisq ;
run ;

*SPLIT INTO DIFFERENT GROUPS ;
*ATTEMPT ;
proc freq data=substance ;
where BHSSU04=1 ;
tables Race1 Hispan ;
run ;

*IDEATION ;
proc freq data=substance ;
where ideation=1 ;
tables Race1 Hispan ;
run ;

*NOIDEATION ;
proc freq data=substance ;
where liferisk=0 ;
tables Race1 Hispan ;
run ;


*MODEL ANALYSIS ;
*LOGISTIC MODEL FOR SUBSTANCE ABUSE ;
proc logistic data=pretlib.CBMP ;
model liferisk(event="1")=BHSSA01 BHSSA02 BHSSA03 BHSSA04 BHSSA08 ;
run ;


*TOBACCO ;

proc logistic data=pretlib.CBMP ;
class BHSSA01(ref="0") ;
model liferisk(event="1")= BHSSA01 ;
run ;

*ADJUST FOR AGE AND GENDER ;
proc logistic data=pretlib.CBMP ;
class BHSSA01(ref="0") ;
model liferisk(event="1")= BHSSA01 age gender ;
run ;

*ADJUST FOR AGE GENDER AND RACE ;
proc logistic data=pretlib.CBMP ;
class BHSSA01(ref="0") ;
model liferisk(event="1")= BHSSA01 age gender race;
run ;

*ADJUST FOR AGE GENDER RACE AND DEPRESSION ;
proc logistic data=pretlib.CBMP ;
class BHSSA01(ref="0") ;
model liferisk(event="1")= BHSSA01 age gender race depress ;
run ;


*ALCOHOL ;

proc logistic data=pretlib.CBMP ;
class BHSSA02(ref="0") ;
model liferisk(event="1")= BHSSA02 ;
run ;

*ADJUST FOR AGE AND GENDER ;
proc logistic data=pretlib.CBMP ;
class BHSSA02(ref="0") ;
model liferisk(event="1")= BHSSA02 age gender ;
run ;

*ADJUST FOR AGE GENDER AND RACE ;
proc logistic data=pretlib.CBMP ;
class BHSSA02(ref="0") ;
model liferisk(event="1")= BHSSA02 age gender race;
run ;

*ADJUST FOR AGE GENDER RACE AND DEPRESSION ;
proc logistic data=pretlib.CBMP ;
class BHSSA02(ref="0") ;
model liferisk(event="1")= BHSSA02 age gender race depress ;
run ;




*MARIJUANA ;

proc logistic data=pretlib.CBMP ;
class BHSSA03(ref="0") ;
model liferisk(event="1")= BHSSA03 ;
run ;

*ADJUST FOR AGE AND GENDER ;
proc logistic data=pretlib.CBMP ;
class BHSSA03(ref="0") ;
model liferisk(event="1")= BHSSA03 age gender ;
run ;

*ADJUST FOR AGE GENDER AND RACE ;
proc logistic data=pretlib.CBMP ;
class BHSSA03(ref="0") ;
model liferisk(event="1")= BHSSA03 age gender race;
run ;

*ADJUST FOR AGE GENDER RACE AND DEPRESSION ;
proc logistic data=pretlib.CBMP ;
class BHSSA03(ref="0") ;
model liferisk(event="1")= BHSSA03 age gender race depress ;
run ;


*ANY OTHER ILLICIT DRUGS ;

proc logistic data=pretlib.CBMP ;
class BHSSA04(ref="0") ;
model liferisk(event="1")= BHSSA04 ;
run ;

*ADJUST FOR AGE AND GENDER ;
proc logistic data=pretlib.CBMP ;
class BHSSA04(ref="0") ;
model liferisk(event="1")= BHSSA04 age gender ;
run ;

*ADJUST FOR AGE GENDER AND RACE ;
proc logistic data=pretlib.CBMP ;
class BHSSA04(ref="0") ;
model liferisk(event="1")= BHSSA04 age gender race;
run ;

*ADJUST FOR AGE GENDER RACE AND DEPRESSION ;
proc logistic data=pretlib.CBMP ;
class BHSSA04(ref="0") ;
model liferisk(event="1")= BHSSA04 age gender race depress ;
run ;

*

proc logistic data=pretlib.CBMP descending 
model liferisk(event="1")= BHSSA01 BHSSA02 BHSSA03 BHSSA04 BHSSA08 gender race age depress / selection=Stepwise slstay=0.05 
run 

*ADJUST FOR DEMOGRAPHIC VARIABLES 
*FULL MODEL 

proc logistic data=pretlib.CBMP 
model liferisk(event="1")= BHSSA01 BHSSA02 BHSSA03 BHSSA04 BHSSA08 gender race age depress  
run ;

*REDUCED MODEL 
proc logistic data=pretlib.CBMP 
class BHSSA01 (ref="0") BHSSA03 (ref="0") BHSSA04 (ref="0") BHSSA08 (ref="0")  
model liferisk(event="1")= BHSSA01 BHSSA03 BHSSA04 BHSSA08 age depress  
run 

data pvalue 
pvalue= 1-CDF('ChiSquare',47.29,62) 
run 

proc print data=pvalue 
run 


