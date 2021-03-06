clear
clear matrix
clear mata
capture log close
set maxvar 15000
set more off
numlabel, add

*defining directory  , you need to change according to your computer
local datadir "E:\Self_GitKraken\Working_Repo_GitHub\India-COVID19-Study\dataset\rawdata"
global outputdir  "E:\Self_GitKraken\Working_Repo_GitHub\India-COVID19-Study\dataset\output"
global dofiledir "E:\Self_GitKraken\Working_Repo_GitHub\India-COVID19-Study\dofile"

cd $outputdir
/*
*Create folder called Archived_Data in the Listing Folder
* Zip all of the old versions of the datasets.  Updates the archive rather than replacing so all old versions are still in archive
capture zipfile COVID19*, saving (Archived_Data/ArchivedIndiaCovid_$date.zip, replace)

*Delete old versions.  Old version still saved in ArchivedData.zip
capture shell erase COVID19*
*/
cd "`datadir'"


*set date 

local today=c(current_date)
local c_today= "`today'"
local date=subinstr("`c_today'", " ", "",.)
di "`date'"
global date=subinstr("`c_today'", " ", "",.)

*date code ends here

local github_url = "https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_daily_reports/"
*defining directory ends Here

forvalues month = 1/12 {
   forvalues day = 1/31 {
      local month = string(`month', "%02.0f")
      local day = string(`day', "%02.0f")
      local year = "2020"
      local today = "`month'-`day'-`year'"
      local csvfile = "`github_url'`today'.csv"
      clear
      capture import delimited "`csvfile'"
      capture confirm variable ïprovincestate
      if _rc == 0 {
         rename ïprovincestate provincestate
         label variable provincestate "Province/State"
      }
      capture rename province_state provincestate
      capture rename country_region countryregion
      capture rename last_update lastupdate
      capture rename lat latitude
      capture rename long longitude
	  generate tempdate = "`today'"
      capture save "`today'", replace
      }
}
clear
forvalues month = 1/12 {
   forvalues day = 1/31 {
      local month = string(`month', "%02.0f")
      local day = string(`day', "%02.0f")
      local year = "2020"
      local today = "`month'-`day'-`year'"
      capture append using "`today'"
   }
}

save India_COVID19_github.dta , replace

*datasave for India only
cd $outputdir

generate date = date(tempdate, "MDY")

format date %tdNN/DD/CCYY
keep if countryregion == "India"
save India_COVID19_$date.dta, replace

*drop other dataset 
cd "`datadir'" 
!del *.dta


*Uncomment only if you want to check total cases of COVID 
/*
use covid19_date , clear

*It can be ony useful to check total number of cases with date
collapse (sum) confirmed deaths recovered, by(date)
*/


*India Specific 
cd "$dofiledir"
run "covid19_India_NS_v01.do"


/*
preserve
keep if countryregion =="India"
generate newcases = D.confirmed
tsline confirmed, title(India Confirmed COVID-19 Cases till "`today'" )
restore
*/

*agrregate data of India 

/*
keep if countryregion=="India"

collapse (sum) confirmed deaths recovered, by(date)
format %8.0fc confirmed deaths recovered
tsset date, daily
generate newcases = D.confirmed
tsline confirmed, title(India Confirmed COVID-19 Cases)

*change directory accoring to your computer
graph save Graph "E:\Self_GitKraken\Working_Repo_GitHub\COVID19\graphs\India_01April2020.gph" , replace
graph export "E:\Self_GitKraken\Working_Repo_GitHub\COVID19\graphs\India_01April2020.png", as(png) replace
*till here


*compare India , USA , Italy 
preserve
keep if inlist(countryregion, "India", "US", "Italy")
collapse (sum) confirmed deaths recovered, by(date countryregion)
encode countryregion, gen(country)
label list country
* label need to assign India 1 , Italy 2 , US 3 . 
* If you are using this for any other country then change varibale accordingly
* and check them 
tsset country date, daily
save COVID19_long.dta , replace 


use COVID19_long.dta , clear


keep date country confirmed deaths recovered
reshape wide confirmed deaths recovered, i(date) j(country)


rename confirmed1 india_c
rename deaths1 india_d
rename recovered1 india_r
label var india_c "India cases"
label var india_d "India deaths"
label var india_r "India recovered"

rename confirmed2 italy_c
rename deaths2 italy_d
rename recovered2 italy_r
label var italy_c "Italy cases"
label var italy_d "Italy deaths"
label var italy_r "Italy recovered"


rename confirmed3 usa_c
rename deaths3 usa_d
rename recovered3 usa_r
label var usa_c "USA cases"
label var usa_d "USA deaths"
label var usa_r "USA recovered"

twoway (line india_d date) ///
       (line italy_d date) ///
       (line usa_d date)   ///
       , title(Death COVID-19 Cases in India Italy USA )
	   
graph export "E:\Self_GitKraken\Working_Repo_GitHub\COVID19\graphs\India_Italy_USA_death_compare.png", as(png) replace	   
	   
twoway (line india_d date),  title(Death Case in India of COVID-19 )
*change directory 
graph export "E:\Self_GitKraken\Working_Repo_GitHub\COVID19\graphs\India_death.png", as(png) replace
twoway (line india_c date),  title(Confirmed Case in India of COVID-19 )
*change directory
graph export "E:\Self_GitKraken\Working_Repo_GitHub\COVID19\graphs\India_case.png", as(png) replace
twoway (line india_r date),  title(Recovered Case in India of COVID-19 )
*change directory
graph export "E:\Self_GitKraken\Working_Repo_GitHub\COVID19\graphs\India_recovered.png", as(png) replace

	   
	   
