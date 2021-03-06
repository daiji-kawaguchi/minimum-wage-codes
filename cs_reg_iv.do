#delimit ;
set more off;
cap log close;
cap eststo clear;
log using ${path}\log\cs_reg_iv.log,replace;
clear;

use ${datapath}\cross.dta,replace;
label variable lmw "\$ \ln (MW)\$";
gen zero1=0;
gen zero2=0;

forvalues y=2002/2016 {;
gen d`y'=(year==`y');
gen lgap_d`y'=lgap*d`y';
};

regress lmw zero1 lgap_d2003 lgap_d2004 lgap_d2005 lgap_d2006 zero2 lgap_d2008 lgap_d2009 lgap_d2010 lgap_d2011 lgap_d2012 lgap_d2013 lgap_d2014 lgap_d2015 lgap_d2016 ${control} ${fix}, cluster(prefecture);
test lgap_d2003=lgap_d2004=lgap_d2005=lgap_d2006=0;
test lgap_d2008=lgap_d2009=lgap_d2010=lgap_d2011=lgap_d2012=lgap_d2013=lgap_d2014=lgap_d2015=lgap_d2016=0;
coefplot, omitted vertical xline(6.5, lpattern(dash))
keep(zero1 lgap_d2003 lgap_d2004 lgap_d2005 lgap_d2006 zero2 lgap_d2008 lgap_d2009 lgap_d2010 lgap_d2011 lgap_d2012 lgap_d2013 lgap_d2014 lgap_d2015 lgap_d2016) coeflabels
(zero1=02 lgap_d2003=03 lgap_d2004=04 lgap_d2005=05 lgap_d2006=06 zero2=07 lgap_d2008=08 lgap_d2009=09 lgap_d2010=10 lgap_d2011=11 lgap_d2012=12
lgap_d2013=13 lgap_d2014=14 lgap_d2015=15 lgap_d2016=16);
graph export "${path}\out\firststage.pdf", replace;

regress emp zero1 lgap_d2003 lgap_d2004 lgap_d2005 lgap_d2006 zero2 lgap_d2008 lgap_d2009 lgap_d2010 lgap_d2011 lgap_d2012 lgap_d2013 lgap_d2014 lgap_d2015 lgap_d2016 ${control} ${fix} if sex==1&age>=19&age<=24, cluster(prefecture);
test lgap_d2003=lgap_d2004=lgap_d2005=lgap_d2006=0;
coefplot, omitted vertical xline(6.5, lpattern(dash)) yline(0)
keep(zero1 lgap_d2003 lgap_d2004 lgap_d2005 lgap_d2006 zero2 lgap_d2008 lgap_d2009 lgap_d2010 lgap_d2011 lgap_d2012 lgap_d2013 lgap_d2014 lgap_d2015 lgap_d2016) 
coeflabels(zero1=2 lgap_d2003=3 lgap_d2004=4 lgap_d2005=5 lgap_d2006=6 zero2=7 lgap_d2008=8 lgap_d2009=9 lgap_d2010=10 lgap_d2011=11 lgap_d2012=12
lgap_d2013=13 lgap_d2014=14 lgap_d2015=15 lgap_d2016=16)
name(m1924, replace) title("Male 19-24");

regress emp zero1 lgap_d2003 lgap_d2004 lgap_d2005 lgap_d2006 zero2 lgap_d2008 lgap_d2009 lgap_d2010 lgap_d2011 lgap_d2012 lgap_d2013 lgap_d2014 lgap_d2015 lgap_d2016 ${control} ${fix} if sex==1&age>=25&age<=59, cluster(prefecture);
test lgap_d2003=lgap_d2004=lgap_d2005=lgap_d2006=0;
coefplot, omitted vertical xline(6.5, lpattern(dash)) yline(0)
keep(zero1 lgap_d2003 lgap_d2004 lgap_d2005 lgap_d2006 zero2 lgap_d2008 lgap_d2009 lgap_d2010 lgap_d2011 lgap_d2012 lgap_d2013 lgap_d2014 lgap_d2015 lgap_d2016) 
coeflabels(zero1=2 lgap_d2003=3 lgap_d2004=4 lgap_d2005=5 lgap_d2006=6 zero2=7 lgap_d2008=8 lgap_d2009=9 lgap_d2010=10 lgap_d2011=11 lgap_d2012=12
lgap_d2013=13 lgap_d2014=14 lgap_d2015=15 lgap_d2016=16)
name(m2559, replace) title("Male 25-59");

