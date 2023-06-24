########################################
# Bayesian Autoregressive AR(2) Model
########################################

#=

References:

# ritvikmath. "Bayesian Time Series : Time Series Talk". 2021. (YouTube)
https://youtu.be/mu-l-K8-8jA

# ritvikmath. Python code for ritvikmath YouTube video.
https://github.com/ritvikmath/YouTubeVideoCode/blob/main/Bayesian%20Time%20Series.ipynb

# "TypeError when sampling AR(2) process using Turing.jl". 2021. Stack Overflow.
https://stackoverflow.com/questions/67730294/typeerror-when-sampling-ar2-process-using-turing-jl

=#

# load packages

using StatsPlots, Turing

using Random; Random.seed!(2)

# generate data

true_phi_1 = -0.2

true_phi_2 = 0.5

true_sigma = 0.1

time = 50

X = Vector{Float64}(undef, time+2)

X[1] = rand(Normal(0, true_sigma))

X[2] = rand(Normal(0, true_sigma))

for t in 3:(time+2)
    noise = rand(Normal(0, true_sigma))
    X[t] = true_phi_1 * X[t-1] +
        true_phi_2 * X[t-2] +
    noise
end

X_data = X[3:end]

# visualize data

p_data = plot(X_data,
    legend = false,
    linewidth = 2,
    xlims = (0, 60),
    ylims = (-0.6, 0.6),
    title = "Bayesian Autoregressive AR(2) Model",
    xlabel = "t",
    ylabel = "X_t",
    widen = true
)

########################################
# Model
########################################

# define model

@model function mymodel(time, X)
    # prior
    phi_1 ~ Normal(0, 1)
    phi_2 ~ Normal(0, 1)
    sigma ~ Exponential(1)
    # likelihood
    X[1] ~ Normal(0, sigma)
    X[2] ~ Normal(0, sigma)
    for t in 3:(time+2)
        mu = phi_1 * X[t-1] + phi_2 * X[t-2]
        X[t] ~ Normal(mu, sigma)
    end
end

# infer posterior probability

model = mymodel(time, X)

sampler = NUTS()

samples = 1_000

chain = sample(model, sampler, samples)

# visualize results

plot(chain)

########################################
# Predictions
########################################

# make predictions

time_fcst = 10

X_fcst = Matrix{Float64}(
    undef, time_fcst+2, samples
)

X_fcst[1, :] .= X_data[time-1]

X_fcst[2, :] .= X_data[time]

for col in 1:samples
    phi_1_fcst = rand(chain[:, 1, 1])
    phi_2_fcst = rand(chain[:, 2, 1])
    error_fcst = rand(chain[:, 3, 1])
    noise_fcst = rand(Normal(0, error_fcst))
    for row in 3:(time_fcst+2)
        X_fcst[row, col] =
            phi_1_fcst * X_fcst[row-1, col] +
            phi_2_fcst * X_fcst[row-2, col] +
        noise_fcst
    end
end

# visualize predictions

ts_fcst = time:(time + time_fcst)

for i in 1:samples
    plot!(p_data, ts_fcst, X_fcst[2:end, i],
        legend = false,
        # predictions
        linewidth = 1, color = :green, alpha = 0.1
    )
end

p_data

# visualize mean values for predictions

X_fcst_mean = [
    mean(X_fcst[i, 1:samples]) for i in 2:(time_fcst+2)
]

plot!(p_data, ts_fcst, X_fcst_mean,
    legend = false,
    linewidth = 2,
    color = :red,
    linestyle = :dot
)
