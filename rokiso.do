#delimit ;
clear;
set more off;
cap log close;
log using ${datapath}\rokiso.log, replace;

cap program drop cleaning;
program define cleaning;
gen birth_year=.;
replace birth_year = birth_year_temp if birth_nengo==0;
replace birth_year = birth_year_temp + 1867 if birth_nengo==1;
replace birth_year = birth_year_temp + 1912 if birth_nengo==2;
replace birth_year = birth_year_temp + 1925 if birth_nengo==3;
replace birth_year = birth_year_temp + 1988 if birth_nengo==4;
drop if birth_year==.;
drop birth_year_temp;
drop birth_nengo;
egen number=count(sex), by(prefecture district hhunit birth_year birth_month sex);
keep if number==1;
drop number;
sort prefecture district hhunit birth_year birth_month sex;
end;

forvalues y =2/6 {;
forvalues m=1/12 {;
local s=2000+`y';
clear;
quietly infix year 7-10 month 11-12 prefecture 15-16 
district 17-19 hhunit 20-22 hhid 23-24  
n15 27-28 nu15_03 33 nu15_46 34 nu15_79 35 nu15_1012 36 nu15_1314 37 
sex 38 rel 39 birth_nengo 40 birth_year_temp 41-44 birth_month 45-46 age 47-49
mar 50 empstat 51 jobpref 52 rsn 53 hour 54-56 class 57 
ind 59-60 occ 61-62 size 63 change 64 weight 134-147
using ${datapath}\rokiso\L2_`s'_RCD_CIX-`y'`m'.TXT;
cleaning;
save ${datapath}\rokiso\kiso_`y'_`m', replace;
};};

forvalues y =7/8 {;
forvalues m=1/12 {;
local s=2000+`y';
clear;
if `m'<=9 {;
quietly infix year 7-10 month 11-12 prefecture 15-16 
district 17-19 hhunit 20-22 hhid 23-24  
n15 27-28 nu15_03 33 nu15_46 34 nu15_79 35 nu15_1012 36 nu15_1314 37 
sex 38 rel 39 birth_nengo 40 birth_year_temp 41-44 birth_month 45-46 age 47-49
mar 50 empstat 51 jobpref 52 rsn 53 hour 54-56 class 57 
ind 59-60 occ 61-62 size 63 change 64 weight 134-147 
using ${datapath}\rokiso\L2_`s'_RCD_CIX-0`y'0`m'_A.TXT;
qui cleaning;
save ${datapath}\rokiso\kiso_`y'_`m', replace;
};
if `m'>=10 {;
quietly infix year 7-10 month 11-12 prefecture 15-16 
district 17-19 hhunit 20-22 hhid 23-24  
n15 27-28 nu15_03 33 nu15_46 34 nu15_79 35 nu15_1012 36 nu15_1314 37 
sex 38 rel 39 birth_nengo 40 birth_year_temp 41-44 birth_month 45-46 age 47-49
mar 50 empstat 51 jobpref 52 rsn 53 hour 54-56 class 57 
ind 59-60 occ 61-62 size 63 change 64 weight 134-147
using ${datapath}\rokiso\L2_`s'_RCD_CIX-0`y'`m'_A.TXT;
qui cleaning;
save ${datapath}\rokiso\kiso_`y'_`m', replace;
};
};};

local y =9;
forvalues m=1/12 {;
local s=2000+`y';
clear;
if `m'<=9 {;
quietly infix year 7-10 month 11-12 prefecture 15-16 
district 17-19 hhunit 20-22 hhid 23-24  
n15 27-28 nu15_03 33 nu15_46 34 nu15_79 35 nu15_1012 36 nu15_1314 37
sex 38 rel 39 birth_nengo 40 birth_year_temp 41-44 birth_month 45-46 
age 47-49 mar 50 empstat 51 hour 54-56 class 57 
ind 59-60 occ 61-62 size 63 weight 134-147 
using ${datapath}\rokiso\L2_`s'_RCD_CIX-0`y'0`m'_A.TXT;
qui cleaning;
save ${datapath}\rokiso\kiso_`y'_`m', replace;
};
if `m'>=10 {;
quietly infix year 7-10 month 11-12 prefecture 15-16 
district 17-19 hhunit 20-22 hhid 23-24  
n15 27-28 nu15_03 33 nu15_46 34 nu15_79 35 nu15_1012 36 nu15_1314 37
sex 38 rel 39 birth_nengo 40 birth_year_temp 41-44 birth_month 45-46 
age 47-49 mar 50 empstat 51 hour 54-56 class 57 
ind 59-60 occ 61-62 size 63 weight 134-147
using ${datapath}\rokiso\L2_`s'_RCD_CIX-0`y'`m'_A.TXT;
qui cleaning;
save ${datapath}\rokiso\kiso_`y'_`m', replace;
};
};

