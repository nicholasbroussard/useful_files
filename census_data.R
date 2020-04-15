library(tidyverse)
library(data.table)

#Used ACS Census data from two sources.
#https://www.census.gov/developers/ <- for city and county data. 
#Use https://www.youtube.com/watch?v=0DVdHquaRiU and https://towardsdatascience.com/getting-census-data-in-5-easy-steps-a08eeb63995d for instructions. 
#www.data.census.gov <- for zip info. Can also be used for city/county data, but returns city/county codes, not names. 
#Use YouTube Census Data Gems for instructions. 
#Use ACS 5-year data, which gathers displays data for all geographies regardless their population size. 

#population_data_zip
#population_zip_2015
#https://api.census.gov/data/2015/acs/acs5/profile?get=DP04_0001E&for=zip%20code%20tabulation%20area:*&key=f0ac46713fecc95dd2bd8965c8af599c248ce387
population_2015_zips <- fromJSON("C:\\Users\\nicho\\Desktop\\population_2015.json", flatten = T)
pop_2015_zips <- as.data.frame(pop_2015_zips, row.names = F)
pop_2015_zips <- pop_2015_zips[-c(1),]
colnames(pop_2015_zips) <- c("population_zip_2015", "zip")
write.csv(pop_2015_zips, 'population_zip_2015.csv', row.names = F)

#population_zip_2018
#https://api.census.gov/data/2018/acs/acs5/profile?get=DP04_0001E&for=zip%20code%20tabulation%20area:*&key=f0ac46713fecc95dd2bd8965c8af599c248ce387
population_zip_2018 <- fromJSON("C:\\Users\\nicho\\Desktop\\profile.json", flatten = T)
zips <- as.data.frame(zips, row.names = F)
zips <- zips[-c(1),]
colnames(zips) <- c("population_zip_2018", "zip")
write.csv(zips, 'population_zip_2018.csv', row.names = F)

#Combined populations tables
population_zip_2015 <- read.csv('C:\\Users\\nicho\\Desktop\\population_zip_2015.csv', stringsAsFactors = F)
population_zip_2018 <- read.csv('C:\\Users\\nicho\\Desktop\\population_zip_2018.csv', stringsAsFactors = F)

population_data_zip <- full_join(population_zip_2015, population_zip_2018, by = 'zip') %>%
  select(zip, population_zip_2015, population_zip_2018)

write.csv(population_data_zip, 'C:\\Users\\nicho\\Desktop\\population_data_zip.csv', row.names = F)


#population_data_city
#Downloaded directly from data.census.gov, using topic = 'Population' and geographies = 'place' + 'Texas'.
#Cleaned up the files from the Census zip file download using Excel. Renamed file name and column names. Removed all cols except for geography and income estimate.
income_city_2015 <- read.csv('C:\\Users\\nicho\\Desktop\\income_city_2015.csv', stringsAsFactors = F)
income_city_2018 <- read.csv('C:\\Users\\nicho\\Desktop\\income_city_2018.csv', stringsAsFactors = F)

income_city_2015$city <- as.character(income_city_2015$city)
income_city_2018$city <- as.character(income_city_2018$city)

income_city_2015$city <- str_remove(income_city_2015$city, "city")
income_city_2015$city <- str_remove(income_city_2015$city, "CDP")
income_city_2015$city <- str_remove(income_city_2015$city, "town")

income_city_2018$city <- str_remove(income_city_2018$city, "city")
income_city_2018$city <- str_remove(income_city_2018$city, "CDP")
income_city_2018$city <- str_remove(income_city_2018$city, "town")

income_data_city <- full_join(income_city_2015, income_city_2018, by = 'city') %>%
  select(city, income_city_2015, income_city_2018)

write.csv(income_data_city, 'C:\\Users\\nicho\\Desktop\\income_data_city.csv')


#income_data_county
#Downloaded directly from data.census.gov, using topic = 'Population' and geographies = 'county' + 'Texas'.
#Cleaned up the files from the Census zip file download using Excel. Renamed file name and column names. Removed all cols except for geography and income estimate. 
income_county_2015 <- read.csv('C:\\Users\\nicho\\Desktop\\income_county_2015.csv', stringsAsFactors = F)
income_county_2018 <- read.csv('C:\\Users\\nicho\\Desktop\\income_county_2018.csv', stringsAsFactors = F)

