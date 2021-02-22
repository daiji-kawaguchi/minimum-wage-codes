#delimit ;
set more off;
cap log close;
cap eststo clear;
log using ${path}\log\ck_cs_reg,replace;
clear;

use ${datapath}\cross.dta,replace;
drop if prefecture==13 | prefecture==14;
label variable lmw "\$ \ln (MW)\$";

forvalues s=1/2{;
eststo: qui regress emp lmw ${control} i.year#i.month i.prefecture#c.year if sex==`s'&age>=19&age<=24, cluster(prefecture);
qui estadd ysumm;
estimates store emp1924_`s';
eststo: qui regress emp lmw ${control} i.year#i.month i.prefecture#c.year if sex==`s'&age>=25&age<=59, cluster(prefecture);
qui estadd ysumm;
estimates store emp2559_`s';
eststo: qui regress emp lmw ${control} i.year#i.month i.prefecture#c.year if sex==`s'&age>=60&age<=64, cluster(prefecture);
qui estadd ysumm;
estimates store emp6064_`s';
};
esttab, b(2) t(2) keep(lmw) se nostar compress mtitles("M19-24" "M25-59" "M60-64" "F19-24" "F25-59" "F60-64") stats(ymean N, labels ("Mean" "Observations") fmt(2 0));
esttab using "${path}\out\ck_crossreg.tex", replace label b(2) t(2) 
keep(lmw) se nostar compress mtitles("M19-24" "M25-59" "M60-64" "F19-24" "F25-59" "F60-64")
stats(ymean N, labels ("Mean" "Observations") fmt(2 0))
fragment;
*coefplot emp1924_1 emp2559_1 emp6064_1 emp1924_2 emp2559_2 emp6064_2, keep(lmw) vertical plotlabels("M19-24" "M25-59" "M60-64" "F19-24" "F25-59" "F60-64");
eststo clear;

forvalues s=1/2{;
eststo: qui regress lf lmw ${control} i.year#i.month i.prefecture#c.year if sex==`s'&age>=19&age<=24, cluster(prefecture);
qui estadd ysumm;
eststo: qui regress lf lmw ${control} i.year#i.month i.prefecture#c.year if sex==`s'&age>=25&age<=59, cluster(prefecture);
qui estadd ysumm;
eststo: qui regress lf lmw ${control} i.year#i.month i.prefecture#c.year if sex==`s'&age>=60&age<=64, cluster(prefecture);
qui estadd ysumm;
};
esttab, b(2) t(2) keep(lmw) se nostar compress stats(ymean N, labels ("Mean" "Observations") fmt(2 0));
esttab using "${path}\out\ck_crossreg.tex", append label b(2) t(2)  
keep(lmw) se nostar compress stats(ymean N, labels ("Mean" "Observations") fmt(2 0))
fragment;
eststo clear;

forvalues s=1/2{;
eststo: qui regress lhour lmw ${control} i.year#i.month i.prefecture#c.year if sex==`s'&age>=19&age<=24, cluster(prefecture);
eststo: qui regress lhour lmw ${control} i.year#i.month i.prefecture#c.year if sex==`s'&age>=25&age<=59, cluster(prefecture);
eststo: qui regress lhour lmw ${control} i.year#i.month i.prefecture#c.year if sex==`s'&age>=60&age<=64, cluster(prefecture);
};
esttab, b(2) t(2) keep(lmw) se nostar compress mtitles("M19-24" "M25-59" "M60-64" "F19-24" "F25-59" "F60-64");
esttab using "${path}\out\ck_crossreg.tex", append label b(2) t(2) keep(lmw) se nostar compress fragment;
eststo clear;
sum hour if lhour~=.&sex==1&age>=19&age<=24;
sum hour if lhour~=.&sex==1&age>=25&age<=59;
sum hour if lhour~=.&sex==1&age>=60&age<=64;
sum hour if lhour~=.&sex==2&age>=19&age<=24;
sum hour if lhour~=.&sex==2&age>=25&age<=59;
sum hour if lhour~=.&sex==2&age>=60&age<=64;

log close;
exit;

/*
/* by class */
drop if class==9;
gen perm=(class==1 | class==4); *including joko, yakuin;
gen temp=(class==2 | class==3 | class==8); *including Rinji, Hiyatoi, Naishoku;
gen self=(class>=5&class<=7); *with/without employee, family workers;

replace perm=perm*emp;
replace temp=temp*emp;
replace self=self*emp;

forvalues s=1/2{;
eststo: qui regress perm lmw ${control} i.year#i.month i.prefecture#c.year if sex==`s'&age>=19&age<=24, cluster(prefecture);
qui estadd ysumm;
eststo: qui regress temp lmw ${control} i.year#i.month i.prefecture#c.year if sex==`s'&age>=19&age<=24, cluster(prefecture);
qui estadd ysumm;
eststo: qui regress self lmw ${control} i.year#i.month i.prefecture#c.year if sex==`s'&age>=19&age<=24, cluster(prefecture);
qui estadd ysumm;
};
esttab, b(2) t(2) keep(lmw) se nostar compress mtitles("Mperm" "Mtemp" "Mself" "Fperm" "Ftemp" "Fself") stats(ymean N, labels ("Mean" "Observations") fmt(2 0));
esttab using "${path}\out\type1924.tex", replace label b(2) t(2) 
keep(lmw) se nostar compress mtitles("Mperm" "Mtemp" "Mself" "Fperm" "Ftemp" "Fself")
stats(ymean N, labels ("Mean" "Observations") fmt(2 0))
fragment;
eststo clear;