local y = 10;
forvalues m=1/12 {;
local s=2000+`y';
clear;
if `m'<=9 {;
quietly infix year 7-10 month 11-12 prefecture 15-16 
district 17-19 hhunit 20-22 hhid 23-24  
n15 27-28 nu15_03 33 nu15_46 34 nu15_79 35 nu15_1012 36 nu15_1314 37
sex 38 rel 39 birth_nengo 40 birth_year_temp 41-44 birth_month 45-46 
age 47-49 mar 50 empstat 51 hour 54-56 class 57 
ind 59-60 occ 61-62 size 63 weight 134-147  
using ${datapath}\rokiso\L2_`s'_RCD_CIX-`y'0`m'_A.TXT;
qui cleaning;
save ${datapath}\rokiso\kiso_`y'_`m', replace;
};
if `m'>=10 {;
quietly infix year 7-10 month 11-12 prefecture 15-16 
district 17-19 hhunit 20-22 hhid 23-24  
n15 27-28 nu15_03 33 nu15_46 34 nu15_79 35 nu15_1012 36 nu15_1314 37
sex 38 rel 39 birth_nengo 40 birth_year_temp 41-44 birth_month 45-46 
age 47-49 mar 50 empstat 51 hour 54-56 class 57 
ind 59-60 occ 61-62 size 63 weight 134-147
using ${datapath}\rokiso\L2_`s'_RCD_CIX-`y'`m'_A.TXT;
qui cleaning;
save ${datapath}\rokiso\kiso_`y'_`m', replace;
};
};

forvalues y =11/12 {;
forvalues m=1/12 {;
local s=2000+`y';
clear;
if `m'<=9 {;
quietly infix year 7-10 month 11-12 prefecture 15-16 
district 17-19 hhunit 20-22 hhid 23-24  
n15 27-28 nu15_03 33 nu15_46 34 nu15_79 35 nu15_1012 36 nu15_1314 37
sex 38 rel 39 birth_nengo 40 birth_year_temp 41-44 birth_month 45-46 
age 47-49 mar 50 empstat 51 hour 54-56 class 57 
ind 59-60 occ 61-62 size 63 weight 134-147
using ${datapath}\rokiso\L2_`s'_RCD_CIX-`y'0`m'_A.TXT;
qui cleaning;
save ${datapath}\rokiso\kiso_`y'_`m', replace;
};
if `m'>=10 {;
quietly infix year 7-10 month 11-12 prefecture 15-16 
district 17-19 hhunit 20-22 hhid 23-24  
n15 27-28 nu15_03 33 nu15_46 34 nu15_79 35 nu15_1012 36 nu15_1314 37
sex 38 rel 39 birth_nengo 40 birth_year_temp 41-44 birth_month 45-46 
age 47-49 mar 50 empstat 51 hour 54-56 class 57 
ind 59-60 occ 61-62 size 63 weight 134-147
using ${datapath}\rokiso\L2_`s'_RCD_CIX-`y'`m'_A.TXT;
qui cleaning;
save ${datapath}\rokiso\kiso_`y'_`m', replace;
};
};};

forvalues y =13/16 {;
forvalues m=1/12 {;
local s=2000+`y';
clear;
if `m'<=9 {;
quietly infix year 7-10 month 11-12 prefecture 15-16 
district 17-19 hhunit 20-22 hhid 23-24  
n15 27-28 nu15_03 33 nu15_46 34 nu15_79 35 nu15_1012 36 nu15_1314 37
sex 38 rel 39 birth_nengo 40 birth_year_temp 41-44 birth_month 45-46 
age 47-49 mar 50 empstat 51 hour 55-57 class 60 
ind 63-64 occ 65-66 size 67 weight 168-181
using ${datapath}\rokiso\L2_`s'_RCD_CIX-`y'0`m'_A.TXT;
qui cleaning;
save ${datapath}\rokiso\kiso_`y'_`m', replace;
};
if `m'>=10 {;
quietly infix year 7-10 month 11-12 prefecture 15-16 
district 17-19 hhunit 20-22 hhid 23-24  
n15 27-28 nu15_03 33 nu15_46 34 nu15_79 35 nu15_1012 36 nu15_1314 37
sex 38 rel 39 birth_nengo 40 birth_year_temp 41-44 birth_month 45-46 
age 47-49 mar 50 empstat 51 hour 55-57 class 60 
ind 63-64 occ 65-66 size 67 weight 168-181
using ${datapath}\rokiso\L2_`s'_RCD_CIX-`y'`m'_A.TXT;
qui cleaning;
save ${datapath}\rokiso\kiso_`y'_`m', replace;
};
};};

clear;
use ${datapath}\rokiso\kiso_2_1.dta;

forvalues y=2/16 {;
forvalues m=1/12 {;
if ~(`y'==2&`m'==1) {;
append using ${datapath}\rokiso\kiso_`y'_`m'.dta;
};
};
};

save ${datapath}\rokiso\rokiso2002_2016, replace;

log close;
exit;
