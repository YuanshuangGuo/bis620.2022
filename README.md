
<!-- README.md is generated from README.Rmd. Please edit that file -->

# bis620.2022

<!-- badges: start -->

[![R-CMD-check](https://github.com/YuanshuangGuo/bis620.2022/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/YuanshuangGuo/bis620.2022/actions/workflows/R-CMD-check.yaml)
[![test-coverage](https://github.com/YuanshuangGuo/bis620.2022/actions/workflows/test-coverage.yaml/badge.svg)](https://github.com/YuanshuangGuo/bis620.2022/actions/workflows/test-coverage.yaml)

<!-- badges: end -->

The goal of bis620.2022 is to build a shiny app to help visualize the
trials requested by a keyword.

## Installation

You can install the development version of bis620.2022 from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("YuanshuangGuo/bis620.2022")
```

## usage

We have in total implemented four features to the original web
application. Each feature is documented as follows.

Feature 1: add a checkbox of overall status - Motivation: we are
interested in the overall status of the trials in a query, for example,
if we only want to incorporate trials that are completed, we can use
this feature to filter the trials in a query. - Description: this
checkbox is used to subset trials in a query with desired overall
status, where overall status is a categorical variable indicating
whether the study is “Recruiting”, “Terminated”, “Completed”, or in some
other 11 status. If none of the checkbox is selected, the filter will
not be performed and all trials in a query will be returned. - Use of
feature: click on the checkbox to filter trials in a query, multiple
selection is acceptable. This feature cannot be used directly as a
function call.

Feature 2: add date range input - Motivation: we are interested in
studies that have been completed within a specific time range, for
example, if we only want to incorporate trials that are completed in
year 2023, we can use this feature to filter the trials in a query. -
Description: this date range panel is used to filter trials in a query
whose completion date is within a specific time range. If time range is
not specified, the default time range is 1900-01-01 to 2100-12-31, which
is the range of completion date for all studies, that is, the filter
will not be performed and all trials in a query will be returned. - Use
of feature: select time range to filter trials in a query. This feature
cannot be used directly as a function call.

Feature 3: add a new tab showing the histogram of study type -
Motivation: we are interested in the distribution of study type of
trials in a query. We can use this feature to easily view the count for
each category of study type of the returned trials. - Description: this
feature is used to visualize the histogram of study types of the
returned trials, where study type is a categorical variable taking
values “Interventional”, “Observational”, “Observational \[Patient
Registry\]”, “Expanded Access” or it can be missing. - Use of feature:
click on the Study Type tab of the Shiny web application to view the
histogram there. The “plot_study_type_histogram” function can be
directed called from the utility function file, with a parameter “x”
specifying the database table.

Feature 4: add a new tab showing the piechart plot of number of arms -
Motivation: we are interested in the distribution of the number of arms
of trials in a query. We can use this feature to easily view the count
for different numbers of arms in the returned trials. - Description:
this feature is used to visualize the piechart of number of arms in the
returned trials, where number of arms is a numerical variable taking
integer values from 1 to 44, or it can be missing. - Use of feature:
click on the Number of Arms tab of the Shiny web application to view the
piechart there. The “plot_num_arms” function can be directed called from
the utility function file, with a parameter “x” specifying the database
table.

# link to coverage page

You can access the test coverage page of bis620.2022 from
(https://app.codecov.io/gh/YuanshuangGuo/bis620.2022).

or by running

``` r
covr::report()
```
