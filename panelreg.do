#delimit ;
set more off;
cap log close;
cap eststo clear;
log using ${path}\log\panelreg.log,replace;
clear;

use ${datapath}\cross.dta,replace;

recode month (1=3) (12=2) (11=1) (10=0) (9=11) (8=10) (7=9) (6=8) (5=7) (4=6) (3=5) (2=4),gen(a);
gen e_lmw= (a/12)*lmw+((12-a)/12)*lag1_lmw;
forvalues y=2002/2016 {;
gen d`y'=(year==`y');
gen lag1_d`y'=(year==`y'-1);
gen lgap_d`y'=lgap*d`y';
gen lag1_lgap_d`y'=lgap*lag1_d`y';
gen e_lgap_d`y'= (a/12)*lgap_d`y'+((12-a)/12)*lag1_lgap_d`y';
};

local expvar "e_lmw";
local iv "e_lgap_d2003 e_lgap_d2004 e_lgap_d2005 e_lgap_d2006 e_lgap_d2008 e_lgap_d2009 
e_lgap_d2010 e_lgap_d2011 e_lgap_d2012 e_lgap_d2013 e_lgap_d2014 e_lgap_d2015 e_lgap_d2016";
label variable e_lmw "$\ln \widetilde{MW}$";

sort id round;
gen emp_2=emp[_n-2] if round==4 & round[_n-2]==2 & id==id[_n-2];
replace emp_2=emp[_n-1] if round==4 & round[_n-1]==2 & id==id[_n-1];

