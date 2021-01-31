# delimit;
clear;
set mem 4g;
set more off;
cap log close;
log using ${datapath}\wagecensus.log,replace;

/* Employee */

* H.14-16 (2002-2004) *;
 
forvalues t=14/16 {;
clear;
local s=1988+`t';
infix year 1-4 prefecture 10-11 estid 12-16 citycode 22-24 firmsize 49 
 weight 57-62 PrivatePublic 64 maleL 65-69 femaleL 70-74 str 
IndustryL 75 IndustryM 76-77 IndustryS 78 sex 79 TypeOfWorker 80 contract 81 
emptype 82 educ 83 age 84-85 ten 86-87 occ 88-90 exper 91 day 92-93 
contracthour 94-96 overhour 97-99 salary 100-104 oversalary 105-108 
contractsalary 109-113 CommuterAllowance 114-116 
RegularAttendanceAllowance 117-119 FamilyAllowance 120-122 bonus 123-128 
using "${datapath}\wcensus\h`t'_k-chin.txt" ;
save "${datapath}\wcensus\wc`s'.dta",replace;
};

* H.17-21 (2005-2009) *;
forvalues t=17/21{;
clear;
local s=1988+`t';
infix year 1-4 prefecture 10-11 estid 12-16 citycode 22-24 Industry 46-48 
firmsize 51 weight 60-65 PrivatePublic 67 maleL_Regular 70-74 
femaleL_Regular 75-79 maleL_NonRegular 80-84 femaleL_NonRegular 85-89 sex 104 
contract 105 emptype 106 educ 107 age 108-109 ten 110-111 TypeOfWorker 112 
occ 113-115 exper 116 day 117-118 contracthour 119-121 overhour 122-124 
salary 125-129 oversalary 130-133 contractsalary 134-138 
CommuterAllowance 139-141 RegularAttendanceAllowance 142-144 
FamilyAllowance 145-147 bonus 148-153 
using "${datapath}\wcensus\h`t'_k-chin.txt";
save "${datapath}\wcensus\wc`s'.dta",replace;
};


* H.22-26(2010-2014) *;
forvalues t=22/26{;
clear;
local s=1988+`t';
infix year 1-4 prefecture 10-11 estid 12-16 citycode 22-24 Industry 46-48 
firmsize 51 weight 60-69 PrivatePublic 71 maleL_Regular 74-78 
femaleL_Regular 79-83 maleL_NonRegular 84-88 femaleL_NonRegular 89-93 sex 108 
contract 109 emptype 110 educ 111 age 112-113 ten 114-115 TypeOfWorker 116 
occ 117-119 exper 120 day 121-122 contracthour 123-125 overhour 126-128 
salary 129-133 oversalary 134-137 contractsalary 138-142 
CommuterAllowance 143-145 RegularAttendanceAllowance 146-148 
FamilyAllowance 149-151 bonus 152-157 
using "${datapath}\wcensus\h`t'_k-chin.txt";
save "${datapath}\wcensus\wc`s'.dta",replace;
};

* H.27-29 (2015-2017) *;
forvalues t=27/29{;
clear;
local s=1988+`t';
infix year 1-4 prefecture 10-11 estid 12-16 citycode 22-24  
Industry 46-48 firmsize 51 weight 60-69 PrivatePublic 71 maleL_Regular 74-78 
femaleL_Regular 79-83 maleL_NonRegular 84-88 femaleL_NonRegular 89-93 sex 108 
contract 109 emptype 110 educ 111 age 112-113 ten 114-115 TypeOfWorker 116 
occ 117-119 exper 120 day 121-122 contracthour 123-125 overhour 126-128 
salary 129-133 oversalary 134-137 contractsalary 138-142 
CommuterAllowance 143-145 RegularAttendanceAllowance 146-148 
FamilyAllowance 149-151 bonus 152-157 
using "${datapath}\wcensus\h`t'_k-chin.txt";
save "${datapath}\wcensus\wc`s'.dta",replace;
};



/* Jigyosyo */
* H14-16 (2002-2004) *;

