%put code executed on &sysdate9. at &systime.;
data _null_; call symput('begintime',time()); run;

OPTIONS source nostimer nocenter pagesize = 60 linesize = 132 noquotelenmax mprint mlogic
validvarname=v7 ;

ods noproctitle;

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

%let program_name=rm100096_ahs_1_data;

title1 "100096 AHS";
title2;
title3; 
footnote1 "GAO-ARM. Ruben Montes de Oca &PROGRAM_NAME..sas executed on &sysdate9. at &systime.";

%include "\\winsas01\cdma\montesdeocar\RM100096\PROGRAMS\AHS\rm100096_AHS_formats.sas";

libname ahs '\\winsas01\cdma\montesdeocar\RM100096\DATA\AHS\';

libname ahs1993 '\\winsas01\cdma\montesdeocar\RM100096\DATA\AHS\AHS1993\';
libname ahs1995 '\\winsas01\cdma\montesdeocar\RM100096\DATA\AHS\AHS1995\';
libname ahs1997 '\\winsas01\cdma\montesdeocar\RM100096\DATA\AHS\AHS1997\';
libname ahs1999 '\\winsas01\cdma\montesdeocar\RM100096\DATA\AHS\AHS1999\';
libname ahs2001 '\\winsas01\cdma\montesdeocar\RM100096\DATA\AHS\AHS2001\';
libname ahs2003 '\\winsas01\cdma\montesdeocar\RM100096\DATA\AHS\AHS2003\';
libname ahs2005 '\\winsas01\cdma\montesdeocar\RM100096\DATA\AHS\AHS2005\';
libname ahs2007 '\\winsas01\cdma\montesdeocar\RM100096\DATA\AHS\AHS2007\';
libname ahs2009 '\\winsas01\cdma\montesdeocar\RM100096\DATA\AHS\AHS2009\';
libname ahs2011 '\\winsas01\cdma\montesdeocar\RM100096\DATA\AHS\AHS2011\';
libname ahs2013 '\\winsas01\cdma\montesdeocar\RM100096\DATA\AHS\AHS2013\';

**A. Showing downloaded zip file and unzipped SAS data sets:;
***SAS data downloaded from AHS National Public Use File (PUF), year 2007, 2009, 2011, 2013: 
http://www.census.gov/programs-surveys/ahs/data.2007.html
http://www.census.gov/programs-surveys/ahs/data.2009.html
http://www.census.gov/programs-surveys/ahs/data.2011.html
http://www.census.gov/programs-surveys/ahs/data.2013.html
;
  %macro stamps(folder);
  FILENAME DIRLIST PIPE &folder;
  DATA DIRLIST;
    LENGTH BUFFER $256 ; INFILE DIRLIST LENGTH=RECLEN;
    INPUT BUFFER $varying256. RECLEN; LIST ;
  RUN;
  %mend stamps;

**(Time stamps of data created by this program at the end of the log);

