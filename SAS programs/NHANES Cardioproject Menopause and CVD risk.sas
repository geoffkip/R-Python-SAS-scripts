libname cardio xport "C:\Users\Geoffrey\Dropbox\Cardio data analysis\CDQ_D.XPT" ; 
libname hormones xport "C:\Users\Geoffrey\Dropbox\Cardio data analysis\RHQ_D.XPT" ; 
libname demog xport "C:\Users\Geoffrey\Dropbox\Cardio data analysis\DEMO_D.XPT" ;
libname biomark xport "C:\Users\Geoffrey\Dropbox\Cardio data analysis\TCHOL_D.XPT" ;
libname CRP xport "C:\Users\Geoffrey\Dropbox\Cardio data analysis\CRP_D.XPT" ;
libname cholest xport "C:\Users\Geoffrey\Dropbox\Cardio data analysis\HDL_D.XPT" ;
libname glucose xport "C:\Users\Geoffrey\Dropbox\Cardio data analysis\Glu_D.XPT" ;
libname LDL xport "C:\Users\Geoffrey\Dropbox\Cardio data analysis\trigly_D.XPT" ;
libname CVD "C:\Users\Geoffrey\Dropbox\Cardio data analysis" ;
run ;

proc copy in=cardio out=CVD ;
proc copy in=hormones out=CVD ;
run ;
proc copy in=demog out=CVD ;
proc copy in=biomark out=CVD ;
proc copy in=CRP out=CVD ;
proc copy in=cholest out=CVD ;
proc copy in=glucose out=CVD ;
proc copy in=LDL out=CVD ;
run ;

data LDL ;
set "C:\Users\Geoffrey\Dropbox\Cardio data analysis\trigly_D.sas7bdat" ;
run ; 
data glucose ;
set "C:\Users\Geoffrey\Dropbox\Cardio data analysis\glu_D.sas7bdat" ;
run ;
data demor ;
set "C:\Users\Geoffrey\Dropbox\Cardio data analysis\demo_D.sas7bdat" ;
run ;
data hormo ;
set  "C:\Users\Geoffrey\Dropbox\Cardio data analysis\rhq_D.sas7bdat" ;
run ;
data card ;
set "C:\Users\Geoffrey\Dropbox\Cardio data analysis\cdq_D.sas7bdat" ;

data biomar ;
set "C:\Users\Geoffrey\Dropbox\Cardio data analysis\tchol_D.sas7bdat" ;
run ;

data CRP ;
set "C:\Users\Geoffrey\Dropbox\Cardio data analysis\CRP_D.sas7bdat" ;
run ;

data cholest ;
set "C:\Users\Geoffrey\Dropbox\Cardio data analysis\hdl_D.sas7bdat" ;
run ;

proc sort data=LDL 
out=LDL1 ;
by SEQN ;
run ;

proc sort data=glucose 
out=glucose1 ;
by SEQN ;
run ;

proc sort data=cholest
out=cholest1 ;
by SEQN ;
run ;

proc sort data=CRP 
out=CRP1 ;
by SEQN ;
run ;


proc sort data=demor 
out=demor1 ; 
by SEQN ;
run ;

proc sort data=hormo 
out=hormo1 ; 
by SEQN ;
run ;

proc sort data=card
out=card1 ; 
by SEQN ;
run ;

proc sort data=biomar 
out=biomar1 ; 
by SEQN ;
run ;

libname pretlib "C:\Users\Geoffrey\Dropbox\Cardio data analysis" ;

proc format ;
*TOTAL CHOLESTEROL ;
value $totcholestf
"2"="High"
"1"="Desirable" 
" "= "Missing" 
; 

*LDL ;
value $LDLF
"1"="Desirable"
"2"="High" 
" "= "Missing" 
;

*HDL CHolesterol ;
value $HDLF 
" "= "Missing"
"1"="High"
"2"="Low"

;
*Triglyceride ;
value $trigf 
"1"="Normal" 
"2"="High"
" "="Missing" 
;
*C-Reactive Protein ;
value $CRPF
" "="Missing"
"1"="Low Risk"
"2"="High Risk"
 

;

*Apolipo-protein ;
value $APBF
" "= "Missing"
"1"="Low Risk"
"2"="High Risk"

 
;
*FASTING BLOOD GLUCOSE ;
value $GLUF 
" "= "Missing"
"1"="Normal"
"2"= "Diabetic"

 :
;

run ;

