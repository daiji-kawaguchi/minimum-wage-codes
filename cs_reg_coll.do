#delimit ;
set more off;
cap log close;
cap eststo clear;
log using ${path}\log\cs_reg_coll.log,replace;
clear;

use ${datapath}\cross_coll.dta,replace;
label variable lmw "\$ \ln (MW)\$";
local control2 "i.age frac1_19_24 frac1_25_59 frac1_60_64 frac2_19_24 frac2_25_59 frac2_60_64";

forvalues y=2002/2016 {;
gen d`y'=(year==`y');
gen lgap_d`y'=lgap*d`y';
};

eststo: qui regress emp lmw ${control} ${fix} if sex==1&age>=19&age<=24, cluster(prefecture);
qui estadd ysumm;
eststo: qui regress emp lmw ${control} ${fix} if sex==1&age>=25&age<=59, cluster(prefecture);
qui estadd ysumm;
eststo: qui regress emp lmw ${control} ${fix} if sex==1&age>=60&age<=64, cluster(prefecture);
qui estadd ysumm;
eststo: qui regress emp lmw ${control} ${fix} if sex==2&age>=19&age<=24, cluster(prefecture);
qui estadd ysumm;
eststo: qui regress emp lmw ${control} ${fix} if sex==2&age>=25&age<=59, cluster(prefecture);
qui estadd ysumm;
eststo: qui regress emp lmw ${control} ${fix} if sex==2&age>=60&age<=64, cluster(prefecture);
qui estadd ysumm;
esttab, b(2) t(2) keep(lmw) se nostar compress mtitles("M19-24" "M25-59" "M60-64" "F19-24" "F25-59" "F60-64");
esttab using "${path}\out\crossreg_coll.tex", replace label b(2) t(2) 
keep(lmw) se nostar compress mtitles("M19-24" "M25-59" "M60-64" "F19-24" "F25-59" "F60-64")
stats(ymean N, labels ("Mean" "Observations") fmt(2 0))
fragment;
eststo clear;

eststo: qui regress emp lmw `control2' ${fix} if sex==1&age>=19&age<=24, cluster(prefecture);
qui estadd ysumm;
eststo: qui regress emp lmw `control2' ${fix} if sex==1&age>=25&age<=59, cluster(prefecture);
qui estadd ysumm;
eststo: qui regress emp lmw `control2' ${fix} if sex==1&age>=60&age<=64, cluster(prefecture);
qui estadd ysumm;
eststo: qui regress emp lmw `control2' ${fix} if sex==2&age>=19&age<=24, cluster(prefecture);
qui estadd ysumm;
eststo: qui regress emp lmw `control2' ${fix} if sex==2&age>=25&age<=59, cluster(prefecture);
qui estadd ysumm;
eststo: qui regress emp lmw `control2' ${fix} if sex==2&age>=60&age<=64, cluster(prefecture);
qui estadd ysumm;
esttab, b(2) t(2) keep(lmw) se nostar compress mtitles("M19-24" "M25-59" "M60-64" "F19-24" "F25-59" "F60-64");
esttab using "${path}\out\crossreg_coll2.tex", replace label b(2) t(2) 
keep(lmw) se nostar compress mtitles("M19-24" "M25-59" "M60-64" "F19-24" "F25-59" "F60-64")
stats(ymean N, labels ("Mean" "Observations") fmt(2 0))
fragment;
eststo clear;

forvalues s=1/2{;
eststo: qui ivregress 2sls emp (lmw=lgap_d2003 lgap_d2004 lgap_d2005 lgap_d2006 lgap_d2008 lgap_d2009 lgap_d2010 lgap_d2011 lgap_d2012 lgap_d2013 lgap_d2014 lgap_d2015 lgap_d2016) ${control} ${fix} if sex==`s'&age>=19&age<=24, cluster(prefecture);
qui estadd ysumm;
eststo: qui ivregress 2sls emp (lmw=lgap_d2003 lgap_d2004 lgap_d2005 lgap_d2006 lgap_d2008 lgap_d2009 lgap_d2010 lgap_d2011 lgap_d2012 lgap_d2013 lgap_d2014 lgap_d2015 lgap_d2016) ${control} ${fix} if sex==`s'&age>=25&age<=59, cluster(prefecture);
qui estadd ysumm;
eststo: qui ivregress 2sls emp (lmw=lgap_d2003 lgap_d2004 lgap_d2005 lgap_d2006 lgap_d2008 lgap_d2009 lgap_d2010 lgap_d2011 lgap_d2012 lgap_d2013 lgap_d2014 lgap_d2015 lgap_d2016) ${control} ${fix} if sex==`s'&age>=60&age<=64, cluster(prefecture);
qui estadd ysumm;
};
esttab, b(2) t(2) keep(lmw) se nostar compress mtitles("M19-24" "M25-59" "M60-64" "F19-24" "F25-59" "F60-64");
esttab using "${path}\out\crossreg_coll.tex", append label b(2) t(2) 
keep(lmw) se nostar compress stats(ymean N, labels ("Mean" "Observations") fmt(2 0))
fragment;
eststo clear;

forvalues s=1/2{;
eststo: qui ivregress 2sls emp (lmw=lgap_d2002 lgap_d2003 lgap_d2004 lgap_d2005 lgap_d2006 lgap_d2008 lgap_d2009 lgap_d2010 lgap_d2011 lgap_d2012 lgap_d2013 lgap_d2014 lgap_d2015 lgap_d2016) ${control} ${wo_fix} if sex==`s'&age>=19&age<=24, cluster(prefecture);
qui estadd ysumm;
eststo: qui ivregress 2sls emp (lmw=lgap_d2002 lgap_d2003 lgap_d2004 lgap_d2005 lgap_d2006 lgap_d2008 lgap_d2009 lgap_d2010 lgap_d2011 lgap_d2012 lgap_d2013 lgap_d2014 lgap_d2015 lgap_d2016) ${control} ${wo_fix} if sex==`s'&age>=25&age<=59, cluster(prefecture);
qui estadd ysumm;
eststo: qui ivregress 2sls emp (lmw=lgap_d2002 lgap_d2003 lgap_d2004 lgap_d2005 lgap_d2006 lgap_d2008 lgap_d2009 lgap_d2010 lgap_d2011 lgap_d2012 lgap_d2013 lgap_d2014 lgap_d2015 lgap_d2016) ${control} ${wo_fix} if sex==`s'&age>=60&age<=64, cluster(prefecture);
qui estadd ysumm;
};
esttab, b(2) t(2) keep(lmw) se nostar compress mtitles("M19-24" "M25-59" "M60-64" "F19-24" "F25-59" "F60-64");
esttab using "${path}\out\crossreg_coll.tex", append label b(2) t(2) 
keep(lmw) se nostar compress stats(ymean N, labels ("Mean" "Observations") fmt(2 0))
fragment;
eststo clear;