***(See log) Showing downloaded zip file and unzipped SAS data sets:;

  %stamps('dir "\\winsas01\cdma\montesdeocar\RM100096\DATA\AHS\AHS1993\"*.zip');
  %stamps('dir "\\winsas01\cdma\montesdeocar\RM100096\DATA\AHS\AHS1993\"*.sas7bdat');

  %stamps('dir "\\winsas01\cdma\montesdeocar\RM100096\DATA\AHS\AHS1995\"*.zip');
  %stamps('dir "\\winsas01\cdma\montesdeocar\RM100096\DATA\AHS\AHS1995\"*.sas7bdat');

  %stamps('dir "\\winsas01\cdma\montesdeocar\RM100096\DATA\AHS\AHS1997\"*.zip');
  %stamps('dir "\\winsas01\cdma\montesdeocar\RM100096\DATA\AHS\AHS1997\"*.sas7bdat');

  %stamps('dir "\\winsas01\cdma\montesdeocar\RM100096\DATA\AHS\AHS1999\"*.zip');
  %stamps('dir "\\winsas01\cdma\montesdeocar\RM100096\DATA\AHS\AHS1999\"*.sas7bdat');

  %stamps('dir "\\winsas01\cdma\montesdeocar\RM100096\DATA\AHS\AHS2001\"*.zip');
  %stamps('dir "\\winsas01\cdma\montesdeocar\RM100096\DATA\AHS\AHS2001\"*.sas7bdat');

  %stamps('dir "\\winsas01\cdma\montesdeocar\RM100096\DATA\AHS\AHS2003\"*.zip');
  %stamps('dir "\\winsas01\cdma\montesdeocar\RM100096\DATA\AHS\AHS2003\"*.sas7bdat');

  %stamps('dir "\\winsas01\cdma\montesdeocar\RM100096\DATA\AHS\AHS2005\"*.zip');
  %stamps('dir "\\winsas01\cdma\montesdeocar\RM100096\DATA\AHS\AHS2005\"*.sas7bdat');

  %stamps('dir "\\winsas01\cdma\montesdeocar\RM100096\DATA\AHS\AHS2007\"*.zip');
  %stamps('dir "\\winsas01\cdma\montesdeocar\RM100096\DATA\AHS\AHS2007\"*.sas7bdat');

  %stamps('dir "\\winsas01\cdma\montesdeocar\RM100096\DATA\AHS\AHS2009\"*.zip');
  %stamps('dir "\\winsas01\cdma\montesdeocar\RM100096\DATA\AHS\AHS2009\"*.sas7bdat');

  %stamps('dir "\\winsas01\cdma\montesdeocar\RM100096\DATA\AHS\AHS2011\"*.zip');
  %stamps('dir "\\winsas01\cdma\montesdeocar\RM100096\DATA\AHS\AHS2011\"*.sas7bdat');

  %stamps('dir "\\winsas01\cdma\montesdeocar\RM100096\DATA\AHS\AHS2013\"*.zip');
  %stamps('dir "\\winsas01\cdma\montesdeocar\RM100096\DATA\AHS\AHS2013\"*.sas7bdat');


**A. Variables in data:;
%macro contents(data);

proc contents data=&data;
title4 "A. Variables in data: &data";
run;

%mend contents;

**Permanent data sets to the AHS folder:;

**Need variables from the repwgt data set:;
proc sort data=ahs2011.repwgt out=work.repwgt; by control; 
data ahs.ahs2011;
merge ahs2011.ahs2011 ahs2011.newhouse work.repwgt;
by control;
run;

**B. Recode variables for SUDAAN and test that recoding is right:;

%macro vars(datain, data);**Use for 1999- 2013;

**recode variables in permanent data AHS 1999 to 2013:;

title4 "B. Recode variables for SUDAAN and test that recoding is right: &data";

data ahs.&data;
set &datain;

one=1;

**Status:;
status_sud=status*1;
format status_sud status_sud.;
label status_sud='Interview status';

*Define age of household;
if age1>=0 then do;
	if age1<65 then age65_class=1;
		else if 65<=age1<75 then age65_class=2;
		else if 75<=age1<85 then age65_class=3;
		else if age1>84 then age65_class=4;
end;
label age65_class='Age1: age of head of household';

**Create variables for SUDAAN: 0 is not an acceptable value for categorical variables in SUDAAN;
if hhsex notin ('B','D','R','') then hhsex_sud=hhsex*1; else hhsex_sud=.;

if bldmnt notin ('B','D','R','') then bldmnt_sud=bldmnt*1; else bldmnt_sud=.;
if freeze notin ('B','D','R','') then freeze_sud=freeze*1; else freeze_sud=.;
if kitchen notin ('B','D','R','') then kitchen_sud=kitchen*1; else kitchen_sud=.;
if nowire notin ('B','D','R','') then nowire_sud=nowire*1; else nowire_sud=.;
if plumb notin ('B','D','R','') then plumb_sud=plumb*1; else plumb_sud=.;
if tenure notin ('B','D','R','') then tenure_sud=tenure*1; else tenure_sud=.;
if waters notin ('B','D','R','') then waters_sud=waters*1; else waters_sud=.;

