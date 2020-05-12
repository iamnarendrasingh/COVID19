
cd  $outputdir

use covid19_$date.dta
preserve
keep if countryregion == "India"
*days since first covid patient found 
generate date_india = date(tempdate, "MDY")
format date_india %tdNN/DD/CCYY

save covid19_datechange.dta, replace

collapse (sum) confirmed deaths recovered, by(date_india)

list date confirmed deaths recovered           ///
      if date_india==date("1/30/2020", "MDY"), abbreviate(13)

format %8.0fc confirmed deaths recovered

tsset date_india, daily

generate newcases = D.confirmed
 
tsline confirmed, title(India Confirmed COVID-19 Cases) 

graph save Graph India_confirmed_case_$date.gph , replace
save covid19_India_$date.dta , replace 
restore

*lockdown trend
use covid19_India_$date.dta 

gen lockdown = 1 if inrange(date, mdy(3,25,2020), mdy(4,14,2020))
replace lockdown = 2 if inrange(date, mdy(4,15,2020), mdy(5,3,2020))
replace lockdown = 3 if inrange(date, mdy(5,4,2020), mdy(5,10,2020))


save covid19_India_lockdown.dta, replace
