#delimit ;
set more off;
cap log close;
log using ${path}\log\subreg.log,replace;
clear;

use ${datapath}\analysis.dta,replace;
keep if educ==4;
keep if age4>=18&age4<.;
label variable fd_lmw "{&Delta} ln mw {sub:t}";
label variable lag1_fd_lmw "{&Delta} ln mw {sub:t-1}";
generate byte agecat=recode(age4, 18, 20, 25, 30, 60, 65, 70);

forvalues s=1/2{;
*eststo: qui; 
regress fd_emp c.fd_lmw#i.agecat c.lag1_fd_lmw#i.agecat i.yearmonth i.prefecture if sex==`s', cluster(prefecture);
};

exit;
esttab, b(2) t(2) star(* 0.10 ** 0.05 *** 0.01) 
keep(c.fd_lmw##i.agecat c.lag1_fd_lmw##i.agecat) se compress;
eststo clear;



log close;
exit;
