# @title aux_mean
# @description finds the mean value given the probability of success and number of total trials using the formula n * p
# @param trials: number of trials total
# @param prob: probability of success
# @return an object of class numeric representing mean value
aux_mean <- function(trials, prob) {
  return(trials * prob)
}

# @title aux_variance
# @description finds the variance value given the probability of success and number of total trials using the formula np(1 - p)
# @param trials: number of trials total
# @param prob: probability of success
# @return an object of class numeric representing variance value
aux_variance <- function(trials, prob) {
  return(trials * prob * (1 - prob))
}

# @title aux_mode
# @description finds the mode value given the probability of success and number of total trials using the formula int(np + p)
# @param trials: number of trials total
# @param prob: probability of success
# @return an object of class numeric representing mode value
aux_mode <- function(trials, prob) {
  return(floor(trials * prob + prob))
}

# @title aux_skewness
# @description finds the skewness value given the probability of success and number of total trials using the formula (1 - 2p) / sqrt(np*(1 - p))
# @param trials: number of trials total
# @param prob: probability of success
# @return an object of class numeric representing skewness value
aux_skewness <- function(trials, prob) {
  return((1 - 2 * prob) / sqrt(trials * prob * (1 - prob)))
}

# @title aux_kurtosis
# @description finds the kurtosis value given the probability of success and number of total trials using the formula (1 - 6p(1 - p)) / (np*(1 - p))
# @param trials: number of trials total
# @param prob: probability of success
# @return an object of class numeric representing kurtosis value
aux_kurtosis <- function(trials, prob) {
  return((1 - 6 * prob * (1 - prob)) / (trials * prob * (1 - prob)))
}
