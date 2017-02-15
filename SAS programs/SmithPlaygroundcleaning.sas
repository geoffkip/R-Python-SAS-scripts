libname smith 'C:\Users\Geoffrey\Dropbox\Survey final';

PROC IMPORT OUT= SMITH.Step1 
            DATAFILE= "C:\Users\Geoffrey\Dropbox\Survey final\PBHL632final.csv" 
            DBMS=CSV REPLACE;
     GETNAMES=YES; 
     DATAROW=3; 
	 GUESSINGROWS=200; 

proc contents data=SMITH.Step1; 
run;

proc format;
value race
1 = 'White'
2 = 'Black'
3 = 'American Indian'
4 = 'Asian/Pacific Islander'
5 = 'Other'
6 = 'Multiple Race'
7 = 'None specified';

value sex
1 = 'Male'
2 = 'Female'
3 = 'No Response';

value yntwo
1 = 'Yes'
2 = 'No'
3 = 'No Response';

    value edu
1 = 'Less than HS'
2 = 'High School Degree or GED'
3 = 'Vocational Training'
4 = 'Some college'
5 = 'College/University Degree'
6 = 'Graduate or Professional Degree'
7 = 'Do not know'
8 = 'No response';

value visit
0 = 'Never'
1 = 'About once a month'
2 = 'A few times per month'
3 = 'About once a week'
4 = 'A few times a week'
5 = 'Every day';

    value hear
1 = 'Banner or sign'
2 = 'School visit'
3 = 'Word of mouth (friend, family or neighbor)'
4 = 'Newspaper, News'
5 = 'Listing in a guidebook'
6 = 'Facebook, Twitter, or other social media'
7 = 'Advertisement'
9 = 'Search Engine (Google, Yahoo etc)'
10 = 'Other'
11 = 'Birthday party';

value primary
1 = 'No cost'
2 = 'Personal time with your child'
3 = 'Safe area to play'
4 = 'Exercise/physical activity'
5 = 'Relaxation'
6 = 'Fun for my child'
7 = 'Socializing for my child'
8 = 'To attend a program or class'
9 = 'To meet other caregivers'
10 = 'Other';

    value transport
1 = 'My car'
2 = 'Friend/Relatives car'
3 = 'Subway'
4 = 'Bus'
5 = 'Regional Rail'
6 = 'Walk'
7 = 'Bicycle'
8 = 'Taxi cab'
9 = 'Trolley';

value income
1 = 'Below $15,000'
2 = '$15,000 - $24.999'
3 = '$25,000-$49,999'
4 = '$50,000-$74,999' 
5 = '$75,000-$99,999'
6 = '$100,000 and above';

run;

data SMITH.Step2;
    set SMITH.Step1;
