libname data "C:\Users\Geoff\Desktop\BRFSS\SAScode";
libname brfss "C:\Users\Geoff\Desktop\BRFSS\BRFSS2010";

data data.set0 ;
	set brfss.sasdata10 (where = (_state in (11 15 32 50 55))) ;

	/*clean outcome variables*/
	if cvdinfr4 = 1 or cvdcrhd4 = 1 or cvdstrk3 = 1 then cvd = 1;
		else if cvdinfr4 = 2 and cvdcrhd4 = 2 and cvdstrk3 = 2 then cvd = 0;
		else cvd = .;

	/*clean exposure variables*/
	if acetouch in (2 3) or acetthem in (2 3) or acehvsex in (2 3) then sexabuse = 1;
		else if acetouch = 1 and acetthem = 1 and acehvsex = 1 then sexabuse = 0;
		else sexabuse = .;
	if acepunch in (2 3) or acehurt in (2 3) then phyabuse = 1;
		else if acepunch = 1 and acehurt = 1 then phyabuse = 0;
		else phyabuse =.;
	if acedrink = 1 or acedrugs = 1 then viceabuse = 1;
		else if acedrink = 2 and acedrugs = 2 then viceabuse = 0;
		else viceabuse =.;
	if acedivrc = 1 then divorce = 1;
		else if acedivrc = 2 then divorce = 0;
		else divorce =.;
	if aceprisn = 1 then prison = 1;
		else if aceprisn = 2 then prison = 0;
		else prison =.;
	if acedeprs = 1 then depress = 1 ;
		else if acedeprs = 2 then depress = 0;
		else depress = .;
	if aceswear in (2 3) then swear = 1 ;
		else if aceswear = 1 then swear = 0 ;
		else swear = . ;
	if _age_g in(1 2) then _age_g_new = 1;
		else if _age_g = 3 then _age_g_new = 2;
		else if _age_g = 4 then _age_g_new = 3;
		else if _age_g = 5 then _age_g_new = 4;
		else if _age_g = 6 then _age_g_new = 5;

	/*clean counder variables*/
	if _state = 11 then state = 0;
		else if _state = 50 then state = 1;
		else if _state = 32 then state = 2;
		else if _state = 15 then state = 3;
		else if _state = 55 then state = 4;
		else if _state = 42 then state = 5;
	if _educag =9 then _educag = .;
	if hlthplan = 1 then insura = 1;
		else if hlthplan = 2 then insura = 0;
		else hlthplan = .;
	if _incomg in (77 99) then _incomg = .;

	disorders = sexabuse+phyabuse+viceabuse+divorce+prison+depress+swear;
	if disorders = 0 then disscore = 0;
		else if disorders in (1 2 3) then disscore = 1;
		else disscore = 2;

run;

data data.set1;
	set data.set0 (where = (cvd ne . and sexabuse ne . and phyabuse ne . and 
									viceabuse ne . and divorce ne . and prison ne . and depress ne . and
									swear ne . and _educag ne . and insura ne . and _incomg ne 9)) ;;
run;

proc surveyfreq data = data.set1;
	tables _state*cvd/clwt cl row nowt nostd chisq;
	strata _ststr;
	cluster _psu;
	weight _finalwt;
run;

proc surveyfreq data = data.set1;
	tables _age_g_new*cvd/clwt cl row nowt nostd chisq;
	strata _ststr;
	cluster _psu;
	weight _finalwt;
run;

proc surveyfreq data = data.set1;
	tables sex*cvd/clwt cl row nowt nostd chisq;
	strata _ststr;
	cluster _psu;
	weight _finalwt;
run;

proc surveyfreq data = data.set1;
	tables sexabuse*cvd/clwt cl row nowt nostd chisq;
	strata _ststr;
	cluster _psu;
	weight _finalwt;
run;

proc surveyfreq data = data.set1;
	tables phyabuse*cvd/clwt cl row nowt nostd chisq;
	strata _ststr;
	cluster _psu;
	weight _finalwt;
run;

proc surveyfreq data = data.set1;
	tables viceabuse*cvd/clwt cl row nowt nostd chisq;
	strata _ststr;
	cluster _psu;
	weight _finalwt;
run;

proc surveyfreq data = data.set1;
	tables divorce*cvd/clwt cl row nowt nostd chisq;
	strata _ststr;
	cluster _psu;
	weight _finalwt;
run;