data pretlib.project ;
merge demor1(in=indem)
      hormo1 (in=inhormo)
	  card1 (in=incard)
	  biomar1 (in=inbio)
	  CRP1 (in=inCRP)
	  cholest1 (in=incholest)
	  glucose1 (in=inglucose)
	  LDL1 (in=inLDL) 
	  ;
*TOTAL CHOLESTEROL TO HDL RATIO ;
CHOHDL=LBXTC/LBDHDD ;
if CHOHDL <3.5 then CHOHDL_num1=1;
else CHOHDL_num1=0 ;
if CHOHDL=3.524 then CHOHDL_num2=1 ;
else CHOHDL_num2=0 ;
if CHOHDL ge 5 then CHOHDL_num3=1 ;
else CHOHDL_num3=0 ;
by SEQN ;

*LABELS ;
label totcholest="Total cholesterol" 
      LDL="LDL Cholesterol" 
	  HDL="HDL Cholesterol" 
	  trig="Triglycerides" 
	  CRP="C-Reactive Protein" 
      APB= "Apoliporprotein" 
	  CRP= "CRP REACTIVE PROTEIN" ;
	  
	  ;
	  
*TOTAL CHOLESTEROL ;
if LBXTC gt 0 and LBXTC lt 200 then lbxtccd=1 ;  
else if LBXTC ge 200 then lbxtccd=2 ; *DONT NEED A CODE FOR MISSING VARIABLES SINCE WE GROUPED THEM "GREATER THAN 0" FOR EXAMPLE ;

if lbxtccd=1 then totcholest="Desirable" ;
else if lbxtccd=2 then totcholest="High" ;
;


*LDL ;
if LBDLDL gt 0 and LBDLDL  lt 129 then LBDLDLcd=1 ;
else if LBDLDL ge 129 then LBDLDLcd=2 ;

if LBDLDLcd=1 then LDL="Desirable" ;
else if LBDLDLcd=2 then LDL="High" ;


*HDL ;
if LBDHDD gt 0 and LBDHDD lt 50 then LBDHDDcd=1 ;
else if LBDHDD ge 50 then LBDHDDcd=2 ;

if LBDHDDcd=1 then HDL="High" ;
else if LBDHDDcd=2 then HDL="Low" ;

*Triglyceride ;

if LBXTR ne . and LBXTR ge 0 and LBXTR lt 150 then LBXTRcd=1 ;
else if LBXTR ge 150 then LBXTRcd=2 ;
 

if LBXTRcd=1 then trig="Normal" ;
else if LBXTRcd=2 then trig="High" ;


*CRP ;
if LBXCRP ne . and LBXCRP ge 0 and LBXCRP lt 1 then LBXCRPcd=1 ;
else if LBXCRP ge 1 then LBXCRPcd=2 ;

if LBXCRPcd=1 then CRP="Low Risk" ;
else if LBXCRPcd=2 then CRP="High Risk" ;

*Aopololipoprotein ;
if LBXAPB gt 0 and LBXAPB lt 130 then LBXAPBcd=1;
else if LBXAPB le 110 then LBXAPBcd=2 ;


if LBXAPBcd=1 then APB="Low Risk";
if LBXAPBcd=2 then APB="High Risk" ;


*BLOOD GLUCOSE ;
if LBXGLU gt 70 and LBXGLU lt 100 then GLU="Normal" ;
if LBXGLU  ge 101 then GLU="Diabetic" ;

if RHQ554 eq 1 or RHQ562 eq 1 or RHQ570 eq 1 then pilluse=1 ;
if RHQ554 ne 9 or RHQ562 ne 9 or RHQ570 eq 9 then pilluse=0 ;

run ; 

proc freq data=pretlib.project ;
where RHQ550 eq 2 ; 
tables totcholest 
	   HDL  
	   CRP
	   / list missing nocum nopercent 
	   ;
format totcholest $totcholestf.
	   HDL $HDLF.
	   CRP $CRPF.
	 

	   ; *ADD P-VALUES USE PROC MI TO RUN IMPUTATIONS FOR MISSING DATA  
	   LESS GROUPS GROUP THEM TOGETHER, E.G OPTIMAL, HIGH and VERY HIGH. SAMPLE SIZE TOO SMALL 
	   TAKE AWAY MISSING AND DONT' KNOW VARIABLES. CAN DO LOGISTIC REGRESSION THEN. ALSO USE CHI-SQUARE TEST TO CALCULATE P-VALUES;
