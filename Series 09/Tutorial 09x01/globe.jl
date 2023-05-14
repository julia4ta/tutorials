########################################
# Globe Tossing
########################################

#=

Sources:
# McElreath, Richard. "Statistical Rethinking 2023 - 02 - The Garden of Forking Data." 2023. (YouTube)
https://youtu.be/R1vcdhPBlXA?list=PLDcUM9US4XdPz-KxHM4XHt7uUVGWWVSus

# "StatisticalRethinkingJulia/TuringModels.jl/m2.1: Globe tossing"
https://statisticalrethinkingjulia.github.io/TuringModels.jl/models/globe-tossing/

Grantham, Neal. "Statistical Rethinking homework solutions with Turing.jl." 2022.
https://www.nsgrantham.com/stat-rethinking-hw

=#

# load packages

using Turing, StatsPlots

########################################
# Traditional Approach
########################################

# inputs

n = 9

p = 0.71

# model

f(n, p) = Int(round(n * p))

# output

w = f(n, p)

# try to back into the value of p

w / n

p1 = 0.62

w1 = f(n, p1)

p2 = 0.72

w2 = f(n, p2)

########################################
# Bayesian Approach
########################################

# observe data

tosses = 9

water = 6

# define model

@model function globe_toss(tosses, water)
    # prior
    percent_water ~ Beta(1, 1)
    # likelihood
    water ~ Binomial(tosses, percent_water)
end

# infer posterior distribution

model = globe_toss(tosses, water)

sampler = NUTS()

samples = 1_000

chain = sample(model, sampler, samples)

# visualize results

plot(chain)

density(chain[:percent_water],
    legend = false,
    linewidth = 2,
    fill = true,
    alpha = 0.3,
    xlims = (0, 1),
    widen = true,
    title = "Posterior Distribution (approx)",
    xlabel = "percent_water",
    ylabel = "density"
)
