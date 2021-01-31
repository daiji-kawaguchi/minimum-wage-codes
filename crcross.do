#delimit ;

set more off;
cap log close;
log using ${path}\log\crcross.log,replace;
clear;

use ${datapath}\rotoku\toku_match2003_2016.dta;
egen id=group(year4 month4 prefecture district hhunit birth_year birth_month sex);
reshape long year month age mar rel empstat hour jobpref rsn class ind occ size change weight, i(id) j(round);
drop if year==.|month==.|prefecture==.;
sort year month prefecture;

merge m:1 year month prefecture using ${datapath}\composition.dta;
*certain prefecutre and year/month are not matched because of non-survey coverage;
drop if _merge~=3;
drop _merge;
sort year month prefecture;
tab year;


merge m:1 year month prefecture using ${datapath}\col_rate.dta;
drop if _merge~=3;
drop _merge;
sort year month prefecture;

merge m:1 year month prefecture using ${datapath}\income.dta;
drop if _merge~=3;
drop _merge;
sort year month prefecture;

merge m:1 year month prefecture using ${datapath}\job.dta;
drop if _merge~=3;
drop _merge;
sort year month prefecture;

merge m:1 year month prefecture using ${datapath}\old.dta;
drop if _merge~=3;
drop _merge;
sort year prefecture;

merge m:1 year prefecture using ${datapath}\ind.dta;
drop _merge;
sort year month prefecture;

merge m:1 year month prefecture using ${datapath}\ue.dta;
drop if _merge~=3;
drop _merge;
sort year month prefecture;

merge m:1 year prefecture using ${datapath}\mw.dta;
drop if _merge~=3;
drop _merge;

merge m:1 prefecture using ${datapath}\gap2006.dta;
gen mw2006_temp=mw if year==2006;
egen mw2006=mean(mw2006_temp), by(prefecture);
drop mw2006_temp;
*gen lgap=ln(assistance2007)-ln(mw2007*173.8*0.859);
gen lgap=ln(mw2006+gap)-ln(mw2006);
label variable lgap "ln(WB/MWE) in 2006";
drop if _merge~=3;
drop _merge;

*LFS asks the labor force status of the last week of the last month;
replace lmw=lead1_lmw if month>=11&month<=12;
replace lag1_lmw=lmw if month>=11&month<=12;
replace lag2_lmw=lag1_lmw if month>=11&month<=12;
replace lag3_lmw=lag2_lmw if month>=11&month<=12;
replace lead1_lmw=lead2_lmw if month>=11&month<=12;
replace lead2_lmw=lead3_lmw if month>=11&month<=12;
replace lead3_lmw=lead4_lmw if month>=11&month<=12;
drop lead4_lmw;

label define rel 1 "head of hh" 2 "spouse" 3 "child" 4 "spouse of child"
5 "grand child" 6 "parents" 7 "grand parents" 8 "siblings" 9 "other relatives"
0 "misc";
label values rel rel;
label define sex 1 "male" 2 "female";
label values sex sex;
label define mar 1 "unmarried" 2 "married" 3 "divorced/separated" 4 "unknown";
label values mar mar;
label define prefecture 1 "Hokkaido" 2 "Aomori" 3 "Iwate" 4 "Miyagi" 5 "Akita" 6 "Yamagata"
7 "Fukushima" 8 "Ibaraki" 9 "Tochigi" 10 "Gunma" 11 "Saitama" 12 "Chiba" 13 "Tokyo"
14 "Kanagawa" 15 "Nigata" 16 "Toyama" 17 "Ishikawa" 18 "Fukui" 19 "Yamanashi" 20 "Nagano"
21 "Gifu" 22 "Shizuoka" 23 "Aichi" 24 "Mie" 25 "Shiga" 26 "Kyoto" 27 "Osaka" 28 "Hyogo"
29 "Nara" 30 "Wakayama" 31 "Tottori" 32 "Shimane" 33 "Okayama" 34 "Hiroshima" 35 "Yamaguchi"
36 "Tokushima" 37 "Kagawa" 38 "Ehime" 39 "Kochi" 40 "Fukuoka" 41 "Saga" 42 "Nagasaki" 
43 "Kumamoto" 44 "Oita" 45 "Miyazaki" 46 "Kagoshima" 47 "Okinawa"; 
label values prefecture prefecture;
label define educ 1 "in school, hs" 2 "in school, jc" 3 "in school, col"
4 "hs" 5 "jc" 6 "coll" 7 "never" 8 "dk"; 
label values educ educ;

replace empstat=. if empstat==9; 
label define empstat 1 "work main" 2 "in school main" 3 "house keeping main"
4 "absent from work" 5 "unemployed" 6 "olf, in school" 7 "olf, house keeping"
8 "misc(retired)";
label values empstat empstat;

label define class 1 "permanent" 2 "temporary" 3 "daily" 4 "executive"
5 "se w/ employee" 6 "se w/o employee" 7 "family employee" 8 "in house production"
9 "unknown";
label values class class;
label define size 1 "1" 2 "2-4" 3 "5-9" 4 "10-29" 5 "30-99" 6 "100-499"
7 "500-999" 8 "1000-" 9 "public" 0 "unknown";
label values size size;
label define ind 1 "agriculture" 6 "forestry" 8 "fishery" 10 "mining"
15 "construction" 20 "textile" 26 "chemical" 28 "misc. chemical" 31 "steel"
33 "metal products" 34 "machinary" 35 "electronics" 18 "food" 36 "transport"
39 "misc mfg" 40 "wholesale" 44 "retail, textile, grocery, furniture"
45 "retail, food" 46 "restaurant" 49 "retail, misc" 50 "fire" 60 "transport & communication"
70 "public utilities" 87 "specialized service" 75 "customer service" 84 "business service"
79 "entertainment" 95 "service, misc" 97 "public" 90 "unclassified";
label values ind ind;

gen emp=.;
replace emp=0 if empstat>=4&empstat<=8;
replace emp=1 if empstat>=1&empstat<=3;

gen lf=.;
replace lf=0 if empstat>=6&empstat<=8;
replace lf=1 if empstat>=1&empstat<=5;

gen lhour=.;
replace lhour=ln(hour);
label variable lhour "ln (hour)";

recode prefecture (1/7=1) (8/14=2) (15/18=3) (19/20=2) (21/24=4) (25/30=5) (31/35=6) (36/39=7) (40/47=8),gen(region);
gen age2=age^2;
gen marriage=1 if mar==2;
replace marriage=0 if mar==1 | mar==3;

preserve;
keep if educ==4;
keep if age>=19&age<=64;

save "${datapath}\cross.dta",replace;

restore;
keep if educ==6 |educ==5;
keep if age>=19&age<=64;

save "${datapath}\cross_coll.dta",replace;

exit;

*occupation code changes in 2001 and after
label define occ 1 "engineer" 2 "teacher" 3 "professionals, misc"
10 "management" 20 "clerical" 30 "sales" 40 "agriculture, forestry and fishery"
50 "miner" 60 "transportation and communication" 71 "skilled production worker"
72 "unskilled worker, unclassified" 81 "house keeping service" 82 "security"
83 "service, misc" 90 "unclassified";
label values occ occ;
