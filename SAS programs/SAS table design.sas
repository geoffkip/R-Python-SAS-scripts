
/* 
** PROGRAM: Kip_G_Health_Project.SAS 9.3
** PURPOSE: CREATING TABLE 1 
** AUTHOR: GEOFFREY KIP
** INPUT: Kip_G PROJECT ADPBHL623 DATASET
**/ 
libname pretlib "C:\Users\Geoffrey\Documents\PBHL 623\Final Project Part 4" ;

  ** CREATE CUSTOM STYLE WITH PROC TEMPLATE **;
proc template ;
   define style TStyleRTF ;   /* NEW STYLE NAME */
      parent=styles.rtf ;     /* BASED ON DEFAULT RTF STYLE */

      style table from table /
         Background=_UNDEF_
         rules=groups   /* PUTS BOTTOM BORDER ON ROW HEADERS */
         frame=void   /* REMOVES LINE AROUND OUTSIDE OF TABLE */
         cellspacing=0
         cellpadding=0  /* REMOVES PARAGRAPH SPACING BEFORE AND AFTER CELL CONTENTS */
         ;

	  style fonts from fonts /
      /* RESET FONTS */
         'TitleFont2'         = ("Arial, Times New Roman",10pt,Bold)
         'TitleFont'          = ("Arial, Times New Roman",10pt,Bold)
         'StrongFont'         = ("Arial, Times New Roman",10pt,Bold)
         'EmphasisFont'       = ("Arial, Times New Roman",10pt,Italic)
         'FixedEmphasisFont'  = ("Arial, Times New Roman",10pt,Italic)
         'FixedStrongFont'    = ("Arial, Times New Roman",10pt,Bold)
         'FixedHeadingFont'   = ("Arial, Times New Roman",10pt)
         'BatchFixedFont'     = ("Arial, Times New Roman",10pt)
         'FixedFont'          = ("Arial, Times New Roman",10pt)
         'headingEmphasisFont'= ("Arial, Times New Roman",10pt,Italic)
         'headingFont'        = ("Arial, Times New Roman",10pt,Bold)    /* FONT FOR COLUMN HEADERS */
         'docFont'            = ("Arial, Times New Roman",10pt)
         ;

      /* SET PAGE MARGINS */
      style Body from Body /
         bottommargin = 1in
         topmargin    = 1in
         rightmargin  = 1in
         leftmargin   = 1in
         ;

      /* SET PAGE HEADER AND FOOTER STYLE */
      style header from header /
         font = fonts('HeadingFont')
         foreground = colors('headerfg')
         background = _UNDEF_  /* CLEAR */
         ;

      /* SET BODY TITLES AND FOOTERS */
      style TitlesAndFooters from TitlesAndFooters /
         font = Fonts('TitleFont')
         background = _undef_
         foreground = colors('systitlefg')
         rules = ALL
         just  = CENTER
         ;

      style PageNo from PageNo /
         font        = Fonts('docFont')      /* SO PAGENO IS NOT BOLD */
         ;

   end ;

run ;

*PROC FORMATTED ALL VARIABLES TO HAVE VALUES AND INVALUES ;

proc format ;
	value mstats 1 = 'n'
                2 = 'mean'
                3 = 'std dev'
                4 = 'min'
                5 = 'max'
                ;
   invalue mstats 'N'    = 1
                  'MEAN' = 2
                  'STD'  = 3
                  'MIN'  = 4
                  'MAX'  = 5
                  ;
    *FORMATTED AGEGRPCD (NUMERIC VARIABLE) AND MADE AGEF. DECODED ALL THE VARIABLES TO SPLIT THE AGE IN DIFFERENT RANGES. IF NO NUMBER WAS ANWERED THEN IT WAS CONSIDERED MISSING ;
   value agef
   1 = "< 18"
   2 = "18 - 29"
   3 = "30 - 39"
   4 = "40 - 49"
   5 = "50 - 64"
   6 = ">= 65"
   9 = "Missing"
   ;

   *FORMATTED THE CHARACTER VARIABLE STATEABBR TO STATEABBRF AND INCLUDED THE TOP 3 STATES WITH THE HIGHEST FREQUENCIES WHICH WERE PA, NJ AND NY. EX WAS USED TO REFER TO NON-US COUNTRIES AND OTHER WAS USED TO REFER TO OTHER STATES IN THE USA BESIDES THE TOP 3 ;
   value stateabbrf
  5= "Other, Ex"
  1="PA" 
  2="NJ"
  3="NY"
  4 = "Other, US"
  9 = "Missing"  
  ;
   invalue stateabbrf
   "PA"=1 
   "NJ"=2
   "NY"=3
   "EX"= 5
   " "= 9
   other =4
   ;