forvalues t=14/16{;
clear;
infix year 2-5 prefecture 7-8 estid 9-13 cityid 16-18 ind 52-54 firmsize 56 
baseup 57 extractionrate 59-62 maletot 58-62 femaletot 63-67 startingwagedetermined 78 
double wage_jh_w_male 79-82	double emp_jh_w_male 83-85	double wage_jh_w_female 86-90 	
double emp_jh_w_female 91-94 	double wage_jh_b_male 95-98	double emp_jh_b_male 99-102	
double wage_jh_b_female 103-106	double emp_jh_b_female 107-110 
double wage_h_w_male	111-114	double emp_h_w_male 115-118	double wage_h_w_female 119-122	
double emp_h_w_female 123-126	double wage_h_b_male 127-130	double emp_h_b_male 131-134	
double wage_h_b_female 135-138	double emp_h_b_female 139-142 double wage_jc_w_male	143-146	
double emp_jc_w_male 147-150	double wage_jc_w_female 151-154	double emp_jc_w_female	155-158	
double wage_jc_b_male	159-162	double emp_jc_b_male 163-166	double wage_jc_b_female 167-170	
double emp_jc_b_female 171-174 double wage_4c_w_male	175-178	double emp_4c_w_male 179-182	
double wage_4c_w_female 183-186	double emp_4c_w_female	187-190	double wage_4c_b_male	191-194	
double emp_4c_b_male 195-198	double wage_4c_b_female 199-202	double emp_4c_b_female 203-206 
using "${datapath}\wcensus\h`t'_j-chin.txt";
local s=`t' + 1988;
sort estid;
save "${datapath}\wcensus\wce`s'.dta", replace ;
};

* H17-20 (2005-2017) *;
forvalues t=17/29{;
clear;
infix year 1-4 prefecture 6-7 estid 8-12 cityid 15-17 ind 39-41 firmsize 44 extractionrate 45-48 
male_regular_tot 58-62 female_regular_tot 63-67 male_nonregular_tot 68-72 female_nonregular_tot 73-77 
startingwagedetermined 89 double wage_h_male 91-94 double emp_h_male 95-98 double 
wage_h_female 99-102 double emp_h_female 103-106 double wage_jc_male 107-110 double 
emp_jc_male 111-114 double wage_jc_female 115-118 double emp_jc_female 119-122 
double wage_4c_clerical_male 123-126  double emp_4c_clerical_male 127-130 double 
wage_4c_clerical_female 131-134 double emp_4c_clerical_female 135-138 double  
wage_4c_technical_male 139-142 double emp_4c_technical_male 143-146 double 
wage_4c_technical_female 147-150 double emp_4c_technical_female 151-154 
double wage_grad_male 155-158 double emp_grad_male 159-162 double wage_grad_female 163-166 double 
emp_grad_female 167-170 
using "${datapath}\wcensus\h`t'_j-chin.txt";
local s=`t' + 1988;
sort estid;
save "${datapath}\wcensus\wce`s'.dta", replace ; 
};

/* merge */;

clear;
forvalues t=14/29{;
local s=`t' + 1988;
clear;
use ${datapath}\wcensus\wc`s'.dta;
sort estid;
merge m:1 prefecture estid using ${datapath}\wcensus\wce`s'.dta;
drop if _merge!=3;
drop _merge;
save ${datapath}\wcensus\wcm`s'.dta, replace;
};


*-------------------------
*stacking all year data*
*-------------------------;

clear;
use "${datapath}\wcensus\wcm2002.dta";

forvalues t=2003/2017{;
append using "${datapath}\wcensus\wcm`t'.dta";
};
gen wage=(contractsalary- CommuterAllowance- RegularAttendanceAllowance- 
FamilyAllowance)/ contracthour;
gen lwage=log(wage);
replace wage=wage*100;

merge m:1 year prefecture using "${datapath}\mw.dta";
drop if _merge==2;

label define prefecture 1 "Hokkaido" 2 "Aomori" 3 "Iwate" 4 "Miyagi" 5 "Akita" 6 "Yamagata"
7 "Fukushima" 8 "Ibaraki" 9 "Tochigi" 10 "Gunma" 11 "Saitama" 12 "Chiba" 13 "Tokyo"
14 "Kanagawa" 15 "Nigata" 16 "Toyama" 17 "Ishikawa" 18 "Fukui" 19 "Yamanashi" 20 "Nagano"
21 "Gifu" 22 "Shizuoka" 23 "Aichi" 24 "Mie" 25 "Shiga" 26 "Kyoto" 27 "Osaka" 28 "Hyogo"
29 "Nara" 30 "Wakayama" 31 "Tottori" 32 "Shimane" 33 "Okayama" 34 "Hiroshima" 35 "Yamaguchi"
36 "Tokushima" 37 "Kagawa" 38 "Ehime" 39 "Kochi" 40 "Fukuoka" 41 "Saga" 42 "Nagasaki" 
43 "Kumamoto" 44 "Oita" 45 "Miyazaki" 46 "Kagoshima" 47 "Okinawa"; 
label values prefecture prefecture;

gen pexp=age-15 if educ==1;
replace pexp=age-18 if educ==2;
replace pexp=age-20 if educ==3;
replace pexp=age-22 if educ==4;

*-------------------------
*checking variable construction
*-------------------------;
tab year;
tab year sex, row nofreq;
tab pref year, column nofreq;
tab educ sex, column nofreq;

tabstat wage, by(year);
tabstat pexp, by(year);

keep if age>=19&age<=64;
save "${datapath}\wcensus\wcensus2002_2017.dta", replace;

log close;
exit;

