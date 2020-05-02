*Goal : Need to create map from this do file zone wise

*importing csv file 
import excel "E:\Dropbox (Gates Institute)\PMA2020_INDIA\Performance Monitoring for Action\Phase1_Report\ML\EA_Check\Final_ML_Update_for_weath_q5\Final_PMAP1_Sampling_134EA_Code_20200422_NS_v05.xlsx", sheet("134EA_update") firstrow allstring

*dropping REName and OldEA
drop REName OldEA

*generating new variable for zone in COVID
gen covid_zone_02May="."
replace covid_zone_02May = "Red" if Level1_NS =="Jaipur"
replace covid_zone_02May = "Red" if Level1_NS =="Jodhpur"
replace covid_zone_02May = "Red" if Level1_NS =="Kota"
replace covid_zone_02May = "Red" if Level1_NS =="Ajmer"
replace covid_zone_02May = "Red" if Level1_NS =="Bharatpur"
replace covid_zone_02May = "Red" if Level1_NS =="Nagaur"
replace covid_zone_02May = "Red" if Level1_NS =="Banswara"
replace covid_zone_02May = "Red" if Level1_NS =="Jhalawar"
replace covid_zone_02May = "Orange" if Level1_NS =="Tonk"
replace covid_zone_02May = "Orange" if Level1_NS =="Jaisalmer"
replace covid_zone_02May = "Orange" if Level1_NS =="Dausa"
replace covid_zone_02May = "Orange" if Level1_NS =="Jhunjhunu"
replace covid_zone_02May = "Orange" if Level1_NS =="Hanumangarh"
replace covid_zone_02May = "Orange" if Level1_NS =="Bhilwara"
replace covid_zone_02May = "Orange" if Level1_NS =="Sawai Madhopur"
replace covid_zone_02May = "Orange" if Level1_NS =="Chittaurgarh"
replace covid_zone_02May = "Orange" if Level1_NS =="Dungarpur"
replace covid_zone_02May = "Orange" if Level1_NS =="Udaipur"
replace covid_zone_02May = "Orange" if Level1_NS =="Dhaulpur"
replace covid_zone_02May = "Orange" if Level1_NS =="Sikar"
replace covid_zone_02May = "Orange" if Level1_NS =="Alwar"
replace covid_zone_02May = "Orange" if Level1_NS =="Bikaner"
replace covid_zone_02May = "Orange" if Level1_NS =="Churu"
replace covid_zone_02May = "Orange" if Level1_NS =="Pali"
replace covid_zone_02May = "Orange" if Level1_NS =="Barmer"
replace covid_zone_02May = "Orange" if Level1_NS =="Karauli"
replace covid_zone_02May = "Orange" if Level1_NS =="Rajsamand"
replace covid_zone_02May = "Green" if Level1_NS =="Baran"
replace covid_zone_02May = "Green" if Level1_NS =="Bundi"
replace covid_zone_02May = "Green" if Level1_NS =="Ganganagar"
replace covid_zone_02May = "Green" if Level1_NS =="Jalore"
replace covid_zone_02May = "Green" if Level1_NS =="Sirohi"
replace covid_zone_02May = "Green" if Level1_NS =="Pratapgarh"

tab covid_zone_02May

cd "E:\Dropbox (Gates Institute)\PMA2020_INDIA\Performance Monitoring for Action\Phase1_Report\ML\EA_Check\Final_ML_Update_for_weath_q5"

save "Final_PMAP1_Sampling_134EA_Code_20200422_NS_v05.dta" , replace
