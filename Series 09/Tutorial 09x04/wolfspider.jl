########################################
# Bayesian Logistic Regression
########################################

#=

Data Source:

Suzuki et al.
"Distribution of an endangered burrowing spider Lycosa ishikariana in the San'in Coast of Honshu, Japan (Araneae: Lycodidae)."
Acta Arachnologica, 2006.
https://www.jstage.jst.go.jp/article/asjaa/55/2/55_2_79/_pdf/-char/en

=#

# load packages

using CSV, StatsPlots, Turing

# download data

url = "https://raw.githubusercontent.com/julia4ta/tutorials/master/Series%2009/Files/wolfspider.csv"

data = CSV.File(download(url))

X = data.feature

y = data.class

data_matrix = [X y]

# visualize data

p_data = scatter(X, y,
    legend = false,
    xlims = (0, 1.25),
    color = :red,
    markersize = 5,
    title = "Wolf Spider Present (1) or Absent (0)",
    xlabel = "Median Grain Size of Sand (mm)",
    ylabel = "Probability of Presence",
    widen = true
)

########################################
# Bayesian Approach (Turing.jl)
########################################

# define model

@model function mymodel(grain_size, presence)
    # prior
    intercept ~ Uniform(-5, 0)
    slope ~ Uniform(0, 10)
    # likelihood
    line = intercept .+ slope .* grain_size
    p = 1 ./ (1 .+ exp.(-line))
    for i in eachindex(p)
        presence[i] ~ Bernoulli(p[i])
    end
end

# infer posterior probability

model = mymodel(X, y)

sampler = NUTS()

samples = 1_000

chain = sample(model, sampler, samples)

# visualize results

plot(chain)

xs = 0.0:0.01:1.2

for i in 1:samples
    intercept = chain[i, 1, 1]
    slope = chain[i, 2, 1]
    line(x) = intercept + slope * x
    p(x) = 1 / (1 + exp(-line(x)))
    plot!(p_data, xs, p,
        legend = false,
        # samples
        linewidth = 2, color = :blue, alpha = 0.03
    )
end

p_data

# make predictions

newX = [0.25, 0.5, 0.75, 1.0]

p_spider = fill(missing, length(newX))

predictions = predict(mymodel(newX, p_spider), chain)

# visualize predictions

plot(predictions)