proc surveyfreq data = data.set1;
	tables prison*cvd/clwt cl row nowt nostd chisq;
	strata _ststr;
	cluster _psu;
	weight _finalwt;
run;

proc surveyfreq data = data.set1;
	tables depress*cvd/clwt cl row nowt nostd chisq;
	strata _ststr;
	cluster _psu;
	weight _finalwt;
run;

proc surveyfreq data = data.set1;
	tables swear*cvd/clwt cl row nowt nostd chisq;
	strata _ststr;
	cluster _psu;
	weight _finalwt;
run;

proc surveyfreq data = data.set1;
	tables _educag*cvd/clwt cl row nowt nostd chisq;
	strata _ststr;
	cluster _psu;
	weight _finalwt;
run;

proc surveyfreq data = data.set1;
	tables insura*cvd/clwt cl row nowt nostd chisq;
	strata _ststr;
	cluster _psu;
	weight _finalwt;
run;

proc surveyfreq data = data.set1;
	tables _incomg*cvd/clwt cl row nowt nostd chisq;
	strata _ststr;
	cluster _psu;
	weight _finalwt;
run;

proc freq data = data.set1;
	table disscore;
run;

proc surveyfreq data = data.set1;
	tables disscore*cvd/clwt cl row nowt nostd chisq;
	strata _ststr;
	cluster _psu;
	weight _finalwt;
run;








data data.set1;
	set data.set0 (where = (cvd ne . and sexabuse ne . and phyabuse ne . and 
									viceabuse ne . and divorce ne . and prison ne . and depress ne . and
									swear ne . and _educag ne . and insura ne . and _incomg ne 9)) ;;
run;

proc contents data = data.set1;
run;

%macro decpt (var = );
proc freq data = data.set1 ;
	tables &var * cvd / chisq out = &var._dec (rename = (&var = variable));
run; 

proc sort data = &var._dec;
	by variable;
run;

proc transpose data = &var._dec out = &var._dec_trans;
	id cvd;
	by variable;
	var count;
run;

data &var._dec_trans (drop = _name_ _label_);
	set &var._dec_trans;
	total = _0+_1;
	pct_0 = _0/total;
	pct_1 = _1/total;
run;

proc print data = &var._dec_trans;
run;
%mend decpt;

%decpt (var = _state);
%decpt (var = _age_g_new);
%decpt (var = sex);
%decpt (var = sexabuse);
%decpt (var = phyabuse);
%decpt (var = viceabuse);
%decpt (var = divorce);
%decpt (var = prison);
%decpt (var = depress);
%decpt (var = swear);
%decpt (var = _educag);
%decpt (var = insura);
%decpt (var = _incomg);

data data.set0_dcpt;
	set _state_dec_trans
		_age_g_new_dec_trans
		sex_dec_trans
		sexabuse_dec_trans
		phyabuse_dec_trans
		viceabuse_dec_trans
		divorce_dec_trans
		prison_dec_trans
		depress_dec_trans
		swear_dec_trans
		_educag_dec_trans
		insura_dec_trans
		_incomg_dec_trans;
run;

proc print data = data.set0_dcpt;
run;

data data.set2;
	set data.set1;
	disorders = sexabuse+phyabuse+viceaburse+divorce+prison+depress+swear;
	if disorders = 0 then disscore = 0;
		else if disorders in (1 2 3) then disscore = 1;
		else disscore = 2;
run;

/*proc surveymeans data = data.set2;*/
/*	var age bmi;*/
/*	strata _ststr;*/
/*	cluster _psu;*/
/*	weight _finalwt;*/
/*run;*/
/**/
/*proc surveyfreq data = ....;*/
/*	tables race1*dm/clwt cl row nowt nostd chisq;*/
/*	strata _ststr;*/
/*	cluster _psu;*/
/*	weight _finalwt;*/
/*run;*/


%macro dc (var = );
data state1;
	set data.set1;
	where _state = 11;
run;

proc surveylogistic data=state1;
	strata _ststr;
	cluster _psu;
	weight _finalwt;
	class &var (ref = first) 
			_age_g_new (ref = first) sex (ref = last) _incomg (ref = first)  _educag (ref = first) /PARAM=REF;
	model cvd (event ="1") = &var ;
run;

proc surveylogistic data=state1;
	strata _ststr;
	cluster _psu;
	weight _finalwt;
	class &var (ref = first) 
			_age_g_new (ref = first) sex (ref = last) _incomg (ref = first)  _educag (ref = first) /PARAM=REF;
	model cvd (event ="1") = &var 
				_age_g_new sex _incomg  _educag;