*FORMATTED THE RACECD (CHARACTER VARIABLE) AS RACEF."O" WAS USED TO REFER TO ALL THE PEOPLE NOT IN THE MENTIONED RACES AND IF NO ANSWER WAS RECORDED THEN IT WAS DECODED AS MISSING ;
	value racef
	1="White"
	2="Black of African Heritage"
	3="Asian"
	4="Other"
	9= "Missing"
	;
	invalue racef
	"W"=1
	"B"=2
	"A"= 3
	"O"= 4
	" "= 9
	; 
*FORMATTED ETHNIC VARIABLE AND DECODED ANSWERS. "Y" MEAN THE PERSON WAS HISPANIC OR LATINO AND "N" MEAN THE PERSON WAS NOT HISPANIC OR LATINO ;
	value ethnicf
	1="Hispanic or Latino"
	2="Not Hispanic or Latino"
	9= "Missing"
	;
	invalue ethnicf
	"Y"=1
	"N"=2
	" "= 9
	;

*FORMATTED SCHOOLCD TO SCHOOLCDF. 1 TO 5 WERE USED TO DECODE DIFFERENT LEVELS OF EDUCATION> NO ANSWERS WERE SET AS MISSING ;
	value schoolcdf
	1= "High school/GED" 
	2= "Associate (2-year) degree"
	3= "Bachelor's (4-year) degree"
	4= "Master's Degree"
	5= "PHD, MD or equivalent"
	9 = "Missing"
	;

	value bmistats 1 = 'n'
                2 = 'mean'
                3 = 'std dev'
                4 = 'min'
                5 = 'max'
                ;
   invalue bmistats 'N'    = 1
                  'MEAN' = 2
                  'STD'  = 3
                  'MIN'  = 4
                  'MAX'  = 5
                  ;


*FORMATTED BMICLASS AS BMICLASSF AND USED 1 TO 4 TO CLASSIFY IF A PERSON'S BMICLASS AS UNDERWEIGHT, NORMAL WEIGHT, OVERWEIGHT OR OBESE ; 
   value bmiclassf
   1="Underweight"
   2="Normal weight"
   3="Overweight"
   4="Obese"
   9= "Missing"
   ;
  
   value estincstats 1 = 'n'
                2 = 'mean'
                3 = 'std dev'
                4 = 'min'
                5 = 'max'
                ;
   invalue estincstats 'N'= 1
                  'MEAN' = 2
                  'STD'  = 3
                  'MIN'  = 4
                  'MAX'  = 5
                  ;

   *FORMATTED LIFESATCD AS LIFESATCDF AND DECODED VALUES USING 1 TO 8 TO INDICATE HOW SATISFIED IN LIFE THE PERSON WAS ;
   value lifesatcdf
   1="Very Satisfied"
   2="Somewhat satisfied"
   3="Satisfied"
   4="Somewhat dissatisfied"
   5="Dissatisfied"
   6="Very Dissatisfied"
   8="Not sure"
   9= "Missing"
   ; 

*ADDED A VALUE FOR TCAT TO ASSIGN HEADINGS FOR THE VARIABLES ;
	value tcat
	1= "^R'\ql\b 'Age"
	2= "^R'\ql\b 'Age group, n(%)" 
	3= "^R'\ql\b 'State of residence, n (%)" 
	4= "^R'\ql\b 'Race, n (%)" 
	5= "^R'\ql\b 'Ethnicity, n (%)"
	6= "^R'\ql\b 'Education, n (%)"
	7= "^R'\ql\b 'Body Mass Index"
	8= "^R'\ql\b 'BMI Classification, n (%)"
	9= "^R'\ql\b 'Estimated Median Income"
	10="^R'\ql\b 'General Life Satisfaction, n (%)" 
	;


   run ;

