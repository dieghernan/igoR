# Download
rm(list = ls())

library(dplyr)

curl::curl_download(
  "https://correlatesofwar.org/data-sets/IGOs/codebook-version-3-igo-data/@@download/file/IGO%20Codebook_v3_short%20copy.pdf",
  "./data-raw/IGO Codebook_v3_short copy.pdf"
)

# Files

# download.file(
#   "https://correlatesofwar.org/data-sets/IGOs/igo-data-stata-files-zip/@@download/file/IGO_stata.ZIP",
#   "./data-raw/IGO_stata.ZIP"
# )


# unzip("./data-raw/igo_year_formatv3.zip", exdir = "./data-raw/igo_year_formatv3")

# Read

igo_year_format3 <- haven::read_dta("data-raw/igo_year_format_3.dta") %>% as.data.frame()

state_year_format3 <-
  haven::read_dta("./data-raw/state_year_format3.dta") %>% as.data.frame()


usethis::use_data(igo_year_format3, overwrite = TRUE)
usethis::use_data(state_year_format3, overwrite = TRUE)

tools::checkRdaFiles("./data")