if hhmar notin ('B','D','R','') then hhmar_sud=hhmar*1; else hhmar_sud=.;

/**Not in ahs2007 nor ahs2009
if hhpcare notin ('B','D','R','') then hhpcare_sud=hhpcare*1; else hhpcare_sud=.;
if hhphear notin ('B','D','R','') then hhphear_sud=hhphear*1; else hhphear_sud=.;
if hhperrnd notin ('B','D','R','') then hhperrnd_sud=hhperrnd*1; else hhperrnd_sud=.;
if hhpmemry notin ('B','D','R','') then hhpmemry_sud=hhpmemry*1; else hhpmemry_sud=.;
if hhpsee notin ('B','D','R','') then hhpsee_sud=hhpsee*1; else hhpsee_sud=.;
if hhpwalk notin ('B','D','R','') then hhpwalk_sud=hhpwalk*1; else hhpwalk_sud=.;
if hhpqsal notin ('B','D','R','') then hhpqsal_sud=hhpqsal*1; else hhpqsal_sud=.;
if hhpqself notin ('B','D','R','') then hhpqself_sud=hhpqself*1; else hhpqself_sud=.;
*/

**zinc2 is numeric, Hhpten not found;

**other definitions:;
if tenure notin ('B','D','R','') then do;
	if tenure='1' then tenureB_sud=1;
		else if tenure in ('2', '3') then tenureB_sud=2; **tenure=2=Rented, tenure=3=Occupied without payment or rent;
end;

if age1 ne . then do;
	if age1 <25 then ageB_sud=1;
		else if 25<=age1<30 then ageB_sud=2;
		else if 30<=age1<35 then ageB_sud=3;
		else if 35<=age1<45 then ageB_sud=4;
		else if 45<=age1<55 then ageB_sud=5;
		else if 55<=age1<65 then ageB_sud=6;
		else if 65<=age1<75 then ageB_sud=7;
		else if 75<=age1 then ageB_sud=8;

end;
format ageB_sud ageB_sud.;

if tenure_sud in (2,3) then tenureB_sud=2;
	else tenureB_sud=tenure_sud;
format tenureB_sud tenureB_sud.;

format 

status $status.
bldmnt $bldmnt.
freeze $freeze.
kitchen $kitchen.
nowire $nowire.
plumb $plumb.
tenure $tenure.
waters $waters.

hhmar $hhmar.

age65_class age65_class.

hhsex_sud hhsex_sud.

bldmnt_sud bldmnt_sud.
freeze_sud freeze_sud.
kitchen_sud kitchen_sud.
nowire_sud nowire_sud.
plumb_sud plumb_sud.
tenure_sud tenure_sud.
waters_sud waters_sud.

hhmar_sud hhmar_sud.
;
run;

proc means;
class age65_class;
var age1;
run;

proc freq;

tables 

age65_class

status_sud* status
bldmnt_sud* bldmnt
freeze_sud* freeze
kitchen_sud* kitchen
nowire_sud* nowire
plumb_sud* plumb
tenure_sud* tenure
waters_sud* waters

hhmar_sud* hhmar

/list missing
;

run;

**Testing that id=control is not repeated:;
proc freq data=ahs.&data noprint;
tables control/out=work.freq;
run;
proc freq data=work.freq; 
title4 "If count = 1 then id=control is not repeated";
tables count;
run;


%mend vars;



%macro varsB(data);**Use for 2007- 2013;

title4 "B. More recoding for SUDAAN and test that recoding is right: &data";

data ahs.&data;
set ahs.&data;

if hhten in ('X', 'x') then hhten_sud=1;**checked;
	else if hhten='' then hhten_sud=.N;**not reported;
label hhten_sud="HHTEN: Householder is owner/renter of unit";
format hhten_sud hhten_sud. hhten $hhten.;

if MG ='1' then MG_sud=1;
	else if MG='2' then MG_sud=2;
	else if MG in ('B', '-6') then MG_sud=3;
label MG_sud="MG: Any mortgages on this property";
format MG_sud MG_sud. MG $mg.;