label V8="StartDate" ;
label V9="EndDate" ;
label Q33 ='Do you consent to take this survey?';
label Q2 ='What is the zipcode where you live?';
label Q4 ='Are you a parent or guardian of the child?';
label Q5 ='What is the age of your child in years? ';
label Q6 ='What is the gender of your child?';
label Q7 ='Is your child of Hispanic, Latinoa, or Spanish origin?';
label Q8_1 ='Which of these groups would  you say best represents your child’s race? Select all that  apply.-White';
label Q8_2 ='Which of these groups would  you say best represents your child’s race? Select all that  apply.-Black or African American';
label Q8_3 ='Which of these groups would  you say best represents your child’s race? Select all that  apply.-American Indian or Alaska Native';
label Q8_4 ='Which of these groups would  you say best represents your child’s race? Select all that  apply.-AsianPacific Islander';
label Q8_6 ='Which of these groups would  you say best represents your child’s race? Select all that  apply.-Other';
label  Q8_6_TEXT="Which of these groups would you say best represents your child's race? Select all that /  apply-Other-TEXT";
label    Q9="How often do you usually visit / Smith?" ;
label    Q10="How did you hear about Smith Playground? Only select one" ;
label    Q10_TEXT="How did you hear about Smith Playground? Only select one-TEXT";
label    Q11="What is the primary reason that you usually visit Smith? Only select one" ;
label    Q11_TEXT="What is theåÊprimaryåÊreason that you usually visit Smith?åÊOnly select one-TEXT" ;
label    Q12="What is your primary mode of / transportation when you come to Smith?" ;
label    Q13="We appreciate your volunteering to take this survey, however these / questions only apply to parents or guardians of children between / the ages of 2 and 12."; 
label    Q14="In these next few questions we are going to ask you about your / child and play" ;
label    Q15_1="Which of these activities would you consider to be play? Select all that apply-Shopping" ;
label    Q15_2="Which of these activities would you consider to be play? Select all that apply-Using the internet" ;
label    Q15_3="Which of these activities would you consider to be play? Select all that apply-Watching TV or videos" ;
label    Q15_4="Which of these activities would you consider to be play? Select all that apply-Video games" ;
label    Q15_5="Which of these activities would you consider to be play? Select all that apply-Reading" ;
label    Q15_6="Which of these activities would you consider to be play? Select all that apply-Make believe with dolls/action figures" ;
label    Q15_7="Which of these activities would you consider to be play? Select all that apply-Painting, drawing, or making things" ;
label    Q15_8="Which of these activities would you consider to be play? Select all that apply-Building toys" ;
label    Q15_9="Which of these activities would you consider to be play? Select all that apply-Going to the playground" ;
label    Q15_10="Which of these activities would you consider to be play? Select all that apply-Team sports" ;
label    Q16="For this survey, we define play, or free play, as motivated /  and directed by the child and not involving a screen.åÊ For /  example, play can include a game of dress up, hide and seek, or /  make be..." ;
label    Q17_1="Please indicate how much you agree with the following statements-Time spent playing is also time spent learning" ;
label    Q17_3="Please indicate how much you agree with the following statements-Recess is not an important part of a child‰Ûªs curriculum in school" ;
label    Q17_5="Please indicate how much you agree with the following statements-My child should spend more time in planned activities and lessons, rather than more time playing" ;
label    Q17_7="Please indicate how much you agree with the following statements-It is important for my child to experience free play outside of school" ;
label    Q18="When you were a child, do you / think you played more or less than your child plays today?";
label    Q19="On an average day /  how many hours does your child /  spend involved in free play?" ; 
label    Q20_1="On an average day during this time of year, how many hours does / your child spend doing the following activities:-Physical activity such as: bicycling, running, skipping, skateboarding, swimming, baseball, dance, football, basketball, or other sports" ;
label    Q20_2="On an average day during this time of year, how many hours does / your child spend doing the following activities:-Watching TV" ;
label    Q20_3="On an average day during this time of year, how many hours does / your child spend doing the following activities:-Playing video or computer games, playing on a tablet or smart phone, or playing on the Internet" ;
label    Q20_4="On an average day during this time of year, how many hours does / your child spend doing the following activities:-Playing quietly, reading, being read to, playing a musical instrument, or doing homework" ;
label    Q21="The next set of questions ask about barriers to free / play" ;
label    Q22_2="For each possible barrier to free play please indicate /  your level of agreement-I have trouble coming up with ideas for play with my child" ;
label    Q22_3="For each possible barrier to free play please indicate /  your level of agreement-Some options for play are too expensive" ;
label    Q22_4="For each possible barrier to free play please indicate /  your level of agreement-I am afraid of my child getting injured or ill during play" ;
label    Q22_6="For each possible barrier to free play please indicate /  your level of agreement-There are no other children around to play with" ;
label    Q22_11="For each possible barrier to free play please indicate /  your level of agreement-I am afraid of other children being a bad influence on my child" ;
label    Q23="The next set of questions will be asking about places in your / neighborhood, excluding Smith" ;
label    Q24="Is there a park, recreation center, and/or playground in your / neighborhood?" ;
label    Q25="Do you feel safe at this park, recreation center, and/or / playground?" ;
label    Q26="This last set of questions ask for some basic demographic / information about you" ;
label    Q27="What is your gender?" ;
label    Q28="What is your highest education / level completed?" ;
label    Q29="Are you Hispanic, Latino/a, or / Spanish origin?" ;
label    Q30_1="Which one of these groups would / you say best represents your race? Select all that apply-White" ;
label    Q30_2="Which one of these groups would / you say best represents your race? Select all that apply-Black of African American" ;
label    Q30_3="Which one of these groups would / you say best represents your race? Select all that apply-American Indian or Alaska Native" ;
label    Q30_4="Which one of these groups would / you say best represents your race? Select all that apply-Asian" ;
label    Q30_5="Which one of these groups would / you say best represents your race? Select all that apply-Pacific Islander" ;
label    Q30_6="Which one of these groups would / you say best represents your race? Select all that apply-Other" ;
label    Q30_6_TEXT="Which one of these groups would / you say best represents your race? Select all that apply-Other-TEXT" ;
label    Q31="Please indicate your approximate / annual household income" ;
drop  V8 V9 Q3 Q13 Q14 Q16 Q21 Q23 Q26 ; 