regress emp zero1 lgap_d2003 lgap_d2004 lgap_d2005 lgap_d2006 zero2 lgap_d2008 lgap_d2009 lgap_d2010 lgap_d2011 lgap_d2012 lgap_d2013 lgap_d2014 lgap_d2015 lgap_d2016 ${control} ${fix} if sex==1&age>=60&age<=64, cluster(prefecture);
test lgap_d2003=lgap_d2004=lgap_d2005=lgap_d2006=0;
coefplot, omitted vertical xline(6.5, lpattern(dash)) yline(0)
keep(zero1 lgap_d2003 lgap_d2004 lgap_d2005 lgap_d2006 zero2 lgap_d2008 lgap_d2009 lgap_d2010 lgap_d2011 lgap_d2012 lgap_d2013 lgap_d2014 lgap_d2015 lgap_d2016) 
coeflabels(zero1=2 lgap_d2003=3 lgap_d2004=4 lgap_d2005=5 lgap_d2006=6 zero2=7 lgap_d2008=8 lgap_d2009=9 lgap_d2010=10 lgap_d2011=11 lgap_d2012=12
lgap_d2013=13 lgap_d2014=14 lgap_d2015=15 lgap_d2016=16)
name(m6064, replace) title("Male 60-64");

regress emp zero1 lgap_d2003 lgap_d2004 lgap_d2005 lgap_d2006 zero2 lgap_d2008 lgap_d2009 lgap_d2010 lgap_d2011 lgap_d2012 lgap_d2013 lgap_d2014 lgap_d2015 lgap_d2016 ${control} ${fix} if sex==2&age>=19&age<=24, cluster(prefecture);
test lgap_d2003=lgap_d2004=lgap_d2005=lgap_d2006=0;
coefplot, omitted vertical xline(6.5, lpattern(dash)) yline(0)
keep(zero1 lgap_d2003 lgap_d2004 lgap_d2005 lgap_d2006 zero2 lgap_d2008 lgap_d2009 lgap_d2010 lgap_d2011 lgap_d2012 lgap_d2013 lgap_d2014 lgap_d2015 lgap_d2016) 
coeflabels(zero1=2 lgap_d2003=3 lgap_d2004=4 lgap_d2005=5 lgap_d2006=6 zero2=7 lgap_d2008=8 lgap_d2009=9 lgap_d2010=10 lgap_d2011=11 lgap_d2012=12
lgap_d2013=13 lgap_d2014=14 lgap_d2015=15 lgap_d2016=16)
name(f1924, replace) title("Female 19-24");

regress emp zero1 lgap_d2003 lgap_d2004 lgap_d2005 lgap_d2006 zero2 lgap_d2008 lgap_d2009 lgap_d2010 lgap_d2011 lgap_d2012 lgap_d2013 lgap_d2014 lgap_d2015 lgap_d2016 ${control} ${fix} if sex==2&age>=25&age<=59, cluster(prefecture);
test lgap_d2003=lgap_d2004=lgap_d2005=lgap_d2006=0;
coefplot, omitted vertical xline(6.5, lpattern(dash)) yline(0)
keep(zero1 lgap_d2003 lgap_d2004 lgap_d2005 lgap_d2006 zero2 lgap_d2008 lgap_d2009 lgap_d2010 lgap_d2011 lgap_d2012 lgap_d2013 lgap_d2014 lgap_d2015 lgap_d2016) 
coeflabels(zero1=2 lgap_d2003=3 lgap_d2004=4 lgap_d2005=5 lgap_d2006=6 zero2=7 lgap_d2008=8 lgap_d2009=9 lgap_d2010=10 lgap_d2011=11 lgap_d2012=12
lgap_d2013=13 lgap_d2014=14 lgap_d2015=15 lgap_d2016=16)
name(f2559, replace) title("Female 25-59");

regress emp zero1 lgap_d2003 lgap_d2004 lgap_d2005 lgap_d2006 zero2 lgap_d2008 lgap_d2009 lgap_d2010 lgap_d2011 lgap_d2012 lgap_d2013 lgap_d2014 lgap_d2015 lgap_d2016 ${control} ${fix} if sex==2&age>=60&age<=64, cluster(prefecture);
test lgap_d2003=lgap_d2004=lgap_d2005=lgap_d2006=0;
coefplot, omitted vertical xline(6.5, lpattern(dash)) yline(0)
keep(zero1 lgap_d2003 lgap_d2004 lgap_d2005 lgap_d2006 zero2 lgap_d2008 lgap_d2009 lgap_d2010 lgap_d2011 lgap_d2012 lgap_d2013 lgap_d2014 lgap_d2015 lgap_d2016) 
coeflabels(zero1=2 lgap_d2003=3 lgap_d2004=4 lgap_d2005=5 lgap_d2006=6 zero2=7 lgap_d2008=8 lgap_d2009=9 lgap_d2010=10 lgap_d2011=11 lgap_d2012=12
lgap_d2013=13 lgap_d2014=14 lgap_d2015=15 lgap_d2016=16)
name(f6064, replace) title("Female 60-64");

