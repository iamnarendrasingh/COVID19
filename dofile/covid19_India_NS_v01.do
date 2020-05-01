
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
