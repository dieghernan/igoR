aa <- igo_search("European")


lintr::lint_package()

goodpractice::gp()

countrycode::codelis

devtools::check()

#ACCT

#Andean

ff <- igo_search()

fff <- state_year_format3

ioname = "ECCD"
year = 1895
status = c("Full Membership")
destination = "country.name"

rm(list = ls())


roxygen2::roxygenise()


lintr::lint_package()

devtools::check()



igo_members("EU")








ff <- reshape2::melt(igoR::state_year_format3,
                     id.vars = c("state","year"),
                     measure.vars=unique(tolower(igo_year_format3$ioname)))


ff34 <- ff[!ff$value %in% c(0,1,-9,-1),]
library(dplyr)

ff34 %>% group_by(variable) %>% summarise(min = min(value),
                                          max = max(value))

intersect(names(cntries), names(codestatus))


View(helpdf)
Category	Numerical Value
No Membership	0
Full Membership	1
Associate Membership	2
Observer	3
Missing data	-9
IGO Not In Existence	-1

igoR::


cntrynames <- sort(unique(cntries$state))

dfcont <- df[,c("ioname",cntrynames)]

# Add Missing Data
dfcont[is.na(dfcont)] <- -99


dfcont==1


igo

library(igoR)







all <- igo_search()

example("igo_search","igoR")


library(dplyr)

all$all <- f$political+f$social+f$economic

f <- igo_search("Warsaw")

countrycode::guess_field("España")

example("igo_search","igoR")

devtools::check()

lintr::lint_package()

citation("igoR")


goodpractice::gp()

igo

roxygen2::roxygenise()

rm(list = ls())

devtools::check()



# All values
all <- igo_search()

nrow(all)
colnames(all)


# Search by pattern

eu1 <- igo_search("EU")
head(eu1[, 1:3])

eu2 <- igo_search("EU", exact = TRUE)
head(eu2[, 1:3])

# With integers

search10_1 <- igo_search(10)
head(search10_1[, 1:3])

search10_1 <- igo_search(10, exact = TRUE)
head(search10_1[, 1:3])

row.names(eu1) <- c()
row.names(eu1)

ss <- countrycode::codelist_panel

pattern = "EU"
exact = TRUE


igo_search <- function(pattern = NULL, exact = FALSE) {
  db <- igo_year_format3

  # Select columns that not are countries
  cols <- !colnames(db) %in% c(unique(state_year_format3$state))
  db.clean <- db[, cols]

  # Extract last date
  db_last <- db.clean[, c("ioname", "year")]
  db_last.year <-
    aggregate(db_last, by = list(db_last$ioname), FUN = max)
  db_last.year <- db_last.year[, c("ioname", "year")]

  db.end <-  merge(db.clean, db_last.year)

  # Create label column
  db.end$label <- db.end$longorgname

  db.end$label <- gsub("\\((.*?)\\)", "", db.end$label)
  db.end$label <- gsub("\\((.*?)$", "", db.end$label)
  db.end$label <- gsub("  ", " ", db.end$label)

  # Reorder col
  cols <-
    unique(c(
      "ionum",
      "ioname",
      "orgname",
      "longorgname",
      "label",
      colnames(db.end)
    ))
  cols <- cols[cols != "year"]
  db.end <- db.end[, cols]

  # Pattern
  if (!is.null(pattern)) {

    pattern <- as.character(pattern)

    if (exact){
      pattern <- paste0("^",pattern,"$")
    }

    # Search in long name
    lon <- grep(pattern, db.end$longorgname)
    # Search in org name
    lon <- c(lon, grep(pattern, db.end$orgname))
    # Search in id
    lon <- c(lon, grep(pattern, db.end$ioname))
    # Search on ionum
    lon <- c(lon, grep(pattern, as.character(db.end$ionum)))



    lon <- unique(lon)

    if (length(lon) > 0) {
      db.end <- db.end[lon, ]
    } else {
      stop("Pattern '", pattern, "' do not match with any IGO")
    }
  }
  return(db.end)
}

r <- igo_search(10)



grep(10,r$ionum, fixed = TRUE)
print(r)

print(igo_year_format3)

print(r)

# Reorder col
cols <- unique(c("ionum", "ioname", "orgname", "longorgname", "label",
               colnames(db.end)))
db.end <- db.end[, cols]

# Create label column

class(db.end)



# Search

text <- "United"

regexpr <- "^Un$"

f <- db.endclean

long <- db.endclean$longorgname

ff <-
  as.character(lapply(seq_len(nrow(db.endclean)), function(x)
    gsub(
      paste0(" (",
             db.endclean[x, "ioname"],")"),
             "",
             db.endclean[x, "longorgname"],
      fixed = TRUE)
    )
    )
test <- f[1:5,]$longorgname

test
grep("\\(",test)

gsub("\\((.*?)\\)","",test)

s <- db.endclean[grep("NAFTA", db.endclean$longorgname),]
f <- d

length(unique(igo_year_format3$ionum)) == nrow(db.endclean)

subs

cols <- c(
  "ioname",
  "ionum","orgname","longorgname",
          "sdate","deaddate","dead","integrated","ionum")


??igo_year_format3
db <- igo_year_format3

s <- db2[db2$ioname=="AMIPO",]

cols <- c("ioname","orgname","longorgname",
          "sdate","deaddate","dead","integrated","ionum")

db3 <- unique(db[,cols])
summary(db3)

n <- aggregate(db3, list(db3$ioname), FUN = max)


cols <- !colnames(db) %in% c(unique(state_year_format3$state))
db2 <- unique(db[,cols])

names(db2)

db2 <- unique(db2)
s <- db[db$ioname=="ACPEU",]

sessionInfo()
"sdate"                            "deaddate"
[223] "dead"                             "integrated"
[225] "replaced"                         "longorgname"
[227] "ionum"                            "igocode"
[229] "version"                          "accuracyofpre1965membershipdates"
[231] "sourcesandnotes"                  "imputed"
[233] "political"                        "social"
[235] "economic"