graph combine m1924 m2559 m6064 f1924 f2559 f6064, rows(2);
graph export "${path}\out\reducedform.pdf", replace;

forvalues s=1/2{;
eststo: qui ivregress 2sls emp (lmw=lgap_d2003 lgap_d2004 lgap_d2005 lgap_d2006 lgap_d2008 lgap_d2009 lgap_d2010 lgap_d2011 lgap_d2012 lgap_d2013 lgap_d2014 lgap_d2015 lgap_d2016) ${control} ${fix} if sex==`s'&age>=19&age<=24, cluster(prefecture);
qui estadd ysumm;
eststo: qui ivregress 2sls emp (lmw=lgap_d2003 lgap_d2004 lgap_d2005 lgap_d2006 lgap_d2008 lgap_d2009 lgap_d2010 lgap_d2011 lgap_d2012 lgap_d2013 lgap_d2014 lgap_d2015 lgap_d2016) ${control} ${fix} if sex==`s'&age>=25&age<=59, cluster(prefecture);
qui estadd ysumm;
eststo: qui ivregress 2sls emp (lmw=lgap_d2003 lgap_d2004 lgap_d2005 lgap_d2006 lgap_d2008 lgap_d2009 lgap_d2010 lgap_d2011 lgap_d2012 lgap_d2013 lgap_d2014 lgap_d2015 lgap_d2016) ${control} ${fix} if sex==`s'&age>=60&age<=64, cluster(prefecture);
qui estadd ysumm;
};
esttab, b(2) t(2) keep(lmw) se nostar compress mtitles("M19-24" "M25-59" "M60-64" "F19-24" "F25-59" "F60-64");
esttab using "${path}\out\crossreg.tex", append label b(2) t(2) 
keep(lmw) se nostar compress stats(ymean N, labels ("Mean" "Observations") fmt(2 0))
fragment;
eststo clear;
*/;
forvalues s=1/2{;
qui regress lmw lgap_d2003 lgap_d2004 lgap_d2005 lgap_d2006 lgap_d2008 lgap_d2009 lgap_d2010 lgap_d2011 lgap_d2012 lgap_d2013 lgap_d2014 lgap_d2015 lgap_d2016 ${control} ${fix} if sex==`s'&age>=19&age<=24, cluster(prefecture);
predict vhat, residual;
eststo: qui regress emp vhat lmw ${control} ${fix} if sex==`s'&age>=19&age<=24, cluster(prefecture);
drop vhat;

qui regress lmw lgap_d2003 lgap_d2004 lgap_d2005 lgap_d2006 lgap_d2008 lgap_d2009 lgap_d2010 lgap_d2011 lgap_d2012 lgap_d2013 lgap_d2014 lgap_d2015 lgap_d2016 ${control} ${fix} if sex==`s'&age>=25&age<=59, cluster(prefecture);
predict vhat, residual;
eststo: qui regress emp vhat lmw ${control} ${fix} if sex==`s'&age>=25&age<=59, cluster(prefecture);
drop vhat;

qui regress lmw lgap_d2003 lgap_d2004 lgap_d2005 lgap_d2006 lgap_d2008 lgap_d2009 lgap_d2010 lgap_d2011 lgap_d2012 lgap_d2013 lgap_d2014 lgap_d2015 lgap_d2016 ${control} ${fix} if sex==`s'&age>=60&age<=64, cluster(prefecture);
predict vhat, residual;
eststo: qui regress emp vhat lmw ${control} ${fix} if sex==`s'&age>=60&age<=64, cluster(prefecture);
drop vhat;
};

esttab, b(2) t(2) keep(vhat) p nostar compress;
esttab using "${path}\out\crossreg.tex", append label b(2) t(2) 
keep(vhat) se nostar compress fragment;
eststo clear;


regress lf zero1 lgap_d2003 lgap_d2004 lgap_d2005 lgap_d2006 zero2 lgap_d2008 lgap_d2009 lgap_d2010 lgap_d2011 lgap_d2012 lgap_d2013 lgap_d2014 lgap_d2015 lgap_d2016 ${control} ${fix} if sex==1&age>=19&age<=24, cluster(prefecture);
coefplot, omitted vertical xline(6.5, lpattern(dash)) yline(0)
keep(zero1 lgap_d2003 lgap_d2004 lgap_d2005 lgap_d2006 zero2 lgap_d2008 lgap_d2009 lgap_d2010 lgap_d2011 lgap_d2012 lgap_d2013 lgap_d2014 lgap_d2015 lgap_d2016) 
coeflabels(zero1=2 lgap_d2003=3 lgap_d2004=4 lgap_d2005=5 lgap_d2006=6 zero2=7 lgap_d2008=8 lgap_d2009=9 lgap_d2010=10 lgap_d2011=11 lgap_d2012=12
lgap_d2013=13 lgap_d2014=14 lgap_d2015=15 lgap_d2016=16)
name(m1924, replace) title("Male 19-24");

regress lf zero1 lgap_d2003 lgap_d2004 lgap_d2005 lgap_d2006 zero2 lgap_d2008 lgap_d2009 lgap_d2010 lgap_d2011 lgap_d2012 lgap_d2013 lgap_d2014 lgap_d2015 lgap_d2016 ${control} ${fix} if sex==1&age>=25&age<=59, cluster(prefecture);
coefplot, omitted vertical xline(6.5, lpattern(dash)) yline(0)
keep(zero1 lgap_d2003 lgap_d2004 lgap_d2005 lgap_d2006 zero2 lgap_d2008 lgap_d2009 lgap_d2010 lgap_d2011 lgap_d2012 lgap_d2013 lgap_d2014 lgap_d2015 lgap_d2016) 
coeflabels(zero1=2 lgap_d2003=3 lgap_d2004=4 lgap_d2005=5 lgap_d2006=6 zero2=7 lgap_d2008=8 lgap_d2009=9 lgap_d2010=10 lgap_d2011=11 lgap_d2012=12
lgap_d2013=13 lgap_d2014=14 lgap_d2015=15 lgap_d2016=16)
name(m2559, replace) title("Male 25-59");

regress lf zero1 lgap_d2003 lgap_d2004 lgap_d2005 lgap_d2006 zero2 lgap_d2008 lgap_d2009 lgap_d2010 lgap_d2011 lgap_d2012 lgap_d2013 lgap_d2014 lgap_d2015 lgap_d2016 ${control} ${fix} if sex==1&age>=60&age<=64, cluster(prefecture);
coefplot, omitted vertical xline(6.5, lpattern(dash)) yline(0)
keep(zero1 lgap_d2003 lgap_d2004 lgap_d2005 lgap_d2006 zero2 lgap_d2008 lgap_d2009 lgap_d2010 lgap_d2011 lgap_d2012 lgap_d2013 lgap_d2014 lgap_d2015 lgap_d2016) 
coeflabels(zero1=2 lgap_d2003=3 lgap_d2004=4 lgap_d2005=5 lgap_d2006=6 zero2=7 lgap_d2008=8 lgap_d2009=9 lgap_d2010=10 lgap_d2011=11 lgap_d2012=12
lgap_d2013=13 lgap_d2014=14 lgap_d2015=15 lgap_d2016=16)
name(m6064, replace) title("Male 60-64");

regress lf zero1 lgap_d2003 lgap_d2004 lgap_d2005 lgap_d2006 zero2 lgap_d2008 lgap_d2009 lgap_d2010 lgap_d2011 lgap_d2012 lgap_d2013 lgap_d2014 lgap_d2015 lgap_d2016 ${control} ${fix} if sex==2&age>=19&age<=24, cluster(prefecture);
coefplot, omitted vertical xline(6.5, lpattern(dash)) yline(0)
keep(zero1 lgap_d2003 lgap_d2004 lgap_d2005 lgap_d2006 zero2 lgap_d2008 lgap_d2009 lgap_d2010 lgap_d2011 lgap_d2012 lgap_d2013 lgap_d2014 lgap_d2015 lgap_d2016) 
coeflabels(zero1=2 lgap_d2003=3 lgap_d2004=4 lgap_d2005=5 lgap_d2006=6 zero2=7 lgap_d2008=8 lgap_d2009=9 lgap_d2010=10 lgap_d2011=11 lgap_d2012=12
lgap_d2013=13 lgap_d2014=14 lgap_d2015=15 lgap_d2016=16)
name(f1924, replace) title("Female 19-24");

regress lf zero1 lgap_d2003 lgap_d2004 lgap_d2005 lgap_d2006 zero2 lgap_d2008 lgap_d2009 lgap_d2010 lgap_d2011 lgap_d2012 lgap_d2013 lgap_d2014 lgap_d2015 lgap_d2016 ${control} ${fix} if sex==2&age>=25&age<=59, cluster(prefecture);
coefplot, omitted vertical xline(6.5, lpattern(dash)) yline(0)
keep(zero1 lgap_d2003 lgap_d2004 lgap_d2005 lgap_d2006 zero2 lgap_d2008 lgap_d2009 lgap_d2010 lgap_d2011 lgap_d2012 lgap_d2013 lgap_d2014 lgap_d2015 lgap_d2016) 
coeflabels(zero1=2 lgap_d2003=3 lgap_d2004=4 lgap_d2005=5 lgap_d2006=6 zero2=7 lgap_d2008=8 lgap_d2009=9 lgap_d2010=10 lgap_d2011=11 lgap_d2012=12
lgap_d2013=13 lgap_d2014=14 lgap_d2015=15 lgap_d2016=16)
name(f2559, replace) title("Female 25-59");

regress lf zero1 lgap_d2003 lgap_d2004 lgap_d2005 lgap_d2006 zero2 lgap_d2008 lgap_d2009 lgap_d2010 lgap_d2011 lgap_d2012 lgap_d2013 lgap_d2014 lgap_d2015 lgap_d2016 ${control} ${fix} if sex==2&age>=60&age<=64, cluster(prefecture);
coefplot, omitted vertical xline(6.5, lpattern(dash)) yline(0)
keep(zero1 lgap_d2003 lgap_d2004 lgap_d2005 lgap_d2006 zero2 lgap_d2008 lgap_d2009 lgap_d2010 lgap_d2011 lgap_d2012 lgap_d2013 lgap_d2014 lgap_d2015 lgap_d2016) 
coeflabels(zero1=2 lgap_d2003=3 lgap_d2004=4 lgap_d2005=5 lgap_d2006=6 zero2=7 lgap_d2008=8 lgap_d2009=9 lgap_d2010=10 lgap_d2011=11 lgap_d2012=12
lgap_d2013=13 lgap_d2014=14 lgap_d2015=15 lgap_d2016=16)
name(f6064, replace) title("Female 60-64");

graph combine m1924 m2559 m6064 f1924 f2559 f6064, rows(2);
graph export "${path}\out\reducedform_lf.pdf", replace;

forvalues s=1/2{;
eststo: qui ivregress 2sls lf (lmw=lgap_d2003 lgap_d2004 lgap_d2005 lgap_d2006 lgap_d2008 lgap_d2009 lgap_d2010 lgap_d2011 lgap_d2012 lgap_d2013 lgap_d2014 lgap_d2015 lgap_d2016) ${control} ${fix} if sex==`s'&age>=19&age<=24, cluster(prefecture);
qui estadd ysumm;
eststo: qui ivregress 2sls lf (lmw=lgap_d2003 lgap_d2004 lgap_d2005 lgap_d2006 lgap_d2008 lgap_d2009 lgap_d2010 lgap_d2011 lgap_d2012 lgap_d2013 lgap_d2014 lgap_d2015 lgap_d2016) ${control} ${fix} if sex==`s'&age>=25&age<=59, cluster(prefecture);
qui estadd ysumm;
eststo: qui ivregress 2sls lf (lmw=lgap_d2003 lgap_d2004 lgap_d2005 lgap_d2006 lgap_d2008 lgap_d2009 lgap_d2010 lgap_d2011 lgap_d2012 lgap_d2013 lgap_d2014 lgap_d2015 lgap_d2016) ${control} ${fix} if sex==`s'&age>=60&age<=64, cluster(prefecture);
qui estadd ysumm;
};
esttab, b(2) t(2) keep(lmw) se nostar compress mtitles("M19-24" "M25-59" "M60-64" "F19-24" "F25-59" "F60-64");
esttab using "${path}\out\crossreg.tex", append label b(2) t(2)  
keep(lmw) se nostar compress stats(ymean N, labels ("Mean" "Observations") fmt(2 0))
fragment;
eststo clear;

