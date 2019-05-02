# @title check_prob
# @description tests if an input prob is a valid probability value (0 <= p <= 1)
# @param prob: proability of success
# @return TRUE / error based on whether or not prob is valid
check_prob <- function(prob) {
  if ((length(prob) == 1) && (prob <= 1) && (prob >= 0)) {
    return(TRUE)
  }
  stop("invalid prob value")
}

# @title check_trials
# @description tests if an input trials is a valid trials value (t >= 0)
# @param trials: number of trials
# @return TRUE / error based on whether or not trials is valid
check_trials <- function(trials) {
  if (trials >= 0) {
    return(TRUE)
  }
  stop("invalid trials value")
}

# @title check_success
# @description tests if an input success is a valid success value based on the number of total trials (0 <= success <= trials)
# @param success: number of successes
# @param trials: number of trials
# @return TRUE / error based on whether or not success is valid
check_success <- function(success, trials) {
  if (length(success) == 1) {
    if (success >= 0 && success <= trials) {
      return(TRUE)
    }
    stop("invalid success value")
  } else {
    for (s in success) {
      if (s < 0 || s > trials) {
        stop("invalid success value")
      }
    }
    return(TRUE)
  }
}