eststo: qui regress emp `expvar' ${control} i.year#i.month i.prefecture if sex==1&emp_2==0&age>=19&age<=24&round==4, cluster(prefecture);
qui estadd ysumm;
eststo: qui regress emp `expvar' ${control} i.year#i.month i.prefecture if sex==1&emp_2==0&age>=25&age<=59&round==4, cluster(prefecture);
qui estadd ysumm;
eststo: qui regress emp `expvar' ${control} i.year#i.month i.prefecture if sex==1&emp_2==0&age>=60&age<=64&round==4, cluster(prefecture);
qui estadd ysumm;
eststo: qui regress emp `expvar' ${control} i.year#i.month i.prefecture if sex==1&emp_2==1&age>=19&age<=24&round==4, cluster(prefecture);
qui estadd ysumm;
eststo: qui regress emp `expvar' ${control} i.year#i.month i.prefecture if sex==1&emp_2==1&age>=25&age<=59&round==4, cluster(prefecture);
qui estadd ysumm;
eststo: qui regress emp `expvar' ${control} i.year#i.month i.prefecture if sex==1&emp_2==1&age>=60&age<=64&round==4, cluster(prefecture);
qui estadd ysumm;
esttab, b(2) t(2) nostar keep(`expvar') se compress
mtitles("NE19-24" "NE25-59" "NE60-64" "E19-24" "E25-59" "E60-64")
stats(ymean N, labels ("Mean" "Observations") fmt(2 0));
esttab using ${path}\out\panel.tex, replace label b(2) t(2) nostar 
keep(`expvar') se compress 
mtitles("NE19-24" "NE25-59" "NE60-64" "E19-24" "E25-59" "E60-64")
stats(ymean N, labels ("Mean" "Observations") fmt(2 0)) fragment;
eststo clear;

eststo: qui ivregress 2sls emp (`expvar'= `iv') ${control} i.year#i.month i.prefecture if sex==1&emp_2==0&age>=19&age<=24&round==4, cluster(prefecture);
qui estadd ysumm;
eststo: qui ivregress 2sls emp (`expvar'= `iv') ${control} i.year#i.month i.prefecture if sex==1&emp_2==0&age>=25&age<=59&round==4, cluster(prefecture);
qui estadd ysumm;
eststo: qui ivregress 2sls emp (`expvar'= `iv') ${control} i.year#i.month i.prefecture if sex==1&emp_2==0&age>=60&age<=64&round==4, cluster(prefecture);
qui estadd ysumm;
eststo: qui ivregress 2sls emp (`expvar'= `iv') ${control} i.year#i.month i.prefecture if sex==1&emp_2==1&age>=19&age<=24&round==4, cluster(prefecture);
qui estadd ysumm;
eststo: qui ivregress 2sls emp (`expvar'= `iv') ${control} i.year#i.month i.prefecture if sex==1&emp_2==1&age>=25&age<=59&round==4, cluster(prefecture);
qui estadd ysumm;
eststo: qui ivregress 2sls emp (`expvar'= `iv') ${control} i.year#i.month i.prefecture if sex==1&emp_2==1&age>=60&age<=64&round==4, cluster(prefecture);
qui estadd ysumm;
esttab, b(2) t(2) nostar keep(`expvar') se compress
mtitles("NE19-24" "NE25-59" "NE60-64" "E19-24" "E25-59" "E60-64")
stats(ymean N, labels ("Mean" "Observations") fmt(2 0));
esttab using ${path}\out\panel.tex, append label b(2) t(2) nostar 
keep(`expvar') se compress 
mtitles("NE19-24" "NE25-59" "NE60-64" "E19-24" "E25-59" "E60-64")
stats(ymean N, labels ("Mean" "Observations") fmt(2 0)) fragment;
eststo clear;

qui regress `expvar' `iv' ${control} i.year#i.month i.prefecture if sex==1&emp_2==0&age>=19&age<=24, cluster(prefecture);
qui predict vhat, residual;
eststo: qui regress emp `expvar' ${control} i.year#i.month i.prefecture vhat if sex==1&emp_2==0&age>=19&age<=24, cluster(prefecture);
drop vhat;

qui regress `expvar' `iv' ${control} i.year#i.month i.prefecture if sex==1&emp_2==0&age>=25&age<=59, cluster(prefecture);
predict vhat, residual;
qui eststo: qui regress emp `expvar' ${control} i.year#i.month i.prefecture vhat if sex==1&emp_2==0&age>=25&age<=59, cluster(prefecture);
drop vhat;

qui regress `expvar' `iv' ${control} i.year#i.month i.prefecture if sex==1&emp_2==0&age>=60&age<=64, cluster(prefecture);
qui predict vhat, residual;
eststo: qui regress emp `expvar' ${control} i.year#i.month i.prefecture vhat if sex==1&emp_2==0&age>=60&age<=64, cluster(prefecture);
drop vhat;

qui regress `expvar' `iv' ${control} i.year#i.month i.prefecture if sex==1&emp_2==1&age>=19&age<=24, cluster(prefecture);
qui predict vhat, residual;
eststo: qui regress emp `expvar' ${control} i.year#i.month i.prefecture vhat if sex==1&emp_2==0&age>=19&age<=24, cluster(prefecture);
drop vhat;

qui regress `expvar' `iv' ${control} i.year#i.month i.prefecture if sex==1&emp_2==1&age>=25&age<=59, cluster(prefecture);
predict vhat, residual;
qui eststo: qui regress emp `expvar' ${control} i.year#i.month i.prefecture vhat if sex==1&emp_2==0&age>=25&age<=59, cluster(prefecture);
drop vhat;

qui regress `expvar' `iv' ${control} i.year#i.month i.prefecture if sex==1&emp_2==1&age>=60&age<=64, cluster(prefecture);
qui predict vhat, residual;
eststo: qui regress emp `expvar' ${control} i.year#i.month i.prefecture vhat if sex==1&emp_2==0&age>=60&age<=64, cluster(prefecture);
drop vhat;


esttab, b(2) t(2) keep(vhat) p nostar compress;
esttab using "${path}\out\crossreg.tex", append label b(2) t(2) 
keep(vhat) se nostar compress fragment;
eststo clear;


eststo: qui regress emp `expvar' ${control} i.year#i.month i.prefecture if sex==2&emp_2==0&age>=19&age<=24&round==4, cluster(prefecture);
qui estadd ysumm;
eststo: qui regress emp `expvar' ${control} i.year#i.month i.prefecture if sex==2&emp_2==0&age>=25&age<=59&round==4, cluster(prefecture);
qui estadd ysumm;
eststo: qui regress emp `expvar' ${control} i.year#i.month i.prefecture if sex==2&emp_2==0&age>=60&age<=64&round==4, cluster(prefecture);
qui estadd ysumm;
eststo: qui regress emp `expvar' ${control} i.year#i.month i.prefecture if sex==2&emp_2==1&age>=19&age<=24&round==4, cluster(prefecture);
qui estadd ysumm;
eststo: qui regress emp `expvar' ${control} i.year#i.month i.prefecture if sex==2&emp_2==1&age>=25&age<=59&round==4, cluster(prefecture);
qui estadd ysumm;
eststo: qui regress emp `expvar' ${control} i.year#i.month i.prefecture if sex==2&emp_2==1&age>=60&age<=64&round==4, cluster(prefecture);
qui estadd ysumm;
esttab, b(2) t(2) nostar keep(`expvar') se compress
mtitles("NE19-24" "NE25-59" "NE60-64" "E19-24" "E25-59" "E60-64")
stats(ymean N, labels ("Mean" "Observations") fmt(2 0));
esttab using ${path}\out\panel.tex, append label b(2) t(2) nostar 
keep(`expvar') se compress nomtitles
stats(ymean N, labels ("Mean" "Observations") fmt(2 0)) fragment;
eststo clear;

eststo: qui ivregress 2sls emp (`expvar'= `iv') ${control} i.year#i.month i.prefecture if sex==2&emp_2==0&age>=19&age<=24&round==4, cluster(prefecture);
qui estadd ysumm;
eststo: qui ivregress 2sls emp (`expvar'= `iv') ${control} i.year#i.month i.prefecture if sex==2&emp_2==0&age>=25&age<=59&round==4, cluster(prefecture);
qui estadd ysumm;
eststo: qui ivregress 2sls emp (`expvar'= `iv') ${control} i.year#i.month i.prefecture if sex==2&emp_2==0&age>=60&age<=64&round==4, cluster(prefecture);
qui estadd ysumm;
eststo: qui ivregress 2sls emp (`expvar'= `iv') ${control} i.year#i.month i.prefecture if sex==2&emp_2==1&age>=19&age<=24&round==4, cluster(prefecture);
qui estadd ysumm;
eststo: qui ivregress 2sls emp (`expvar'= `iv') ${control} i.year#i.month i.prefecture if sex==2&emp_2==1&age>=25&age<=59&round==4, cluster(prefecture);
qui estadd ysumm;
eststo: qui ivregress 2sls emp (`expvar'= `iv') ${control} i.year#i.month i.prefecture if sex==2&emp_2==1&age>=60&age<=64&round==4, cluster(prefecture);
qui estadd ysumm;
esttab, b(2) t(2) nostar keep(`expvar') se compress
mtitles("NE19-24" "NE25-59" "NE60-64" "E19-24" "E25-59" "E60-64")
stats(ymean N, labels ("Mean" "Observations") fmt(2 0));
esttab using ${path}\out\panel.tex, append label b(2) t(2) nostar 
keep(`expvar') se compress 
mtitles("NE19-24" "NE25-59" "NE60-64" "E19-24" "E25-59" "E60-64")
stats(ymean N, labels ("Mean" "Observations") fmt(2 0)) fragment;
eststo clear;

qui regress `expvar' `iv' ${control} i.year#i.month i.prefecture if sex==2&emp_2==0&age>=19&age<=24, cluster(prefecture);
qui predict vhat, residual;
eststo: qui regress emp `expvar' ${control} i.year#i.month i.prefecture vhat if sex==2&emp_2==0&age>=19&age<=24, cluster(prefecture);
drop vhat;

qui regress `expvar' `iv' ${control} i.year#i.month i.prefecture if sex==2&emp_2==0&age>=25&age<=59, cluster(prefecture);
predict vhat, residual;
qui eststo: qui regress emp `expvar' ${control} i.year#i.month i.prefecture vhat if sex==1&emp_2==0&age>=25&age<=59, cluster(prefecture);
drop vhat;

qui regress `expvar' `iv' ${control} i.year#i.month i.prefecture if sex==2&emp_2==0&age>=60&age<=64, cluster(prefecture);
qui predict vhat, residual;
eststo: qui regress emp `expvar' ${control} i.year#i.month i.prefecture vhat if sex==1&emp_2==0&age>=60&age<=64, cluster(prefecture);
drop vhat;

qui regress `expvar' `iv' ${control} i.year#i.month i.prefecture if sex==2&emp_2==1&age>=19&age<=24, cluster(prefecture);
qui predict vhat, residual;
eststo: qui regress emp `expvar' ${control} i.year#i.month i.prefecture vhat if sex==1&emp_2==0&age>=19&age<=24, cluster(prefecture);
drop vhat;

qui regress `expvar' `iv' ${control} i.year#i.month i.prefecture if sex==2&emp_2==1&age>=25&age<=59, cluster(prefecture);
predict vhat, residual;
qui eststo: qui regress emp `expvar' ${control} i.year#i.month i.prefecture vhat if sex==1&emp_2==0&age>=25&age<=59, cluster(prefecture);
drop vhat;

qui regress `expvar' `iv' ${control} i.year#i.month i.prefecture if sex==2&emp_2==1&age>=60&age<=64, cluster(prefecture);
qui predict vhat, residual;
eststo: qui regress emp `expvar' ${control} i.year#i.month i.prefecture vhat if sex==1&emp_2==0&age>=60&age<=64, cluster(prefecture);
drop vhat;

esttab, b(2) t(2) keep(vhat) p nostar compress;
esttab using "${path}\out\crossreg.tex", append label b(2) t(2) 
keep(vhat) se nostar compress fragment;
eststo clear;




exit;

log close;


