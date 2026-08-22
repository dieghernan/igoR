# Code to prepare the `states2024` data set.

library(dplyr)

url <- "https://correlatesofwar.org/wp-content/uploads/States2024.zip"
zip_file <- tempfile(fileext = ".zip")

download.file(url, zip_file, mode = "wb")
states2024 <- read.csv2(
  unz(zip_file, "States2024/statelist2024.csv"),
  sep = ",",
  stringsAsFactors = FALSE
)

# Add codes from the IGO data.
codesigo <- igoR::state_year_format3 |>
  select(ccode, state) |>
  unique()

colnames(states2024) <- tolower(colnames(states2024))

states2024 <- merge(states2024, codesigo)
states2024 <- dplyr::arrange(states2024, ccode, styear)

for (col in colnames(states2024)[sapply(states2024, class) == "character"]) {
  if (!all(na.omit(stringi::stri_enc_mark(states2024[[col]])) == "ASCII")) {
    states2024[[col]] <- enc2utf8(states2024[[col]])
  }
}

usethis::use_data(states2024, overwrite = TRUE)

rm(list = ls())

tools::checkRdaFiles("./data")
