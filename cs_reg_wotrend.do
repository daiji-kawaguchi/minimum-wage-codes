#delimit ;
set more off;
cap log close;
cap eststo clear;
log using ${path}\log\cs_reg_wotrend.log,replace;
clear;

use ${datapath}\cross.dta,replace;
label variable lmw "\$ \ln (MW)\$";

forvalues s=1/2{;
eststo: qui regress emp lmw ${wo_fix} if sex==`s'&age>=19&age<=24, cluster(prefecture);
qui estadd ysumm;
eststo: qui regress emp lmw ${wo_fix} if sex==`s'&age>=25&age<=59, cluster(prefecture);
qui estadd ysumm;
eststo: qui regress emp lmw ${wo_fix} if sex==`s'&age>=60&age<=64, cluster(prefecture);
qui estadd ysumm;
};
esttab, b(2) t(2) keep(lmw) se nostar compress mtitles("M19-24" "M25-59" "M60-64" "F19-24" "F25-59" "F60-64");
esttab using "${path}\out\crossreg_wotrend.tex", replace label b(2) t(2) 
keep(lmw) se nostar compress mtitles("M19-24" "M25-59" "M60-64" "F19-24" "F25-59" "F60-64")
stats(ymean N, labels ("Mean" "Observations") fmt(2 0))
fragment;
eststo clear;

forvalues s=1/2{;
eststo: qui regress lf lmw ${wo_fix} if sex==`s'&age>=19&age<=24, cluster(prefecture);
qui estadd ysumm;
eststo: qui regress lf lmw ${wo_fix} if sex==`s'&age>=25&age<=59, cluster(prefecture);
qui estadd ysumm;
eststo: qui regress lf lmw ${wo_fix} if sex==`s'&age>=60&age<=64, cluster(prefecture);
qui estadd ysumm;
};
esttab, b(2) t(2) keep(lmw) se nostar compress mtitles("M19-24" "M25-59" "M60-64" "F19-24" "F25-59" "F60-64");
esttab using "${path}\out\crossreg_wotrend.tex", append label b(2) t(2)  
keep(lmw) se nostar compress mtitles("M19-24" "M25-59" "M60-64" "F19-24" "F25-59" "F60-64")
stats(ymean N, labels ("Mean" "Observations") fmt(2 0))
fragment;
eststo clear;

forvalues s=1/2{;
eststo: qui regress lhour lmw ${wo_fix} if sex==`s'&age>=19&age<=24, cluster(prefecture);
eststo: qui regress lhour lmw ${wo_fix} if sex==`s'&age>=25&age<=59, cluster(prefecture);
eststo: qui regress lhour lmw ${wo_fix} if sex==`s'&age>=60&age<=64, cluster(prefecture);
};
esttab, b(2) t(2) keep(lmw) se nostar compress mtitles("M19-24" "M25-59" "M60-64" "F19-24" "F25-59" "F60-64");
esttab using "${path}\out\crossreg_wotrend.tex", append label b(2) t(2)  
keep(lmw) se nostar compress mtitles("M19-24" "M25-59" "M60-64" "F19-24" "F25-59" "F60-64")
fragment;
eststo clear;

log close;
exit;