if NUMMOR =1 then NUMMOR_sud=1;
	else if NUMMOR=2 then NUMMOR_sud=2;
	else if NUMMOR=3 then NUMMOR_sud=3;
	else if NUMMOR=4 then NUMMOR_sud=4;
	else if NUMMOR>4 then NUMMOR_sud=5;
label NUMMOR_sud="NUMMOR: Number of mortgages including home equity loans";
format NUMMOR_sud NUMMOR_sud.;

if numcold ='0' then numcold_sud=1;**Never broken;
	else if numcold in ('1', '2', '3', '4', '5', '6', '7') then numcold_sud=2;**1 to 7 breakdowns lasted 6 hours or more;
	else if numcold in ('8') then numcold_sud=3;**8 or more breakdowns lasting 6 hours or more;
	else if numcold in ('B', '-6') then numcold_sud=4;
label numcold_sud="NUMCOLD: # times main heating equipment broke down (lasting 6 hours or more)";
format numcold_sud numcold_sud. numcold $numcold.;

if RAM ='1' then RAM_sud=1;
	else if RAM='2' then RAM_sud=2;
	else if RAM in ('B', '-6') then RAM_sud=3;
label RAM_sud="RAM: Has reserve annuity or home equity conversion mortgage";
format RAM_sud RAM_sud. ram $ram.;

if SUBRNT ='1' then SUBRNT_sud=1;
	else if SUBRNT='2' then SUBRNT_sud=2;
	else if SUBRNT in ('B', '-6') then SUBRNT_sud=3;
label SUBRNT_sud="SUBRNT: Government subsidizes rent for unit";
format SUBRNT_sud SUBRNT_sud. SUBRNT $SUBRNT.;

if VCHER ='1' then VCHER_sud=1;
	else if VCHER='2' then VCHER_sud=2;
	else if VCHER in ('B', '-6') then VCHER_sud=3;
label VCHER_sud="VCHER: Received voucher to help pay rent";
format VCHER_sud VCHER_sud. VCHER $VCHER.;

run;

proc freq;

tables 

hhten_sud* hhten 
MG_sud* MG
NUMMOR_sud* NUMMOR 
numcold_sud* numcold 
RAM_sud*RAM
SUBRNT_sud*SUBRNT
VCHER_sud*VCHER

/list missing
;

run;
%mend varsB;


%macro varsC(data);**Use for 2011 and 2013. Variables not in other years;

title4 "B. More recoding for SUDAAN and test that recoding is right: &data";

data ahs.&data;
set ahs.&data;

if elder=0 then elder_sud=1;
	else if 1<=elder<=29 then elder_sud=2;
	else if elder=30 then elder_sud=3;
label elder_sud='ELDER: Number of persons living in household 65 years or older';

if HHPQSS ='1' then HHPQSS_sud=1;
	else if HHPQSS='2' then HHPQSS_sud=2;
	else if HHPQSS in ('B', '-6') then HHPQSS_sud=3;
label HHPQSS_sud="HHPQSS: Householder received social security or pension";
format HHPQSS_sud HHPQSS_sud. HHPQSS $HHPQSS.;

if HHPQSSI ='1' then HHPQSSI_sud=1;
	else if HHPQSSI='2' then HHPQSSI_sud=2;
	else if HHPQSSI in ('B', '-6') then HHPQSSI_sud=3;
label HHPQSSI_sud="HHPQSSI: Householder received supplemental security income";
format HHPQSSI_sud HHPQSSI_sud. HHPQSSI$ HHPQSSI.;

if HHPCARE ='1' then HHPCARE_sud=1;
	else if HHPCARE='2' then HHPCARE_sud=2;
	else if HHPCARE in ('B', '-6') then HHPCARE_sud=3;
label HHPCARE_sud="HHPCARE: Householder has self-care disability";
format HHPCARE_sud HHPCARE_sud. hhpcare $hhpcare.;;

if HHPHEAR ='1' then HHPHEAR_sud=1;
	else if HHPHEAR='2' then HHPHEAR_sud=2;
	else if HHPHEAR in ('B', '-6') then HHPHEAR_sud=3;
