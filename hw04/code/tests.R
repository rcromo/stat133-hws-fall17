library(testthat)
context("Remove Missing")
a <- c(1,4,7,NA, 10)
b <- c(NA,NA,NA, 0)
c <- c(1,2,3,4)
d <-c(NA,NA,NA)
p <- c(0, 0, 0, 0)
e <- c(10,11,9,8,7)


test_that("expect is equal", {
  expect_equal(remove_missing(a), c(1,4,7,10))
  expect_equal(remove_missing(b), c(0))
  expect_equal(remove_missing(c), c(1,2,3,4))
  expect_equal(remove_missing(d), logical(0))
})



context("Get minimum")
test_that("expect is the minimum", {
  expect_equal(get_minimum(a, na.rm = TRUE), 1)
  expect_equal(get_minimum(b, na.rm = TRUE), 0)
  expect_equal(get_minimum(c, na.rm = TRUE), 1)
  expect_equal(get_minimum(e), 7)
})

context("Get maximum")
test_that("expect is the maximum", {
  expect_equal(get_maximum(a, na.rm = TRUE), 10)
  expect_equal(get_maximum(b, na.rm = TRUE), 0)
  expect_equal(get_maximum(c, na.rm = TRUE), 4)
  expect_equal(get_maximum(e), 11)
})

context("Get range")
test_that("expect is the range", {
  expect_equal(get_range(a, na.rm = TRUE), 9)
  expect_equal(get_range(b, na.rm = TRUE), 0)
  expect_equal(get_range(c, na.rm = TRUE), 3)
  expect_equal(get_range(e), 4)
})


context("Compute 10th percential")
test_that("expect is the 10th percentile", {
  expect_equal(as.numeric(get_percentile10(a, na.rm = TRUE)), 1.9)
  expect_equal(as.numeric(get_percentile10(b, na.rm = TRUE)), 0)
  expect_equal(as.numeric(get_percentile10(c, na.rm = TRUE)), 1.3)
  expect_equal(as.numeric(get_percentile10(e)), 7.4)
})


context("Compute 90th percential")
test_that("expect is the 90th percentile", {
  expect_equal(as.numeric(get_percentile90(a, na.rm = TRUE)), 9.1)
  expect_equal(as.numeric(get_percentile90(b, na.rm = TRUE)), 0)
  expect_equal(as.numeric(get_percentile90(c, na.rm = TRUE)), 3.7)
  expect_equal(as.numeric(get_percentile90(e)),  as.double(10.6))
})

context("Compute 1st quartile")
test_that("expect is the 1st quartile", {
  expect_equal(as.numeric(get_quartile1(a, na.rm = TRUE)), 3.25)
  expect_equal(as.numeric(get_quartile1(b, na.rm = TRUE)), 0)
  expect_equal(as.numeric(get_quartile1(c, na.rm = TRUE)), 1.75)
  expect_equal(as.numeric(get_quartile1(e)), 8)
})

context("Compute 3rd  quartile")
test_that("expect is the 3rd quartile", {
  expect_equal(as.numeric(get_quartile3(a, na.rm = TRUE)), 7.75)
  expect_equal(as.numeric(get_quartile3(b, na.rm = TRUE)), 0)
  expect_equal(as.numeric(get_quartile3(c, na.rm = TRUE)), 3.25)
  expect_equal(as.numeric(get_quartile3(e)), 10)
})


context("Compute the median")
test_that("expect is the median", {
  expect_equal(get_median(a, na.rm = TRUE), 5.5)
  expect_equal(get_median(b, na.rm = TRUE), 0)
  expect_equal(get_median(c, na.rm = TRUE), 2.5)
  expect_equal(get_median(e), 9)
})


context("Compute the average")
test_that("expect is the average n", {
  expect_equal(get_average(a, na.rm = TRUE), 5.5)
  expect_equal(get_average(b, na.rm = TRUE), 0)
  expect_equal(get_average(c, na.rm = TRUE), 2.5)
  expect_equal(get_average(e), 9)
})

context("Compute the standard deviation")
test_that("expect is the standard deviation", {
  expect_equal(get_stdev(b, na.rm = TRUE), NaN)
  expect_equal(get_stdev(c, na.rm = TRUE), 1.290994449)
  expect_equal(get_stdev(e), 1.58113883)
  expect_equal(get_stdev(p), 0)
})

context("Compute the number of missing values NA")
test_that("expect is the number of missing values", {
  expect_equal(count_missing(a), 1)
  expect_equal(count_missing(b), 3)
  expect_equal(count_missing(c), 0)
  expect_equal(count_missing(e), 0)
})


