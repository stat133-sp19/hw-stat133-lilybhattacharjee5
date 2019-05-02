library(ggplot2)

#' @title bin_choose
#' @description calculates the number of combinations in which k successes can occur in n trials according to the formula n choose k = n! / (k! (n - k)!)
#' @param n: number of trials total
#' @param k: number of successes
#' @return number of combinations for k successes within n trials
bin_choose <- function(n, k) {
  if (length(k[k > n])) {
    stop("k cannot be greater than n")
  }
  return(factorial(n) / (factorial(k) * factorial(n - k)))
}

#' @title bin_probability
#' @description calculates the probability that a certain number of successes occur within some number of trials
#' @param success: number of successes
#' @param trials: number of total trials
#' @param prob: probability of success
#' @return numeric value representing probability of k successes within n trials total
bin_probability <- function(success, trials, prob) {
  check_trials(trials)
  check_prob(prob)
  check_success(success, trials)
  return(bin_choose(trials, success) * prob^success * (1 - prob)^(trials - success))
}

#' @title bin_distribution
#' @description calculates using bin_probability the chance of getting k successes within n trials for all possible values of k (0 to n)
#' @param trials: number of total trials
#' @param prob: probability of success
#' @return a data.frame with two classes -- c("bindis", "data.frame") -- with the probability distribution: successes in the 1st column, probability in the 2nd column
bin_distribution <- function(trials, prob) {
  success <- 0:trials
  probability <- bin_probability(success, trials, prob)
  distr <- data.frame(success, probability)
  class(distr) <- c("bindis", "data.frame")
  return(distr)
}

#' @export
plot.bindis <- function(distribution) {
  ggplot(distribution) + geom_col(aes(success, probability))
}

#' @title bin_cumulative
#' @description calculates using bin_probability the chance of getting <= k successes within n trials for all possible values of k (0 to n)
#' @param trials: number of total trials
#' @param prob: probability of success
#' @return a data.frame with two classes -- c("bincum", "data.frame") -- with the probability distribution: successes in the 1st column, probability in the 2nd column, cumulative in the 3rd column
bin_cumulative <- function(trials, prob) {
  success <- 0:trials
  probability <- bin_probability(success, trials, prob)
  cumulative <- c(probability[1])
  for (prob in probability[2:length(probability)]) {
    cumulative <- append(cumulative, cumulative[length(cumulative)] + prob)
  }
  distr <- data.frame(success, probability, cumulative)
  class(distr) <- c("bincum", "data.frame")
  return(distr)
}

#' @export
plot.bincum <- function(distribution) {
  ggplot(distribution) + geom_line(aes(success, cumulative)) + geom_point(aes(success, cumulative))
}

#' @title bin_variable
#' @description creates a binomial variable list of named elements -- trials for the number of trials and prob for the probability of success
#' @param trials: number of total trials
#' @param prob: probability of success
#' @return an object of class "binvar" -- a binomial variable object
bin_variable <- function(trials, prob) {
  check_trials(trials)
  check_prob(prob)
  bin_variable <- c(trials, prob)
  names(bin_variable) <- c("trials", "prob")
  class(bin_variable) <- "binvar"
  return(bin_variable)
}

#' @export
print.binvar <- function(binomial_variable) {
  print("Binomial variable")
  print("Parameters")
  print(paste0("- number of trials: ", binomial_variable["trials"]))
  print(paste0("- prob of success: ", binomial_variable["prob"]))
}

#' @export
summary.binvar <- function(binomial_variable) {
  trials <- binomial_variable["trials"]
  prob <- binomial_variable["prob"]
  mean_binvar <- aux_mean(trials, prob)
  var_binvar <- aux_variance(trials, prob)
  mode_binvar <- aux_mode(trials, prob)
  skewness_binvar <- aux_skewness(trials, prob)
  kurtosis_binvar <- aux_kurtosis(trials, prob)
  summary_list <- c(trials, prob, mean_binvar, var_binvar, mode_binvar, skewness_binvar, kurtosis_binvar)
  names(summary_list) <- c("trials", "prob", "mean", "variance", "mode", "skewness", "kurtosis")
  class(summary_list) <- "summary.binvar"
  return(summary_list)
}

#' @export
print.summary.binvar <- function(binomial_summary) {
  print("Summary Binomial")
  print("Parameters")
  print(paste0("- number of trials: ", binomial_summary["trials"]))
  print(paste0("- prob of success: ", binomial_summary["prob"]))
  print("Measures")
  print(paste0("mean: ", binomial_summary["mean"]))
  print(paste0("variance: ", binomial_summary["variance"]))
  print(paste0("mode: ", binomial_summary["mode"]))
  print(paste0("skewness: ", binomial_summary["skewness"]))
  print(paste0("kurtosis: ", binomial_summary["kurtosis"]))
}

#' @title bin_mean
#' @description calculates mean of binomial scenario of n trials and p prob of success using aux_mean
#' @param trials: number of total trials
#' @param prob: probability of success
#' @return numeric value representing mean given number of trials and prob of success
bin_mean <- function(trials, prob) {
  check_trials(trials)
  check_prob(prob)
  return(aux_mean(trials, prob))
}

#' @title bin_variance
#' @description calculates variance of binomial scenario of n trials and p prob of success using aux_variance
#' @param trials: number of total trials
#' @param prob: probability of success
#' @return numeric value representing variance given number of trials and prob of success
bin_variance <- function(trials, prob) {
  check_trials(trials)
  check_prob(prob)
  return(aux_variance(trials, prob))
}

#' @title bin_mode
#' @description calculates mode of binomial scenario of n trials and p prob of success using aux_mode
#' @param trials: number of total trials
#' @param prob: probability of success
#' @return numeric value representing mode given number of trials and prob of success
bin_mode <- function(trials, prob) {
  check_trials(trials)
  check_prob(prob)
  return(aux_mode(trials, prob))
}

#' @title bin_skewness
#' @description calculates mode of binomial scenario of n trials and p prob of success using aux_skewness
#' @param trials: number of total trials
#' @param prob: probability of success
#' @return numeric value representing skewness given number of trials and prob of success
bin_skewness <- function(trials, prob) {
  check_trials(trials)
  check_prob(prob)
  return(aux_skewness(trials, prob))
}

#' @title bin_kurtosis
#' @description calculates kurtosis of binomial scenario of n trials and p prob of success using aux_kurtosis
#' @param trials: number of total trials
#' @param prob: probability of success
#' @return numeric value representing kurtosis given number of trials and prob of success
bin_kurtosis <- function(trials, prob) {
  check_trials(trials)
  check_prob(prob)
  return(aux_kurtosis(trials, prob))
}