forvalues s=1/2{;
qui regress lmw lgap_d2003 lgap_d2004 lgap_d2005 lgap_d2006 lgap_d2008 lgap_d2009 lgap_d2010 lgap_d2011 lgap_d2012 lgap_d2013 lgap_d2014 lgap_d2015 lgap_d2016 ${control} ${fix} if sex==`s'&age>=19&age<=24, cluster(prefecture);
predict vhat, residual;
eststo: qui regress lf vhat lmw ${control} ${fix} if sex==`s'&age>=19&age<=24, cluster(prefecture);
drop vhat;

qui regress lmw lgap_d2003 lgap_d2004 lgap_d2005 lgap_d2006 lgap_d2008 lgap_d2009 lgap_d2010 lgap_d2011 lgap_d2012 lgap_d2013 lgap_d2014 lgap_d2015 lgap_d2016 ${control} ${fix} if sex==`s'&age>=25&age<=59, cluster(prefecture);
predict vhat, residual;
eststo: qui regress lf vhat lmw ${control} ${fix} if sex==`s'&age>=25&age<=59, cluster(prefecture);
drop vhat;

qui regress lmw lgap_d2003 lgap_d2004 lgap_d2005 lgap_d2006 lgap_d2008 lgap_d2009 lgap_d2010 lgap_d2011 lgap_d2012 lgap_d2013 lgap_d2014 lgap_d2015 lgap_d2016 ${control} ${fix} if sex==`s'&age>=60&age<=64, cluster(prefecture);
predict vhat, residual;
eststo: qui regress lf vhat lmw ${control} ${fix} if sex==`s'&age>=60&age<=64, cluster(prefecture);
drop vhat;
};

