#delimit ;

set more off;
cap log close;
cap eststo clear;
log using ${path}\log\cs_reg_iv_wotrend.log,replace;
clear;

use ${datapath}\cross.dta,replace;
label variable lmw "\$ \ln (MW)\$";
*gen zero1=0;
gen zero2=0;

forvalues y=2002/2016 {;
gen d`y'=(year==`y');
gen lgap_d`y'=lgap*d`y';
};

regress lmw lgap_d2002 lgap_d2003 lgap_d2004 lgap_d2005 lgap_d2006 zero2 lgap_d2008 lgap_d2009 lgap_d2010 lgap_d2011 lgap_d2012 lgap_d2013 lgap_d2014 lgap_d2015 lgap_d2016 ${control} ${wo_fix} , cluster(prefecture);
test lgap_d2002=lgap_d2003=lgap_d2004=lgap_d2005=lgap_d2006=0;
test lgap_d2008=lgap_d2009=lgap_d2010=lgap_d2011=lgap_d2012=lgap_d2013=lgap_d2014=lgap_d2015=lgap_d2016=0;
coefplot, omitted vertical xline(6.5, lpattern(dash))
keep(lgap_d2002 lgap_d2003 lgap_d2004 lgap_d2005 lgap_d2006 zero2 lgap_d2008 lgap_d2009 lgap_d2010 lgap_d2011 lgap_d2012 lgap_d2013 lgap_d2014 lgap_d2015 lgap_d2016) coeflabels
(lgap_d2002=02 lgap_d2003=03 lgap_d2004=04 lgap_d2005=05 lgap_d2006=06 zero2=07 lgap_d2008=08 lgap_d2009=09 lgap_d2010=10 lgap_d2011=11 lgap_d2012=12
lgap_d2013=13 lgap_d2014=14 lgap_d2015=15 lgap_d2016=16);
graph export "${path}\out\firststage_wotrend.pdf", replace;

regress emp lgap_d2002 lgap_d2003 lgap_d2004 lgap_d2005 lgap_d2006 zero2 lgap_d2008 lgap_d2009 lgap_d2010 lgap_d2011 lgap_d2012 lgap_d2013 lgap_d2014 lgap_d2015 lgap_d2016 ${control} ${wo_fix} if sex==1&age>=19&age<=24, cluster(prefecture);
test lgap_d2002=lgap_d2003=lgap_d2004=lgap_d2005=lgap_d2006=0;
coefplot, omitted vertical xline(6.5, lpattern(dash)) yline(0)
keep(lgap_d2002 lgap_d2003 lgap_d2004 lgap_d2005 lgap_d2006 zero2 lgap_d2008 lgap_d2009 lgap_d2010 lgap_d2011 lgap_d2012 lgap_d2013 lgap_d2014 lgap_d2015 lgap_d2016) 
coeflabels(lgap_d2002=2 lgap_d2003=3 lgap_d2004=4 lgap_d2005=5 lgap_d2006=6 zero2=7 lgap_d2008=8 lgap_d2009=9 lgap_d2010=10 lgap_d2011=11 lgap_d2012=12
lgap_d2013=13 lgap_d2014=14 lgap_d2015=15 lgap_d2016=16)
name(m1924, replace) title("Male 19-24");

regress emp lgap_d2002 lgap_d2003 lgap_d2004 lgap_d2005 lgap_d2006 zero2 lgap_d2008 lgap_d2009 lgap_d2010 lgap_d2011 lgap_d2012 lgap_d2013 lgap_d2014 lgap_d2015 lgap_d2016 ${control} ${wo_fix} if sex==1&age>=25&age<=59, cluster(prefecture);
test lgap_d2002=lgap_d2003=lgap_d2004=lgap_d2005=lgap_d2006=0;
coefplot, omitted vertical xline(6.5, lpattern(dash)) yline(0)
keep(lgap_d2002 lgap_d2003 lgap_d2004 lgap_d2005 lgap_d2006 zero2 lgap_d2008 lgap_d2009 lgap_d2010 lgap_d2011 lgap_d2012 lgap_d2013 lgap_d2014 lgap_d2015 lgap_d2016) 
coeflabels(lgap_d2002=2 lgap_d2003=3 lgap_d2004=4 lgap_d2005=5 lgap_d2006=6 zero2=7 lgap_d2008=8 lgap_d2009=9 lgap_d2010=10 lgap_d2011=11 lgap_d2012=12
lgap_d2013=13 lgap_d2014=14 lgap_d2015=15 lgap_d2016=16)
name(m2559, replace) title("Male 25-59");