*CREATING DATASET CALLED FPTAB ;
data fptab ;
	set pretlib.adpbhl623 ; *BRINGING IN DATA FROM THE ADPBHL623 DATASET ;
	if sex eq "M" then sexcd=1 ; *CREATING A NUMERIC VARIABLE FOR SEX CALLED SEXCD ;
	else if sex eq "F" then sexcd=2 ;
	if sexcd in (1 2) then output ;
	sexcd=3 ;
	output ;
run ;

*MADE A DATASTEP TO CREATE NUMERIC VARIABLES FOR STATEABBR, RACECD, AND ETHNIC ;
data fptab;
	set fptab;
	stateabbrp = input(stateabbr, stateabbrf.);
	racecdp= input (racecd, racef.);
	ethnicp= input (ethnic, ethnicf.);
	if schoolcd = . then schoolcd = 9 ; *IF SCHOOLCD IS MISSING THEN SCHOOLCD IS EQUAL TO 9 THE SAME VALUE I DID IN MY PROC FORMAT ;
	if bmiclscd= . then bmiclscd=9 ;
	if lifesatcd= . then lifesatcd= 9 ;
	if agegrpcd= . then agegrpcd= 9 ;
run;

proc print data = fptab noobs;
	var stateabbr schoolcd;
run;

*PROC SORT SORTING THE DATASET BY SEX ;
proc sort data= fptab 
           out= fptab1 ;
		   by sex ;
run ; 

*PROC FREQ ON MY TEMPORARY DATASET TO PRINT TABLES FOR ALL THE VARIABLES THAT NEED TO BE IN THE TABLE ;

proc freq data=fptab ;
table sexcd  / out=denoms (drop=percent) ;
table agegrpcd*sexcd /out=agecnt(drop=percent);
table stateabbrp*sexcd /out=statecnt  (drop=percent); 
table racecdp*sexcd /out=racecnt (drop=percent);
table schoolcd*sexcd /out=schoolcnt (drop=percent);
table ethnicp*sexcd /out=ethniccnt (drop=percent);
table bmiclscd*sexcd /out=bmiclasscnt  (drop=percent);
table lifesatcd*sexcd /out=lifesatcnt (drop=percent);
run ;

proc print data=denoms ;
   title 'DENOMINATORS FOR TABLE' ;
run ; 

proc freq data=denoms ;
run ;

proc print data=agecnt ;
   title 'AGE COUNTS COUNTS BY SEX' ;
run ;


proc print data=statecnt ;
   title 'STATE COUNTS BY SEX' ;
run ;

proc print data=racecnt ;
   title 'RACE COUNTS BY SEX' ;
run ;

proc print data=schoolcnt ;
   title 'SCHOOL COUNTS BY SEX' ;
run ;

proc print data=ethniccnt ;
   title 'ETHNIC COUNTS BY SEX' ;
run ;

proc print data=bmiclasscnt ;
   title 'BMI COUNTS BY SEX' ;
run ;

proc print data=lifesatcnt ;
   title 'LIFESATCNT COUNTS BY SEX' ;
run ;

**----- TRANSPOSE DENOMS -----**;

proc transpose data=denoms out=tdenoms prefix=den_ ;
   id sexcd ; *SEXCD IS THE SINGLE CATEGORICAL VARIABLE WHOSE VALUES WILL BECOME NEW VARIABLES WITH THE PREFIX DEN_;
   var count ; *COUNTS WILL BECOME THE VALUES WITHIN THE NEW ID VARIABLE ;
run ;


proc print data=tdenoms ;
   title 'TRANSPOSED DENOMS' ;
run ;

**----- TRANSPOSE COUNTS -----**;

proc transpose data=agecnt out=tagecnt prefix=cnt_ ;
   by agegrpcd ;
   id sexcd ;
   var count ;
run ;

proc print data=agecnt ;
   title 'TRANSPOSED AGE COUNTS ' ;
run ;

proc transpose data=statecnt out=tstatecnt prefix=cnt_ ;
   by stateabbrp ;
   id sexcd ;
   var count ;
run ;

proc print data=tstatecnt ;
   title 'TRANSPOSED STATE COUNTS' ;
run ;

proc transpose data=racecnt out=tracecnt prefix=cnt_ ;
   by racecdp ;
   id sexcd ;
   var count ;
