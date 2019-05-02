context("test aux mean")
test_that("0 trials, expect 0 mean regardless of prob", {
  trials <- 0
  prob <- 0.3
  expect_equal(aux_mean(trials, prob), 0)
})

test_that("prob = 1, expect trials to be returned", {
  trials <- 100
  prob <- 1
  expect_equal(aux_mean(trials, prob), 100)
})

test_that("prob, trials both in normal range", {
  trials <- 100
  prob <- 0.4
  expect_equal(aux_mean(trials, prob), 40)
})

context("test aux variance")
test_that("prob, trials both in normal range", {
  trials <- 15
  prob <- 0.3
  expect_equal(aux_variance(trials, prob), 3.15)
})

test_that("prob = 0.5, 1 - prob = 0.5", {
  trials <- 100
  prob <- 0.5
  expect_equal(aux_variance(trials, prob), 25)
})

test_that("prob = 0, variance should be 0", {
  trials <- 100
  prob <- 0
  expect_equal(aux_variance(trials, prob), 0)
})

context("test aux mode")
test_that("prob, trials both in normal range", {
  expect_equal(aux_mode(15, 0.3), 4)
})

test_that("trials * prob gives an integer", {
  expect_equal(aux_mode(100, 0.3), 30)
})

test_that("prob is 0, mode should also be 0", {
  expect_equal(aux_mode(100, 0), 0)
})

context("test aux skewness")
test_that("prob, trials both in normal range", {
  expect_equal(aux_skewness(100, 0.4), 0.04082482904)
})

test_that("prob = 0.5, 1 - prob = 0.5", {
  expect_equal(aux_skewness(100, 0.5), 0)
})

test_that("prob = 0, 1 - prob = 1 leads to infinite skewness", {
  expect_equal(aux_skewness(100, 0), Inf)
})

context("test aux kurtosis")
test_that("trials = 100, prob = 0.3, both in normal range", {
  expect_equal(aux_kurtosis(100, 0.3), -0.01238095238)
})

test_that("prob = 0, 1 - prob = 1 leads to infinite kurtosis", {
  expect_equal(aux_kurtosis(100, 0), Inf)
})

test_that("prob = 1 - prob = 0.5", {
  expect_equal(aux_kurtosis(100, 0.5), -0.02)
})
