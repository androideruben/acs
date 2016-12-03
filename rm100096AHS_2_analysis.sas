%put code executed on &sysdate9. at &systime.;
data _null_; call symput('begintime',time()); run;

OPTIONS SOURCE NOSTIMER NOCENTER PAGESIZE = 60 LINESIZE = 132 NOQUOTELENMAX orientation=landscape
validvarname=v7 ;

/**************************************************************************************
COMPUTER CODE VERIFICATION-- REVIEWER SIGNATURE AND DATE.

	NAME AND LAST NAME / SIGNED / MM/DD/YYYY: 

      --------------------------------------------------------------------------------
	                     I reviewed the calculations and code in this program and      							
                          found that they meet GAO policy requirements.                 							
                                                                         							
**************************************************************************************
					Reports and calculations contained in this analysis package are       							
                         					*** PRELIMINARY ***                             							
     					 until they have been verified and signed by the reviewer.          							
**************************************************************************************

**************************************************************************************
AUTHOR: Ruben Montes de Oca       
 

**************************************************************************************/

%let program_name=rm100096_ahs_2_analysis;

title1 "100096 AHS";
title2;
title3; 
footnote1 "GAO-ARM. Ruben Montes de Oca &PROGRAM_NAME..sas executed on &sysdate9. at &systime.";

%include "\\winsas01\cdma\montesdeocar\RM100096\PROGRAMS\AHS\rm100096_AHS_formats.sas";

libname ahs '\\winsas01\cdma\montesdeocar\RM100096\DATA\AHS\';

libname ahs2007 '\\winsas01\cdma\montesdeocar\RM100096\DATA\AHS\AHS2007\';
libname ahs2009 '\\winsas01\cdma\montesdeocar\RM100096\DATA\AHS\AHS2009\';
libname ahs2011 '\\winsas01\cdma\montesdeocar\RM100096\DATA\AHS\AHS2011\';
libname ahs2013 '\\winsas01\cdma\montesdeocar\RM100096\DATA\AHS\AHS2013\';

options mprint mlogic;


**Time stamps;
  %macro stamps(folder);
  FILENAME DIRLIST PIPE &folder;
  DATA DIRLIST;
    LENGTH BUFFER $256 ; INFILE DIRLIST LENGTH=RECLEN;
    INPUT BUFFER $varying256. RECLEN; LIST ;
  RUN;
  %mend stamps;

**Data used in this analysis:;
  %stamps('dir "\\winsas01\cdma\montesdeocar\RM100096\DATA\AHS\*.sas7bdat"');

ods noproctitle;

*%let age=age62_class;
%let age=age65_class;

%macro age(data, class, class_label, level, subpopn);**SUDAAN Crosstab for two variables;

proc crosstab data=ahs.&data design= brr;

&subpopn;

weight wgt90geo;
repwgt repwgt1-- repwgt99/adjfay=0.5;**GAO #6610994;

tables &class *   &age;

subgroup &class  &age;
levels   &level  4;

setenv colspce=2 labwidth=10 colwidth=15 decwidth=5;
print nsum wsum totper setot rowper serow lowrow uprow colper secol lowcol upcol; 
output nsum wsum rowper serow lowrow uprow colper secol lowcol upcol/filename=&class replace; 

run;

data temp;
set &class;

me_col=max ( colper- lowcol, upcol- colper);
label me_col="Col Margin of Error";
if me_col>10 then me_col_star=1; else me_col_star=0;

me_row=max ( rowper- lowrow, uprow- rowper);
label me_row="Row Margin of Error";
if me_row>10 then me_row_star=1; else me_row_star=0;

format me_row_star me_col_star star.;

run;

proc tabulate data=temp;
var nsum wsum 
		rowper serow lowrow uprow me_row me_row_star
		colper secol lowcol upcol me_col me_col_star;

class &class &age;

table &class=''*sum='', (&age='age1 Head of Household')*
(nsum='Unweighted N'*f=comma10. wsum='Weighted N'*f=comma10. 

	colper='Col %'*f=10.2 secol='Col s.e.'*f=10.3 lowcol='Col 95% C.I. lb'*f=10.3 upcol='Col 95% C.I. ub'*f=10.3 
	me_col='Col M.E. (pct points)'*f=10.3 me_col_star='** if Col M.E.>10 pct points'*f=star.)