context("Returns summary statistics")
test_that("expect the summary statistics", {
  aa <-summary_stats(a)
  bb <-summary_stats(b)
  cc <-summary_stats(c)
  ee <-summary_stats(e)
  expect_equal(aa, list(minimum = get_minimum(a, na.rm = TRUE), percent10 = get_percentile10(a, na.rm = TRUE),
                                      quartile1 = get_quartile1(a, na.rm = TRUE), median = get_median(a, na.rm = TRUE),
                                      mean = get_average(a, na.rm = TRUE), quartile3 = get_quartile3(a, na.rm = TRUE),
                                      percent90 = get_percentile90(a, na.rm = TRUE), maximum = get_maximum(a, na.rm = TRUE),
                                      range = get_range(a, na.rm = TRUE), stdev = get_stdev(a, na.rm = TRUE), missing = count_missing(a)))
  expect_equal(bb, list(minimum = get_minimum(b, na.rm = TRUE), percent10 = get_percentile10(b, na.rm = TRUE),
                                      quartile1 = get_quartile1(b, na.rm = TRUE), median = get_median(b, na.rm = TRUE),
                                      mean = get_average(b, na.rm = TRUE), quartile3 = get_quartile3(b, na.rm = TRUE),
                                      percent90 = get_percentile90(b, na.rm = TRUE), maximum = get_maximum(b, na.rm = TRUE),
                                      range = get_range(b, na.rm = TRUE), stdev = get_stdev(b, na.rm = TRUE), missing = count_missing(b)))
  expect_equal(cc, list(minimum = get_minimum(c, na.rm = TRUE), percent10 = get_percentile10(c, na.rm = TRUE),
                                      quartile1 = get_quartile1(c, na.rm = TRUE), median = get_median(c, na.rm = TRUE),
                                      mean = get_average(c, na.rm = TRUE), quartile3 = get_quartile3(c, na.rm = TRUE),
                                      percent90 = get_percentile90(c, na.rm = TRUE), maximum = get_maximum(c, na.rm = TRUE),
                                      range = get_range(c, na.rm = TRUE), stdev = get_stdev(c, na.rm = TRUE), missing = count_missing(c)))
  expect_equal(ee, list(minimum = get_minimum(e, na.rm = TRUE), percent10 = get_percentile10(e, na.rm = TRUE),
                                      quartile1 = get_quartile1(e, na.rm = TRUE), median = get_median(e, na.rm = TRUE),
                                      mean = get_average(e, na.rm = TRUE), quartile3 = get_quartile3(e, na.rm = TRUE),
                                      percent90 = get_percentile90(e, na.rm = TRUE), maximum = get_maximum(e, na.rm = TRUE),
                                      range = get_range(e, na.rm = TRUE), stdev = get_stdev(e, na.rm = TRUE), missing = count_missing(e)))
})

context("Returns a vector and drops lowest value")
test_that("expect is the vector with  dropped value", {
  expect_equal(drop_lowest(a), c(4, 7, 10))
  expect_equal(drop_lowest(b), c(NA, 0))
  expect_equal(drop_lowest(c), c(2, 3, 4))
  expect_equal(drop_lowest(e), c(8, 9, 10, 11))
})

context("Returns a rescaled vector")
test_that("expect  the rescaled vector", {
  expect_equal(rescale100(a, xmin = 0, xmax = 20), c(5, 20, 35, NA, 50))
  expect_equal(rescale100(b, xmin = 0, xmax = 100), c(NA, NA, NA, 0))
  expect_equal(rescale100(c, xmin = 0, xmax = 50), c(2, 4, 6, 8))
  expect_equal(rescale100(e, xmin = 0, xmax = 50), c(20, 22, 18, 16, 14))
})




context("Returns the average of the homework scores with or without lowest score dropped")
test_that("expect is the average of the homework scores", {
  expect_equal(score_homework(a, drop = TRUE), 7)
  expect_equal(score_homework(c), 2.5)
  expect_equal(score_homework(e, drop = TRUE), 9.5)
  expect_equal(score_homework(p), 0)
})

context("Returns a single quiz value with or without lowest score dropped")
test_that("expect is the quiz value", {
  expect_equal(score_quiz(a, drop = TRUE), 28.6111111)
  expect_equal(score_quiz(c), 13.61111111)
  expect_equal(score_quiz(e, drop = TRUE), 63.148148150000004)
  expect_equal(score_quiz(p), 0)
})

context("Returns lab score given attendance")
test_that("expect is the lab score", {
  expect_equal(score_lab(0), 0)
  expect_equal(score_lab(7), 20)
  expect_equal(score_lab(10), 80)
  expect_equal(score_lab(12), 100)
})