label HHPHEAR_sud="HHPHEAR: Householder has hearing disability";
format HHPHEAR_sud HHPHEAR_sud. HHPHEAR $HHPHEAR.;

if HHPERRND ='1' then HHPERRND_sud=1;
	else if HHPERRND='2' then HHPERRND_sud=2;
	else if HHPERRND in ('B', '-6') then HHPERRND_sud=3;
label HHPERRND_sud="HHPERRND: Householder has go-outside-home disability";
format HHPERRND_sud HHPERRND_sud.;

if HHPMEMRY ='1' then HHPMEMRY_sud=1;
	else if HHPMEMRY='2' then HHPMEMRY_sud=2;
	else if HHPMEMRY in ('B', '-6') then HHPMEMRY_sud=3;
label HHPMEMRY_sud="HHPMEMRY: Householder has memory disability";
format HHPMEMRY_sud HHPMEMRY_sud. HHPMEMRY $HHPMEMRY.;

if HHPSEE ='1' then HHPSEE_sud=1;
	else if HHPSEE='2' then HHPSEE_sud=2;
	else if HHPSEE in ('B', '-6') then HHPSEE_sud=3;
label HHPSEE_sud="HHPSEE: Householder has seeing disability";
format HHPSEE_sud HHPSEE_sud. HHPSEE $HHPSEE.;

if HHPWALK ='1' then HHPWALK_sud=1;
	else if HHPWALK='2' then HHPWALK_sud=2;
	else if HHPWALK in ('B', '-6') then HHPWALK_sud=3;
label HHPWALK_sud="HHPWALK: Householder has walking disability";
format HHPWALK_sud HHPWALK_sud. HHPWALK $HHPWALK.;

if HHPQSAL ='1' then HHPQSAL_sud=1;
	else if HHPQSAL='2' then HHPQSAL_sud=2;
	else if HHPQSAL in ('B', '-6') then HHPQSAL_sud=3;
label HHPQSAL_sud="HHPQSAL: Householder has wages/salary";
format HHPQSAL_sud HHPQSAL_sud. HHPQSAL $HHPQSAL.;

if HHPQSELF ='1' then HHPQSELF_sud=1;
	else if HHPQSELF='2' then HHPQSELF_sud=2;
	else if HHPQSELF in ('B', '-6') then HHPQSELF_sud=3;
label HHPQSELF_sud="HHPQSELF: Householder received self-employment income";
format HHPQSELF_sud HHPQSELF_sud. HHPQSELF $HHPQSELF.;

if LENMOD ='1' then LENMOD_sud=1;
	else if LENMOD='2' then LENMOD_sud=2;
	else if LENMOD in ('B', '-6') then LENMOD_sud=3;
label LENMOD_sud="LENMOD: Mortgage payment changed because mortgage modified to prevent foreclosure";
format LENMOD_sud LENMOD_sud. LENMOD $LENMOD.;

proc freq;

tables 

elder_sud*elder
HHPQSS_sud*HHPQSS
HHPQSSI_sud*HHPQSSI
HHPCARE_sud*HHPCARE
HHPHEAR_SUD*HHPHEAR
HHPERRND_SUD*HHPERRND
HHPMEMRY_SUD*HHPMEMRY
HHPSEE_SUD*HHPSEE
HHPWALK_SUD*HHPWALK
HHPQSAL_SUD*HHPQSAL
HHPQSELF_SUD*HHPQSELF
LENMOD_sud*LENMOD
/list missing
;

run;

%mend varsC;

**C. Understanding weights:;
%macro weights(data, vars);

proc means n nmiss median sum data=ahs.&data maxdec=0;
title4 "C. Understanding weights: &data";
var &vars;
output out=work.sum&data sum(weight)=sum_weight;
run;

proc freq data=ahs.&data;
title5 "Status";
weight weight;
tables status/out=work.status&data;
run;

%mend weights;

**Macros B to E are below:;

ods _all_ close;

options orientation=landscape;
ods pdf file = "\\winsas01\cdma\montesdeocar\RM100096\LST AND LOG\&program_name repeated weights doc &sysdate9..pdf";

