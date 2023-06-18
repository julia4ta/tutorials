########################################
# Bayesian Poisson Regression
########################################

#=

Reference:

Turing.jl Tutorials
https://turinglang.org/dev/tutorials/07-poisson-regression/

=#

# load packages

using CSV, DataFrames, StatsPlots, Turing

# load data

url = "https://raw.githubusercontent.com/julia4ta/tutorials/master/Series%2009/Files/pollen_meds.csv"

df = CSV.read(download(url), DataFrame)

# split data

noPollen_noMeds = df[
    (df[:, :pollen] .== 0) .& (df[:, :meds] .== 0), :count
]

noPollen_Meds = df[
    (df[:, :pollen] .== 0) .& (df[:, :meds] .== 1), :count
]

Pollen_noMeds = df[
    (df[:, :pollen] .== 1) .& (df[:, :meds] .== 0), :count
]

Pollen_Meds = df[
    (df[:, :pollen] .== 1) .& (df[:, :meds] .== 1), :count
]

# visualize data

p1 = histogram(noPollen_noMeds,
    legend = false,
    title = "No Pollen, No Meds",
    widen = true
)

p2 = histogram(noPollen_Meds,
    legend = false,
    title = "No Pollen, Meds",
    widen = true
)

p3 = histogram(Pollen_noMeds,
    legend = false,
    title = "Pollen, No Meds",
    widen = true
)

p4 = histogram(Pollen_Meds,
    legend = false,
    title = "Pollen, Meds",
    widen = true
)

plot(p1, p2, p3, p4,
    layout = (2, 2),
    legend = false
)

# set up features and labels

features = Matrix(df[:, [:pollen, :meds]])

labels = df[:, :count]

########################################
# Model
########################################

# define model

@model function mymodel(X, y)
    # prior
    intercept ~ Normal(0, 1)
    pollen ~ Normal(0, 1)
    meds ~ Normal(0, 1)
    # likelihood
    for i in 1:length(y)
        line = intercept + pollen * X[i, 1] + meds * X[i, 2]
        log_transform = exp(line)
        y[i] ~ Poisson(log_transform)
    end
end

# infer posterior probability

model = mymodel(features, labels)

sampler = NUTS()

samples = 1_000

chain = sample(model, sampler, samples)

# visualize results

plot(chain)

# make predictions

newX = [
    0 0 # noPollen_noMeds
    0 1 # noPollen_Meds
    1 0 # Pollen_noMeds
    1 1 # Pollen_Meds
]

missing_counts = fill(missing, 4)

predict_model = mymodel(newX, missing_counts)

predictions = predict(predict_model, chain)

# visualize predictions

plot(predictions)

# recycle plots

p5 = histogram(predictions[:, 1, 1],
    legend = false,
    title = "No Pollen, No Meds (predict)",
    widen = true
)

p6 = histogram(predictions[:, 2, 1],
    legend = false,
    title = "No Pollen, Meds (predict)",
    widen = true
)

p7 = histogram(predictions[:, 3, 1],
    legend = false,
    title = "Pollen, No Meds (predict)",
    widen = true
)

p8 = histogram(predictions[:, 4, 1],
    legend = false,
    title = "Pollen, Meds (predict)",
    widen = true
)

plot(p1, p5, p2, p6, p3, p7, p4, p8,
    layout = (4, 2),
    legend = false,
    size = (720, 840)
)