regress emp lgap_d2002 lgap_d2003 lgap_d2004 lgap_d2005 lgap_d2006 zero2 lgap_d2008 lgap_d2009 lgap_d2010 lgap_d2011 lgap_d2012 lgap_d2013 lgap_d2014 lgap_d2015 lgap_d2016 ${control} ${wo_fix} if sex==1&age>=60&age<=64, cluster(prefecture);
test lgap_d2002=lgap_d2003=lgap_d2004=lgap_d2005=lgap_d2006=0;
coefplot, omitted vertical xline(6.5, lpattern(dash)) yline(0)
keep(lgap_d2002 lgap_d2003 lgap_d2004 lgap_d2005 lgap_d2006 zero2 lgap_d2008 lgap_d2009 lgap_d2010 lgap_d2011 lgap_d2012 lgap_d2013 lgap_d2014 lgap_d2015 lgap_d2016) 
coeflabels(lgap_d2002=2 lgap_d2003=3 lgap_d2004=4 lgap_d2005=5 lgap_d2006=6 zero2=7 lgap_d2008=8 lgap_d2009=9 lgap_d2010=10 lgap_d2011=11 lgap_d2012=12
lgap_d2013=13 lgap_d2014=14 lgap_d2015=15 lgap_d2016=16)
name(m6064, replace) title("Male 60-64");

regress emp lgap_d2002 lgap_d2003 lgap_d2004 lgap_d2005 lgap_d2006 zero2 lgap_d2008 lgap_d2009 lgap_d2010 lgap_d2011 lgap_d2012 lgap_d2013 lgap_d2014 lgap_d2015 lgap_d2016 ${control} ${wo_fix} if sex==2&age>=19&age<=24, cluster(prefecture);
test lgap_d2002=lgap_d2003=lgap_d2004=lgap_d2005=lgap_d2006=0;
coefplot, omitted vertical xline(6.5, lpattern(dash)) yline(0)
keep(lgap_d2002 lgap_d2003 lgap_d2004 lgap_d2005 lgap_d2006 zero2 lgap_d2008 lgap_d2009 lgap_d2010 lgap_d2011 lgap_d2012 lgap_d2013 lgap_d2014 lgap_d2015 lgap_d2016) 
coeflabels(lgap_d2002=2 lgap_d2003=3 lgap_d2004=4 lgap_d2005=5 lgap_d2006=6 zero2=7 lgap_d2008=8 lgap_d2009=9 lgap_d2010=10 lgap_d2011=11 lgap_d2012=12
lgap_d2013=13 lgap_d2014=14 lgap_d2015=15 lgap_d2016=16)
name(f1924, replace) title("Female 19-24");

regress emp lgap_d2002 lgap_d2003 lgap_d2004 lgap_d2005 lgap_d2006 zero2 lgap_d2008 lgap_d2009 lgap_d2010 lgap_d2011 lgap_d2012 lgap_d2013 lgap_d2014 lgap_d2015 lgap_d2016 ${control} ${wo_fix} if sex==2&age>=25&age<=59, cluster(prefecture);
test lgap_d2002=lgap_d2003=lgap_d2004=lgap_d2005=lgap_d2006=0;
coefplot, omitted vertical xline(6.5, lpattern(dash)) yline(0)
keep(lgap_d2002 lgap_d2003 lgap_d2004 lgap_d2005 lgap_d2006 zero2 lgap_d2008 lgap_d2009 lgap_d2010 lgap_d2011 lgap_d2012 lgap_d2013 lgap_d2014 lgap_d2015 lgap_d2016) 
coeflabels(lgap_d2002=2 lgap_d2003=3 lgap_d2004=4 lgap_d2005=5 lgap_d2006=6 zero2=7 lgap_d2008=8 lgap_d2009=9 lgap_d2010=10 lgap_d2011=11 lgap_d2012=12
lgap_d2013=13 lgap_d2014=14 lgap_d2015=15 lgap_d2016=16)
name(f2559, replace) title("Female 25-59");

