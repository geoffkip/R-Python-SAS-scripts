libname pretlib "C:\Users\Geoffrey\Dropbox\CBMP data analysis" ;
proc import datafile='C:\Users\Geoffrey\Dropbox\CBMP data analysis/deidentified old ed data.xlsx' DBMS=xlsx out=test; 
run ;
data pretlib.CBMP ;
set test ;
drop patient_name staff ;
birthdt=input(dob,anydtdte25.); 
if birthdt ne . then age= INT(('02FEB2015'd - birthdt)/365.25);
format birthdt mmddyy10. ;
run; 
proc print data=pretlib.CBMP ;
run; 
proc contents data=pretlib.CBMP varnum ;
run ;
proc means data=pretlib.CBMP ;
run ;