/box=&class_label printmiss indent=2 rts=35;
run;

%mend age;

%macro tablesB(data, var, var_label);

proc descript data=ahs.&data design= brr;
weight wgt90geo;
repwgt repwgt1-- repwgt99/adjfay=0.5;**GAO #6610994;
var &var;
subpopn one=1;
percentile 90/ median quartiles;
tables age65_class;
subgroup age65_class;
levels 4;
setenv colspce=2 labwidth=10 colwidth=15 decwidth=5;
print nsum wsum qtile seqtile lowqtile upqtile;
output nsum wsum qtile seqtile lowqtile upqtile/filename=work.&var replace; 
run;

data work.temp;
set work.&var;
run;
proc tabulate data=work.temp;
var nsum wsum  NSUM WSUM QTILE SEQTILE LOWQTILE UPQTILE ;
class age65_class pctiles;

table (age65_class='age1 Head of Household' *pctiles=&var_label"percentiles")*
(nsum='Unweighted N'*f=comma15. wsum='Weighted N'*f=comma15. QTILE='Qtile'*f=comma15. 
		SEQTILE='s.e.'*f=comma15.2 LOWQTILE='Lower limit'*f=comma15. UPQTILE='Upper limit'*f=comma15.)*sum=''

/box=&var_label printmiss indent=2 rts=35;
run;

%mend tablesB;

options orientation=landscape;
ods rtf file = "\\winsas01\cdma\montesdeocar\RM100096\LST AND LOG\&program_name RTF &sysdate9..rtf";


ods listing close;
ods tagsets.ExcelXP path="\\winsas01\cdma\montesdeocar\RM100096\LST AND LOG\"
            		body="&program_name XLSX &sysdate9..xml"
            		style=default;

	  ods tagsets.excelxp options(sheet_interval='none' 
								embedded_titles='yes' embedded_footnotes='yes'
								orientation='landscape'
								suppress_bylines='no' 
								print_footer='page &amp;p of &amp;n'
								sheet_name='AHS 2009');

title4 "AHS 2009";

%tablesB(ahs2009, BUILT, "BUILT: Year unit was built");
title4;

%age(ahs2009, tenure_sud, "TENURE: Owner/renter of unit", 3, subpopn (one=1));
%age(ahs2009, kitchen_sud, "KITCHEN: Complete kitchen facilities in unit", 2, subpopn (one=1));
%age(ahs2009, nowire_sud, "NOWIRE: Electrical wiring concealed by walls/wiring", 3, subpopn (one=1));
%age(ahs2009, bldmnt_sud, "BLDMNT: Satisfaction with building maintenance", 4, subpopn (one=1));
%age(ahs2009, plumb_sud, "PLUMB: Complete plumbing facilities in unit", 2, subpopn (one=1));
%age(ahs2009, numcold_sud, "NUMCOLD: # times main heating equipment broke down (lasting 6 hours or more)", 4, subpopn (one=1));
%age(ahs2009, freeze_sud, "FREEZE: Unit cold 24+ hours was uncomfortable", 3, subpopn (one=1));
%age(ahs2009, waters_sud, "WATERS: Water safe for drinking & cooking", 2, subpopn (one=1));
%tablesB(ahs2009, hhage, "HHAGE: Age of householder");
%tablesB(ahs2009, per, "PER: Number of persons in household");
*%age(ahs2009, ELDER_sud, "ELDER: Number of persons living in household 65 years or older", 3, subpopn (one=1));
%age(ahs2009, hhmar_sud, "HHMAR: Marital status of householder", 2, subpopn (one=1));
%age(ahs2009, HHTEN_sud, "Householder is owner/renter of unit", 2, subpopn (one=1));
*%age(ahs2009, hhpcare_sud, "HHPCARE: Householder has difficulty dressing or bathing", 2, subpopn (one=1));
*%age(ahs2009, hhphear_sud, "HHPHEAR: Householder has difficulty hearing", 2, subpopn (one=1));
*%age(ahs2009, hhperrnd_sud, "HHPERRND: Householder has difficulty doing errands", 2, subpopn (one=1));
*%age(ahs2009, hhpmemry_sud, "HPMEMRY: Householder has difficulty concentrating or remembering", 2, subpopn (one=1));
*%age(ahs2009, hhpsee_sud, "HHPSEE: Householder has difficulty seeing", 2, subpopn (one=1));
*%age(ahs2009, hhpwalk_sud, "HHPWALK: Householder has difficulty walking or climbing stairs", 2, subpopn (one=1));
%tablesB(ahs2009, ZINC2, "ZINC2: Household income ");
*%age(ahs2009, hhpqsal_sud, "HHPQSAL: Householder has wage/salary", 2, subpopn (one=1));
*%age(ahs2009, hhpqself_sud, "HHPQSELF: Householder received self-employment income", 2, subpopn (one=1));
*%age(ahs2009, HHPQSS_sud, "HHPQSS: Householder received social security or pension", 3, subpopn (one=1));
*%age(ahs2009, HHPQSSI_sud, "HHPQSSI: Householder received supplemental security income", 3, subpopn (one=1));
%age(ahs2009, SUBRNT_sud, "SUBRNT: Government subsidizes rent for unit", 3, subpopn (one=1));
%age(ahs2009, VCHER_sud, "VCHER: Received voucher to help pay rent", 3, subpopn (one=1));
%age(ahs2009, MG_sud, "MG: Any mortgages on this property", 3, subpopn (one=1));
%age(ahs2009, NUMMOR_sud, "NUMMOR: Number of mortgages including home equity loans", 5, subpopn (one=1));
%age(ahs2009, RAM_sud, "RAM: Has reserve annuity or home equity conversion mortgage", 3, subpopn (one=1));
*%age(ahs2009, LENMOD_sud, "LENMOD: Mortgage payment changed because mortgage modified to prevent foreclosure", 2, subpopn (one=1));
*%age(ahs2009, ECOM1_sud, "ECOM1: Business/institutions within ½ block", 2, subpopn (one=1));**Ecom1 not in 2009;

