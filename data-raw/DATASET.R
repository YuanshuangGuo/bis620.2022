## code to prepare `DATASET` dataset goes here

accel = readRDS("accel.rds")
usethis::use_data(accel, overwrite = TRUE)

condi = load("condi.RData")
usethis::use_data(condi, overwrite = TRUE)

studies = load("studies.RData")
usethis::use_data(studies, overwrite = TRUE)

