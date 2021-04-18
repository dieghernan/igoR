## code to prepare `states2016` dataset goes here

library(dplyr)

url <-
  "https://correlatesofwar.org/data-sets/state-system-membership/states2016/at_download/file"

download.file(
  url,
  "data-raw/states2016.csv"
)

states2016 <- read.csv2("data-raw/states2016.csv",
  sep = ",",
  stringsAsFactors = FALSE
)

# Add codes from IGO
codesigo <-
  igoR::state_year_format3 %>%
  select(ccode, state) %>%
  unique()

colnames(states2016) <- tolower(colnames(states2016))

states2016 <-
  merge(states2016, codesigo)


states2016 <- dplyr::arrange(states2016, ccode, styear)

for (col in colnames(states2016)[sapply(states2016, class) == "character"]) {
  if (!all(na.omit(stringi::stri_enc_mark(states2016[[col]])) == "ASCII")) {
    states2016[[col]] <- enc2utf8(states2016[[col]])
  }
}

usethis::use_data(states2016, overwrite = TRUE)

rm(list = ls())

tools::checkRdaFiles("./data")