ods tagsets.ExcelXP path="\\winsas01\cdma\montesdeocar\RM100096\LST AND LOG\"
            		body="&program_name repeated weights xlsx &sysdate9..xml"
            		style=default;

	ods tagsets.excelxp options(sheet_interval='none' 
								embedded_titles='yes' embedded_footnotes='yes'
								orientation='landscape'
								suppress_bylines='no' 
								print_footer='page &amp;p of &amp;n'
								sheet_name='A. Variables in data');


**Macro A. Variables in data:;

*%contents(ahs1993.ahs93n);**Has different variable names. Data not included;
*%contents(ahs1995.ahs95n);**Has different variable names. Data not included;

%contents(ahs1997.ahs1997n);
%contents(ahs1997.homimp);
%contents(ahs1997.houshld);
%contents(ahs1997.jtw);
%contents(ahs1997.mortg);
%contents(ahs1997.owner);
%contents(ahs1997.person);
%contents(ahs1997.rmov);
%contents(ahs1997.toppuf);
%contents(ahs1997.weight);
data one; set ahs1997.ahs1997n; proc sort; by control;
data two; set ahs1997.weight; proc sort; by control;
title4 "If 'No unequal values were found' then no need to merge to the 'weights' data set";
proc compare base=one compare=two; run;

%contents(ahs1999.ahs1999n);
%contents(ahs1999.homimp);
%contents(ahs1999.houshld);
%contents(ahs1999.jtw);
%contents(ahs1999.mortg);
%contents(ahs1999.owner);
%contents(ahs1999.person);
%contents(ahs1999.ratiov);
%contents(ahs1999.rmov);
%contents(ahs1999.toppuf);
%contents(ahs1999.weight);
data one; set ahs1999.ahs1999n; proc sort; by control;
data two; set ahs1999.weight; proc sort; by control;
title4 "If 'No unequal values were found' then no need to merge to the 'weights' data set";
proc compare base=one compare=two; run;

%contents(ahs2001.ahs2001n);
%contents(ahs2001.homimp);
%contents(ahs2001.jtw);
%contents(ahs2001.mortg);
%contents(ahs2001.newformat);
%contents(ahs2001.newhouse);
%contents(ahs2001.owner);
%contents(ahs2001.person);
%contents(ahs2001.ratiov);
%contents(ahs2001.rmov);

%contents(ahs2003.ahs2003n);
%contents(ahs2003.homimp);
%contents(ahs2003.jtw);
%contents(ahs2003.mortg);
%contents(ahs2003.newformat);
%contents(ahs2003.newhouse);
%contents(ahs2003.owner);
%contents(ahs2003.person);
%contents(ahs2003.ratiov);
%contents(ahs2003.rmov);

%contents(ahs2005.ahs2005n);
%contents(ahs2005.homimp); 
%contents(ahs2005.jtw);
%contents(ahs2005.mortg);
%contents(ahs2005.newformat);
%contents(ahs2005.newhouse);
%contents(ahs2005.owner);
%contents(ahs2005.person);
%contents(ahs2005.ratiov);
%contents(ahs2005.rmov);

%contents(ahs2007.ahs2007n);**I renamed 'AHS 2007 National PUF V1.1a Flat SAS.sas7bdat' as 'ahs2007n.sas7bdat';
%contents(ahs2007.homimp);
%contents(ahs2007.jtw);
%contents(ahs2007.mortg);
%contents(ahs2007.newhouse);
%contents(ahs2007.owner);
%contents(ahs2007.person);
%contents(ahs2007.repwgt);
%contents(ahs2007.rmov);

%contents(ahs2009.ahs2009n);
%contents(ahs2009.homimp);
%contents(ahs2009.jtw);
%contents(ahs2009.mortg);
%contents(ahs2009.newformat09);
%contents(ahs2009.newhouse);
%contents(ahs2009.owner);
%contents(ahs2009.person);
%contents(ahs2009.ratiov);
%contents(ahs2009.repwgt);
%contents(ahs2009.rmov);