run ;

proc print data=tracecnt ;
   title 'TRANSPOSED RACE COUNTS' ;
run ;

proc transpose data=schoolcnt out=tschoolcnt prefix=cnt_ ;
   by schoolcd ;
   id sexcd ;
   var count ;
run ;

proc print data=tschoolcnt ;
   title 'TRANSPOSED SCHOOL COUNTS' ;
run ;

proc transpose data=ethniccnt out=tethniccnt prefix=cnt_ ;
   by ethnicp ;
   id sexcd ;
   var count ;
run ;

proc print data=tethniccnt ;
   title 'TRANSPOSED ETHNIC COUNTS' ;
run ;

proc transpose data=bmiclasscnt out=tbmiclasscnt prefix=cnt_ ;
   by bmiclscd ;
   id sexcd ;
   var count ;
run ;

proc print data=tbmiclasscnt ;
   title 'TRANSPOSED BMI COUNTS' ;
run ;

proc transpose data=lifesatcnt out=tlifesatcnt prefix=cnt_ ;
   by lifesatcd ;
   id sexcd ;
   var count ;
run ;

proc print data=tlifesatcnt ;
   title 'TRANSPOSED LIFESAT COUNTS' ;
run ;


**----- ADD DENOMINATORS TO COUNTS AND CALCULATE PERCENTS -----**;

data tagecnt(drop=_label_);
   merge tagecnt tdenoms ; *MERGING THE TRANSPOSED DATASET TAGECNT WITH TDENOMS BY _NAME_ ; 
  by _name_ ;
   array cnts{3} cnt_1 - cnt_3 ; *CNTS IS THE ARRAY NAME. THE 3 DESCRIPES THE NUMBER AND ARRANGEMENTS OF ELEMENTS FOR ARRAY ELEMENTS CNTS 1-3 ;
   array pcts{3} pct_1 - pct_3 ;
   array dens{3} den_1 - den_3 ;
   array cpts{3} $ cpt_1 - cpt_3; *$ IS USED TO DENOTE CPT_1 - CPT_3 AS CHARACTER ;
   do i = 1 to 3 ;
   		if cnts{i} gt . then pcts{i} = round((cnts{i}/dens{i}*100),.1) ; *FORMULA TO CALCULATE PERCENTS FROM CNTS AND DENOMINATORS AND IT IS ROUNDED TO 1 DECIMAL PLACE ;
	    else 		cnts{1}=0 ;
					if cnts{i}=0 then pcts{i}=0 ; 
					cpts{i} = '(' || compress(put(pcts{i},5.1)) || ')' ; *USED COMPRESS FORMULA TO ADD PARENTHESES AROUND THE PERCENTS ;
					
   end ;
run ;

proc print data=tagecnt ;
   title 'AGE STATUS COUNTS BY SITE WITH PCT' ;
run ;


data tstatecnt(drop=_label_);
   merge tstatecnt tdenoms ;
  by _name_ ;
   array cnts{3} cnt_1 - cnt_3 ;
   array pcts{3} pct_1 - pct_3 ;
   array dens{3} den_1 - den_3 ;
   array cpts{3} $ cpt_1 - cpt_3;
   do i = 1 to 3 ;
   		if cnts{i} gt . then pcts{i} = round((cnts{i}/dens{i}*100),.1) ;
	    else 		cnts{1}=0 ;
					if cnts{i}=0 then pcts{i}=0 ;
					cpts{i} = '(' || compress(put(pcts{i},5.1)) || ')' ;
					
   end ;
run ;

proc print data=tstatecnt ;
   title 'STATE COUNTS BY SITE WITH PCT' ;
run ; 

data tracecnt(drop=_label_);
   merge tracecnt tdenoms ;
  by _name_ ;
   array cnts{3} cnt_1 - cnt_3 ;
   array pcts{3} pct_1 - pct_3 ;
   array dens{3} den_1 - den_3 ;
   array cpts{3} $ cpt_1 - cpt_3;
   do i = 1 to 3 ;
   		if cnts{i} gt . then pcts{i} = round((cnts{i}/dens{i}*100),.1) ;
	    else 		cnts{1}=0 ;
					if cnts{i}=0 then pcts{i}=0 ;
					cpts{i} = '(' || compress(put(pcts{i},5.1)) || ')' ;
					
   end ;
