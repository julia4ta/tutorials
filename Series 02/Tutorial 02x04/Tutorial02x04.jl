# Tutorial 02x04: Statistics Part 1 of 2

# Julia v1.5.3

# Packages used in this tutorial:

# StatsBase v0.33.2
# HypothesisTests v0.10.2

using Statistics
using StatsBase

# example: beverage calories (copy data from description):

calories = [144, 151, 157, 170, 152, 145, 175, 149, 99, 113, 140, 102, 135, 149, 149, 68, 136, 144, 72, 97]

vscodedisplay(calories)

# hack

calories_sort = sort!(calories)
index = collect(1:length(calories))
calories_table = [index calories_sort]

vscodedisplay(calories_table)

# Descriptive Statistics XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX

# measures of location

# summarize data

describe(calories) # StatsBase

# separate functions

length(calories)

mean(calories)

minimum(calories)

median(calories)

maximum(calories)

quantile(calories)

mode(calories)

# measures of dispersion

# range

r = maximum(calories) - minimum(calories)

# sample variance

sample_var = var(calories)

# population variance

population_var = var(calories, corrected = false)

# sample standard deviation

std(calories)

# population standard deviation

std(calories; corrected = false)

# the standard deviation is just the square root of the variance

sqrt(sample_var)

sqrt(population_var)

# Inferential Statistics XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX

# confidence intervals

# example: number of pints of beverage consumed per week

beverage_mean = 5.67
beverage_std = 2.09
beverage_n = 200

# standard error of the mean

beverage_sem = beverage_std / sqrt(beverage_n)

# Unicode for Plus-Minus Sign: \pm<TAB>

println("95% CI = ", beverage_mean, " ± ", 1.96 * beverage_sem)

# standard error of the mean from StatsBase

sem(calories) # StatsBase

std(calories) / sqrt(length(calories))

# 95% Confidence Interval = Mean ± 1.96 x Standard Error

function ci(data)
    interval = 1.96 * sem(data)
    lower = mean(data) - interval
    upper = mean(data) + interval
    println("95% CI = ", mean(data), " ± ", interval)
    return (lower, upper)
end

ci(calories)

# CI for binomial distributions

# standard error for binomial distribution

function se_binomial(p, n)
    seb = sqrt(p * (1 - p) / n)
end

# example: marketing survey

p = 0.72
n = 200
se_binomial(p, n)

# 95% Confidence Interval = Mean ± 1.96 x Standard Error

function ci_binomial(p, n)
    interval = 1.96 * se_binomial(p, n)
    lower = p - interval
    upper = p + interval
    println("95% CI = ", p, " ± ", interval)
    return (lower, upper)
end

ci_binomial(p, n)

# Tests of Significance

using HypothesisTests

# example: A/B testing

difference = [-4, -7, -3, -4, -6, -1, 1, 8, -8, 1]

OneSampleTTest(difference)

# example: training plan effectiveness testing

using LinearAlgebra

# observations

O = [175, 25, 100, 100]

# expectations

E = [137.5, 62.5, 137.5, 62.5]

# Pearson's Chi-square Test

ChisqTest(O, normalize(E, 1))