esttab, b(2) t(2) keep(vhat) p nostar compress;
esttab using "${path}\out\crossreg.tex", append label b(2) t(2) 
keep(vhat) se nostar compress fragment;
eststo clear;

regress lhour zero1 lgap_d2003 lgap_d2004 lgap_d2005 lgap_d2006 zero2 lgap_d2008 lgap_d2009 lgap_d2010 lgap_d2011 lgap_d2012 lgap_d2013 lgap_d2014 lgap_d2015 lgap_d2016 ${control} ${fix} if sex==1&age>=19&age<=24, cluster(prefecture);
coefplot, omitted vertical xline(6.5, lpattern(dash)) yline(0)
keep(zero1 lgap_d2003 lgap_d2004 lgap_d2005 lgap_d2006 zero2 lgap_d2008 lgap_d2009 lgap_d2010 lgap_d2011 lgap_d2012 lgap_d2013 lgap_d2014 lgap_d2015 lgap_d2016) 
coeflabels(zero1=2 lgap_d2003=3 lgap_d2004=4 lgap_d2005=5 lgap_d2006=6 zero2=7 lgap_d2008=8 lgap_d2009=9 lgap_d2010=10 lgap_d2011=11 lgap_d2012=12
lgap_d2013=13 lgap_d2014=14 lgap_d2015=15 lgap_d2016=16)
name(m1924, replace) title("Male 19-24");