run ;

proc print data=tracecnt ;
   title 'RACE COUNTS BY SITE WITH PCT' ;
run ; 

data tschoolcnt(drop=_label_);
   merge tschoolcnt tdenoms ;
  by _name_ ;
   array cnts{3} cnt_1 - cnt_3 ;
   array pcts{3} pct_1 - pct_3 ;
   array dens{3} den_1 - den_3 ;
   array cpts{3} $ cpt_1 - cpt_3;
   do i = 1 to 3 ;
   		if cnts{i} gt . then pcts{i} = round((cnts{i}/dens{i}*100),.1) ;
	    else 		cnts{1}=0 ;
					if cnts{i}=0 then pcts{i}=0 ;
					cpts{i} = '(' || compress(put(pcts{i},5.1)) || ')' ;
					
   end ;
run ;

proc print data=tschoolcnt ;
   title 'SCHOOL COUNTS BY SITE WITH PCT' ;
run ; 

data tethniccnt(drop=_label_);
   merge tethniccnt tdenoms ;
  by _name_ ;
   array cnts{3} cnt_1 - cnt_3 ;
   array pcts{3} pct_1 - pct_3 ;
   array dens{3} den_1 - den_3 ;
   array cpts{3} $ cpt_1 - cpt_3;
   do i = 1 to 3 ;
   		if cnts{i} gt . then pcts{i} = round((cnts{i}/dens{i}*100),.1) ;
	    else 		cnts{1}=0 ;
					if cnts{i}=0 then pcts{i}=0 ;
					cpts{i} = '(' || compress(put(pcts{i},5.1)) || ')' ;
					
   end ;
run ;

proc print data=tethniccnt ;
   title 'ETHNIC COUNTS BY SITE WITH PCT' ;
run ; 

data tbmiclasscnt(drop=_label_);
   merge tbmiclasscnt tdenoms ;
  by _name_ ;
   array cnts{3} cnt_1 - cnt_3 ;
   array pcts{3} pct_1 - pct_3 ;
   array dens{3} den_1 - den_3 ;
   array cpts{3} $ cpt_1 - cpt_3;
   do i = 1 to 3 ;
   		if cnts{i} gt . then pcts{i} = round((cnts{i}/dens{i}*100),.1) ;
	    else 		cnts{1}=0 ;
					if cnts{i}=0 then pcts{i}=0 ;
					cpts{i} = '(' || compress(put(pcts{i},5.1)) || ')' ;
					
   end ;
run ;

proc print data=tbmiclasscnt ;
   title 'BMI COUNTS BY SITE WITH PCT' ;
run ; 

data tlifesatcnt(drop=_label_);
   merge tlifesatcnt tdenoms ;
  by _name_ ;
   array cnts{3} cnt_1 - cnt_3 ;
   array pcts{3} pct_1 - pct_3 ;
   array dens{3} den_1 - den_3 ;
   array cpts{3} $ cpt_1 - cpt_3;
   do i = 1 to 3 ;
   		if cnts{i} gt . then pcts{i} = round((cnts{i}/dens{i}*100),.1) ;
	    else 		cnts{1}=0 ;
					if cnts{i}=0 then pcts{i}=0 ;
					cpts{i} = '(' || compress(put(pcts{i},5.1)) || ')' ;
					
   end ;
run ;

proc print data=tlifesatcnt ;
   title 'LIFESAT COUNTS BY SITE WITH PCT' ;
run ; 

**----- COMBINE STATISTICS INTO ONE DATA SET -----**;