regress emp lgap_d2002 lgap_d2003 lgap_d2004 lgap_d2005 lgap_d2006 zero2 lgap_d2008 lgap_d2009 lgap_d2010 lgap_d2011 lgap_d2012 lgap_d2013 lgap_d2014 lgap_d2015 lgap_d2016 ${control} ${wo_fix} if sex==2&age>=60&age<=64, cluster(prefecture);
test lgap_d2002=lgap_d2003=lgap_d2004=lgap_d2005=lgap_d2006=0;
coefplot, omitted vertical xline(6.5, lpattern(dash)) yline(0)
keep(lgap_d2002 lgap_d2003 lgap_d2004 lgap_d2005 lgap_d2006 zero2 lgap_d2008 lgap_d2009 lgap_d2010 lgap_d2011 lgap_d2012 lgap_d2013 lgap_d2014 lgap_d2015 lgap_d2016) 
coeflabels(lgap_d2002=2 lgap_d2003=3 lgap_d2004=4 lgap_d2005=5 lgap_d2006=6 zero2=7 lgap_d2008=8 lgap_d2009=9 lgap_d2010=10 lgap_d2011=11 lgap_d2012=12
lgap_d2013=13 lgap_d2014=14 lgap_d2015=15 lgap_d2016=16)
name(f6064, replace) title("Female 60-64");

graph combine m1924 m2559 m6064 f1924 f2559 f6064, rows(2);
graph export "${path}\out\reducedform_wotrend.pdf", replace;

