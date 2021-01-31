#delimit ;
set more off;
cap log close;

log using ${path}\log\descriptive.log,replace;
clear;

insheet using ${datapath}\gap2006.csv;
replace gap=0 if gap==.;
save ${datapath}\gap2006.dta,replace;
clear;

local b=2;
local m=7;
local e=16;

use ${datapath}\mw.dta;
drop lmw-lead4_lmw;
label define prefecture 1 "Hokkaido" 2 "Aomori" 3 "Iwate" 4 "Miyagi" 5 "Akita" 6 "Yamagata"
7 "Fukushima" 8 "Ibaraki" 9 "Tochigi" 10 "Gunma" 11 "Saitama" 12 "Chiba" 13 "Tokyo"
14 "Kanagawa" 15 "Nigata" 16 "Toyama" 17 "Ishikawa" 18 "Fukui" 19 "Yamanashi" 20 "Nagano"
21 "Gifu" 22 "Shizuoka" 23 "Aichi" 24 "Mie" 25 "Shiga" 26 "Kyoto" 27 "Osaka" 28 "Hyogo"
29 "Nara" 30 "Wakayama" 31 "Tottori" 32 "Shimane" 33 "Okayama" 34 "Hiroshima" 35 "Yamaguchi"
36 "Tokushima" 37 "Kagawa" 38 "Ehime" 39 "Kochi" 40 "Fukuoka" 41 "Saga" 42 "Nagasaki"
43 "Kumamoto" 44 "Oita" 45 "Miyazaki" 46 "Kagoshima" 47 "Okinawa";
label values prefecture prefecture;