data counts (drop=den: _name_) ; *BRINGING IN THE DATA FROM ALL THE TRANSPOSED DATASETS AND CREATING A NEW DATASET CALLED COUNTS ;
   set tagecnt (in=inage)
       tstatecnt (in=instate) 
	   tracecnt (in=inrace)
	   tschoolcnt (in=inschool)
	   tethniccnt (in=inethnic) 
	   tbmiclasscnt (in=inbmiclass)
       tlifesatcnt (in=inlife)
	   ; *USED IN OPTION TO DENOTE WHICH DATASET DATA WOULD BE IN;


   length rowhead $60 ;*SPECIFIES THE LENGTH OF THE ROWHEAD AND THE $ IS USED TO SHOW THAT IT IS A CHARACTER ;
   if inage then
      do ;
         tcat    = 2 ; *SPECIFIES THE HEADING AS OUTLINED IN THE PROC FORMAT ;
         rowhead = put(agegrpcd, agef.) ; *PUT IS USED TO PUT THE NUMERIC VARIABLEE IN TO THE CHARACTER FORMAT THAT I USED IN THE PROC FORMAT ;
         roword = agegrpcd ; 
      end ;
   else if instate then
      do ;
         tcat = 3 ;
         rowhead = put(stateabbrp, stateabbrf.) ;
         roword = stateabbrp ; *ROWORD LABELS THE ROWORD ;
      end ;
   else if inrace then
      do ;
         tcat = 4 ;
         rowhead = put(racecdp,racef.) ;
         roword = racecdp ;
      end ;

  else if inschool  then
      do ;
         tcat = 6 ;
         rowhead = put(schoolcd, schoolcdf.) ;
         roword = schoolcd ;
      end ;
 else if inethnic then
      do ;
         tcat = 5 ;
         rowhead = put(ethnicp, ethnicf.) ;
         roword = ethnicp ;
      end ;
	else if inbmiclass then
      do ;
         tcat = 8 ;
         rowhead = put(bmiclscd,bmiclassf.) ;
         roword = bmiclscd ;
      end ;
	else if inlife then
      do ;
         tcat = 10 ;
         rowhead = put(lifesatcd, lifesatcdf.) ;
         roword = lifesatcd ;
      end ;
run ;

proc print data = counts;
run;

proc sort data=counts ;
   by tcat ;
run ;

proc print data=counts ;
   title 'FINAL COUNT DATA FOR TABLE' ;
run ;

*PROC SORTING THE DATASET BY SEXCD ;

proc sort data= fptab1 
 		  out= fptab1; 
		  by sexcd ;
run ;

**----- GET SUMMARY STATS FOR AGE -----**;
proc means data =fptab1  noprint;
	by sexcd ; *PERFORMING A PROC MEANS BY SEXCD ;
	var age ;   *VAR IS USED TO SPECIFY AGE AND ORDER ITS RESULTS ;
	output out = age ; *CREATING THE TEMPORARY DATA SET AGE ;
run ;

proc print data = fptab1 ;
	title "CHECK STATS FOR AGE" ;
run ;

data age ;
	set age;
    if _stat_ in("N" "MIN" "MAX") then age = round(age,1.) ; *IF _STAT_ INCLUDES N MIN MAX THEN AGE IS EQUAL TO ROUNDING AGE BY 1 DECIMAL PLACE ; 
    else if _stat_ = "STD"             then age = round(age,.01) ;
    else if _stat_ = "MEAN"            then age = round(age,.1) ;
run ;


*SORTING AGE BY _STAT_ ;

proc sort data = age ;
	by _stat_ ;
run ;

proc transpose data = age out = tage prefix = cnt_;
	id sexcd ; *SEXCD WILL BE THE NEW VARIABLES WITH THE PREFIX CNT BEFORE;
	by _stat_ ;
	var age ;
run ;

data tage ;
	set tage ;
    roword  = input(_stat_, mstats.) ;  *INPUT IS USED TO CONVERT CHARACTER TO NUMERIC VALUES ;
    rowhead = put(roword, mstats.) ; *PUT IS USED TO CONVERT NUMERIC TO CHARACTER ;
    tcat = 1 ;
run ;

proc print data = tage ;
	title "CHECK DATA FOR AGE" ;
run ;


**----- GET SUMMARY STATS FOR BMI -----**;
proc means data =fptab1  noprint;
	by sexcd ;
	var bmi ;
	output out = bmi ;
run ;

proc print data = fptab1 ;
	title "CHECK STATS FOR AGE" ;
run ;

data bmi ;
	set bmi ;
         if _stat_ in("N" "MIN" "MAX") then bmi = round(bmi,.1) ;
    else if _stat_ = "STD"             then bmi = round(bmi,.001) ;
    else if _stat_ = "MEAN"            then bmi = round(bmi,.01) ;
run ;

proc sort data = bmi ;
	by _stat_ ;
