## code to prepare `sysdata` dataset goes here

library(dplyr)
ff <- igoR::cow_country_codes

cow_country_codes <- igoR::states2016 %>%
  select(ccode, stateabb,statenme, state) %>%
  unique() %>% arrange(ccode)


usethis::use_data(cow_country_codes, overwrite = TRUE,
                  internal = TRUE)

tools::checkRdaFiles("./R")


