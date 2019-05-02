context("test check prob")
test_that("prob is a number between 0 and 1", {
  expect_true(check_prob(0.3))
})

test_that("prob is of length 1", {
  expect_error(check_prob(c(0.3, 0.4)))
})

test_that("getting an error if prob is invalid", {
  expect_error(check_prob(-1))
})

context("test check trials")
test_that("getting an error if trials is negative", {
  expect_error(check_trials(-14))
})

test_that("trials is a number >= 0", {
  expect_true(check_trials(12))
})

test_that("trials is 0", {
  expect_true(check_trials(0))
})

context("test check success")
test_that("success >= 0 and success <= trials", {
  expect_true(check_success(13, 15))
})

test_that("success is of length 1 but greater than trials", {
  expect_error(check_success(15, 13))
})

test_that("success length > 1 but has 1 value > trials", {
  expect_error(check_success(c(3, 4, 15), 13))
})