regress lhour zero1 lgap_d2003 lgap_d2004 lgap_d2005 lgap_d2006 zero2 lgap_d2008 lgap_d2009 lgap_d2010 lgap_d2011 lgap_d2012 lgap_d2013 lgap_d2014 lgap_d2015 lgap_d2016 ${control} ${fix}  if sex==1&age>=25&age<=59, cluster(prefecture);
coefplot, omitted vertical xline(6.5, lpattern(dash)) yline(0)
keep(zero1 lgap_d2003 lgap_d2004 lgap_d2005 lgap_d2006 zero2 lgap_d2008 lgap_d2009 lgap_d2010 lgap_d2011 lgap_d2012 lgap_d2013 lgap_d2014 lgap_d2015 lgap_d2016) 
coeflabels(zero1=2 lgap_d2003=3 lgap_d2004=4 lgap_d2005=5 lgap_d2006=6 zero2=7 lgap_d2008=8 lgap_d2009=9 lgap_d2010=10 lgap_d2011=11 lgap_d2012=12
lgap_d2013=13 lgap_d2014=14 lgap_d2015=15 lgap_d2016=16)
name(m2559, replace) title("Male 25-59");

regress lhour zero1 lgap_d2003 lgap_d2004 lgap_d2005 lgap_d2006 zero2 lgap_d2008 lgap_d2009 lgap_d2010 lgap_d2011 lgap_d2012 lgap_d2013 lgap_d2014 lgap_d2015 lgap_d2016 ${control} ${fix} if sex==1&age>=60&age<=64, cluster(prefecture);
coefplot, omitted vertical xline(6.5, lpattern(dash)) yline(0)
keep(zero1 lgap_d2003 lgap_d2004 lgap_d2005 lgap_d2006 zero2 lgap_d2008 lgap_d2009 lgap_d2010 lgap_d2011 lgap_d2012 lgap_d2013 lgap_d2014 lgap_d2015 lgap_d2016) 
coeflabels(zero1=2 lgap_d2003=3 lgap_d2004=4 lgap_d2005=5 lgap_d2006=6 zero2=7 lgap_d2008=8 lgap_d2009=9 lgap_d2010=10 lgap_d2011=11 lgap_d2012=12
lgap_d2013=13 lgap_d2014=14 lgap_d2015=15 lgap_d2016=16)
name(m6064, replace) title("Male 60-64");