income_data_county <- full_join(income_county_2015, income_county_2018, by = 'county') %>%
  select(county, income_county_2015, income_county_2018)

write.csv(income_data_county, 'C:\\Users\\nicho\\Desktop\\income_data_county.csv', row.names = F)


#income_data_zip
#income_zip_2015
#https://api.census.gov/data/2015/acs/acs5/profile?get=DP03_0062E&for=zip%20code%20tabulation%20area:*&key=f0ac46713fecc95dd2bd8965c8af599c248ce387
income_zip_2015 <- fromJSON("C:\\Users\\nicho\\Desktop\\income_zip_2015.json", flatten = T)
income_zip_2015 <- as.data.frame(income_zip_2015, row.names = F)
income_zip_2015 <- income_zip_2015[-c(1),]
colnames(income_zip_2015) <- c("income_zip_2015", "zip")
write.csv(income_zip_2015, 'C:\\Users\\nicho\\Desktop\\income_zip_2015.csv', row.names = F)

#income_zip_2018
#https://api.census.gov/data/2018/acs/acs5/profile?get=DP03_0062E&for=zip%20code%20tabulation%20area:*&key=f0ac46713fecc95dd2bd8965c8af599c248ce387
income_zip_2018 <- fromJSON("C:\\Users\\nicho\\Desktop\\income_zip_2018.json", flatten = T)
income_zip_2018 <- as.data.frame(income_zip_2018, row.names = F)
income_zip_2018 <- income_zip_2018[-c(1),]
colnames(income_zip_2018) <- c("income_zip_2018", "zip")
write.csv(income_zip_2018, 'C:\\Users\\nicho\\Desktop\\income_zip_2018.csv', row.names = F)

#combined file
income_zip_2015 <- read.csv('C:\\Users\\nicho\\Desktop\\income_zip_2015.csv', stringsAsFactors = F)
income_zip_2018 <- read.csv('C:\\Users\\nicho\\Desktop\\income_zip_2018.csv', stringsAsFactors = F)

income_data_zip <- full_join(income_zip_2015, income_zip_2018, by = 'zip') %>%
  select(zip, income_zip_2015, income_zip_2018)

write.csv(income_data_zip, 'C:\\Users\\nicho\\Desktop\\income_data_zip.csv', row.names = F)


#income_data_city
#Downloaded directly from data.census.gov, using topic = 'Income and Earnings' and geographies = 'place' + 'Texas'.
#Cleaned up the files from the Census zip file download using Excel. Renamed file name and column names. Removed all cols except for geography and income estimate.
income_city_2015 <- read.csv('C:\\Users\\nicho\\Desktop\\income_city_2015.csv', stringsAsFactors = F)
income_city_2018 <- read.csv('C:\\Users\\nicho\\Desktop\\income_city_2018.csv', stringsAsFactors = F)

income_city_2015$city <- as.character(income_city_2015$city)
income_city_2018$city <- as.character(income_city_2018$city)

income_city_2015$city <- str_remove(income_city_2015$city, "city")
income_city_2015$city <- str_remove(income_city_2015$city, "CDP")
income_city_2015$city <- str_remove(income_city_2015$city, "town")

income_city_2018$city <- str_remove(income_city_2018$city, "city")
income_city_2018$city <- str_remove(income_city_2018$city, "CDP")
income_city_2018$city <- str_remove(income_city_2018$city, "town")

income_data_city <- full_join(income_city_2015, income_city_2018, by = 'city') %>%
  select(city, income_city_2015, income_city_2018)

write.csv(income_data_city, 'C:\\Users\\nicho\\Desktop\\income_data_city.csv', row.names = F)


#income_data_county
#Downloaded directly from data.census.gov, using topic = 'Income and Earnings' and geographies = 'county' + 'Texas'.
#Cleaned up the files from the Census zip file download using Excel. Renamed file name and column names. Removed all cols except for geography and income estimate. 
income_county_2015 <- read.csv('C:\\Users\\nicho\\Desktop\\income_county_2015.csv', stringsAsFactors = F)
income_county_2018 <- read.csv('C:\\Users\\nicho\\Desktop\\income_county_2018.csv', stringsAsFactors = F)

income_data_county <- full_join(income_county_2015, income_county_2018, by = 'county') %>%
  select(county, income_county_2015, income_county_2018)

write.csv(income_data_county, 'C:\\Users\\nicho\\Desktop\\income_data_county.csv', row.names = F)