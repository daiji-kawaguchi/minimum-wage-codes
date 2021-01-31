#delimit ;
global path "C:\Users\DAIJI\Documents\GitHub\minimum-wage";
*global path "C:\Users\森悠子\Documents\GitHub\minimu-wage";
global datapath "C:\stataproject\data\minimumwage";
global control "i.age frac1_19_24 frac1_25_59 frac1_60_64 frac2_19_24 frac2_25_59 frac2_60_64 ue_cl25_59";
*job col_rate ind1-ind18 i.region#c.year i.region#i.year marriage age age2  i.age#i.prefecture;
global control_bsws "i.age#i.sex i.prefecture i.year";
global fix "i.year#i.month i.prefecture i.prefecture#c.year";
global wo_fix "i.year#i.month i.prefecture";

set scheme s2mono, permanently;
set mat 4000;
exit;

do "${path}\do\wcensus.do";

do "${path}\do\rokiso.do";
do "${path}\do\rotoku.do";
do "${path}\do\matching.do";
do "${path}\do\aggregate.do";
do "${path}\do\crcross.do";

do "${path}\do\wage_descriptive.do";
do "${path}\do\wage_reg.do";

do "${path}\do\descriptive.do";
do "${path}\do\cs_reg.do";
do "${path}\do\cs_reg_iv.do";
do "${path}\do\panelreg.do";

*without Tokyo & Kanagawa;
do "${path}\do\ck_cs_reg.do";
do "${path}\do\ck_cs_reg_iv.do";
exit;

