
proc format;

value age62_class
0='Total'
1='Ages >=62'
2='Ages < 62';

value age65_class
0='Total'
1='Ages < 65'
2='Ages 65 to 74'
3='Ages 75 to 84'
4='Ages 85 and over';

value ageB_sud
0='Total'
1='Under 25 years old'
2='25 to 29 years old'
3='30 to 34 years old'
4='35 to 44 years old'
5='45 to 54 years old'
6='55 to 64 years old'
7='65 to 74 years old'
8='75 years old and over';

value $bldmnt
'1'=' Completely satisfied'
'2'='Partially staisfied'
'3'='Disatisfied'
'4'='Landlord not responsible for building maintenance'
'B'='Not applicable'
'D'="Don't know"
'R'='Refused'
''='Not reported';

value bldmnt_sud
0='Total'
1=' Completely satisfied'
2='Partially staisfied'
3='Disatisfied'
4='Landlord not responsible for building maintenance';

value $drugstore
'1'='Yes'
'2'='No';

value DRUGSTORE_sud
0='Total'
1='Yes'
2='No'
3='N/A';

value $ecom1f
'B'='Not applicable'
'D'="Don't know"
'R'='Refused'
'1'='Yes'
'2'='No';

value ecom1_sud
0='Total'
1='Yes'
2='No'
3='N/A';

value elder_sud
0='Total'
1='None'
2='One to 29'
3='30 or more';

value $freeze
'1'='Yes'
'2'='No'
'3'='Did not live here last winter'
'B'='Not applicable'
'D'="Don't know"
'R'='Refused'
''='Not reported';

value freeze_sud
0='Total'
1='Yes'
2='No'
3='Did not live here last winter';

value $hhmar
'1'='Married, spuse present'
'2'='Married, spouse absent'
'3'='Widowed'
'4'='Divorced'
'5'='Separated'
'6'='Never married';

value hhmar_sud
0='Total'
1='Married, spuse present'
2='Married, spouse absent'
3='Widowed'
4='Divorced'
5='Separated'
6='Never married';

value $hhpcare
'1'='Yes'
'2'='No'
'B'='Not applicable'
'D'="Don't know"
'R'='Refused'
''='Not reported';

value hhpcare_sud
0='Total'
1='Yes'
2='No'
3='Not applicable';

value $hhperrnd
'1'='Yes'
'2'='No'
'B'='Not applicable'
'D'="Don't know"
'R'='Refused'
''='Not reported';

value hhperrnd_sud
0='Total'
1='Yes'
2='No'
3='Not applicable';

value $hhphear
'1'='Yes'
'2'='No'
'B'='Not applicable'
'D'="Don't know"
'R'='Refused'
''='Not reported';

value hhphear_sud
0='Total'
1='Yes'
2='No'
3='Not applicable';

value $hhpmemry
'1'='Yes'
'2'='No'
'B'='Not applicable'
'D'="Don't know"
'R'='Refused'
''='Not reported';

value hhpmemry_sud
0='Total'
1='Yes'
2='No'
3='Not applicable';

value $hhpqsal
'1'='Yes'
'2'='No'
'B'='Not applicable'
'D'="Don't know"
'R'='Refused'
''='Not reported';

value hhpqsal_sud
0='Total'
1='Yes'
2='No'
3='Not applicable';

value $hhpqself
'1'='Yes'
'2'='No'
'B'='Not applicable'
'D'="Don't know"
'R'='Refused'
''='Not reported';

value hhpqself_sud
0='Total'
1='Yes'
2='No'
3='Not applicable';

value $hhpsee
'1'='Yes'
'2'='No'
'B'='Not applicable'
'D'="Don't know"
'R'='Refused'
''='Not reported';

value hhpsee_sud
0='Total'
1='Yes'
2='No'
3='Not applicable';

value $hhpwalk
'1'='Yes'
'2'='No'
'B'='Not applicable'
'D'="Don't know"
'R'='Refused'
''='Not reported';

value hhpwalk_sud
0='Total'
1='Yes'
2='No'
3='Not applicable';

value $HMOUTLET
'1'='Home has feature, and is currently used by a household member with a physical limitation'
'2'='Home has feature, but is not currently used by a household member with a physical limitation'
'3'='Home does not have feature';

value HMOUTLET_sud
0='Total'
1='Home has feature, and is currently used by a household member with a physical limitation'
2='Home has feature, but is not currently used by a household member with a physical limitation'
3='Home does not have feature';

value $HMSWITCH										
'1'='Home has feature, and is currently used by a household member with a physical limitation'
'2'='Home has feature, but is not currently used by a household member with a physical limitation'
'3'='Home does not have feature';

value HMSWITCH_sud
0='Total'
1='Home has feature, and is currently used by a household member with a physical limitation'
2='Home has feature, but is not currently used by a household member with a physical limitation'
3='Home does not have feature';

value $HMCLCTRL										
'1'='Home has feature, and is currently used by a household member with a physical limitation'
'2'='Home has feature, but is not currently used by a household member with a physical limitation'
'3'='Home does not have feature';

value HMCLCTRL_sud
0='Total'
1='Home has feature, and is currently used by a household member with a physical limitation'
2='Home has feature, but is not currently used by a household member with a physical limitation'
3='Home does not have feature';

value $HMACAB										
'1'='Home has feature, and is currently used by a household member with a physical limitation'
'2'='Home has feature, but is not currently used by a household member with a physical limitation'
'3'='Home does not have feature';