RUN ; 

proc freq data=SMITH.Step2;
    table Q6 Q30_6_TEXT Q27; 
run;


/*WHAT SHOULD WE DO WITH THESE RESPONSES?*/
proc print data=SMITH.Step2 noobs;
    where Q30_6_TEXT ne "";
    var Q30_6_TEXT Q30_1-Q30_6 Q27 ;
run;
proc print data=SMITH.Step2 noobs;
    where Q27  ne . ;
    var Q27 Q30_1-Q30_6 ;
run;
proc print data=SMITH.Step2 noobs;
    where Q8_6_TEXT ne "";
    var Q8_6_TEXT Q8_1-Q8_4 Q8_6;
run;


data SMITH.Step3;
    set SMITH.Step2;

    /*FIRST LET'S CLEAN THE OTHER TEXT RESPONSES*/
    if Q30_6_TEXT="South Asian.Pakistani" then Q30_4=1;
    if Q30_6_TEXT="South Asian.Pakistani" then Q30_6=.;

    if Q30_6_TEXT="Latino " then Q30_6=.;

    if Q30_6_TEXT="Jewish" then Q30_6=.;

    if Q30_1=. then White=Q50_1;
        else White=Q30_1;
    /*IF THERE IS NO RESPONSE FOR WHITE, WE WILL SET IT TO ZERO*/
    if White=. then White=0;
    if Q30_2=. then Black=Q50_2;
        else Black=Q30_2;
    if Black=. then Black=0;
    if Q30_3=. then AmInd=Q50_3;
        else AmInd=Q30_3;
    if AmInd=. then AmInd=0;
    if Q30_4=. then Asian=Q50_4;
        else Asian=Q30_4;
    if Asian=. then Asian=0;
    if Q30_5=. then PI=Q50_5;
        else PI=Q30_5;
    if PI=. then PI=0;
    if Q30_6=. then Other=Q50_6;
        else Other=Q30_6;
    if Other=. then Other=0;

    /* WE WILL DO THE SAME FOR THE RACE OF THE CHILD*/
    if Q8_1=. then ChildWhite=Q8_1;
        else ChildWhite=Q8_1;
    if ChildWhite=. then ChildWhite=0;
    if Q8_2=. then ChildBlack=Q8_2;
        else ChildBlack=Q8_2;
    if ChildBlack=. then ChildBlack=0;
    if Q8_3=. then ChildAmInd=Q8_3;
        else ChildAmInd=Q8_3;
    if ChildAmInd=. then ChildAmInd=0;
    if Q8_4=. then ChildAsianPI=Q8_4;
        else ChildAsianPI=Q8_4;
    if ChildAsianPI=. then ChildAsianPI=0;
    if Q8_6=. then ChildOther=Q8_6;
        else ChildOther=Q8_6;
    if ChildOther=. then ChildOther=0;

    /*WE WILL NOW CREATE AN INDICATOR FOR THE TOTAL NUMBER OF RESPONSES*/
    TOTRace=White+Black+AmInd+Asian+PI+Other;
    TotRaceChild=ChildWhite+ChildBlack+ChildAmInd+ChildAsianPI+ChildOther;

    /*NOW WE WILL USE THIS INDICATOR VARIABLE TO CREATE A SINGLE RACE VARIABLE*/
    if TotRace=0 then Race=7;
        else if TotRace>1 then Race=6;
        else if TotRace=1 and White=1 then Race=1;
        else if TotRace=1 and Black=1 then Race=2;
        else if TotRace=1 and AmInd=1 then Race=3;
        else if TotRace=1 and Asian=1 then Race=4;
        else if TotRace=1 and PI=1 then Race=4;
        else if TotRace=1 and Other=1 then Race=5;
    if TotRaceChild=0 then ChildRace=7;
        else if TotRaceChild>1 then ChildRace=6;
        else if TotRaceChild=1 and ChildWhite=1 then ChildRace=1;
        else if TotRaceChild=1 and ChildBlack=1 then ChildRace=2;
        else if TotRaceChild=1 and ChildAmInd=1 then ChildRace=3;
        else if TotRaceChild=1 and ChildAsianPI=1 then ChildRace=4;
        else if TotRaceChild=1 and ChildOther=1 then ChildRace=5;
    if Q8_6_TEXT="mixed race" then ChildRace=6;
    format race ChildRace race.;
    label race = 'What is your race?';
    label ChildRace= 'What is the race of your child?';

    /*NOW WE WILL RECODE THE ETHNICITY VARIABLE*/
    /*NOTE THAT THIS IS CODED 1=YES 0=NO*/
    if Q29=. then Ethnicity=Q49;
        else Ethnicity=Q29;
    if Ethnicity=. then Ethnicity=3;
    if Ethnicity=0 then Ethnicity=2;
    format ethnicity yntwo.;
    label ethnicity = 'Are you Hispanic or Latino/a?';

    if Q7=. then ChildEthnicity=3;
        else if Q7=1 then ChildEthnicity=1;
        else if Q7=0 then ChildEthnicity=2;
    format ChildEthnicity yntwo.;
    label childethnicity = 'Is your child Hispanic or Latino/a?';

    /*NOW WE WILL RECODE THE GENDER VARIABLE*/
    if Q27=. then Sex=Q47;
        else Sex=Q27;
    if Sex=. then Sex=3;

    if Q6=. then ChildSex=3;
        else ChildSex=Q6;
    format sex ChildSex sex.;
    label sex = "What is your sex?";
    label ChildSex = "What is the sex of your child?";


    /*NOW WE WILL RECODE THE EDUCATION VARIABLE*/
    if Q28=. then Education=Q48;
        else Education=Q28;
    if Education=. then Education=8;
    format education edu.;
    label education = 'What is your highest level of education?';

    /*NEXT WE WILL RENAME AND FORMAT THE CONSENT VARIABLE*/
    Consent=Q33*1;
    if Consent=. then Consent=3;
    format consent yntwo.;
    
    /*SINCE THESE VARIABLES HAVE ALREADY BEEN USED, WE NO LONGER NEED THEM AND THEY CAN BE DROPPED*/
    ** drop TotRace White Black AmInd Asian PI Other Q30_1-Q30_6 Q50_1-Q50_6 Q30_6_TEXT Q50_6_TEXT Q27 Q47 Q29 Q49 Q28 Q48 Q33
    Q8_1-Q8_4 Q8_6 Q8_6_Text ChildWhite ChildBlack ChildAmInd ChildAsianPI ChildOther TotRaceChild Q6 Q7;
