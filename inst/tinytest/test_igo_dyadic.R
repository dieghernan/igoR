library(tinytest)


expect_error(igo_dyadic("USA", "Cuba", 1900))
expect_error(igo_dyadic("USA", "Cuba", 1800))
expect_error(igo_dyadic("Baden", "Cuba"))
expect_error(igo_dyadic(c("USA", "USA"), "Cuba", 1900))
expect_error(igo_dyadic("USA", "United States of America", 1900:1902))
expect_error(igo_dyadic("USA", "USA", 1900:1902))

expect_silent(igo_dyadic("USA", "Cuba", 1900:1902))
expect_silent(igo_dyadic("USA", c("Cuba", "Mexico"), 1900:1902))
expect_silent(igo_dyadic("USA", c("USA", "Canada"), 1921))

expect_silent(igo_dyadic("USA", "Spain", 1990, "un"))
expect_silent(igo_dyadic("USA", c("Spain", "France"), 1995, c("un", "WTo")))

expect_warning(igo_dyadic("USA", "Spain", 1990, c("un", "random")))
expect_error(igo_dyadic("USA", "Spain", 1990, c("xxx", "random")))

n1 <- igo_dyadic("USA", "Cuba", 1905)
n2 <- igo_dyadic("Kosovo", "Cuba")
n3 <- igo_dyadic("Kosovo", "Cuba", ioname = "UN")
expect_true(ncol(n1) == ncol(n2))
expect_false(ncol(n2) == ncol(n3))
