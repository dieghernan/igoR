library(tinytest)

expect_error(igo_state_membership())
expect_error(igo_state_membership("Error"))
expect_error(igo_state_membership("Kosovo", year = 1900))
expect_error(igo_state_membership("Spain", status = "Error"))
expect_warning(igo_state_membership("Spain",
                                    status = c("Full Membership", "Error")))
expect_silent(igo_state_membership("Spain", status = "Observer"))
expect_silent(igo_state_membership("Spain"))
expect_silent(igo_state_membership("Spain", year = 2000))
expect_false(nrow(igo_state_membership("Spain", year = 2000)) ==
               nrow(igo_state_membership("Spain", year = 1993)))
expect_silent(igo_state_membership(c("USA", "Spain"), year = 1993))
expect_warning(igo_state_membership(c("Spain"), year = 1820))

expect_silent(igo_state_membership("domrepublic"))
expect_silent(igo_state_membership("united kingdom"))
expect_silent(igo_state_membership("SPAIN"))
