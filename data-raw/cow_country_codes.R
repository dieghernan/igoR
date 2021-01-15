## code to prepare `cow_country_codes` dataset goes here


library(readr)
library(dplyr)

# https://correlatesofwar.org/data-sets/cow-country-codes/cow-country-codes")

cow_country_codes <-
  read_csv("data-raw/COW country codes.csv") %>% unique()

# Add codes from IGO
codesigo <-
  igoR::state_year_format3 %>% select(ccode, state) %>% unique()

colnames(cow_country_codes) <- tolower(colnames(cow_country_codes))


cow_country_codes <-
  merge(cow_country_codes, codesigo) %>% arrange(ccode)

for (col in colnames(cow_country_codes)[sapply(cow_country_codes, class) == 'character']) {
  if (!all(na.omit(stringi::stri_enc_mark(cow_country_codes[[col]])) == 'ASCII')) {
    cow_country_codes[[col]] <- enc2utf8(cow_country_codes[[col]])
  }
}

usethis::use_data(cow_country_codes, overwrite = TRUE)


tools::checkRdaFiles("./data")