regress lhour zero1 lgap_d2003 lgap_d2004 lgap_d2005 lgap_d2006 zero2 lgap_d2008 lgap_d2009 lgap_d2010 lgap_d2011 lgap_d2012 lgap_d2013 lgap_d2014 lgap_d2015 lgap_d2016 ${control} ${fix} if sex==2&age>=19&age<=24, cluster(prefecture);
coefplot, omitted vertical xline(6.5, lpattern(dash)) yline(0)
keep(zero1 lgap_d2003 lgap_d2004 lgap_d2005 lgap_d2006 zero2 lgap_d2008 lgap_d2009 lgap_d2010 lgap_d2011 lgap_d2012 lgap_d2013 lgap_d2014 lgap_d2015 lgap_d2016) 
coeflabels(zero1=2 lgap_d2003=3 lgap_d2004=4 lgap_d2005=5 lgap_d2006=6 zero2=7 lgap_d2008=8 lgap_d2009=9 lgap_d2010=10 lgap_d2011=11 lgap_d2012=12
lgap_d2013=13 lgap_d2014=14 lgap_d2015=15 lgap_d2016=16)
name(f1924, replace) title("Female 19-24");

regress lhour zero1 lgap_d2003 lgap_d2004 lgap_d2005 lgap_d2006 zero2 lgap_d2008 lgap_d2009 lgap_d2010 lgap_d2011 lgap_d2012 lgap_d2013 lgap_d2014 lgap_d2015 lgap_d2016 ${control} ${fix} if sex==2&age>=25&age<=59, cluster(prefecture);
coefplot, omitted vertical xline(6.5, lpattern(dash)) yline(0)
keep(zero1 lgap_d2003 lgap_d2004 lgap_d2005 lgap_d2006 zero2 lgap_d2008 lgap_d2009 lgap_d2010 lgap_d2011 lgap_d2012 lgap_d2013 lgap_d2014 lgap_d2015 lgap_d2016) 
coeflabels(zero1=2 lgap_d2003=3 lgap_d2004=4 lgap_d2005=5 lgap_d2006=6 zero2=7 lgap_d2008=8 lgap_d2009=9 lgap_d2010=10 lgap_d2011=11 lgap_d2012=12
lgap_d2013=13 lgap_d2014=14 lgap_d2015=15 lgap_d2016=16)
name(f2559, replace) title("Female 25-59");

regress lhour zero1 lgap_d2003 lgap_d2004 lgap_d2005 lgap_d2006 zero2 lgap_d2008 lgap_d2009 lgap_d2010 lgap_d2011 lgap_d2012 lgap_d2013 lgap_d2014 lgap_d2015 lgap_d2016 ${control} ${fix} if sex==2&age>=60&age<=64, cluster(prefecture);
coefplot, omitted vertical xline(6.5, lpattern(dash)) yline(0)
keep(zero1 lgap_d2003 lgap_d2004 lgap_d2005 lgap_d2006 zero2 lgap_d2008 lgap_d2009 lgap_d2010 lgap_d2011 lgap_d2012 lgap_d2013 lgap_d2014 lgap_d2015 lgap_d2016) 
coeflabels(zero1=2 lgap_d2003=3 lgap_d2004=4 lgap_d2005=5 lgap_d2006=6 zero2=7 lgap_d2008=8 lgap_d2009=9 lgap_d2010=10 lgap_d2011=11 lgap_d2012=12
lgap_d2013=13 lgap_d2014=14 lgap_d2015=15 lgap_d2016=16)
name(f6064, replace) title("Female 60-64");

graph combine m1924 m2559 m6064 f1924 f2559 f6064, rows(2);
graph export "${path}\out\reducedform_hour.pdf", replace;

