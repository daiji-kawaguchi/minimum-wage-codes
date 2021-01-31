#delimit ;
cd $workpath ; 
cap log close;
log using $workpath/log/reg_control.log, replace;
clear;
clear matrix;
clear mata;
set more off;
set matsize 1600;
set maxvar 5000;
set emptycells drop;
eststo clear;
clear;

use $workpath/data/kakei_2005_2014.dta;

keep if elec_comp==3|elec_comp==5;
gen treat=(elec_comp==3);
tab elec_comp treat;

reg lelec_qty i.treat#i.year#i.month i.treat i.year#i.month, vce($vce);

exit;