run ;

proc contents data=pretlib.project varnum ;
run ;
proc print data=pretlib.project ;
run ;

proc freq data=pretlib.project ;
table RIAGENDR RIDRETH1 RHQ550 RHQ551A ;
run ;

proc print data=pretlib.project ;
where RHQ550 eq 1 ;
var RHQ550 RIAGENDR RIDRETH1 ;
run ;

proc freq data=pretlib.project ;
where RHQ550 eq 1;
table RHQ540 RIAGENDR RHQ551E RHQ551A RHQ554 RHQ562 ;
run ;

proc means data=pretlib.project ;
where RHQ550 eq 1; 
var RIDAGEYR DMDYRSUS RHQ556 RHQ560Q RHQ568Q ;
run ;

*LOOK AT CARDIO VARIABLES ;
proc freq data=pretlib.project ;
where RHQ550 eq 1 ;
table CDQ001  ;
run ;
*LOOK AT BIOMARKERS ;
proc freq data=pretlib.project ;
where RHQ550 eq 1 ;
table LBXTC ;
run ;

*EXPLORATORY DATA ANALYSIS ;
proc means data=pretlib.project ;
where RHQ550 eq 1 ;
var  LBXTC LBDHDD LBXGLU LBXIN LBXTR LBDLDL LBXAPB LBXCRP ;
run ;

proc freq data=pretlib.project ;
where RHQ550 eq 2 ;
table RHQ554 RHQ562 RHQ570 ;
run ;

proc freq data=pretlib.project ;
where lbxtccd=1 and LBXCRPcd=1 and RHQ570 eq 1 ;
table RHD080 ;
run ;
* JUST MAKE ALL OUTCOME VARIABLES HAVE 2 VALUES. HIGH AND LOW FOR PROC LOGISTIC MODEL ;

*RUN PROC UNIVARIATE FOR TRIGLYCERIDES. IF THE DISTRIBUTION IS NOT NORMAL USE A LOG TRANSFORM ;
*USE KEEP STATEMENT AND IN ;
proc freq data=pretlib.project ;
where lbxtccd=. and R550 eq 1 ;
table lbxtccd ;
run ;


*MODEL ANALYSIS ; *RUN ALL SURVEY LOGISTIC ;


*TOTAL CHOLESTEROL ;
*PRE-MENOPAUSAL REDUCED MODEL ;
proc logistic data=pretlib.project ;
where RHQ550 eq 1 ;
model totcholest(Event="High")=RHQ554 RHQ562 RHQ570 ; *COLLAPSE THEM ALL INTO ONE CATEGORY ;
run ; 
*PRE-MENOPAUSAL ADJUSTED FOR AGE ;
proc logistic data=pretlib.project ;
where RHQ550 eq 1 ;
model totcholest(Event="High")=RHQ554 RHQ562 RHQ570 RIDAGEYR   ; 
run ; 
*ADJUSTED FOR RACE AND PREGNANCY STATUS ;
proc logistic data=pretlib.project ;
where RHQ550 eq 1 ;
model totcholest(Event="High")=RHQ554 RHQ562 RHQ570 RIDAGEYR RIDRETH1 RIDEXPRG ; 
run ; 
*POST-MENOPAUSAL REDUCED MODEL ;
proc logistic data=pretlib.project ;
where RHQ550 eq 2 ;
model totcholest(Event="High")=RHQ554 RHQ562 RHQ570 ; 
run ; 
*PRE-MENOPAUSAL ADJUSTED FOR AGE ;
proc logistic data=pretlib.project ;
where RHQ550 eq 2 ;
model totcholest(Event="High")=RHQ554 RHQ562 RHQ570 RIDAGEYR   ; 
run ; 

*ADJUSTED FOR PREGNANCY STATUS AND RACE ;
proc logistic data=pretlib.project ;
where RHQ550 eq 2 ;
model totcholest(Event="High")=RHQ554 RHQ562 RHQ570 RIDAGEYR RIDRETH1 RIDEXPRG  ; 
run ; 

proc freq data=pretlib.project ;
tables RHQ554 RHQ562 RHQ570 ;
run ;
*IF RHQ554 eq 1 or RHQ562 eq 1 or RHQ570 eq 1 then create new variable=1 else new variable=0 ;