proc freq data=ahs.ahs2009; tables  ecom1; run;
	  ods tagsets.excelxp options(sheet_interval='none' 
								embedded_titles='yes' embedded_footnotes='yes'
								orientation='landscape'
								suppress_bylines='no' 
								print_footer='page &amp;p of &amp;n'
								sheet_name='AHS 2011');

title4 "AHS 2011";

%tablesB(ahs2011, BUILT, "BUILT: Year unit was built");
title4;

%age(ahs2011, tenure_sud, "TENURE: Owner/renter of unit", 3, subpopn (one=1));
%age(ahs2011, kitchen_sud, "KITCHEN: Complete kitchen facilities in unit", 2, subpopn (one=1));
%age(ahs2011, nowire_sud, "NOWIRE: Electrical wiring concealed by walls/wiring", 3, subpopn (one=1));
%age(ahs2011, bldmnt_sud, "BLDMNT: Satisfaction with building maintenance", 4, subpopn (one=1));
%age(ahs2011, plumb_sud, "PLUMB: Complete plumbing facilities in unit", 2, subpopn (one=1));
%age(ahs2011, numcold_sud, "NUMCOLD: # times main heating equipment broke down (lasting 6 hours or more)", 4, subpopn (one=1));
%age(ahs2011, freeze_sud, "FREEZE: Unit cold 24+ hours was uncomfortable", 3, subpopn (one=1));
%age(ahs2011, waters_sud, "WATERS: Water safe for drinking & cooking", 2, subpopn (one=1));
%tablesB(ahs2011, hhage, "HHAGE: Age of householder");
%tablesB(ahs2011, per, "PER: Number of persons in household");
%age(ahs2011, ELDER_sud, "ELDER: Number of persons living in household 65 years or older", 3, subpopn (one=1));
%age(ahs2011, hhmar_sud, "HHMAR: Marital status of householder", 2, subpopn (one=1));
%age(ahs2011, HHTEN_sud, "Householder is owner/renter of unit", 2, subpopn (one=1));
%age(ahs2011, hhpcare_sud, "HHPCARE: Householder has difficulty dressing or bathing", 2, subpopn (one=1));
%age(ahs2011, hhphear_sud, "HHPHEAR: Householder has difficulty hearing", 2, subpopn (one=1));
%age(ahs2011, hhperrnd_sud, "HHPERRND: Householder has difficulty doing errands", 2, subpopn (one=1));
%age(ahs2011, hhpmemry_sud, "HPMEMRY: Householder has difficulty concentrating or remembering", 2, subpopn (one=1));
%age(ahs2011, hhpsee_sud, "HHPSEE: Householder has difficulty seeing", 2, subpopn (one=1));
%age(ahs2011, hhpwalk_sud, "HHPWALK: Householder has difficulty walking or climbing stairs", 2, subpopn (one=1));
%tablesB(ahs2011, ZINC2, "ZINC2: Household income ");
%age(ahs2011, hhpqsal_sud, "HHPQSAL: Householder has wage/salary", 2, subpopn (one=1));
%age(ahs2011, hhpqself_sud, "HHPQSELF: Householder received self-employment income", 2, subpopn (one=1));
%age(ahs2011, HHPQSS_sud, "HHPQSS: Householder received social security or pension", 3, subpopn (one=1));
%age(ahs2011, HHPQSSI_sud, "HHPQSSI: Householder received supplemental security income", 3, subpopn (one=1));
%age(ahs2011, SUBRNT_sud, "SUBRNT: Government subsidizes rent for unit", 3, subpopn (one=1));
%age(ahs2011, VCHER_sud, "VCHER: Received voucher to help pay rent", 3, subpopn (one=1));
%age(ahs2011, MG_sud, "MG: Any mortgages on this property", 3, subpopn (one=1));
%age(ahs2011, NUMMOR_sud, "NUMMOR: Number of mortgages including home equity loans", 5, subpopn (one=1));
%age(ahs2011, RAM_sud, "RAM: Has reserve annuity or home equity conversion mortgage", 3, subpopn (one=1));
%age(ahs2011, LENMOD_sud, "LENMOD: Mortgage payment changed because mortgage modified to prevent foreclosure", 2, subpopn (one=1));

	ods tagsets.excelxp options(sheet_interval='none' 
								embedded_titles='yes' embedded_footnotes='yes'
								orientation='landscape'
								suppress_bylines='no' 
								print_footer='page &amp;p of &amp;n'
								sheet_name='AHS 2013');
