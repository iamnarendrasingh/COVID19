


use covid19_date.dta , replace
preserve
keep if countryregion == "India"
*days since first covid patient found 
gen day = _n

save covid19_India_$date.dta , replace 
restore

save covid19_date.dta , replace
