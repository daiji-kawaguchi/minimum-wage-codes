# delimit;
clear;
set more off;
set emptycells drop;
set matsize 5000;
cap log close;
log using ${path}\log\wage_descriptive.log,replace;

use ${datapath}\wcensus\wcensus2002_2017.dta;
svyset [pweight=weight];

drop if wage==.;

tabstat wage if year==2002, by(prefecture);

local p=13;
forvalues y=2002(15)2017{;
quietly sum mw if prefecture==`p'&year==`y';
local mw=r(mean);
histogram wage if prefecture==`p'&year==`y'&wage<=5000, w(50) xline(`mw')
name(dist_`p'_`y', replace) xtitle("Tokyo, `y', MW=`mw'") fraction nodraw;
};

local p=36;
forvalues y=2002(15)2017{;
quietly sum mw if prefecture==`p'&year==`y';
local mw=r(mean);
histogram wage if prefecture==`p'&year==`y'&wage<=5000, w(50) xline(`mw')
name(dist_`p'_`y', replace) xtitle("Tokushima, `y', MW=`mw'") fraction nodraw;
};

graph combine dist_13_2002 dist_13_2017 dist_36_2002 dist_36_2017;
graph export ${path}\out\wagedist.pdf, replace;

forvalues p=1/47{;
quietly sum mw if prefecture==`p'&year==2002;
local mw=r(mean);
histogram wage if prefecture==`p'&year==2002&wage<=5000, w(50) xline(`mw')
name(dist_`p', replace) xtitle("ID=`p', MW=`mw'") fraction nodraw ;
};

graph combine dist_1 dist_2 dist_3 dist_4 dist_5 dist_6 dist_7 dist_8 dist_9 dist_10 
dist_11 dist_12 dist_13 dist_14 dist_15 dist_16 dist_17 dist_18 dist_19 dist_20 dist_21 dist_22 
dist_23 dist_24 dist_25 dist_26 dist_27 dist_28 dist_29 dist_30 dist_31 dist_32 dist_33 dist_34 
dist_35 dist_36 dist_37 dist_38 dist_39 dist_40 dist_41 dist_42 dist_43 dist_44 dist_45 dist_46 dist_47, title("Wage distribution in 2002");
graph export ${path}\out\wagedist_p_2002.pdf, replace;

forvalues p=1/47{;
quietly sum mw if prefecture==`p'&year==2017;
local mw=r(mean);
histogram wage if prefecture==`p'&year==2017&wage<=5000, w(50) xline(`mw')
name(dist_`p', replace) xtitle("ID=`p', MW=`mw'") fraction nodraw ;
};

graph combine dist_1 dist_2 dist_3 dist_4 dist_5 dist_6 dist_7 dist_8 dist_9 dist_10 
dist_11 dist_12 dist_13 dist_14 dist_15 dist_16 dist_17 dist_18 dist_19 dist_20 dist_21 dist_22 
dist_23 dist_24 dist_25 dist_26 dist_27 dist_28 dist_29 dist_30 dist_31 dist_32 dist_33 dist_34 
dist_35 dist_36 dist_37 dist_38 dist_39 dist_40 dist_41 dist_42 dist_43 dist_44 dist_45 dist_46 dist_47, title("Wage distribution in 2017");
graph export ${path}\out\wagedist_p_2017.pdf, replace;

gen mwworker=0;
replace mwworker=1 if wage<=1.05*mw;
label var mwworker "Fraction W<=1.05 MW";
label var age "Age";

svy: mean mwworker;

preserve;
keep if year==2017&mwworker==1;
drop IndustryL;
recode ind (50/59=3)(60/89=4)(90/329=5)(330/369=6)(370/416=7)(420/491=8)
(500/619=9)(620/675=10)(680/709=11)(710/749=12)(750/772=13)(780/809=14)
(810/829=15)(830/859=16)(860/872=17)(880/969=18), gen(IndustryL);
estpost tab IndustryL;
esttab .,cell(pct) noobs mtitles("Fraction of workers (\%)") ;
esttab using ${path}\out\tab_industry.tex,replace rename(3 "Mining" 4 "Construction" 5 "Manufacturing" 6 "Electlicity, gas, and water" 7 "Information and communications" 8 "Transport and postal services" 9 "Wholesale and retail Trade" 10 "Finance and insurance" 11 "Real estate" 12 "Scientific research and technics" 13 "Hotel and restaurant" 14 "Life and amusement services" 15 "Education" 16 "Medical and health care" 17 "Compound services" 18 "Other services") mtitles("") cell(pct(fmt(2))) noobs fragment;

recode occ (101/105=1)(201/237=2)(301/303=3) (401/406=4)(501/506=5)(601/602=6)(701/711=7)
(801/864=8), gen(occL) label(occL);
estpost tab occL;
esttab .,cell(pct) noobs mtitles("Fraction of workers (\%)") ;
esttab using ${path}\out\tab_occ.tex,replace rename(1 "Administrative workers" 2 "Specialist professionals" 3 "Clerical workers" 4 "Sales workers" 5 "Service workers" 6 "Security workers" 7 "Transport operation workers" 
8 "Manufacturing process workers") mtitles("") cell(pct(fmt(2))) noobs fragment;

restore;
preserve;

collapse (mean) mwworker (mean) mw (count) number=mwworker [pweight=weight], by (prefecture year);
reshape wide mwworker mw number, i(prefecture) j(year);

gen lmw1702=ln(mw2017)-ln(mw2002);
gen mwworker1702=mwworker2017-mwworker2002;
scatter mwworker1702 lmw1702 [w=number2002], msymbol(circle_hollow)
|| lfit mwworker1702 lmw1702 [w=number2002],
legend(off)
xtitle("ln(MW2017) - ln(MW2002)") 
ytitle("Change in Frac. W=<1.05 MW from 2002 to 2017");
graph export ${path}\out\wagegrowth.pdf, replace;

*-------------------------
*checking minimum wage workers
*-------------------------;
restore;*/;

cap graph drop malelow;
cap graph drop malehigh;
cap graph drop femalelow;
cap graph drop femalehigh;

binscatter mwworker age if sex==1&educ>=1&educ<=2, discrete linetype(none) xsc(r(18 69)) ysc(r(0 0.04)) title("Male, Educ<=12") xtitle ("Age") ytitle("Fraction W<=1.05 MW") name(malelow) nodraw;
binscatter mwworker age if sex==1&educ>=3&educ<=4, discrete linetype(none) xsc(r(18 69)) ysc(r(0 0.04)) title("Male, Educ>=13") xtitle ("Age") ytitle("Fraction W<=1.05 MW") name(malehigh) nodraw;
binscatter mwworker age if sex==1&educ>=1&educ<=2, discrete linetype(none) xsc(r(18 69)) ysc(r(0 0.04)) title("Female, Educ<=12") xtitle ("Age") ytitle("Fraction W<=1.05 MW") name(femalelow) nodraw;
binscatter mwworker age if sex==1&educ>=3&educ<=4, discrete linetype(none) xsc(r(18 69)) ysc(r(0 0.04)) title("Female, Educ>=13") xtitle ("Age") ytitle("Fraction W<=1.05 MW") name(femalehigh) nodraw;

graph combine malelow femalelow malehigh femalehigh;
graph export ${path}\out\mwworker.pdf, replace;

log close;
exit;