value HMACAB_sud
0='Total'
1='Home has feature, and is currently used by a household member with a physical limitation'
2='Home has feature, but is not currently used by a household member with a physical limitation'
3='Home does not have feature';

value $HMCOUNT										
'1'='Home has feature, and is currently used by a household member with a physical limitation'
'2'='Home has feature, but is not currently used by a household member with a physical limitation'
'3'='Home does not have feature';

value HMCOUNT_sud
0='Total'
1='Home has feature, and is currently used by a household member with a physical limitation'
2='Home has feature, but is not currently used by a household member with a physical limitation'
3='Home does not have feature';

value $HMBROOM										
'1'='Home has feature, and is currently used by a household member with a physical limitation'
'2'='Home has feature, but is not currently used by a household member with a physical limitation'
'3'='Home does not have feature';

value HMBROOM_sud
0='Total'
1='Home has feature, and is currently used by a household member with a physical limitation'
2='Home has feature, but is not currently used by a household member with a physical limitation'
3='Home does not have feature';

VALUE $HHTEN
'X' = 'Person owns or rents unit'
' '= 'Not reported'
;

value hhten_sud 
0='Total'
1='Person owns or rents unit'
.N='Not reported';

value $HHPQSS
'1'='Yes'
'2'='No'
'B'='Not applicable'
'-6'='Not applicable';

value HHPQSS_sud
0='Total'
1='Yes'
2='No'
3='N/A';

value $HHPQSSI
'1'='Yes'
'2'='No'
'B'='Not applicable'
'-6'='Not applicable';

value HHPQSSI_sud
0='Total'
1='Yes'
2='No'
3='N/A';

value $hhsex
'1'='Male'
'2'='Female';

value hhsex_sud
1='Male'
2='Female';

value $kitchen
'1'='Have complete kitchen facilities'
'2'='Lacking complete kitchen facilities'
'B'='Not applicable';

value kitchen_sud
0='Total'
1='Have complete kitchen facilities'
2='Lacking complete kitchen facilities';

value $LENMOD
'1'='Checked response'
'2'='Did not check response'
'B'='Not applicable'
'-6'='Not applicable'
'D'="Don't know"
'-7'="Don't know"
'R'='Refused'
'-8'='Refused'
''='Not reported'
'-9'='Not reported'
;
value LENMOD_sud
0='Total'
1='Checked response'
2='Did not check response'
3='N/A';

value $MG
'1'='Yes'
'2'='No'
'B'='Not applicable'
'-6'='Not applicable';

value MG_sud
0='Total'
1='Yes'
2='No'
3='N/A';

value $numcold
'0'='Never broken down for 6 hours'
'1-7'='1-7 breakdowns lasting 6 hours or more'
'8'='8 or more breakdowns lasting 6 hours or more'
'B'='Not applicable'
'D'="Don't know"
'R'='Refused';

value numcold_sud
0='Total'
1='Never broken down for 6 hours'
2='One to 7 breakdowns lasting 6 hours or more'
3='Eight or more breakdowns lasting 6 hours or more'
4='N/A'
;

value NUMMOR_sud
0='Total'
1='One'
2='Two'
3='Three'
4='Four'
5='Five or more';

value $nowire
'1'='Yes'
'2'='No'
'3'='No electrical wiring'
'B'='Not applicable';

value nowire_sud
0='Total'
1='Yes'
2='No'
3='No electrical wiring';

value $plumb
'1'='Complete plumbing facilities for exclusive use'
'2'='Lacking complete plumbing facilities for exclusive use'
'B'='Not applicable';

value plumb_sud
0='Total'
1='Complete plumbing facilities for exclusive use'
2='Lacking complete plumbing facilities for exclusive use';



value $RAM
'1'='Yes'
'2'='No'
'B'='Not applicable'
'-6'='Not applicable'
'D'="Don't know"
'-7'="Don't know"
'R'='Refused'
'-8'='Refused'
''='Not reported'
'-9'='Not reported';

value RAM_sud
0='Total'
1='Yes'
2='No'
3='N/A';


value star
1="        **        "
0="                  ";

value $status
'1'='Occupied interview'
'2'='URE (Usual residence) elsewhere'
'3'='Vacant interview'
'4'='Non interview';

value status_sud
0='Total'
1='Occupied interview'
2='URE (Usual residence) elsewhere'
3='Vacant interview'
4='Non interview';

value $SUBRNT
'0'='Missing'
''='Missing'
'1'='Yes'
'2'='No'
'B'='Not applicable'
'-6'='Not applicable'
'D'="Don't know"
'-7'="Don't know"
'R'='Refused'
'-8'='Refused';

value SUBRNT_sud
0='Total'
1='Yes'
2='No'
3='N/A'
;

value tenureB_sud
0='Total'
1='Owner'
2='Not owner';

value $tenure
'1'='Owned or being bought by someone in your hosehold'
'2'='Rented'
'3'='Occupied without payment or rent'
'B'='Not applicable';

value tenure_sud
0='Total'
1='Owned or being bought by someone in your hosehold'
2='Rented'
3='Occupied without payment or rent';

value VCHER_sud
0='Total'
1='Yes'
2='No'
3='N/A';

value $VCHER
'1'='Yes'
'2'='No'
'B'='Not applicable'
'-6'='Not applicable'
'D'="Don't know"
'-7'="Don't know"
'R'='Refused'
'-8'='Refused'
''='Not reported'
'-9'='Not reported';

value $waters
'1'='Yes'
'2'='No'
'B'='Not applicable'
'D'="Don't know"
'R'='Refused'
''='Not reported';

value waters_sud
0='Total'
1='Yes'
2='No';

run;