*CRP ;
*PRE-MENOPAUSAL ;
proc logistic data=pretlib.project ;
where RHQ550 eq 1 ;
model CRP=pilluse ; 
run ; 
*ADJUSTED FOR AGE ;
proc logistic data=pretlib.project ;
where RHQ550 eq 1 ;
model CRP=RHQ554 RHQ562 RHQ570 RIDAGEYR ; 
run ; 
*ADJUSTED FOR RACE AND PREGNANCY STATUS ;
proc logistic data=pretlib.project ;
where RHQ550 eq 1 ;
model CRP=RHQ554 RHQ562 RHQ570 RIDAGEYR RIDRETH1 RIDEXPRG ; 
run ;

*POST-MENOPAUSAL ;
proc logistic data=pretlib.project ;
where RHQ550 eq 2 ;
model CRP=RHQ554 RHQ562 RHQ570 ; 
run ; 
*ADJUSTED FOR AGE ;
proc logistic data=pretlib.project ;
where RHQ550 eq 2 ;
model CRP=RHQ554 RHQ562 RHQ570 RIDAGEYR ; 
run ; 

*ADJUSTED FOR RACE AND PREGNANCY STATUS ;
proc logistic data=pretlib.project ;
where RHQ550 eq 2 ;
model CRP=RHQ554 RHQ562 RHQ570 RIDAGEYR RIDEXPRG RIDRETH1 ; 
run ;





*HDL ;
*PRE-MENOPAUSAL ;
proc logistic data=pretlib.project ;
where RHQ550 eq 1 ;
model HDL(Event="Low")=RHQ554 RHQ562 RHQ570  ; 
run ; 

*ADJUSTED FOR AGE;
proc logistic data=pretlib.project ;
where RHQ550 eq 1 ;
model HDL(Event="Low")=RHQ554 RHQ562 RHQ570 RIDAGEYR ; 
run ; 
*ADJUSTED FOR RACE AND PREGNANCY STATUS ;
proc logistic data=pretlib.project ;
where RHQ550 eq 1 ;
model HDL(Event="Low")=RHQ554 RHQ562 RHQ570 RIDAGEYR RIDEXPRG RIDRETH1 ; 
run ; 


*POST-MENOPAUSAL ;
proc logistic data=pretlib.project ;
where RHQ550 eq 2 ;
model HDL(Event="Low")=RHQ554 RHQ562 RHQ570 ; 
run ; 
*ADJUSTED FOR AGE ;
proc logistic data=pretlib.project ;
where RHQ550 eq 2 ;
model HDL(Event="Low")=RHQ554 RHQ562 RHQ570 RIDAGEYR ; 
run ; 
*ADJUSTED FOR RACE AND PREGNANCY STATUS ;
proc logistic data=pretlib.project ;
where RHQ550 eq 2 ;
model HDL(Event="Low")=RHQ554 RHQ562 RHQ570 RIDAGEYR RIDEXPRG RIDRETH1 ; 
run ; 




*CARDIO VARIABLE QUESTIONNAIRE ;
*PRE-MENOPAUSAL ;
proc logistic data=pretlib.project ;
where RHQ550 eq 1 ;
model CDQ001=RHQ554 RHQ562 RHQ570 ; 
run ; 
*AGE ADJUSTED ;
proc logistic data=pretlib.project ;
where RHQ550 eq 1 ;
model CDQ001=RHQ554 RHQ562 RHQ570 RIDAGEYR ; 
run ; 
*ADJUSTED FOR PREGNANCY STATUS AND RACE ;
proc logistic data=pretlib.project ;
where RHQ550 eq 1 ;
model CDQ001=RHQ554 RHQ562 RHQ570 RIDAGEYR RIDRETH1 RIDEXPRG ; 
run ; 


*POST-MENOPAUSAL ;
proc logistic data=pretlib.project ;
where RHQ550 eq 2 ;
model CDQ001=RHQ554 RHQ562 RHQ570 ; 
run ; 
*AGE ADJUSTED;
proc logistic data=pretlib.project ;
where RHQ550 eq 2 ;
model CDQ001=RHQ554 RHQ562 RHQ570 RIDAGEYR ; 
run ; 
*RACE AND PREGNANCY STATUS ;
proc logistic data=pretlib.project ;
where RHQ550 eq 2 ;
model CDQ001=RHQ554 RHQ562 RHQ570 RIDAGEYR RIDEXPRG RIDRETH1 ; 
run ; 

proc freq data=pretlib.project ;
tables pilluse*RHQ550 /chisq missing ;
run ;

*USE SURVEY LOGISTIC ;
