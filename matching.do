#delimit ;
set more off;
cap log close;
log using ${path}\log\matching.log, replace;
clear;

local varlist "year month age mar rel empstat hour jobpref rsn class ind occ size change weight";

local y=2;
local m=1;
clear;
use ${datapath}\rotoku\lfssp_`y'_`m'.dta;
foreach var of varlist `varlist' {;
rename `var' `var'4;
};
save ${datapath}\rotoku\toku_`y'_`m'.dta,replace;

local y=2;
forvalues m=2/12 {;
local pm=`m'-1;
clear;
use ${datapath}\rotoku\lfssp_`y'_`m'.dta;
foreach var of varlist `varlist' {;
rename `var' `var'4;
};

qui merge 1:1 prefecture district hhunit birth_year birth_month sex using 
${datapath}\rokiso\kiso_`y'_`pm'.dta;
drop if _merge==2;
foreach var of varlist `varlist' _merge {;
rename `var' `var'3;
};
save ${datapath}\rotoku\toku_`y'_`m'.dta,replace;
};

local y=3 ;
local py=`y'-1;

clear;
use ${datapath}\rotoku\lfssp_`y'_1.dta;
foreach var of varlist `varlist' {;
rename `var' `var'4;
};

qui merge 1:1 prefecture district hhunit birth_year birth_month sex using 
${datapath}\rokiso\kiso_`py'_12.dta;
drop if _merge==2;
foreach var of varlist `varlist' _merge {;
rename `var' `var'3;
};

qui merge 1:1 prefecture district hhunit birth_year birth_month sex using 
${datapath}\rokiso\kiso_`py'_1.dta;
drop if _merge==2;
foreach var of varlist `varlist' _merge {;
rename `var' `var'2;
};

save ${datapath}\rotoku\toku_`y'_1.dta,replace;

forvalues y=3/16 {;
forvalues m=2/12 {;
local py=`y'-1;
local pm=`m'-1;
clear;
use ${datapath}\rotoku\lfssp_`y'_`m'.dta;
foreach var of varlist `varlist' {;
rename `var' `var'4;
};

qui merge 1:1 prefecture district hhunit birth_year birth_month sex using 
${datapath}\rokiso\kiso_`y'_`pm'.dta;
drop if _merge==2;
foreach var of varlist `varlist' _merge {;
rename `var' `var'3;
};

qui merge 1:1 prefecture district hhunit birth_year birth_month sex using 
${datapath}\rokiso\kiso_`py'_`m'.dta;
drop if _merge==2;
foreach var of varlist `varlist' _merge {;
rename `var' `var'2;
};

qui merge 1:1 prefecture district hhunit birth_year birth_month sex using 
${datapath}\rokiso\kiso_`py'_`pm'.dta;
drop if _merge==2;
foreach var of varlist `varlist' _merge {;
rename `var' `var'1;
};
save ${datapath}\rotoku\toku_`y'_`m'.dta,replace;
};
};

forvalues y=4/16 {;
local py=`y'-1;
local ppy=`y'-2;

clear;
use ${datapath}\rotoku\lfssp_`y'_1.dta;
foreach var of varlist `varlist' {;
rename `var' `var'4;
};

qui merge 1:1 prefecture district hhunit birth_year birth_month sex using 
${datapath}\rokiso\kiso_`py'_12.dta;
drop if _merge==2;
foreach var of varlist `varlist' _merge {;
rename `var' `var'3;
};

qui merge 1:1 prefecture district hhunit birth_year birth_month sex using 
${datapath}\rokiso\kiso_`py'_1.dta;
drop if _merge==2;
foreach var of varlist `varlist' _merge {;
rename `var' `var'2;
};

qui merge 1:1 prefecture district hhunit birth_year birth_month sex using 
${datapath}\rokiso\kiso_`ppy'_12.dta;
drop if _merge==2;
foreach var of varlist `varlist' _merge {;
rename `var' `var'1;
};
save ${datapath}\rotoku\toku_`y'_1.dta,replace;
};

clear;
use ${datapath}\rotoku\toku_2_1;
forvalues m=2/12 {;
qui append using ${datapath}\rotoku\toku_2_`m';
};
forvalues y=3/16 {;
forvalues m=1/12 {;
qui append using ${datapath}\rotoku\toku_`y'_`m';
};
};

*keep if year4>=2002&year4<=2016;
assert year4~=.&month4~=.;
tab _merge1;
tab _merge2;
tab _merge3;
keep year4 month4 prefecture district hhunit birth_year birth_month sex educ inc
age4 mar4 rel4 empstat4 hour4 jobpref4 rsn4 class4 ind4 occ4 size4 change4 weight4
year3 month3 age3 mar3 rel3 empstat3 hour3 jobpref3 rsn3 class3 ind3 occ3 size3 change3 weight3
year2 month2 age2 mar2 rel2 empstat2 hour2 jobpref2 rsn2 class2 ind2 occ2 size2 change2 weight2
year1 month1 age1 mar1 rel1 empstat1 hour1 jobpref1 rsn1 class1 ind1 occ1 size1 change1 weight1;
order year4 month4 prefecture district hhunit birth_year birth_month sex educ inc
age4 mar4 rel4 empstat4 hour4 jobpref4 rsn4 class4 ind4 occ4 size4 change4 weight4
year3 month3 age3 mar3 rel3 empstat3 hour3 jobpref3 rsn3 class3 ind3 occ3 size3 change3 weight3
year2 month2 age2 mar2 rel2 empstat2 hour2 jobpref2 rsn2 class2 ind2 occ2 size2 change2 weight2
year1 month1 age1 mar1 rel1 empstat1 hour1 jobpref1 rsn1 class1 ind1 occ1 size1 change1 weight1;
sort year4 month4 prefecture district hhunit birth_year birth_month sex;
save ${datapath}\rotoku\toku_match2003_2016.dta,replace;

exit;

forvalues y=2/16 {;
forvalues m=1/12 {;
erase ${datapath}\rokiso\kiso_`y'_`m'.dta;
erase ${datapath}\rotoku\lfssp_`y'_`m'.dta;
};};
