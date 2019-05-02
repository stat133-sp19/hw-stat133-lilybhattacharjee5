context("test bin choose")
test_that("number of successes > number of trials will lead to error", {
  expect_error(bin_choose(13, 15))
})

test_that("number of successes and number of trials are valid i.e. trials >= 0, successes >= 0, successes <= trials", {
  expect_equal(bin_choose(6, 2), 15)
})

test_that("successes = trials = 0, expected 1", {
  expect_equal(bin_choose(0, 0), 1)
})

test_that("check vectorized functionality", {
  expect_equal(bin_choose(5, 1:3), c(5, 10, 10))
})

context("test bin probability")
test_that("errors if number of successes is invalid i.e. > number of trials", {
  expect_error(bin_probability(15, 13, 0.5))
})

test_that("gives correct probability if all args valid", {
  expect_equal(bin_probability(3, 10, 0.7), 0.009001692)
})

test_that("gives correct probabilities in vectorized case", {
  expect_equal(bin_probability(3:5, 10, 0.7), c(0.009001692, 0.036756909, 0.1029193452))
})

context("test bin distribution")
test_that("test that class returned is a vector of bindis and data.frame", {
  expect_equal(class(bin_distribution(10, 0.5)), c("bindis", "data.frame"))
})

test_that("check probability column in normal case", {
  expect_equal(as.numeric(unlist(as.list(bin_distribution(5, 0.5)["probability"]))), c(0.03125, 0.15625, 0.3125, 0.3125, 0.15625, 0.03125))
})

test_that("expect error if prob < 0", {
  expect_error(bin_distribution(10, -0.5))
})

context("test bin cumulative")
test_that("test that class returned is a vector of bincum and data.frame", {
  expect_equal(class(bin_cumulative(10, 0.5)), c("bincum", "data.frame"))
})

test_that("check probability column in normal case", {
  expect_equal(as.numeric(unlist(as.list(bin_cumulative(5, 0.5)["probability"]))), c(0.03125, 0.15625, 0.3125, 0.3125, 0.15625, 0.03125))
})

test_that("check cumulative column in normal case", {
  expect_equal(as.numeric(unlist(as.list(bin_cumulative(5, 0.5)["cumulative"]))), c(0.03125, 0.1875, 0.5, 0.8125, 0.96875, 1))
})