run;
/*ALWAYS CHECK FREQUENCIES AFTER YOU RECODE TO MAKE SURE NOTHING STRANGE HAPPENED*/
proc freq data=SMITH.step3;
    table Race Sex Education Ethnicity Consent ChildRace ChildEthnicity/missing list;
run;

/********************************************************************************************************************************
*        STEP 4                                                                                                                    *                                                                                                        *
*        RECODE, RENAME, AND CLEAN                                                                                                *
*            WE WILL THEN RECODE, RENAME, AND CLEAN OTHER VARIABLES                                                                *
********************************************************************************************************************************/


/*LETS CHECK ALL OTHER VARIABLES TO SEE WHAT THE DATA LOOK LIKE*/

proc freq data=SMITH.step3;
run;

data SMITH.step4;
    set SMITH.step3;

    /*RECODE VARIABLES TO 1/2 THAT WERE 1/0*/
    if Q4=0 then Q4=2;
    if Q7=0 then Q7=2;
    if Q24=0 then Q24=2;
    if Q25=0 then Q25=2;

    /*CREATE AN INDICATOR FOR ELIGIBILITY. RESPONDENTS ARE ELIGIBLE IF THEY CONSENT, ARE THE PARENT OR GUARDIAN OF A CHILD,
    AND THEIR CHILD IS OLDER THAN 2*/
    if consent=2 or Q4=0 or Q5=1 then eligible=2;
        else if consent=1 and Q4=1 and Q5 ne 1 AND Q5 ne 13 then eligible=1;
    format eligible yntwo.;

        /*FORMAT VARIABLES THAT DO NOT NEED TO BE RECODED*/
    if Q4=. then Q4=3;
    if Q4=0 then Q4=2;
    format Q4 yntwo.;

    if Q6=. then Q6=3;
    format Q6 sex.;

    if Q7=0 then Q7=2;
    if Q7=. then Q7=3;
    format Q7 yntwo.;

    format Q9 visit.;
    format Q10 hear.;
    format Q11 primary.;
    format Q12 transport.;
    format Q31 income.;
    
    /*LET US RENAME SOME VARIABLES FOR EASE OF USE*/
    rename Q2=zipcode Q4=ParentGuardian Q5=ChildAge Q9=VisitSmith Q11=ReasonVisit Q12=transportation Q31=Income;
