*Question 1; 

data hersdata ;
set "C:\Users\Geoffrey\Documents\SAS_620\Week 8\hers" ;
run ; 

proc contents data=hersdata ;
run ;

proc reg data=hersdata ;
model HDL= globrat ;
run ;

data hersdata1 ;
set hersdata; 
if globrat=2 then health2=1 ; else health2=0 ;
if globrat=3 then health3=1 ; else health3=0 ;
if globrat=4 then health4=1 ; else health4=0 ;
if globrat=5 then health5=1 ; else health5=0 ;
run ;

proc reg data= hersdata1 ;
model HDL=  health2 health3 health4 health5 ;
title1 '' ;
test_1vs3: test health3 = 0 ;
test_3vs5: test health3 - health5 =0 ;
test_4vs5: test health4 - health5 =0 ; 
Title2 "Pairwise tests among different health groups" ;
run ;

*QUESTION 3 HDL ;
*REDUCED MODEL ;
proc reg data=hersdata1 ;
model HDL= age SBP BMI WHR ;
run ;

*FULL MODEL ;
proc reg data=hersdata1 ;
model HDL= age SBP BMI WHR health2 health3 health4 health5 ;
run ;

data hersdata2 ;
pvalue= 1-CDF('F',1.46,4,2735) ;
run ;
proc print data=hersdata2 ;
run ;

*INTERACTION ;

data hersdata2 ;
set hersdata1 ;
globratage1=health2*age ;
globratage2=health3*age ;
globratage3=health4*age ;
globratage4=health5*age ;
run ;
 
*REDUCED MODEL ;
proc reg data=hersdata2 ;
model HDL=  age SBP BMI WHR health2 health3 health4 health5 ;
run ; 

*FULL MODEL ;
proc reg data=hersdata2 ;
model HDL=  age SBP BMI WHR health2 health3 health4 health5 globratage1 globratage2 globratage3 globratage4 ; 
run ;

*Corresponding p-value for F* ; 
data hersdata2 ;
pvalue= 1-CDF('F',0.499,4,2731) ;
run ;

proc print data=hersdata2 ;
run ;

*QUESTION1 ;

data teacherpay ;
length state $2. salary 6.2 education 4.2 geographic 3.2 ;
infile 'C:\Users\Geoffrey\Documents\SAS_620\Week 8\teacherpaydata.csv' dlm=',' dsd missover firstobs=2 ;
input state salary education geographic ;
label state= "State" 
      salary= "Average Teacher Salary" 
	  education= "Average education spending per pupil"
	  geographic= "Geographic Area for each State" 
	  ; 
run ;
proc contents data=teacherpay ;
run ;

title1 'Teacher pay and spending' ;
symbol1 value=dot pointlabel= ('#state' nodropcollisions) ;

proc gplot data=teacherpay ;
plot salary*education  ;
run ;

data teacherpay2 ;
set teacherpay ;
if geographic=2 then area2=1 ; else area2=0 ;
if geographic=3 then area3=1 ; else area3=0 ;
run ;

proc reg data=teacherpay2 ;
id state ;
model salary= area2 area3 education /influence vif  ;
output out=stateinf h=hatdiags p=pred r=resid student=stres cookd=cooksD dffits=dffits ;
run ;

proc gplot data=stateinf ;
plot stres*pred ;
plot hatdiags*pred ;
plot cooksD*pred ;
run ;

*Question 2; 

data bloodpress ;
length  bp 4.2 pt 4.2 age 3.2 weight 5.2 bsa 4.2 dur 3.2 pulse 3.2 stress 3.2;
infile 'C:\Users\Geoffrey\Documents\SAS_620\Week 8\bloodpressure.csv' dlm=',' dsd missover firstobs=2 ;
input pt bp age weight bsa dur pulse stress ;
run ;

proc reg data=bloodpress ;
model bp= age weight bsa dur pulse stress / influence vif ;
run ;

proc reg data=bloodpress ;
model weight= age bsa dur pulse stress /influence vif ;
run ;