forvalues s=1/2{;
eststo: qui ivregress 2sls emp (lmw=lgap_d2003 lgap_d2004 lgap_d2005 lgap_d2006 lgap_d2008 lgap_d2009 lgap_d2010 lgap_d2011 lgap_d2012 lgap_d2013 lgap_d2014 lgap_d2015 lgap_d2016) ${control} ${wo_fix} if sex==`s'&age>=19&age<=24, cluster(prefecture);
qui estadd ysumm;
eststo: qui ivregress 2sls emp (lmw=lgap_d2003 lgap_d2004 lgap_d2005 lgap_d2006 lgap_d2008 lgap_d2009 lgap_d2010 lgap_d2011 lgap_d2012 lgap_d2013 lgap_d2014 lgap_d2015 lgap_d2016) ${control} ${wo_fix} if sex==`s'&age>=25&age<=59, cluster(prefecture);
qui estadd ysumm;
eststo: qui ivregress 2sls emp (lmw=lgap_d2003 lgap_d2004 lgap_d2005 lgap_d2006 lgap_d2008 lgap_d2009 lgap_d2010 lgap_d2011 lgap_d2012 lgap_d2013 lgap_d2014 lgap_d2015 lgap_d2016) ${control} ${wo_fix} if sex==`s'&age>=60&age<=64, cluster(prefecture);
qui estadd ysumm;
};
esttab, b(2) t(2) keep(lmw) se nostar compress mtitles("M19-24" "M25-59" "M60-64" "F19-24" "F25-59" "F60-64");
esttab using "${path}\out\crossreg_coll.tex", append label b(2) t(2) 
keep(lmw) se nostar compress stats(ymean N, labels ("Mean" "Observations") fmt(2 0))
fragment;
eststo clear;

forvalues s=1/2{;
eststo: qui ivregress 2sls emp (lmw=lgap_d2003 lgap_d2004 lgap_d2005 lgap_d2006 lgap_d2008 lgap_d2009 lgap_d2010 lgap_d2011 lgap_d2012 lgap_d2013 lgap_d2014 lgap_d2015 lgap_d2016) `control2' ${fix} if sex==`s'&age>=19&age<=24, cluster(prefecture);
qui estadd ysumm;
eststo: qui ivregress 2sls emp (lmw=lgap_d2003 lgap_d2004 lgap_d2005 lgap_d2006 lgap_d2008 lgap_d2009 lgap_d2010 lgap_d2011 lgap_d2012 lgap_d2013 lgap_d2014 lgap_d2015 lgap_d2016) `control2' ${fix} if sex==`s'&age>=25&age<=59, cluster(prefecture);
qui estadd ysumm;
eststo: qui ivregress 2sls emp (lmw=lgap_d2003 lgap_d2004 lgap_d2005 lgap_d2006 lgap_d2008 lgap_d2009 lgap_d2010 lgap_d2011 lgap_d2012 lgap_d2013 lgap_d2014 lgap_d2015 lgap_d2016) `control2' ${fix} if sex==`s'&age>=60&age<=64, cluster(prefecture);
qui estadd ysumm;
};
esttab, b(2) t(2) keep(lmw) se nostar compress mtitles("M19-24" "M25-59" "M60-64" "F19-24" "F25-59" "F60-64");
esttab using "${path}\out\crossreg_coll2.tex", append label b(2) t(2) 
keep(lmw) se nostar compress stats(ymean N, labels ("Mean" "Observations") fmt(2 0))
fragment;
eststo clear;

log close;
exit;