run;
%mend dc;

%dc (var = sexabuse);
%dc (var = phyabuse);
%dc (var = viceabuse);
%dc (var = divorce);
%dc (var = prison);
%dc (var = depress);
%dc (var = swear);
%dc (var = disscore);

%macro ha (var = );
data state2;
	set data.set1;
	where _state = 15;
run;

proc surveylogistic data=state2;
	strata _ststr;
	cluster _psu;
	weight _finalwt;
	class &var (ref = first) 
			_age_g_new (ref = first) sex (ref = last) _incomg (ref = first)  _educag (ref = first) /PARAM=REF;
	model cvd (event ="1") = &var ;
run;

proc surveylogistic data=state2;
	strata _ststr;
	cluster _psu;
	weight _finalwt;
	class &var (ref = first) 
			_age_g_new (ref = first) sex (ref = last) _incomg (ref = first)  _educag (ref = first) /PARAM=REF;
	model cvd (event ="1") = &var 
				_age_g_new sex _incomg  _educag;
run;
%mend ha;

%ha (var = sexabuse);
%ha (var = phyabuse);
%ha (var = viceabuse);
%ha (var = divorce);
%ha (var = prison);
%ha (var = depress);
%ha (var = swear);
%ha (var = disscore);

%macro ne (var = );
data state3;
	set data.set1;
	where _state = 32;
run;

proc surveylogistic data=state3;
	strata _ststr;
	cluster _psu;
	weight _finalwt;
	class &var (ref = first) 
			_age_g_new (ref = first) sex (ref = last) _incomg (ref = first)  _educag (ref = first) /PARAM=REF;
	model cvd (event ="1") = &var ;
run;

proc surveylogistic data=state3;
	strata _ststr;
	cluster _psu;
	weight _finalwt;
	class &var (ref = first) 
			_age_g_new (ref = first) sex (ref = last) _incomg (ref = first)  _educag (ref = first) /PARAM=REF;
	model cvd (event ="1") = &var 
				_age_g_new sex _incomg  _educag;
run;
%mend ne;

%ne (var = sexabuse);
%ne (var = phyabuse);
%ne (var = viceabuse);
%ne (var = divorce);
%ne (var = prison);
%ne (var = depress);
%ne (var = swear);
%ne (var = disscore);

%macro ve (var = );
data state4;
	set data.set1;
	where _state = 50;
run;

proc surveylogistic data=state4;
	strata _ststr;
	cluster _psu;
	weight _finalwt;
	class &var (ref = first) 
			_age_g_new (ref = first) sex (ref = last) _incomg (ref = first)  _educag (ref = first) /PARAM=REF;
	model cvd (event ="1") = &var ;
run;

proc surveylogistic data=state4;
	strata _ststr;
	cluster _psu;
	weight _finalwt;
	class &var (ref = first) 
			_age_g_new (ref = first) sex (ref = last) _incomg (ref = first)  _educag (ref = first) /PARAM=REF;
	model cvd (event ="1") = &var 
				_age_g_new sex _incomg  _educag;
run;
%mend ve;

%ve (var = sexabuse);
%ve (var = phyabuse);
%ve (var = viceabuse);
%ve (var = divorce);
%ve (var = prison);
%ve (var = depress);
%ve (var = swear);
%ve (var = disscore);

%macro wi (var = );
data state5;
	set data.set1;
	where _state = 55;
run;

proc surveylogistic data=state5;
	strata _ststr;
	cluster _psu;
	weight _finalwt;
	class &var (ref = first) 
			_age_g_new (ref = first) sex (ref = last) _incomg (ref = first)  _educag (ref = first) /PARAM=REF;
	model cvd (event ="1") = &var ;
run;

proc surveylogistic data=state5;
	strata _ststr;
	cluster _psu;
	weight _finalwt;
	class &var (ref = first) 
			_age_g_new (ref = first) sex (ref = last) _incomg (ref = first)  _educag (ref = first) /PARAM=REF;
	model cvd (event ="1") = &var 
				_age_g_new sex _incomg  _educag;
run;
%mend wi;

%wi (var = sexabuse);
%wi (var = phyabuse);
%wi (var = viceabuse);
%wi (var = divorce);
%wi (var = prison);
%wi (var = depress);
%wi (var = swear);
%wi (var = disscore);