run;

proc freq data=SMITH.step4;
    where eligible=1;
    table race education income;
run;


data SMITH.step5 ;
    set SMITH.step4;
    where eligible=1;
IF Q10_Text="Friend" Then    Q10=3 ;
IF Q10_Text="Friend" then Q10_Text= " "; 

IF Q10_Text="How did you hear about Smith Playground? Only select one.-TEXT" then    Q10=10 ;
IF Q10_Text="How did you hear about Smith Playground? Only select one.-TEXT" then    Q10_Text=" " ;

IF Q10_Text="I used to come here when I was little." then    Q10=10;
IF Q10_Text="I used to come here when I was little." then    Q10_Text=" " ;

IF Q10_Text="Know about it when other g' kids were little" then    Q10=2 ;
IF Q10_Text="Know about it when other g' kids were little" then    Q10_Text=" " ;


IF Q10_Text="On a tour of Faiment Park" Then    Q10=2 ;
IF Q10_Text="On a tour of Faiment Park" Then    Q10_Text=" " ;

IF Q10_Text="What to do in Philly" then    Q10=5 ;
IF Q10_Text="What to do in Philly" then    Q10_Text=" " ;


IF Q10_Text="came here as a kid" then    Q10=10 ;
IF Q10_Text="came here as a kid" then    Q10_Text=" " ;



IF Q10_Text="came up as things to do online" then Q10=9 ;
IF Q10_Text="came up as things to do online" then Q10_Text=" " ;

IF Q10_Text="frisbee golf corse " then    Q10=5 ;
IF Q10_Text="frisbee golf corse " then    Q10_Text=" " ;

IF Q10_Text="going as a child" then    Q10=10 ;
IF Q10_Text="going as a child" then    Q10_Text=" " ;

IF Q10_Text="relative (brother)" then    Q10=3 ;
IF Q10_Text="relative (brother)" then    Q10_Text=" " ;
IF Q10_Text="  " then Q10_Text="Missing" ;


    IF Q11_Text="Birthday Party" Then    Q11=7 ;
	IF Q11_Text="Birthday Party" Then    Q11_Text=" " ;
	


    IF Q11_Text="Indoors" then    Q11=8 ;
    IF Q11_Text="Indoors" then    Q11_Text=" " ;



    IF Q11_Text="Just a birthday party." then    Q11=6 ;
	IF Q11_Text="Just a birthday party." then    Q11_Text=" " ;

    IF Q11_Text="get out of the house"  then    Q11=4 ;
    IF Q11_Text="get out of the house"  then    Q11_Text=" " ;

	IF Q11_Text="  " then Q11_Text="Missing" ;

