# delimit;
clear;
set more off;
eststo clear;
cap log close;
log using ${path}\log\lwage_reg.log,replace;

use ${datapath}\wcensus\wcensus2002_2017.dta;
drop if lwage==.;
label variable lmw "\$ \ln (MW)\$";
svyset [pweight=weight];

drop _merge;
merge m:1 prefecture using ${datapath}\gap2006.dta;
gen mw2006_temp=mw if year==2006;
egen mw2006=mean(mw2006_temp), by(prefecture);
drop mw2006_temp;
gen lgap=ln(mw2006+gap)-ln(mw2006);
label variable lgap "ln(mw2006+gap)-ln(mw2007)";
drop if _merge~=3;
drop _merge;

forvalues y=2002/2017 {;
gen d`y'=(year==`y');
gen lgap_d`y'=lgap*d`y';
};

reg lwage lmw ${control_bsws} [pweight=weight], cluster(prefecture);
ivregress 2sls lwage (lmw=lgap_d2003 lgap_d2004 lgap_d2005 lgap_d2006 lgap_d2008 lgap_d2009 lgap_d2010 lgap_d2011 lgap_d2012 lgap_d2013 lgap_d2014 lgap_d2015 lgap_d2016 lgap_d2017) ${control_bsws} [pweight=weight], cluster(prefecture);

gen mwplus0=0;
replace mwplus0=1 if wage<mw;

forvalues h = 5 (5) 30 {;
local l=`h'-5;
gen mwplus`h'=0;
replace mwplus`h'=1 if (1+0.01*`l')*mw<=wage&wage<(1+0.01*`h')*mw;
label var mwplus`h' "`l' - `h'%";
display "`l' - `h'";
};

forvalues h = 0 (5) 30 {;
eststo: qui reg mwplus`h' lmw ${control_bsws} [pweight=weight], cluster(prefecture);
qui estadd ysumm, mean;
};
esttab, b(2) t(2) nostar keep(lmw) se compress
mtitles("Below" "0-5" "5-10" "10-15" "15-20" "20-25" "25-30");
esttab using "${path}\out\wagereg.tex", 
fragment replace label b(2) t(2) keep(lmw) se nostar compress 
mtitles("Below" "0-5" "5-10" "10-15" "15-20" "20-25" "25-30")
stats(ymean, labels ("Mean"))
;

eststo clear;
forvalues h = 0 (5) 30 {;
eststo: qui reg mwplus`h' [pweight=weight];
};
esttab, b(2) t(2) nostar se compress
mtitles("Below" "0-5" "5-10" "10-15" "15-20" "20-25" "25-30");
eststo clear;

gen hour= contracthour + overhour;
gen lhour=ln(hour);

eststo: qui reg lhour lmw ${control_bsws} [pweight=weight] if sex==1&age>=19&age<=24, cluster(prefecture);
eststo: qui reg lhour lmw ${control_bsws} [pweight=weight] if sex==1&age>=25&age<=59, cluster(prefecture);
eststo: qui reg lhour lmw ${control_bsws} [pweight=weight] if sex==1&age>=60&age<=64, cluster(prefecture);
eststo: qui reg lhour lmw ${control_bsws} [pweight=weight] if sex==2&age>=19&age<=24, cluster(prefecture);
eststo: qui reg lhour lmw ${control_bsws} [pweight=weight] if sex==2&age>=25&age<=59, cluster(prefecture);
eststo: qui reg lhour lmw ${control_bsws} [pweight=weight] if sex==2&age>=60&age<=64, cluster(prefecture);
esttab, b(2) t(2) keep(lmw) se nostar compress mtitles("M19-24" "M25-59" "M60-64" "F19-24" "F25-59" "F60-64");
esttab using "${path}\out\hoursalary.tex", replace label b(2) t(2) keep(lmw) se nostar compress mtitles("M19-24" "M25-59" "M60-64" "F19-24" "F25-59" "F60-64") fragment;
eststo clear;

