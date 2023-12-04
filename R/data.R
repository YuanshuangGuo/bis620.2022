#' Accelerometry Data Resampled from UK Biobank
#'
#' Toy accelerometry data for BIS620
#'
#' @format ## `accel`
#' A data frame with 1,080,000 rows and 4 columns:
#' \describe{
#'   \item{time}{the time of the measurement}
#'   \item{X, Y, Z}{Accelerometry measurement (in milligravities).}
#' }
"accel"

#' Condition Data sampled from ctgov-trials
#'
#' Toy condi data for BIS620
#'
#' @format ## `condi`
#' A data frame with 1,000 rows and 4 columns:
#' \describe{
#'   \item{id}{id of study}
#'   \item{nct_id}{nct id}
#'   \item{name}{name}
#'   \item{downcase_name}{downcase name}
#' }
"condi"


#' Studies Data Resampled from ctgove-trials
#'
#' Toy studies data for BIS620
#'
#' @format ## `studies`
#' A data frame with 1,000 rows and 70 columns:
#' \describe{
#'   \item{nct_id}{nct id}
#'   \item{study_type}{study type}
#'   \item{brief_title}{brief title}
#'   \item{phase}{phase}
#'   \item{number_of_arms}{number of arms}
#' }
"studies"