if Q17_1 = 1 or Q17_7 = 1 or Q17_3 = 5 or Q17_5 = 5 then attitude = 1 ;
if Q17_1 = 2 or Q17_7 = 2 or Q17_3 = 4 or Q17_5 = 4 then attitude = 2 ;
if Q17_1 = 3 or Q17_7 = 3 or Q17_3 = 3 or Q17_5 = 3 then attitude = 3 ;
if Q17_1 = 4 or Q17_7 = 4 or Q17_3 = 2 or Q17_5 = 2 then attitude = 4 ;
if Q17_1 = 5 or Q17_7 = 5 or Q17_3 = 1 or Q17_5 = 1 then attitude = 5 ;

if attitude = 1 then chaattitude = 'Strongly Positive' ;
if attitude = 2 then chaattitude = 'Moderately Positive' ;
if attitude = 3 then chaattitude = 'Neutral' ;
if attitude = 4 then chaattitude = 'Moderately Negative' ;
if attitude = 5 then chaattitude = 'Strongly Negative' ; 
run ; 

proc freq data = SMITH.step5 ;
    tables attitude chaattitude ; 
run; 

proc freq data = SMITH.step5 ;
    tables ChildAge Q6 VisitSmith Q10 Q10_TEXT ReasonVisit Q11_TEXT Q17_1 Q17_3 Q17_5 Q17_7 Q19 Education Ethnicity race Income ; 
run ; 

data Smith.Step6 ;
    set SMITH.step5 ;

    if Q6 =3 then Q6 = . ; 
   if Education=8  then Education= . ;
   if Ethnicity=3 then Ethnicity= . ;

   if sex=3 then sex= .;

   if ChildAge in (2 3 4 5) then childcage=1 ;
   if childcage=1 then School="Pre-School" ;
   if ChildAge in (6 7 8 9 10 11 12) then childcage=2 ;
   if childcage=2 then School="School-Aged" ;


   if VisitSmith in (1 2) then freqvisit=3 ;
   if freqvisit=3 then visit="Monthly" ;
   if VisitSmith in (3 4) then freqvisit=1 ;
   if freqvisit=1 then visit="Weekly" ;
   if VisitSmith=0 then freqvisit=2 ;
   if freqvisit=2 then visit="Never" ;
   
if Q19 in (1 2 3 ) then freeplay=1 ;
if freeplay=1 then play="Less than 3 hours per day" ;
if Q19 in (4 5 6) then freeplay=2 ;
if freeplay=2 then play="3 or more hours per day" ;


if ChildEthnicity=3 then ChildEthnicity= . ;


if ChildRace in (3 4 6) then ChildRace=5 ;





 run ;

proc freq data=Smith.Step6 ;
tables Q6 Education Ethnicity School visit play ChildRace  ;
run ;


 *STEP 2 DATA ANALYSIS ;

*PARTICIPATION RATE=Eligible/Those who consented=117/117+19= 117/136=86%
(117/152)*25=19.24 of the people who refused were eligible. ;

*Question 10 ;
*TABLE 1;

proc freq data=Smith.Step6 ;
tables Education Ethnicity Race Income visit ReasonVisit Q6 School  sex ;
run ;

*TABLE 2 ;
*ALL DEMOGRAPHICS IN TABLE 1 vs freeplay. ADD SOME DEMOGRAPHICS FOR THE PARENTS ;

proc freq data=Smith.Step6 ;
tables (chaattitude ChildRace ChildEthnicity School Q6)*play / exact ;
run ;

proc freq data=Smith.Step6 ;
tables play ;
run ;

proc freq data=Smith.Step6 ;
tables (Education  School Ethnicity Race Income chaattitude  Q6)*play /exact ;
run ;