forvalues s=1/2{;
eststo: qui ivregress 2sls emp (lmw=lgap_d2002 lgap_d2003 lgap_d2004 lgap_d2005 lgap_d2006 lgap_d2008 lgap_d2009 lgap_d2010 lgap_d2011 lgap_d2012 lgap_d2013 lgap_d2014 lgap_d2015 lgap_d2016) ${control} ${wo_fix} if sex==`s'&age>=19&age<=24, cluster(prefecture);
qui estadd ysumm;
eststo: qui ivregress 2sls emp (lmw=lgap_d2002 lgap_d2003 lgap_d2004 lgap_d2005 lgap_d2006 lgap_d2008 lgap_d2009 lgap_d2010 lgap_d2011 lgap_d2012 lgap_d2013 lgap_d2014 lgap_d2015 lgap_d2016) ${control} ${wo_fix} if sex==`s'&age>=25&age<=59, cluster(prefecture);
qui estadd ysumm;
eststo: qui ivregress 2sls emp (lmw=lgap_d2002 lgap_d2003 lgap_d2004 lgap_d2005 lgap_d2006 lgap_d2008 lgap_d2009 lgap_d2010 lgap_d2011 lgap_d2012 lgap_d2013 lgap_d2014 lgap_d2015 lgap_d2016) ${control} ${wo_fix} if sex==`s'&age>=60&age<=64, cluster(prefecture);
qui estadd ysumm;
};
esttab, b(2) t(2) keep(lmw) se nostar compress mtitles("M19-24" "M25-59" "M60-64" "F19-24" "F25-59" "F60-64");
esttab using "${path}\out\crossreg_wotrend.tex", append label b(2) t(2) 
keep(lmw) se nostar compress stats(ymean N, labels ("Mean" "Observations") fmt(2 0))
fragment;
eststo clear;

forvalues s=1/2{;
qui regress lmw lgap_d2002 lgap_d2003 lgap_d2004 lgap_d2005 lgap_d2006 lgap_d2008 lgap_d2009 lgap_d2010 lgap_d2011 lgap_d2012 lgap_d2013 lgap_d2014 lgap_d2015 lgap_d2016 ${control} ${wo_fix} if sex==`s'&age>=19&age<=24, cluster(prefecture);
predict vhat, residual;
eststo: qui regress emp vhat lmw ${control} ${wo_fix} if sex==`s'&age>=19&age<=24, cluster(prefecture);
drop vhat;

qui regress lmw lgap_d2002 lgap_d2003 lgap_d2004 lgap_d2005 lgap_d2006 lgap_d2008 lgap_d2009 lgap_d2010 lgap_d2011 lgap_d2012 lgap_d2013 lgap_d2014 lgap_d2015 lgap_d2016 ${control} ${wo_fix} if sex==`s'&age>=25&age<=59, cluster(prefecture);
predict vhat, residual;
eststo: qui regress emp vhat lmw ${control} ${wo_fix} if sex==`s'&age>=25&age<=59, cluster(prefecture);
drop vhat;

qui regress lmw lgap_d2002 lgap_d2003 lgap_d2004 lgap_d2005 lgap_d2006 lgap_d2008 lgap_d2009 lgap_d2010 lgap_d2011 lgap_d2012 lgap_d2013 lgap_d2014 lgap_d2015 lgap_d2016 ${control} ${wo_fix} if sex==`s'&age>=60&age<=64, cluster(prefecture);
predict vhat, residual;
eststo: qui regress emp vhat lmw ${control} ${wo_fix} if sex==`s'&age>=60&age<=64, cluster(prefecture);
drop vhat;
};

esttab, b(2) t(2) keep(vhat) p nostar compress;
esttab using "${path}\out\crossreg_wotrend.tex", append label b(2) t(2) 
keep(vhat) se nostar compress fragment;
eststo clear;

forvalues s=1/2{;
eststo: qui ivregress 2sls lf (lmw=lgap_d2002 lgap_d2003 lgap_d2004 lgap_d2005 lgap_d2006 lgap_d2008 lgap_d2009 lgap_d2010 lgap_d2011 lgap_d2012 lgap_d2013 lgap_d2014 lgap_d2015 lgap_d2016) ${control} ${wo_fix} if sex==`s'&age>=19&age<=24, cluster(prefecture);
qui estadd ysumm;
eststo: qui ivregress 2sls lf (lmw=lgap_d2002 lgap_d2003 lgap_d2004 lgap_d2005 lgap_d2006 lgap_d2008 lgap_d2009 lgap_d2010 lgap_d2011 lgap_d2012 lgap_d2013 lgap_d2014 lgap_d2015 lgap_d2016) ${control} ${wo_fix} if sex==`s'&age>=25&age<=59, cluster(prefecture);
qui estadd ysumm;
eststo: qui ivregress 2sls lf (lmw=lgap_d2002 lgap_d2003 lgap_d2004 lgap_d2005 lgap_d2006 lgap_d2008 lgap_d2009 lgap_d2010 lgap_d2011 lgap_d2012 lgap_d2013 lgap_d2014 lgap_d2015 lgap_d2016) ${control} ${wo_fix} if sex==`s'&age>=60&age<=64, cluster(prefecture);
qui estadd ysumm;
};
esttab, b(2) t(2) keep(lmw) se nostar compress mtitles("M19-24" "M25-59" "M60-64" "F19-24" "F25-59" "F60-64");
esttab using "${path}\out\crossreg_wotrend.tex", append label b(2) t(2)  
keep(lmw) se nostar compress stats(ymean N, labels ("Mean" "Observations") fmt(2 0))
fragment;
eststo clear;

forvalues s=1/2{;
qui regress lmw lgap_d2002 lgap_d2003 lgap_d2004 lgap_d2005 lgap_d2006 lgap_d2008 lgap_d2009 lgap_d2010 lgap_d2011 lgap_d2012 lgap_d2013 lgap_d2014 lgap_d2015 lgap_d2016 ${control} ${wo_fix} if sex==`s'&age>=19&age<=24, cluster(prefecture);
predict vhat, residual;
eststo: qui regress lf vhat lmw ${control} ${fix} if sex==`s'&age>=19&age<=24, cluster(prefecture);
drop vhat;

qui regress lmw lgap_d2002 lgap_d2003 lgap_d2004 lgap_d2005 lgap_d2006 lgap_d2008 lgap_d2009 lgap_d2010 lgap_d2011 lgap_d2012 lgap_d2013 lgap_d2014 lgap_d2015 lgap_d2016 ${control} ${wo_fix} if sex==`s'&age>=25&age<=59, cluster(prefecture);
predict vhat, residual;
eststo: qui regress lf vhat lmw ${control} ${fix} if sex==`s'&age>=25&age<=59, cluster(prefecture);
drop vhat;

qui regress lmw lgap_d2002 lgap_d2003 lgap_d2004 lgap_d2005 lgap_d2006 lgap_d2008 lgap_d2009 lgap_d2010 lgap_d2011 lgap_d2012 lgap_d2013 lgap_d2014 lgap_d2015 lgap_d2016 ${control} ${wo_fix} if sex==`s'&age>=60&age<=64, cluster(prefecture);
predict vhat, residual;
eststo: qui regress lf vhat lmw ${control} ${fix}  if sex==`s'&age>=60&age<=64, cluster(prefecture);
drop vhat;
};

