#delimit ;
clear;
set more off;
cap log close;
log using ${datapath}\rotoku.log, replace;

cap program drop cleaning;
program define cleaning;
replace birth_year = birth_year if birth_nengo==0;
replace birth_year = birth_year + 1867 if birth_nengo==1;
replace birth_year = birth_year + 1912 if birth_nengo==2;
replace birth_year = birth_year + 1925 if birth_nengo==3;
replace birth_year = birth_year + 1988 if birth_nengo==4;
drop if birth_year==.;
assert birth_year<=3000;
egen number=count(sex), by(prefecture district hhunit birth_year birth_month sex);
keep if number==1;
drop number;
replace nu15_03=0 if n15==0;
replace nu15_46=0 if n15==0;
replace nu15_79=0 if n15==0;
replace nu15_1012=0 if n15==0;
replace nu15_1314=0 if n15==0;
sort prefecture district hhunit birth_year birth_month sex;
end;

forvalues y =2/6 {;
forvalues m=1/12 {;
local s=2000+`y';
clear;
quietly infix year 14-17 month 18-19 prefecture 22-23 
district 24-26 hhunit 27-29 hhid 30-31 lineno 32-33 
n15 34-35 nu15_03 36 nu15_46 37 nu15_79 38 nu15_1012 39 nu15_1314 40 
sex 41 rel 42 birth_nengo 43 birth_year 44-47 birth_month 48-49
mar 50 empstat 51 jobpref 52 rsn 53 hour 54-56 class 57 
ind 58-59 occ 60-61 size 62 change 63 emptype 73 educ 111 inc 112-113 age 145-147
weight 320-334
using ${datapath}\rotoku\L3_`s'_RCD_AD1_2JIRIYOU-`m'.TXT;
qui cleaning;
save ${datapath}\rotoku\lfssp_`y'_`m', replace;
};};


forvalues y =7/10 {;
forvalues m =1/12 {;
local s=2000+`y';
clear;
if `m'<=9 {;
quietly infix year 14-17 month 18-19 prefecture 22-23 
district 24-26 hhunit 27-29 hhid 30-31 lineno 32-33 
n15 34-35 nu15_03 36 nu15_46 37 nu15_79 38 nu15_1012 39 nu15_1314 40 
sex 41 rel 42 birth_nengo 43 birth_year 44-47 birth_month 48-49
mar 50 empstat 51 jobpref 52 rsn 53 hour 54-56 class 57 
ind 58-59 occ 60-61 size 62 change 63 emptype 73 educ 111 inc 112-113 age 145-147
weight 320-334
using ${datapath}\rotoku\L3_`s'_RCD_AD1_2JIRIYOU-0`m'_A.TXT;
qui cleaning;
save ${datapath}\rotoku\lfssp_`y'_`m', replace;
};
if `m'>=10 {;
quietly infix year 14-17 month 18-19 prefecture 22-23 
district 24-26 hhunit 27-29 hhid 30-31 lineno 32-33 
n15 34-35 nu15_03 36 nu15_46 37 nu15_79 38 nu15_1012 39 nu15_1314 40 
sex 41 rel 42 birth_nengo 43 birth_year 44-47 birth_month 48-49
mar 50 empstat 51 jobpref 52 rsn 53 hour 54-56 class 57 
ind 58-59 occ 60-61 size 62 change 63 emptype 73 educ 111 inc 112-113 age 145-147
weight 320-334
using ${datapath}\rotoku\L3_`s'_RCD_AD1_2JIRIYOU-`m'_A.TXT;
qui cleaning;
save ${datapath}\rotoku\lfssp_`y'_`m', replace;
};
};
};

forvalues y =11/12 {;
forvalues m =1/12 {;
local s=2000+`y';
clear;
if `m'<=9 {;
quietly infix year 14-17 month 18-19 prefecture 22-23 
district 24-26 hhunit 27-29 hhid 30-31 lineno 32-33 
n15 34-35 nu15_03 36 nu15_46 37 nu15_79 38 nu15_1012 39 nu15_1314 40 
sex 41 rel 42 birth_nengo 43 birth_year 44-47 birth_month 48-49
mar 50 empstat 51 jobpref 52 rsn 53 hour 54-56 class 57 
ind 58-59 occ 60-61 size 62 change 63 emptype 73 educ 111 inc 112-113 age 145-147
weight 320-334
using ${datapath}\rotoku\L3_`s'_RCD_AD1-0`m'_A.TXT;
qui cleaning;
save ${datapath}\rotoku\lfssp_`y'_`m', replace;
};
if `m'>=10 {;
quietly infix year 14-17 month 18-19 prefecture 22-23 
district 24-26 hhunit 27-29 hhid 30-31 lineno 32-33 
n15 34-35 nu15_03 36 nu15_46 37 nu15_79 38 nu15_1012 39 nu15_1314 40 
sex 41 rel 42 birth_nengo 43 birth_year 44-47 birth_month 48-49
mar 50 empstat 51 jobpref 52 rsn 53 hour 54-56 class 57 
ind 58-59 occ 60-61 size 62 change 63 emptype 73 educ 111 inc 112-113 age 145-147
weight 320-334
using ${datapath}\rotoku\L3_`s'_RCD_AD1-`m'_A.TXT;
qui cleaning;
save ${datapath}\rotoku\lfssp_`y'_`m', replace;
};
};
};

forvalues y =13/16 {;
forvalues m =1/12 {;
local s=2000+`y';
clear;
if `m'<=9 {;
quietly infix year 14-17 month 18-19 prefecture 22-23 
district 24-26 hhunit 27-29 hhid 30-31 lineno 32-33 
n15 34-35 nu15_03 36 nu15_46 37 nu15_79 38 nu15_1012 39 nu15_1314 40 
sex 41 rel 42 birth_nengo 43 birth_year 44-47 birth_month 48-49
mar 50 empstat 51 jobpref 52 rsn 53 hour 55-57 class 60 emptype 61 
ind 62-63 occ 64-65 size 66 change 68 educ 121 inc 122-123 age 155-157
weight 345-359
using ${datapath}\rotoku\L3_`s'_RCD_AD1-0`m'_A.TXT;
qui cleaning;
save ${datapath}\rotoku\lfssp_`y'_`m', replace;
};
if `m'>=10 {;
quietly infix year 14-17 month 18-19 prefecture 22-23 
district 24-26 hhunit 27-29 hhid 30-31 lineno 32-33 
n15 34-35 nu15_03 36 nu15_46 37 nu15_79 38 nu15_1012 39 nu15_1314 40 
sex 41 rel 42 birth_nengo 43 birth_year 44-47 birth_month 48-49
mar 50 empstat 51 jobpref 52 rsn 53 hour 55-57 class 60 emptype 61 
ind 62-63 occ 64-65 size 66 change 68 educ 121 inc 122-123 age 155-157
weight 345-359
using ${datapath}\rotoku\L3_`s'_RCD_AD1-`m'_A.TXT;
qui cleaning;
save ${datapath}\rotoku\lfssp_`y'_`m', replace;
};
};
};


clear;
use ${datapath}\rotoku\lfssp_2_1.dta;

forvalues y=2/16 {;
forvalues m=1/12 {;
if ~(`y'==2&`m'==1) {;
append using ${datapath}\rotoku\lfssp_`y'_`m'.dta;
};
};
};

save ${datapath}\rotoku\rotoku2002_2016, replace;


log close;
exit;