run ;

proc transpose data = bmi out = tbmi prefix = cnt_;
	id sexcd ;
	by _stat_ ;
	var bmi ;
run ;

data tbmi ;
	set tbmi ;
    roword  = input(_stat_, bmistats.) ;
    rowhead = put(roword, bmistats.) ;
    tcat = 7 ;
run ;

**----- GET SUMMARY STATS FOR ESTIMATED INCOME-----**;
proc means data =fptab1  noprint;
	by sexcd ;
	var estinc ;
	output out = estinc ;
run ;

proc print data = estinc ;
	title "CHECK STATS FOR AGE" ;
run ;

data estinc ;
	set estinc ;
         if _stat_ in("N" "MIN" "MAX") then estinc = round(estinc,.1) ;
    else if _stat_ = "STD"             then estinc = round(estinc,.001) ;
    else if _stat_ = "MEAN"            then estinc = round(estinc,.01) ;
run ;

proc sort data = estinc ;
	by _stat_ ;
run ;

proc transpose data = estinc out = testinc prefix = cnt_;
	id sexcd ;
	by _stat_ ;
	var estinc ;
run ;

data testinc ;
	set testinc ;
    roword  = input(_stat_, estincstats. ) ;
    rowhead = put(roword, estincstats. ) ;
    tcat = 9 ;
run ;

proc print data=testinc ;
	title "CHECK STATS FOR ESTIMATED INCOME" ;
run ; 

proc sort data = tage ;
	by tcat roword ;
run ;

proc sort data = testinc ;
	by tcat roword ;
run ;

proc sort data = tbmi ;
	by tcat roword ;
run ;

 

*DATASTEP TO COMBINE ALL THE DATA FOR THE SUMMARY STATISTICS ;

data combine ;
	set counts
		tage 
        tbmi
        testinc ;
	by tcat roword ;
run ;

proc print data = combine ;
	title "CHECK FINAL TABLE" ;
run ;

options nodate nonumber orientation=portrait ;*CHANGED THE ORIENTATION TO MAKE IT EQUAL TO PORTRAIT VIEW ;
ods listing close ;
ods escapechar='^' ;
ods rtf file='C:\Users\Geoffrey\Documents\PBHL 623\Final Project Part 4\Kip_G_Table1.RTF'
        style=tstylertf ; *USING THE SPECIFIC STYLE CALLED TSTYLERTF ; *OUTPUTTING MY RTF FILE TO FINAL PROJECT AND CALLING IT TABLE 1 RTF ;


title1 justify=left 'PBHL623:Final Project: Geoffrey Kip' justify= right 'Date: June 10, 2014' ;
title2  'Table 1 Demographics' ; *ADDING A TITLE TO THE TABLE ;


proc report data=combine nowd split="|" headline ; *NOWD SPECIFIES TO OPEN NO OTHER WINDOW ;
	
	column tcat roword rowhead
          ("Men (N=422)"  cnt_1 cpt_1) 
          ("Women (N=524)" cnt_2 cpt_2)
          ("Total (N=949)"  cnt_3 cpt_3)
          ; *LABELS THE COLUMNS AS MEN, WOMEN AND TOTAL ;
   define tcat    / order noprint ;
   define roword  / order noprint ;
   define rowhead / '  ' style(column)=[cellwidth=2.2in]; *SPECIFIED THE CELL WIDTH AS 2.2 IN AND LABELLED THE ROWHEAD AS CATEGORY ;
   define cnt_1   / "^R'\qc 'n"   style(column)=[cellwidth=.75in] center;
   define cpt_1   / '(%)'         style(column)=[cellwidth=.5in just=d] ;
   define cnt_2   / "^R'\qr 'n"   style(column)=[cellwidth=.75in];
   define cpt_2   / '(%)'         style(column)=[cellwidth=.5in just=d] ;
   define cnt_3   / "^R'\qr 'n"   style(column)=[cellwidth=.75in];
   define cpt_3 / '(%)'         style(column)=[cellwidth=.5in just=d] ;
                             
   compute before tcat ;
      line ' ' ;
      line tcat tcat. ;
   endcomp ;

run ;

ods rtf close ; *HAVE TO CLOSE THE OUTPUT DESTINATION FILES ;
ods listing ;