forvalues s=1/2{;
eststo: qui ivregress 2sls lhour (lmw=lgap_d2003 lgap_d2004 lgap_d2005 lgap_d2006 lgap_d2008 lgap_d2009 lgap_d2010 lgap_d2011 lgap_d2012 lgap_d2013 lgap_d2014 lgap_d2015 lgap_d2016) ${control} ${fix} if sex==`s'&age>=19&age<=24, cluster(prefecture);
eststo: qui ivregress 2sls lhour (lmw=lgap_d2003 lgap_d2004 lgap_d2005 lgap_d2006 lgap_d2008 lgap_d2009 lgap_d2010 lgap_d2011 lgap_d2012 lgap_d2013 lgap_d2014 lgap_d2015 lgap_d2016) ${control} ${fix} if sex==`s'&age>=25&age<=59, cluster(prefecture);
eststo: qui ivregress 2sls lhour (lmw=lgap_d2003 lgap_d2004 lgap_d2005 lgap_d2006 lgap_d2008 lgap_d2009 lgap_d2010 lgap_d2011 lgap_d2012 lgap_d2013 lgap_d2014 lgap_d2015 lgap_d2016) ${control} ${fix} if sex==`s'&age>=60&age<=64, cluster(prefecture);
};
esttab, b(2) t(2) keep(lmw) se nostar compress mtitles("M19-24" "M25-59" "M60-64" "F19-24" "F25-59" "F60-64");
esttab using "${path}\out\crossreg.tex", append label b(2) t(2)  
keep(lmw) se nostar compress fragment;
eststo clear;


forvalues s=1/2{;
qui regress lmw lgap_d2003 lgap_d2004 lgap_d2005 lgap_d2006 lgap_d2008 lgap_d2009 lgap_d2010 lgap_d2011 lgap_d2012 lgap_d2013 lgap_d2014 lgap_d2015 lgap_d2016 ${control} ${fix} if sex==`s'&age>=19&age<=24, cluster(prefecture);
predict vhat, residual;
eststo: qui regress lf vhat lmw ${control} ${fix} if sex==`s'&age>=19&age<=24, cluster(prefecture);
drop vhat;

qui regress lmw lgap_d2003 lgap_d2004 lgap_d2005 lgap_d2006 lgap_d2008 lgap_d2009 lgap_d2010 lgap_d2011 lgap_d2012 lgap_d2013 lgap_d2014 lgap_d2015 lgap_d2016 ${control} ${fix} if sex==`s'&age>=25&age<=59, cluster(prefecture);
predict vhat, residual;
eststo: qui regress lf vhat lmw ${control} ${fix} if sex==`s'&age>=25&age<=59, cluster(prefecture);
drop vhat;

qui regress lmw lgap_d2003 lgap_d2004 lgap_d2005 lgap_d2006 lgap_d2008 lgap_d2009 lgap_d2010 lgap_d2011 lgap_d2012 lgap_d2013 lgap_d2014 lgap_d2015 lgap_d2016 ${control} ${fix} if sex==`s'&age>=60&age<=64, cluster(prefecture);
predict vhat, residual;
eststo: qui regress lf vhat lmw ${control} ${fix} if sex==`s'&age>=60&age<=64, cluster(prefecture);
drop vhat;
};

esttab, b(2) t(2) keep(vhat) p nostar compress;
esttab using "${path}\out\crossreg.tex", append label b(2) t(2) 
keep(vhat) se nostar compress fragment;
eststo clear;



recode size (0=.) (1=1) (2=3) (3=7) (4=20) (5=65) (6=300) (7=750) (8=1000) (9=.),gen(firm_size);
forvalues s=1/2{;
eststo: qui ivregress 2sls firm_size (lmw=lgap_d2003 lgap_d2004 lgap_d2005 lgap_d2006 lgap_d2008 lgap_d2009 lgap_d2010 lgap_d2011 lgap_d2012 lgap_d2013 lgap_d2014 lgap_d2015 lgap_d2016) ${control} ${fix} if sex==`s'&age>=19&age<=24, cluster(prefecture);
eststo: qui ivregress 2sls firm_size (lmw=lgap_d2003 lgap_d2004 lgap_d2005 lgap_d2006 lgap_d2008 lgap_d2009 lgap_d2010 lgap_d2011 lgap_d2012 lgap_d2013 lgap_d2014 lgap_d2015 lgap_d2016) ${control} ${fix} if sex==`s'&age>=25&age<=59, cluster(prefecture);
eststo: qui ivregress 2sls firm_size (lmw=lgap_d2003 lgap_d2004 lgap_d2005 lgap_d2006 lgap_d2008 lgap_d2009 lgap_d2010 lgap_d2011 lgap_d2012 lgap_d2013 lgap_d2014 lgap_d2015 lgap_d2016) ${control} ${fix} if sex==`s'&age>=60&age<=64, cluster(prefecture);
};
esttab, b(2) t(2) keep(lmw) se nostar compress mtitles("M19-24" "M25-59" "M60-64" "F19-24" "F25-59" "F60-64");
*esttab using "${path}\out\crossreg.tex", append label b(2) t(2)  
keep(lmw) se nostar compress fragment;
eststo clear;


log close;
exit;

