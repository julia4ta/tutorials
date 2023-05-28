########################################
# Gaussian Model of Height
########################################

#=

Sources:

# McElreath, Richard. "Statistical Rethinking 2023 - 03 - Geocentric Models." 2023. (YouTube)
https://youtu.be/tNOu-SEacNU?list=PLDcUM9US4XdPz-KxHM4XHt7uUVGWWVSus

Grantham, Neal. "Statistical Rethinking homework solutions with Turing.jl." 2022.
https://www.nsgrantham.com/stat-rethinking-hw

=#

# load packages

using CSV, DataFrames, GLM, StatsPlots, Turing

# download data (observations collected by Nancy Howell 1967-1969)

url = "https://raw.githubusercontent.com/rmcelreath/rethinking/master/data/Howell1.csv"

df = CSV.read(download(url), DataFrame, delim = ';')

df_adult = df[df.age .>= 18, :]

# visualize data

p_glm = scatter(df_adult.height, df_adult.weight,
    legend = false,
    title = "Adult Weight-Height Association (GLM)",
    xlabel = "Height (cm)",
    ylabel = "Weight (kg)"
)

p_turing = scatter(df_adult.height, df_adult.weight,
    legend = false,
    title = "Adult Weight-Height Association (Turing)",
    xlabel = "Height (cm)",
    ylabel = "Weight (kg)"
)

########################################
# Non-Bayesian Approach (GLM.jl)
########################################

# define model

ols = lm(@formula(weight ~ height), df_adult)

# visualize results

ols_intercept = coef(ols)[1]

ols_slope = coef(ols)[2]

plot!(p_glm, x -> ols_intercept + ols_slope * x,
    legend = false,
    linewidth = 2
)

# make predictions

ols_newX = DataFrame(height = [140, 160, 175])

ols_predictions = predict(ols, ols_newX)

########################################
# Bayesian Approach (Turing.jl)
########################################

# define model

@model function mymodel(weight, height)
    # prior
    intercept ~ Normal(0, 10)
    slope ~ Uniform(0, 1)
    error ~ Uniform(0, 10)
    # likelihood
    avg_weight = intercept .+ slope .* height
    weight ~ MvNormal(avg_weight, error)
end

# infer posterior probability

model = mymodel(df_adult.weight, df_adult.height)

sampler = NUTS()

samples = 1_000

chain = sample(model, sampler, samples)

# visualize results

plot(chain)

for i in 1:samples
    intercept = chain[i, 1, 1]
    slope = chain[i, 2, 1]
    error = chain[i, 3, 1]
    plot!(p_turing, x -> intercept + slope * x,
        legend = false,
        # samples
        linewidth = 2, color = :orange, alpha = 0.02,
        # error
        ribbon = error, fillalpha = 0.003
    )
end

p_turing

# make predictions

newX = [140, 160, 175]

predictions = predict(mymodel(missing, newX), chain)

# visualize predictions

plot(predictions)
