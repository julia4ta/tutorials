########################################
# RxInfer.jl Demonstration
########################################

#=

# RxInfer.jl Documentation. "Getting Started".
https://biaslab.github.io/RxInfer.jl/stable/manuals/getting-started/

# RxInfer.jl Documentation.
https://biaslab.github.io/RxInfer.jl/stable/

# Bagaev et al. "Reactive Message Passing for Scalable Bayesian Inference". Scientific Programming. 2023.
https://www.hindawi.com/journals/sp/2023/6601690/

=#

########################################
# Packages
########################################

# load packages

using RxInfer, StatsPlots

using Random; Random.seed!(1)

########################################
# Data
########################################

# generate random data

true_success_rate = 0.75

distribution = Bernoulli(true_success_rate)

tosses = 10

myobservations = rand(distribution, tosses)

heads = sum(myobservations)

########################################
# Model
########################################

# define model

@model function mymodel(tosses)
    # prior
    success_rate ~ Beta(1, 1)
    # likelihood
    observations = datavar(Bool, tosses)
    for i in 1:tosses
        observations[i] ~ Bernoulli(success_rate)
    end
end

########################################
# Posterior
########################################

# find posterior distribution

model = mymodel(tosses)

data = (observations = myobservations, )

result = inference(model = model, data = data)

post = result.posteriors[:success_rate]

post_mean = mean(post)

post_std = std(post)

########################################
# Visualization
########################################

# visualize results

p1 = plot(Beta(1, 1);
    legend = false,
    xlims = (0, 1),
    title = "Prior",
    fill = true,
    alpha = 0.3
)

p2 = plot(post;
    label = "",
    xlims = (0, 1),
    title = "Posterior",
    fill = true,
    alpha = 0.3,
    color = 3
)

vline!(p2,
    [post_mean],
    label = "Posterior Mean",
    color = 1,
    linestyle = :dash
)

std_left = post_mean - post_std

std_right = post_mean + post_std

vline!(p2,
    [std_left, std_right],
    label = "Posterior Std",
    color = 2,
    linestyle = :dash
)

vline!(p2,
    [true_success_rate],
    label = "True Success Rate",
    color = :black,
    linestyle = :dash
)

plot(p1, p2;
    layout = (2, 1),
    size = (600, 600)
)
