
cd  $outputdir

use India_COVID19_$date.dta

capture zipfile COVID19*, saving (Archived_Data/ArchivedIndiaCovid_$date.zip, replace)

*Delete old versions.  Old version still saved in ArchivedData.zip
capture shell erase COVID19*

keep if countryregion == "India"
*days since first covid patient found 
generate date_india = date(tempdate, "MDY")
format date_india %tdNN/DD/CCYY

save India_COVID19_datechange.dta, replace

collapse (sum) confirmed deaths recovered, by(date_india)

list date confirmed deaths recovered           ///
      if date_india==date("1/30/2020", "MDY"), abbreviate(13)

format %8.0fc confirmed deaths recovered

tsset date_india, daily

generate newcases = D.confirmed
 
tsline confirmed, title(India Confirmed COVID-19 Cases) 

graph save Graph COVID19_India_confirmed_case_$date.gph , replace
graph export COVID19_India_confirmed_case_$date.png, replace

save COVID19_India_$date.dta , replace 
