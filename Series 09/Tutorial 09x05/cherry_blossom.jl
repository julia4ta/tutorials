########################################
# Bayesian B-splines
########################################

#=

References:

Aono and Saito 2010. International Journal of Biometeorology, 54, 211-219.
Aono and Kazui 2008. International Journal of Climatology, 28, 905-914.
Aono 2012. Chikyu Kankyo (Global Environment), 17, 21-29.
http://atmenv.envi.osakafu-u.ac.jp/aono/kyophenotemp4/

McElreath, Richard. "Statistical Rethinking 2023 - 04 - Categories & Curves." 2023. (YouTube)
https://youtu.be/F0N4b7K_iYQ?list=PLDcUM9US4XdPz-KxHM4XHt7uUVGWWVSus

SR2TuringPluto.jl
https://github.com/StatisticalRethinkingJulia/SR2TuringPluto.jl/blob/master/notebooks/Chapter_04_part_3.jl

=#

# load packages

using BSplines, CSV, DataFrames, StatsPlots, Turing

# download data

url = "https://raw.githubusercontent.com/rmcelreath/rethinking/master/data/cherry_blossoms.csv"

df = CSV.read(
    download(url),
    DataFrame, delim = ';',
    missingstring = "NA"
)

dropmissing!(df, :doy)

X = df.year

y = df.doy

# visualize data

p_data = scatter(X, y,
    legend = false,
    xlims = (800, 2020),
    ylims = (75, 130),
    color = :red, markersize = 4, markeralpha = 0.5,
    title = "Cherry Tree Full Flowering Date by Year",
    xlabel = "Year",
    ylabel = "Calendar Day of Year (doy)",
    widen = true
)

########################################
# BSplines.jl
########################################

knots = 15

probabilities = range(0, 1; length = knots)

knots_list = quantile(df.year, probabilities)

order = 3

basis = BSplineBasis(order, knots_list)

########################################
# Turing.jl
########################################

# define model

@model function mymodel(year, doy, basis)
    # prior
    mu_weight = zeros(length(basis))
    weight ~ MvNormal(mu_weight, 1)
    avg_doy ~ Normal(100, 10)
    error ~ Uniform(0, 10)
    # likelihood
    spline = Spline(basis, weight)
    mu_doy = avg_doy .+ spline.(year)
    doy ~ MvNormal(mu_doy, error)
end

# infer posterior probability

model = mymodel(X, y, basis)

sampler = NUTS()

samples = 1_000

chain = sample(model, sampler, samples)

# visualize results

plot(chain)

########################################
# Plot B-splines
########################################

# convert individual weight columns into a vector of vectors

posterior = DataFrame(chain)

df_weights = select(posterior, r"weight")

weights_vector = Vector.(eachrow(df_weights))

# plot samples

for i in 1:samples
    avg_doy = posterior.avg_doy[i]
    spline = Spline(basis, weights_vector[i]).(X)
    y_spline = avg_doy .+ spline
    error = chain[i, 18, 1]
    plot!(p_data, X, y_spline, legend = false,
        # samples
        linewidth = 2, color = :blue, alpha = 0.01,
        # error
        ribbon = error, fillalpha = 0.002
    )
end

p_data