title4 "AHS 2013";

%tablesB(ahs2013, built, "BUILT: Year unit was built");
title4;

%age(ahs2013, tenure_sud, "TENURE: Owner/renter of unit", 3, subpopn (one=1));
%age(ahs2013, kitchen_sud, "KITCHEN: Complete kitchen facilities in unit", 2, subpopn (one=1));
%age(ahs2013, nowire_sud, "NOWIRE: Electrical wiring concealed by walls/wiring", 3, subpopn (one=1));
%age(ahs2013, bldmnt_sud, "BLDMNT: Satisfaction with building maintenance", 4, subpopn (one=1));
%age(ahs2013, plumb_sud, "PLUMB: Complete plumbing facilities in unit", 2, subpopn (one=1));
%tablesB(ahs2013, numcold_sud, "NUMCOLD: # times main heating equipment broke down (lasting 6 hours or more)");
%age(ahs2013, freeze_sud, "FREEZE: Unit cold 24+ hours was uncomfortable", 3, subpopn (one=1));
%age(ahs2013, waters_sud, "WATERS: Water safe for drinking & cooking", 2, subpopn (one=1));
%tablesB(ahs2013, hhage, "HHAGE: Age of householder");
%tablesB(ahs2013, per, "PER: Number of persons in household");
%age(ahs2013, ELDER_sud, "ELDER: Number of persons living in household 65 years or older", 3, subpopn (one=1));
%age(ahs2013, hhmar_sud, "HHMAR: Marital status of householder", 2, subpopn (one=1));
%age(ahs2013, HHTEN_sud, "HHTEN: Householder is owner/renter of unit", 2, subpopn (one=1));
%age(ahs2013, hhpcare_sud, "HHPCARE: Householder has difficulty dressing or bathing", 2, subpopn (one=1));
%age(ahs2013, hhphear_sud, "HHPHEAR: Householder has difficulty hearing", 2, subpopn (one=1));
%age(ahs2013, hhperrnd_sud, "HHPERRND: Householder has difficulty doing errands", 2, subpopn (one=1));
%age(ahs2013, hhpmemry_sud, "HHPMEMRY: Householder has difficulty concentrating or remembering", 2, subpopn (one=1));
%age(ahs2013, hhpsee_sud, "HHPSEE: Householder has difficulty seeing", 2, subpopn (one=1));
%age(ahs2013, hhpwalk_sud, "HHPWALK: Householder has difficulty walking or climbing stairs", 2, subpopn (one=1));
%tablesB(ahs2013, ZINC2, "ZINC2: Household income ");
%age(ahs2013, hhpqsal_sud, "HHPQSAL: Householder has wage/salary", 2, subpopn (one=1));
%age(ahs2013, hhpqself_sud, "HHPQSELF: Householder received self-employment income", 2, subpopn (one=1));
%age(ahs2013, HHPQSS_sud, "HHPQSS: Householder received social security or pension", 3, subpopn (one=1));
%age(ahs2013, HHPQSSI_sud, "HHPQSSI: Householder received supplemental security income", 3, subpopn (one=1));
%age(ahs2013, SUBRNT_sud, "SUBRNT: Government subsidizes rent for unit", 3, subpopn (one=1));
%age(ahs2013, VCHER_sud, "VCHER: Received voucher to help pay rent", 3, subpopn (one=1));
%age(ahs2013, MG_sud, "MG: Any mortgages on this property", 3, subpopn (one=1));
%age(ahs2013, NUMMOR_sud, "NUMMOR: Number of mortgages including home equity loans", 5, subpopn (one=1));
%age(ahs2013, RAM_sud, "RAM: Has reserve annuity or home equity conversion mortgage", 3, subpopn (one=1));
%age(ahs2013, LENMOD_sud, "LENMOD: Mortgage payment changed because mortgage modified to prevent foreclosure", 2, subpopn (one=1));