esttab, b(2) t(2) keep(vhat) p nostar compress;
esttab using "${path}\out\crossreg_wotrend.tex", append label b(2) t(2) 
keep(vhat) se nostar compress fragment;
eststo clear;

forvalues s=1/2{;
eststo: qui ivregress 2sls lhour (lmw=lgap_d2002 lgap_d2003 lgap_d2004 lgap_d2005 lgap_d2006 lgap_d2008 lgap_d2009 lgap_d2010 lgap_d2011 lgap_d2012 lgap_d2013 lgap_d2014 lgap_d2015 lgap_d2016) ${control} ${wo_fix} if sex==`s'&age>=19&age<=24, cluster(prefecture);
eststo: qui ivregress 2sls lhour (lmw=lgap_d2002 lgap_d2003 lgap_d2004 lgap_d2005 lgap_d2006 lgap_d2008 lgap_d2009 lgap_d2010 lgap_d2011 lgap_d2012 lgap_d2013 lgap_d2014 lgap_d2015 lgap_d2016) ${control} ${wo_fix} if sex==`s'&age>=25&age<=59, cluster(prefecture);
eststo: qui ivregress 2sls lhour (lmw=lgap_d2002 lgap_d2003 lgap_d2004 lgap_d2005 lgap_d2006 lgap_d2008 lgap_d2009 lgap_d2010 lgap_d2011 lgap_d2012 lgap_d2013 lgap_d2014 lgap_d2015 lgap_d2016) ${control} ${wo_fix} if sex==`s'&age>=60&age<=64, cluster(prefecture);
};
esttab, b(2) t(2) keep(lmw) se nostar compress mtitles("M19-24" "M25-59" "M60-64" "F19-24" "F25-59" "F60-64");
esttab using "${path}\out\crossreg_wotrend.tex", append label b(2) t(2)  
keep(lmw) se nostar compress fragment;
eststo clear;


forvalues s=1/2{;
qui regress lmw lgap_d2002 lgap_d2003 lgap_d2004 lgap_d2005 lgap_d2006 lgap_d2008 lgap_d2009 lgap_d2010 lgap_d2011 lgap_d2012 lgap_d2013 lgap_d2014 lgap_d2015 lgap_d2016 ${control} ${wo_fix} if sex==`s'&age>=19&age<=24, cluster(prefecture);
predict vhat, residual;
eststo: qui regress lf vhat lmw ${control} ${fix} if sex==`s'&age>=19&age<=24, cluster(prefecture);
drop vhat;

qui regress lmw lgap_d2002 lgap_d2003 lgap_d2004 lgap_d2005 lgap_d2006 lgap_d2008 lgap_d2009 lgap_d2010 lgap_d2011 lgap_d2012 lgap_d2013 lgap_d2014 lgap_d2015 lgap_d2016 ${control} ${wo_fix} if sex==`s'&age>=25&age<=59, cluster(prefecture);
predict vhat, residual;
eststo: qui regress lf vhat lmw ${control} ${fix} if sex==`s'&age>=25&age<=59, cluster(prefecture);
drop vhat;

qui regress lmw lgap_d2002 lgap_d2003 lgap_d2004 lgap_d2005 lgap_d2006 lgap_d2008 lgap_d2009 lgap_d2010 lgap_d2011 lgap_d2012 lgap_d2013 lgap_d2014 lgap_d2015 lgap_d2016 ${control} ${wo_fix} if sex==`s'&age>=60&age<=64, cluster(prefecture);
predict vhat, residual;
eststo: qui regress lf vhat lmw ${control} ${fix} if sex==`s'&age>=60&age<=64, cluster(prefecture);
drop vhat;
};

esttab, b(2) t(2) keep(vhat) p nostar compress;
esttab using "${path}\out\crossreg_wotrend.tex", append label b(2) t(2) 
keep(vhat) se nostar compress fragment;
eststo clear;


log close;
exit;