%contents(ahs2011.ahs2011);
%contents(ahs2011.homimp);
%contents(ahs2011.mortg);
%contents(ahs2011.newformat11);
%contents(ahs2011.newhouse);
%contents(ahs2011.owner);
%contents(ahs2011.person);
%contents(ahs2011.ratiov);
%contents(ahs2011.repwgt);
%contents(ahs2011.rmov);
%contents(ahs2011.typec);

%contents(ahs2013.ahs2013n);**I renamed 'ahs2013.sas7bdat' as 'ahs2013n.sas7bdat';
%contents(ahs2013.homimp);
%contents(ahs2013.mortg);
%contents(ahs2013.newhouse);
%contents(ahs2013.omov);
%contents(ahs2013.owner);
%contents(ahs2013.person);
%contents(ahs2013.ratiov);
%contents(ahs2013.repwgt);
%contents(ahs2013.rmov);
%contents(ahs2013.topical);
data one; set ahs2013.ahs2013n; proc sort; by control;
data two; set ahs2013.repwgt; proc sort; by control;
title4 "If 'No unequal values were found' then no need to merge to the 'repwgt' data set";
proc compare base=one compare=two; run;


**Create permanent data 1999 to 2013 in rhe AHS data folder:;
title5;


	ods tagsets.excelxp options(sheet_interval='none' 
								embedded_titles='yes' embedded_footnotes='yes'
								orientation='landscape'
								suppress_bylines='no' 
								print_footer='page &amp;p of &amp;n'
								sheet_name='B. Recode variables');


**Macro B. Recode variables for SUDAAN and test that recoding is right:;

*%vars(ahs1993.ahs93n, ahs1993);**Has different variable names. Data not included;
*%vars(ahs1995.ahs95n, ahs1995);**Has different variable names. Data not included;

%vars(ahs1997.ahs1997n, ahs1997);
%vars(ahs1999.ahs1999n, ahs1999);
%vars(ahs2001.ahs2001n, ahs2001);
%vars(ahs2003.ahs2003n, ahs2003);
%vars(ahs2005.ahs2005n, ahs2005);
%vars(ahs2007.ahs2007n, ahs2007);
**Add some other variables to 2007:;
%varsB(ahs2007);
data ahs.ahs2007;
set ahs.ahs2007;
if ecom1 notin ('1','2','B') then ecom1_sud=.;
	else if ecom1='B' then ecom1_sud=3;
	else ecom1_sud=ecom1*1; 
label ecom1_sud="Business/instituitions within 1/2 block";
format ecom1_sud ecom1_sud. ecom1 $ecom1f.;
run;
proc freq data=ahs.ahs2007;
tables ecom1_sud*ecom1/list missing;
run;

%vars(ahs2009.ahs2009n, ahs2009);
**Add some other variables to 2009:;
%varsB(ahs2009);

**Add some other variables to 2011:;
%vars(ahs.ahs2011, ahs2011);
**Add more vars:;
%varsB(ahs2011);
%varsC(ahs2011);

%vars(ahs2013.ahs2013n, ahs2013);
***Add more vars:;
%varsB(ahs2013);
%varsC(ahs2013);

**And more vars unique to ahs2013:;
data ahs.ahs2013;
set ahs.ahs2013;

if DRUGSTORE ='1' then DRUGSTORE_sud=1;
	else if DRUGSTORE='2' then DRUGSTORE_sud=2;
	else if DRUGSTORE in ('B', '-6') then DRUGSTORE_sud=3;
label DRUGSTORE_sud="DRUGSTORE: Drugstore nearby";
format DRUGSTORE_sud DRUGSTORE_sud. drugstore $drugstore.;
proc freq;
tables 
drugstore_sud*drugstore
/list missing;
run;


	ods tagsets.excelxp options(sheet_interval='none' 
								embedded_titles='yes' embedded_footnotes='yes'
								orientation='landscape'
								suppress_bylines='no' 
								print_footer='page &amp;p of &amp;n'
								sheet_name='C. Understanding weights');

**Macro C. Understanding weights:;