**COMMSERV = community services are available (recode)
ERROR: The variable COMMSERV in the DROP, KEEP, or RENAME list has never been referenced.;

%age(ahs2013, DRUGSTORE_sud, "DRUGSTORE: Drugstore nearby", 2, subpopn (one=1));
*%age(ahs2013, ECOM1_sud, "ECOM1: Business/institutions within ½ block", 2, subpopn (one=1));

**NEWTRN = public transportation available
ERROR: The variable NEWTRN in the DROP, KEEP, or RENAME list has never been referenced.;

**NORC = majority of neighbors 55+
ERROR: The variable NORC in the DROP, KEEP, or RENAME list has never been referenced.;

**SHPCLS = neighborhood stores within 15 minutes
ERROR: The variable SHPCLS in the DROP, KEEP, or RENAME list has never been referenced.;

**SHP = neighborhood shopping satisfactory
ERROR: The variable SHP in the DROP, KEEP, or RENAME list has never been referenced.;


ods tagsets.ExcelXP close;
ods listing;

ods rtf;
ods listing;

***II. Time stamps;
  %macro stamps(folder);
  FILENAME DIRLIST PIPE &folder;
  DATA DIRLIST;
    LENGTH BUFFER $256 ; INFILE DIRLIST LENGTH=RECLEN;
    INPUT BUFFER $varying256. RECLEN; LIST ;
  RUN;
  %mend stamps;
  %stamps('dir "\\winsas01\cdma\montesdeocar\RM100096\DATA\AHS\"');
  *%stamps('dir "\\winsas01\cdma\montesdeocar\RM100096\DATA\AHS\AHS2007\"');
  *%stamps('dir "\\winsas01\cdma\montesdeocar\RM100096\DATA\AHS\AHS2009\"');
  *%stamps('dir "\\winsas01\cdma\montesdeocar\RM100096\DATA\AHS\AHS2013\"');

  %stamps('dir "\\winsas01\cdma\montesdeocar\RM100096\LST AND LOG\"');
  *%stamps('dir "\\winsas01\cdma\montesdeocar\RM100096\OLD\"');

options nomprint nomlogic;

data _null_; call symput('endtime',time()); run;
data _null_; howlong=((&endtime-&begintime)/60); 
	put "total time processing took >>>> " howlong 6. " minutes";
run;

/**************************************************************************************
End of \\winsas01\cdma\montesdeocar\RM100096\PROGRAMS\rm100096ahs_2_analysis.sas
**************************************************************************************/



