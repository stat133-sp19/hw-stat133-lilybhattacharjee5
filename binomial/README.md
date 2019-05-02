## Overview

`"binomial"` is an R package that provides functions to simulate the outputs of a binomial distribution / variable.

- `bin_variable()` creates a binomial variable object (of class `"bin_var"`)
- `bin_probability()` displays the probability that k successes will occur among n trials overall at p probability of success per trial
- `plot.bindis()` and `plot.bincum()` plot the pdf and cdf probability distributions visually
- `summary.binvar()` displays summary statistics including mean, variance, mode, skewness, and kurtosis of a binomial scenario with n trials overall and p probability of success
- `bin_mean()`, `bin_variance()`, `bin_mode()`, `bin_skewness()`, `bin_kurtosis()` return the corresponding summary statistics individually
- `bin_choose()` returns the number of combinations in which k successes occur among n trials total with p probability of success for each trial

## Motivation
This package has been developed for the Workout 3 assignment for Stat 133.

## Installation
Install the development version from GitHub via the package `"devtools"`:

````
# development version from Github:
# install.packages("devtools")

# install "binomial" (without vignettes)
devtools::install_github("lilybhattacharjee5/binomial")

# install "binomial" (with vignettes)
devtools::install_github("lilybhattacharjee5/binomial", build_vignettes = TRUE)
````

## Usage

````
library(binomial)

# create basic binomial variable with total number of trials 5, probability of success 0.5
my_binvar <- bin_variable(10, 0.5)
my_binvar
#> "Binomial variable"
#> "Parameters"
#> "- number of trials: 10"
#> "- prob of success: 0.5"

# print summary of my_binvar
summary.binvar(my_binvar)
#> "Summary Binomial"
#> "Parameters"
#> "- number of trials: 10"
#> "- prob of success: 0.5"
#> "Measures"
#> "mean: 5"
#> "variance: 2.5"
#> "mode: 5"
#> "skewness: 0"
#> "kurtosis: -0.2"

# calculate bin distribution for 3 trials, 0.5 probability of success scenario for all success values
bin_distribution(3, 0.5)
#> success probability
#> 0 0.125
#> 1 0.375
#> 2 0.375
#> 3 0.125

# calculate cdf of above scenario, return as dataframe
bin_cumulative(3, 0.5)
#> success probability cumulative
#> 0 0.125 0.125
#> 1 0.375 0.500
#> 2 0.375 0.875
#> 3 0.125 1.000
````