*%weights(ahs1993, pwt weight);**Has different variable names. Data not included;
*%weights(ahs1995, pwt weight);**Has different variable names. Data not included;

%weights(ahs1997, pwt weight);
%weights(ahs1999, pwt weight);
%weights(ahs2001, pwt weight wgt90geo);
%weights(ahs2003, pwt weight wgt90geo);
%weights(ahs2005, pwt weight wgt90geo);

**The xml created cannot be opened. I think that this part creates the problem: repwgt0--repwgt160
I tried also repwgt: and same problem. The pdf output is fine;
%weights(ahs2007, pwt weight wgt90geo repwgt0--repwgt160);
%weights(ahs2009, pwt weight wgt90geo repwgt0--repwgt160);
%weights(ahs2011, pwt weight wgt90geo repwgt1--repwgt0);**Same weight vars, different order;
%weights(ahs2013, pwt weight wgt90geo repwgt0--repwgt160);

data work.sumweights;
set 
work.sumahs1997(in=a)
work.sumahs1999(in=b)
work.sumahs2001(in=c)
work.sumahs2003(in=d)
work.sumahs2005(in=e)
work.sumahs2007(in=f)
work.sumahs2009(in=g)
work.sumahs2011(in=h)
work.sumahs2013(in=i);

if a then year=1997;
if b then year=1999;
if c then year=2001;
if d then year=2003;
if e then year=2005;
if f then year=2007;
if g then year=2009;
if h then year=2011;
if i then year=2013;
run;

proc print noobs label data=work.sumweights;
title4 "C. Understanding weights";
title5 "(AHS 2007- 2013 have also replicated weights)";
var year sum_weight;
label sum_weight="Sum WEIGHTS (1980 Census)"
year='AHS Year';
format sum_weight comma15.0;
run;

data work.STATUS;
set 
work.STATUSahs1997(in=a)
work.STATUSahs1999(in=b)
work.STATUSahs2001(in=c)
work.STATUSahs2003(in=d)
work.STATUSahs2005(in=e)
work.STATUSahs2007(in=f)
work.STATUSahs2009(in=g)
work.STATUSahs2011(in=h)
work.STATUSahs2013(in=i);

if a then year=1997;
if b then year=1999;
if c then year=2001;
if d then year=2003;
if e then year=2005;
if f then year=2007;
if g then year=2009;
if h then year=2011;
if i then year=2013;
run;

proc print noobs label data=work.status;
title4 "C. Understanding weights";
title5 "Status: notice 'occupied'";
by year;
*var year count percent;
label count="N (weighted)" percent='Percent (weighted)'
year='AHS Year';
format count percent comma15.1;
run;


	ods tagsets.excelxp options(sheet_interval='none' 
								embedded_titles='yes' embedded_footnotes='yes'
								orientation='landscape'
								suppress_bylines='no' 
								print_footer='page &amp;p of &amp;n'
								sheet_name='D. Testing weighted analysis 2011');

**D. Testing weighted analysis 2011:;
***Check to the web generated tables:;

proc means n nmiss min max data=ahs.ahs2011 maxdec=0;
title4 "D. Testing weighted analysis 2011";
weight wgt90geo;
var age1;
run;
proc means n nmiss min max data=ahs.ahs2011 maxdec=0;
title4 "D. Testing weighted analysis 2011";
weight wgt90geo;
class ageB_sud;
var age1;
run;

options nomprint nomlogic;

ods tagsets.ExcelXP close;

ods pdf;
ods listing;

***II. Time stamps of data created by this program (see log);
  %stamps('dir "\\winsas01\cdma\montesdeocar\RM100096\DATA\AHS\"');
  %stamps('dir "\\winsas01\cdma\montesdeocar\RM100096\LST AND LOG\"');


data _null_; call symput('endtime',time()); run;
data _null_; howlong=((&endtime-&begintime)/60); 
	put "total time processing took >>>> " howlong 6. " minutes";
run;

/**************************************************************************************
End of \\winsas01\cdma\montesdeocar\RM100096\PROGRAMS\rm100096ahs_1_data.sas
**************************************************************************************/