gen lcontractsalary=ln(contractsalary);
eststo: qui reg lcontractsalary lmw ${control_bsws} [pweight=weight] if sex==1&age>=19&age<=24, cluster(prefecture);
eststo: qui reg lcontractsalary lmw ${control_bsws} [pweight=weight] if sex==1&age>=25&age<=59, cluster(prefecture);
eststo: qui reg lcontractsalary lmw ${control_bsws} [pweight=weight] if sex==1&age>=60&age<=64, cluster(prefecture);
eststo: qui reg lcontractsalary lmw ${control_bsws} [pweight=weight] if sex==2&age>=19&age<=24, cluster(prefecture);
eststo: qui reg lcontractsalary lmw ${control_bsws} [pweight=weight] if sex==2&age>=25&age<=59, cluster(prefecture);
eststo: qui reg lcontractsalary lmw ${control_bsws} [pweight=weight] if sex==2&age>=60&age<=64, cluster(prefecture);
esttab, b(2) t(2) keep(lmw) se nostar compress mtitles("M19-24" "M25-59" "M60-64" "F19-24" "F25-59" "F60-64");
esttab using "${path}\out\hoursalary.tex", append label b(2) t(2) keep(lmw) se nostar compress mtitles("M19-24" "M25-59" "M60-64" "F19-24" "F25-59" "F60-64") fragment;
eststo clear;

forvalues s=1/2{;
eststo: qui ivregress 2sls lhour (lmw=lgap_d2003 lgap_d2004 lgap_d2005 lgap_d2006 lgap_d2008 lgap_d2009 lgap_d2010 lgap_d2011 lgap_d2012 lgap_d2013 lgap_d2014 lgap_d2015 lgap_d2016 lgap_d2017) ${control_bsws} if sex==`s'&age>=19&age<=24, cluster(prefecture);
qui estadd ysumm;
eststo: qui ivregress 2sls lhour (lmw=lgap_d2003 lgap_d2004 lgap_d2005 lgap_d2006 lgap_d2008 lgap_d2009 lgap_d2010 lgap_d2011 lgap_d2012 lgap_d2013 lgap_d2014 lgap_d2015 lgap_d2016 lgap_d2017) ${control_bsws} if sex==`s'&age>=25&age<=59, cluster(prefecture);
qui estadd ysumm;
eststo: qui ivregress 2sls lhour (lmw=lgap_d2003 lgap_d2004 lgap_d2005 lgap_d2006 lgap_d2008 lgap_d2009 lgap_d2010 lgap_d2011 lgap_d2012 lgap_d2013 lgap_d2014 lgap_d2015 lgap_d2016 lgap_d2017) ${control_bsws} if sex==`s'&age>=60&age<=64, cluster(prefecture);
qui estadd ysumm;
};
esttab, b(2) t(2) keep(lmw) se nostar compress mtitles("M19-24" "M25-59" "M60-64" "F19-24" "F25-59" "F60-64");
esttab using "${path}\out\hoursalary.tex", append label b(2) t(2) keep(lmw) se nostar compress fragment;
eststo clear;

forvalues s=1/2{;
eststo: qui ivregress 2sls lcontractsalary (lmw=lgap_d2003 lgap_d2004 lgap_d2005 lgap_d2006 lgap_d2008 lgap_d2009 lgap_d2010 lgap_d2011 lgap_d2012 lgap_d2013 lgap_d2014 lgap_d2015 lgap_d2016 lgap_d2017) ${control_bsws} if sex==`s'&age>=19&age<=24, cluster(prefecture);
qui estadd ysumm;
eststo: qui ivregress 2sls lcontractsalary (lmw=lgap_d2003 lgap_d2004 lgap_d2005 lgap_d2006 lgap_d2008 lgap_d2009 lgap_d2010 lgap_d2011 lgap_d2012 lgap_d2013 lgap_d2014 lgap_d2015 lgap_d2016 lgap_d2017) ${control_bsws} if sex==`s'&age>=25&age<=59, cluster(prefecture);
qui estadd ysumm;
eststo: qui ivregress 2sls lcontractsalary (lmw=lgap_d2003 lgap_d2004 lgap_d2005 lgap_d2006 lgap_d2008 lgap_d2009 lgap_d2010 lgap_d2011 lgap_d2012 lgap_d2013 lgap_d2014 lgap_d2015 lgap_d2016 lgap_d2017) ${control_bsws} if sex==`s'&age>=60&age<=64, cluster(prefecture);
qui estadd ysumm;
};
esttab, b(2) t(2) keep(lmw) se nostar compress mtitles("M19-24" "M25-59" "M60-64" "F19-24" "F25-59" "F60-64");
esttab using "${path}\out\hoursalary.tex", append label b(2) t(2) keep(lmw) se nostar compress fragment;
eststo clear;


log close;
