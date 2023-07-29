########################################
# Variational Inference using RxInfer.jl
########################################

#=

# RxInfer.jl Documentation: Advanced Tutorial.
https://biaslab.github.io/RxInfer.jl/stable/examples/Advanced%20Tutorial/

# RxInfer.jl Documentation Home Page.
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
# Observations
########################################

# generate random observations

true_mean = 3.0

true_precision = 5.0

true_sigma = 1 / sqrt(true_precision)

true_distribution = Normal(true_mean, true_sigma)

n = 100_000

observations = rand(true_distribution, n)

# visualize observations

p_observations = histogram(observations,
    bins = 1.0:0.1:5.0,
    title = "Observations",
    legend = false,
    color = 2,
    alpha = 0.5
)

########################################
# Model
########################################

# define model

@model function mymodel(n)
    # prior
    mu ~ NormalMeanPrecision(0.0, 1.0)
    tau ~ GammaShapeRate(1.0, 1.0)
    # likelihood
    y = datavar(Float64, n)
    for i in 1:n
        y[i] ~ NormalMeanPrecision(mu, tau)
    end
end

########################################
# Constraints
########################################

# define constraints

constraints = @constraints begin
    q(mu, tau) = q(mu)q(tau)
end

########################################
# Inference
########################################

# approximate posteriors

result = inference(
    model = mymodel(n),
    data = (y = observations, ),
    constraints = constraints,
    initmarginals = (
        mu = vague(NormalMeanPrecision),
        tau = vague(GammaShapeRate)
    ),
    returnvars = (mu = KeepLast(), tau = KeepLast()),
    iterations = 5,
    free_energy = true
)

# view results for mu

mu_posterior = result.posteriors[:mu]

mu_mean = mean(mu_posterior)

mu_std = std(mu_posterior)

# view results for tau

tau_posterior = result.posteriors[:tau]

tau_mean = mean(tau_posterior)

tau_std = std(tau_posterior)

# VI approximation

vi_sigma = 1 / sqrt(tau_mean)

vi_approximation = Normal(mu_mean, vi_sigma)

########################################
# Visualization
########################################

# true distribution

p_distributions = plot(true_distribution;
    label = "True Distribution",
    title = "Variational Inference (VI)",
    xlims = (1, 5),
    color = 1,
    fill = true,
    alpha = 0.3
)

# VI approximation

plot!(p_distributions, vi_approximation;
    label = "VI Approximation",
    color = 3,
    linewidth = 2,
    linestyle = :dash
)

# observations + distributions

plot(p_observations, p_distributions;
    layout = (2, 1),
    size = (600, 600)
)