reshape wide mw, i(prefecture) j(year);
sort prefecture;
gen growth`e'07=ln(mw20`e')-ln(mw2007);
label variable growth`e'07 "ln(mw20`e')-ln(mw2007)";
gen growth0798=ln(mw2007)-ln(mw1998);
label variable growth0798 "ln(mw2007)-ln(mw1998)";
sort growth`e'07;
list prefecture growth`e'07;
merge 1:1 prefecture using ${datapath}\gap2006.dta;
gen lgap=ln(mw2006+gap)-ln(mw2006);
label variable lgap "ln(WB/MWE){subscript:2006}";
scatter growth`e'07 lgap, msymbol(circle_hollow) ||
lfit growth`e'07 lgap, ytitle("ln(mw20`e')-ln(mw2007)") name(growth`e'07, replace) nodraw legend(off);
scatter growth0798 lgap, msymbol(circle_hollow) ||
lfit growth0798 lgap, ytitle("ln(mw2007)-ln(mw1998)") name(growth0798, replace) nodraw
legend(off);
graph combine growth`e'07 growth0798, row(1) ycommon name(real, replace);
graph export ${path}\out\reversal.pdf, replace;

drop growth*;
reshape long mw, i(prefecture) j(year);

xtset prefecture year;
sort prefecture year;
label var mw "Minimum wage";
label var year "Year";

xtline mw if (prefecture==21|prefecture==30|prefecture==36|
prefecture==27|prefecture==13|prefecture==14)&
(year>=2000&year<=2016), overlay
legend(order(1 2 4 3 5 6))
xline (2007, lp(dot))
xline (2011, lp(dot));
graph export ${path}\out\mw.pdf, replace;

clear;
use ${datapath}\cross.dta,replace;
keep if educ==4;

*checking pre-trend;
preserve;
keep if sex==1&age>=19&age<=24;
collapse (mean) emp lmw lgap (sum) weight [pweight=weight], by(prefecture year);
reshape wide emp lmw weight, i(prefecture) j(year);
gen chemp0702=(emp2007-emp2002);
label variable lgap "ln(WB/MWE){subscript:2006}";
quietly scatter chemp0702 lgap [w=weight2002], msymbol(circle_hollow) ||
lfit chemp0702 lgap [w=weight2002],
title("Male 19-24") name(male1924, replace) nodraw legend(off);
restore;

preserve;
keep if sex==1&age>=25&age<=59;
collapse (mean) emp lmw lgap (sum) weight [pweight=weight], by(prefecture year);
reshape wide emp lmw weight, i(prefecture) j(year);
gen chemp0702=(emp2007-emp2002);
label variable lgap "ln(WB/MWE){subscript:2006}";
quietly scatter chemp0702 lgap [w=weight2002], msymbol(circle_hollow) ||
lfit chemp0702 lgap [w=weight2002],
title("Male 25-59") name(male2559, replace) nodraw legend(off);
restore;

preserve;
keep if sex==1&age>=60&age<=64;
collapse (mean) emp lmw lgap (sum) weight [pweight=weight], by(prefecture year);
reshape wide emp lmw weight, i(prefecture) j(year);
gen chemp0702=(emp2007-emp2002);
label variable lgap "ln(WB/MWE){subscript:2006}";
quietly scatter chemp0702 lgap [w=weight2002], msymbol(circle_hollow) ||
lfit chemp0702 lgap [w=weight2002],
title("Male 60-64") name(male6064, replace) nodraw legend(off);
restore;

preserve;
keep if sex==2&age>=19&age<=24;
collapse (mean) emp lmw lgap (sum) weight [pweight=weight], by(prefecture year);
reshape wide emp lmw weight, i(prefecture) j(year);
gen chemp0702=(emp2007-emp2002);
label variable lgap "ln(WB/MWE){subscript:2006}";
quietly scatter chemp0702 lgap [w=weight2002], msymbol(circle_hollow) ||
lfit chemp0702 lgap [w=weight2002],
title("Female 19-24") name(female1924, replace) nodraw legend(off);
reg chemp0702 lgap [aweight=weight2002], robust;
restore;

preserve;
keep if sex==2&age>=25&age<=59;
collapse (mean) emp lmw lgap (sum) weight [pweight=weight], by(prefecture year);
reshape wide emp lmw weight, i(prefecture) j(year);
gen chemp0702=(emp2007-emp2002);
label variable lgap "ln(WB/MWE){subscript:2006}";
quietly scatter chemp0702 lgap [w=weight2002], msymbol(circle_hollow) ||
lfit chemp0702 lgap [w=weight2002],
title("Female 25-59") name(female2559, replace) nodraw legend(off);
reg chemp0702 lgap [aweight=weight2002], robust;
restore;

preserve;
keep if sex==2&age>=60&age<=64;
collapse (mean) emp lmw lgap (sum) weight [pweight=weight], by(prefecture year);
reshape wide emp lmw weight, i(prefecture) j(year);
gen chemp0702=(emp2007-emp2002);
label variable lgap "ln(WB/MWE){subscript:2006}";
quietly scatter chemp0702 lgap [w=weight2002], msymbol(circle_hollow) ||
lfit chemp0702 lgap [w=weight2002],
title("Female 60-64") name(female6064, replace) nodraw legend(off);
reg chemp0702 lgap [aweight=weight2002], robust;
restore;

graph combine male1924 male2559 male6064 female1924 female2559 female6064, row(2) ycommon name(real, replace);
graph export ${path}\out\pretrend.pdf, replace;

eststo clear;
preserve;
keep if sex==1&age>=19&age<=24;
collapse (mean) emp lmw lgap (sum) weight [pweight=weight], by(prefecture year);
xtset prefecture year;
eststo: qui reg d.emp lgap i.year [pweight=weight] if year<=2007, cluster(prefecture);
estadd local sex "Male";
estadd local age "19-24";
restore;

preserve;
keep if sex==1&age>=25&age<=59;
collapse (mean) emp lmw lgap (sum) weight [pweight=weight], by(prefecture year);
xtset prefecture year;
eststo: qui reg d.emp lgap i.year [pweight=weight] if year<=2007, cluster(prefecture);
estadd local sex "Male";
estadd local age "25-59";
restore;

preserve;
keep if sex==1&age>=60&age<=64;
collapse (mean) emp lmw lgap (sum) weight [pweight=weight], by(prefecture year);
xtset prefecture year;
eststo: qui reg d.emp lgap i.year [pweight=weight] if year<=2007, cluster(prefecture);
estadd local sex "Male";
estadd local age "60-64";
restore;

preserve;
keep if sex==2&age>=19&age<=24;
collapse (mean) emp lmw lgap (sum) weight [pweight=weight], by(prefecture year);
xtset prefecture year;
eststo: qui reg d.emp lgap i.year [pweight=weight] if year<=2007, cluster(prefecture);
estadd local sex "Female";
estadd local age "19-24";
restore;

preserve;
keep if sex==2&age>=25&age<=59;
collapse (mean) emp lmw lgap (sum) weight [pweight=weight], by(prefecture year);
xtset prefecture year;
eststo: qui reg d.emp lgap i.year [pweight=weight] if year<=2007, cluster(prefecture);
estadd local sex "Female";
estadd local age "25-59";
restore;

preserve;
keep if sex==2&age>=60&age<=64;
collapse (mean) emp lmw lgap (sum) weight [pweight=weight], by(prefecture year);
xtset prefecture year;
eststo: qui reg d.emp lgap i.year [pweight=weight] if year<=2007, cluster(prefecture);
estadd local sex "Female";
estadd local age "60-64";
restore;

esttab, b(2) t(2) keep(lgap) se nostar compress scalars("sex Sex" "age Age") nomtitles;
esttab using "${path}\out\pretrend.tex", replace label b(2) t(2) 
keep(lgap) se nostar compress scalars("sex Sex" "age Age") nomtitles fragment;

*correlation between mw growth and employment growth;
preserve;
keep if sex==1&age>=19&age<=24;
collapse (mean) emp lmw (sum) weight [pweight=weight], by(prefecture year);
reshape wide emp lmw weight, i(prefecture) j(year);
gen chemp0`m'`e'=(emp20`e'-emp200`m');
gen chlmw=lmw20`e'-lmw2007;
label variable chlmw "ln(MW){subscript:2016} - ln(MW){subscript:2007}";
quietly scatter chemp0`m'`e' chlmw [w=weight200`m'], msymbol(circle_hollow) ||
lfit chemp0`m'`e' chlmw [aweight=weight200`m'],
title("Male 19-24") name(male1924, replace) nodraw legend(off);
restore;

preserve;
keep if sex==1&age>=25&age<=59;
collapse (mean) emp lmw (sum) weight [pweight=weight], by(prefecture year);
reshape wide emp lmw weight, i(prefecture) j(year);
gen chemp0`m'`e'=(emp20`e'-emp200`m');
gen chlmw=lmw20`e'-lmw2007;
label variable chlmw "ln(MW){subscript:2016} - ln(MW){subscript:2007}";
quietly scatter chemp0`m'`e' chlmw [w=weight200`m'], msymbol(circle_hollow) ||
lfit chemp0`m'`e' chlmw [aweight=weight200`m'],
title("Male 25-59") name(male2559, replace) nodraw legend(off);
restore;

preserve;
keep if sex==1&age>=60&age<=64;
collapse (mean) emp lmw (sum) weight [pweight=weight], by(prefecture year);
reshape wide emp lmw weight, i(prefecture) j(year);
gen chemp0`m'`e'=(emp20`e'-emp200`m');
gen chlmw=lmw20`e'-lmw2007;
label variable chlmw "ln(MW){subscript:2016} - ln(MW){subscript:2007}";
quietly scatter chemp0`m'`e' chlmw [w=weight200`m'], msymbol(circle_hollow) ||
lfit chemp0`m'`e' chlmw [aweight=weight200`m'],
title("Male 60-64") name(male6064, replace) nodraw legend(off);
restore;

preserve;
keep if sex==2&age>=19&age<=24;
collapse (mean) emp lmw (sum) weight [pweight=weight], by(prefecture year);
reshape wide emp lmw weight, i(prefecture) j(year);
gen chemp0`m'`e'=(emp20`e'-emp200`m');
gen chlmw=lmw20`e'-lmw200`m';
label variable chlmw "ln(MW){subscript:2016} - ln(MW){subscript:2007}";
quietly scatter chemp0`m'`e' chlmw [w=weight200`m'], msymbol(circle_hollow) ||
lfit chemp0`m'`e' chlmw [aweight=weight200`m'],
title("Female 19-24") name(female1924, replace) nodraw legend(off);
restore;

preserve;
keep if sex==2&age>=25&age<=59;
collapse (mean) emp lmw (sum) weight [pweight=weight], by(prefecture year);
reshape wide emp lmw weight, i(prefecture) j(year);
gen chemp0`m'`e'=(emp20`e'-emp200`m');
gen chlmw=lmw20`e'-lmw200`m';
label variable chlmw "ln(MW){subscript:2016} - ln(MW){subscript:2007}";
quietly scatter chemp0`m'`e' chlmw [w=weight200`m'], msymbol(circle_hollow) ||
lfit chemp0`m'`e' chlmw [aweight=weight200`m'],
title("Female 25-59") name(female2559, replace) nodraw legend(off);
restore;

preserve;
keep if sex==2&age>=60&age<=64;
collapse (mean) emp lmw (sum) weight [pweight=weight], by(prefecture year);
reshape wide emp lmw weight, i(prefecture) j(year);

gen chemp0`m'`e'=(emp20`e'-emp200`m');
gen chlmw=lmw20`e'-lmw200`m';
label variable chlmw "ln(MW){subscript:2016} - ln(MW){subscript:2007}";
quietly scatter chemp0`m'`e' chlmw [w=weight200`m'], msymbol(circle_hollow) ||
lfit chemp0`m'`e' chlmw [aweight=weight200`m'],
title("Female 60-64") name(female6064, replace) nodraw legend(off);
restore;

graph combine male1924 male2559 male6064 female1924 female2559 female6064, row(2) ycommon name(real, replace);
graph export ${path}\out\effect.pdf, replace;

log close;
exit;
