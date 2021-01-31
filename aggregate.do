#delimit ;
set more off;
cap log close;
log using ${path}\log\aggregate.log,replace;

clear;
use ${datapath}\rotoku\lfssp_2_1.dta;

forvalues y=2/16 {;
forvalues m=1/12 {;
if ~(`y'==2&`m'==1) {;
append using ${datapath}\rotoku\lfssp_`y'_`m'.dta;
};
};
};

*keep if age>=18 & age<=59;
preserve;

gen frac_le=(educ==4);
gen frac1_le=(educ==4&sex==1);
gen frac2_le=(educ==4&sex==2);
gen frac_le_18_24=(educ==4&age<25);
gen frac_le_25_29=(educ==4&age>=25&age<30);
gen frac1_le_18_24=(educ==4&age<25&sex==1);
gen frac1_le_25_29=(educ==4&age>=25&age<30&sex==1);
gen frac2_le_18_24=(educ==4&age<25&sex==2);
gen frac2_le_25_29=(educ==4&age>=25&age<30&sex==2);
gen frac1_19_24=(age>=19&age<25&sex==1);
gen frac1_25_59=(age>=25&age<60&sex==1);
gen frac1_60_64=(age>=60&age<65&sex==1);
gen frac2_19_24=(age>=19&age<25&sex==2);
gen frac2_25_59=(age>=25&age<60&sex==2);
gen frac2_60_64=(age>=60&age<65&sex==2);

collapse frac_le frac1_le frac2_le frac_le_18_24 frac_le_25_29 frac1_le_18_24 
frac1_le_25_29 frac2_le_18_24 frac2_le_25_29 frac1_19_24 frac1_25_59 frac1_60_64
frac2_19_24 frac2_25_59 frac2_60_64, by(year month prefecture);
sort year month prefecture;
save ${datapath}\composition.dta, replace;
restore;

preserve;
gen old=1 if empstat==1 & age>=60;
collapse(count)old empstat,by(year month prefecture);
gen old_wk=old/empstat;
sort year month prefecture;
save ${datapath}\old.dta,replace;
restore;

keep if age>=18 & age<=59;

preserve;
gen income=0 if inc==1 & empstat==5;
replace income=25 if inc==2;
replace income=75 if inc==3;
replace income=125 if inc==4;
replace income=175 if inc==5;
replace income=250 if inc==6;
replace income=350 if inc==7;
replace income=450 if inc==8;
replace income=600 if inc==9;
replace income=850 if inc==10;
replace income=1250 if inc==11;
replace income=1500 if inc==12;
collapse(mean) income,by(year month prefecture);
sort year month prefecture;
save ${datapath}\income.dta,replace;
restore;



preserve;
drop if educ==1;
gen high=1 if educ!=4 ;
replace high=1 if educ==5;
replace high=. if educ==8;
collapse(count) educ high,by(year month prefecture);
gen col_rate=high/educ;
sort year month prefecture;
save ${datapath}\col_rate.dta, replace;
restore;

preserve;
keep if empstat<=4;
recode ind (1=1) (2=2)(3/4=3) (5=4) (6/8=5) (9/32=6) (33/36=7) (37/41=8) (42/48=9)
(49/60=10)(61/67=11)(68/69=12)(70/72=13)(73/75=14)(76/77=15)(78/79=16)(80/94=17)
(95/96=18) if year!=2002,gen (indL) ;
collapse(count)empstat ,by(year prefecture indL); 
sort year prefecture;
by year prefecture: gen n=year*100+prefecture;
drop if ind==.;
reshape wide empstat ,i (n) j(ind);
forvalues i=1/18 {;
replace empstat`i'=0 if  empstat`i'==.;
};sort year prefecture;
gen total_ind=empstat1+empstat2+empstat3+empstat4+empstat5+empstat6+empstat7+empstat8+empstat9+empstat10+
empstat11+empstat12+empstat13+empstat14+empstat15+empstat16+empstat17+empstat18;
forvalues i=1/18 {;
gen ind`i'=empstat`i'/total_ind;
};
keep year prefecture ind1-ind18;
sort year prefecture;
save ${datapath}\ind.dta, replace;
restore;

keep if age>=25&sex==1;
keep if empstat>=1&empstat<=5;
keep if educ==6;
gen ue_cl25_59=(empstat==5);
collapse ue_cl25_59, by(year month prefecture);
sort year month prefecture;
save ${datapath}\ue.dta, replace;

clear;
insheet using ${datapath}\minimumwage2018.csv;
drop prefecture;
rename prefecturecode prefecture;
reshape long v, i(prefecture) j(year);
replace year=year+1974;
rename v mw;

xtset prefecture year;
gen lmw=log(mw);
gen lag1_lmw=L1.lmw;
gen lag2_lmw=L2.lmw;
gen lag3_lmw=L3.lmw;
gen lead1_lmw=F1.lmw;
gen lead2_lmw=F2.lmw;
gen lead3_lmw=F3.lmw;
gen lead4_lmw=F4.lmw;
sort year prefecture; 
save ${datapath}\mw.dta, replace;

clear;
insheet using ${datapath}\job.csv,names;
drop if prefecture==0;
sort year prefecture;
gen n=_n;
reshape long job ,i(n) j(month);
drop n;
sort year month prefecture;
save ${datapath}\job.dta, replace;

log close;
exit;

