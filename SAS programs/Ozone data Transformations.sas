

data air;
input ozone temp;
cards;
41 67
36 72
12 74
18 62
28 66
23 65
19 59
8 61
7 74
16 69
11 66
14 68
18 58
14 64
34 66
6 57
30 68
11 62
1 59
11 73
4 61
32 61
23 67
45 81
115 79
37 76
29 82
71 90
39 87
23 82
21 77
37 72
20 65
12 73
13 76
135 84
49 85
32 81
64 83
40 83
77 88
97 92
97 92
85 89
10 73
27 81
7 80
48 81
35 82
61 84
79 87
63 85
16 74
80 86
108 85
20 82
52 86
82 88
50 86
64 83
59 81
39 81
9 81
16 82
78 86
35 85
66 87
122 89
89 90
110 90
44 86
28 82
65 80
22 77
59 79
23 76
31 78
44 78
21 77
9 72
45 79
168 81
73 86
76 97
118 94
84 96
85 94
96 91
78 92
73 93
91 93
47 87
32 84
20 80
23 78
21 75
24 73
44 81
21 76
28 77
9 71
13 71
46 78
18 67
13 76
24 68
16 82
13 64
23 71
36 81
7 69
14 63
30 70
14 75
18 76
20 68
;

*QQplot ;


proc gplot data= air ;
symbol value=dot ;
plot ozone*temp ;
run ;

proc reg data=air ;
model ozone=temp /noprint ;
plot ozone*temp ;
run ;

proc reg data= air ;
model ozone= temp /noprint;
output out=air_out p=pred r=resid student=sresid ;
run ;

proc gplot data=air_out ;
title1 'Diagnostic Residual Plots';
symbol value=dot ;
plot resid*pred resid*temp sresid*temp ; ;
run ;

proc univariate data=air_out;
var resid ;
title1 'Residual Plots';
title2 'QQ Plot' ;
qqplot resid ;
run ;

proc univariate data=air_out ;
var resid ;
title1 'Residual Plots' ;
title2 'Residual Histogram Plot' ;
histogram resid /normal 
ctext=blue ;
run ; 

data air_trans ;
set air ;
logtemp= log(temp);
sqrt_temp= sqrt(temp) ;
inc_temp= temp*temp;
logozone=log(ozone);
sqrt_ozone= sqrt(ozone) ;
inc_ozone=ozone*ozone ;
run ;

proc gplot data=air_trans ;
title2 'Transformations of Residuals' ;
plot ozone*logtemp ;
plot ozone*sqrt_temp ;
plot ozone*inc_temp ; 
plot logozone*temp ; *CORRECT TRANSFORMATION ;
plot sqrt_ozone*temp ;
plot inc_ozone*temp ;
run ; 

proc reg data=air_trans ;
model logozone=temp /noprint ;
plot logozone*temp ;
run ;

*QUESTION3 ;

data airmerge ;
input logozone temp ;
datalines ;
. 85 
;
run ;

data aircombine ;
set airmerge air_trans ;
run ;

proc reg data= aircombine ;
model logozone=temp / CLI alpha=.05 ; 
run ;

*Question 4 ;
proc import datafile="C:\Users\Geoffrey\Documents\SAS_620\Week 2\FEV\homework4.xlsx" 
dbms=excel out=datafile ;
run ;

proc reg data=datafile ; 
model fy=fx ;
plot fy*fx ;
run ;

proc reg data= datafile ;
model fy=fx /noprint;
output out=datafile_out p=pred r=resid student=sresid ;
run ;

proc gplot data=datafile_out ;
title1 'Diagnostic Residual Plots question 3';
symbol value=dot ;
plot resid*pred resid*fx sresid*fx ; ;
run ;

proc univariate data=datafile_out;
var resid ;
title1 'Residual Plots';
title2 'QQ Plot' ;
qqplot resid ;
run ;

proc univariate data=datafile_out ;
var resid ;
title1 'Residual Plots' ;
title2 'Residual Histogram Plot' ;
histogram resid /normal 
ctext=blue ;
run ;


data datafile_trans ;
set datafile ;
logfx= log(fx);
sqrt_fx= sqrt(fx) ;
fx_sqr= fx*fx;
logfy=log(fy) ;
sqrt_fy=sqrt(fy);
fy_sqr=fy*fy ;
run ;

proc gplot data=datafile_trans ;
title2 'Transformations of Residuals Question 3' ;
plot fy*logfx ;
plot fy*sqrt_fx ;
plot fy*fx_sqr ; 
plot logfy*fx ;*CORRECT TRANSFORMATION ;
plot sqrt_fy*fx ;
plot fy_sqr*fx ;
plot logfy*logfx ;
plot sqrt_fy*sqrt_fx ;
plot fy_sqr*fx_sqr ;
run ; 

proc reg data=datafile_trans ; 
model logfy=fx ;
title 'TRANSFORMATION OF 4D' ;
plot logfy*fx ;
run ;