forvalues s=1/2{;
eststo: qui regress perm lmw ${control} i.year#i.month i.prefecture#c.year if sex==`s'&age>=25&age<=59, cluster(prefecture);
qui estadd ysumm;
eststo: qui regress temp lmw ${control} i.year#i.month i.prefecture#c.year if sex==`s'&age>=25&age<=59, cluster(prefecture);
qui estadd ysumm;
eststo: qui regress self lmw ${control} i.year#i.month i.prefecture#c.year if sex==`s'&age>=25&age<=59, cluster(prefecture);
qui estadd ysumm;
};
esttab, b(2) t(2) keep(lmw) se nostar compress mtitles("Mperm" "Mtemp" "Mself" "Fperm" "Ftemp" "Fself") stats(ymean N, labels ("Mean" "Observations") fmt(2 0));
esttab using "${path}\out\type2559.tex", replace label b(2) t(2) 
keep(lmw) se nostar compress mtitles("Mperm" "Mtemp" "Mself" "Fperm" "Ftemp" "Fself")
stats(ymean N, labels ("Mean" "Observations") fmt(2 0))
fragment;
eststo clear;


forvalues s=1/2{;
eststo: qui regress perm lmw ${control} i.year#i.month i.prefecture#c.year if sex==`s'&age>=60&age<=64, cluster(prefecture);
qui estadd ysumm;
eststo: qui regress temp lmw ${control} i.year#i.month i.prefecture#c.year if sex==`s'&age>=60&age<=64, cluster(prefecture);
qui estadd ysumm;
eststo: qui regress self lmw ${control} i.year#i.month i.prefecture#c.year if sex==`s'&age>=60&age<=64, cluster(prefecture);
qui estadd ysumm;
};
esttab, b(2) t(2) keep(lmw) se nostar compress mtitles("Mperm" "Mtemp" "Mself" "Fperm" "Ftemp" "Fself") stats(ymean N, labels ("Mean" "Observations") fmt(2 0));
esttab using "${path}\out\type6064.tex", replace label b(2) t(2) 
keep(lmw) se nostar compress mtitles("Mperm" "Mtemp" "Mself" "Fperm" "Ftemp" "Fself")
stats(ymean N, labels ("Mean" "Observations") fmt(2 0))
fragment;
eststo clear;

/* robustness check with trend2 */ 

forvalues s=1/2{;
eststo: qui regress emp lmw ${control} i.year#i.month i.prefecture#c.year i.prefecture#c.year#c.year if sex==`s'&age>=19&age<=24, cluster(prefecture);
qui estadd ysumm;
eststo: qui regress emp lmw ${control} i.year#i.month i.prefecture#c.year i.prefecture#c.year#c.year if sex==`s'&age>=25&age<=59, cluster(prefecture);
qui estadd ysumm;
eststo: qui regress emp lmw ${control} i.year#i.month i.prefecture#c.year i.prefecture#c.year#c.year if sex==`s'&age>=60&age<=64, cluster(prefecture);
qui estadd ysumm;
};
esttab, b(2) t(2) keep(lmw) se nostar compress mtitles("M19-24" "M25-59" "M60-64" "F19-24" "F25-59" "F60-64");
esttab using "${path}\out\crossreg2.tex", replace label b(2) t(2) 
keep(lmw) se nostar compress mtitles("M19-24" "M25-59" "M60-64" "F19-24" "F25-59" "F60-64")
stats(ymean N, labels ("Mean" "Observations") fmt(2 0))
fragment;
eststo clear;

forvalues s=1/2{;
eststo: qui regress lf lmw ${control} i.year#i.month i.prefecture#c.year i.prefecture#c.year#c.year if sex==`s'&age>=19&age<=24, cluster(prefecture);
qui estadd ysumm;
eststo: qui regress lf lmw ${control} i.year#i.month i.prefecture#c.year i.prefecture#c.year#c.year if sex==`s'&age>=25&age<=59, cluster(prefecture);
qui estadd ysumm;
eststo: qui regress lf lmw ${control} i.year#i.month i.prefecture#c.year i.prefecture#c.year#c.year if sex==`s'&age>=60&age<=64, cluster(prefecture);
qui estadd ysumm;
};
esttab, b(2) t(2) keep(lmw) se nostar compress mtitles("M19-24" "M25-59" "M60-64" "F19-24" "F25-59" "F60-64");
esttab using "${path}\out\lfreg2.tex", replace label b(2) t(2)  
keep(lmw) se nostar compress mtitles("M19-24" "M25-59" "M60-64" "F19-24" "F25-59" "F60-64")
stats(ymean N, labels ("Mean" "Observations") fmt(2 0))
fragment;
eststo clear;

forvalues s=1/2{;
eststo: qui regress lhour lmw ${control} i.year#i.month i.prefecture#c.year i.prefecture#c.year#c.year if sex==`s'&age>=19&age<=24, cluster(prefecture);
eststo: qui regress lhour lmw ${control} i.year#i.month i.prefecture#c.year i.prefecture#c.year#c.year if sex==`s'&age>=25&age<=59, cluster(prefecture);
eststo: qui regress lhour lmw ${control} i.year#i.month i.prefecture#c.year i.prefecture#c.year#c.year if sex==`s'&age>=60&age<=64, cluster(prefecture);
};
esttab, b(2) t(2) keep(lmw) se nostar compress mtitles("M19-24" "M25-59" "M60-64" "F19-24" "F25-59" "F60-64");
esttab using "${path}\out\hourreg2.tex", replace label b(2) t(2)  
keep(lmw) se nostar compress mtitles("M19-24" "M25-59" "M60-64" "F19-24" "F25-59" "F60-64")
stats(ymean N, labels ("Mean" "Observations") fmt(2 0))
fragment;
eststo clear;



