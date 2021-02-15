# Tutorial 02x05: Statistics Part 2 of 2

# Julia v1.5.3

#=
    Packages for this tutorial:
        CairoMakie v0.3.14
        GLM v1.3.11
        KernelDensity v0.6.2
        Makie v0.12.0
        PlotlyJS v0.14.0
        Plots v1.10.4
        StatsBase v0.33.2
        StatsPlots v0.14.19
        TypedTables v1.2.3
=#

################################################################################

# copy and paste data

observations = [144, 151, 157, 170, 152, 145, 175, 149, 99, 113, 140, 102, 135, 149, 149, 68, 136, 144, 72, 97]

t = collect(1:20)

# 1. create linear regression manually using Plots/GR

using Plots
gr(size = (800, 450))

p_line = plot(t, observations,
    xlabel = "Time",
    ylabel = "Observations",
    title = "Plots/GR Default (Line) Plot",
    legend = false
)

# create scatter plot

p_scatter = scatter(t, observations,
    xlabel = "Time",
    ylabel = "Observations",
    title = "Plots/GR Linear Regression",
    legend = false,
    color = :dodgerblue,
    alpha = 0.5
)

# calculate mean and standard deviation

using Statistics

avg = mean(observations)
stdev = std(observations)

# add mean and standard deviation to plot

hline!([avg - stdev, avg, avg + stdev],
    linestyle = :dash, color = :green
)

# generate information needed to plot a linear regression line

using GLM
using TypedTables

data = Table(X = t, Y = observations) # TypedTables

typeof(data)

# fit data into linear model

ols = lm(@formula(Y ~ X), data) # GLM

# add linear regression line to plot

plot!(t, predict(ols), color = :red, alpha = 0.5)

R² = r2(ols) # R\^2<TAB>

# how to use predict() function

predict(ols)

newX = Table(X = [5.5, 10.7, 12.3])

predict(ols, newX)

# don't extend prediction beyond observations

past_future_X = Table(X = [-100, 100])

predict(ols, past_future_X)

# save plot

savefig(p_scatter, "regression_gr.svg")

# 2. how to create histogram using Plots/GR

using StatsBase

# estimate number of bins

K = Int(round(1 + 3.322 * log(length(observations)))) # Sturge's Rule

# fit data into Histogram

h = fit(Histogram, observations, nbins = K) # StatsBase

# generate histogram

p_histogram = bar(h.edges, h.weights,
    xlabel = "Observations",
    ylabel = "Count",
    title = "Plots/GR Histogram",
    legend = false,
    color = :dodgerblue,
    alpha = 0.5
)

# add mean and standard deviations

vline!([avg - stdev, avg, avg + stdev],
    linestyle = :dash, color = :green
)

# save plot

savefig(p_histogram, "histogram_gr.svg")

# 3. how to create density plot using Plots/GR

using KernelDensity

d = kde(observations)

# generate plot

p_density = plot(d.x, d.density,
    xlabel = "Observations",
    ylabel = "Density",
    title = "Plots/GR Density Plot",
    legend = false,
    fill = (0, :dodgerblue),
    alpha = 0.5
)

# add mean and standard deviations

vline!([avg - stdev, avg, avg + stdev],
    linestyle = :dash, color = :green
)

# backup calculations

density = d.density

bandwidth = step(d.x)

probability = density .* bandwidth

sum(probability)

# save plot

savefig(p_density, "density_gr.svg")

################################################################################
# using StatsPlots + PlotlyJS
################################################################################

# copy and paste data

observations = [144, 151, 157, 170, 152, 145, 175, 149, 99, 113, 140, 102, 135, 149, 149, 68, 136, 144, 72, 97]

t = collect(1:20)

# select plotting packages

using StatsPlots
plotlyjs(size = (800, 450))

# 4. how to create linear regression using StatsPlots/PlotlyJS

p_scatter = scatter(t, observations,
    xlabel = "Time",
    ylabel = "Observations",
    title = "StatsPlots/PlotlyJS Linear Regression",
    legend = false,
    color = :dodgerblue,
    alpha = 0.5,
    regression = true
)

# calculate mean and standard deviation

using Statistics

avg = mean(observations)
stdev = std(observations)

# add mean and standard deviation to plot

hline!([avg - stdev, avg, avg + stdev],
    linestyle = :dash, color = :green
)

# save plot

savefig(p_scatter, "regression_plotlyjs.svg")

# 5. how to create histogram using StatsPlots/PlotlyJS

# Sturge's Rule

K = Int(round(1 + 3.322 * log(length(observations))))

# generate histogram

p_histogram = histogram(observations,
    bins = K,
    xlabel = "Observations",
    ylabel = "Count",
    title = "StatsPlots/PlotlyJS Histogram",
    legend = false,
    color = :dodgerblue,
    alpha = 0.5
)

# add mean and standard deviations

vline!([avg - stdev, avg, avg + stdev],
    linestyle = :dash, color = :green
)

# save plot

savefig(p_histogram, "histogram_plotlyjs.svg")

# 6. how to create density plot using StatsPlots/PlotlyJS

# generate plot

p_density = density(t, observations,
    xlabel = "Observations",
    ylabel = "Density",
    title = "StatsPlots/PlotlyJS Density Plot",
    legend = false,
    fill = (0, :dodgerblue),
    alpha = 0.5
)

# add mean and standard deviations

vline!([avg - stdev, avg, avg + stdev],
    linestyle = :dash, color = :green
)

# save plot

savefig(p_density, "density_plotlyjs.svg")

################################################################################
# using CairoMakie
################################################################################

# copy and paste data

observations = [144, 151, 157, 170, 152, 145, 175, 149, 99, 113, 140, 102, 135, 149, 149, 68, 136, 144, 72, 97]

t = collect(1:20)

# select plotting package

using CairoMakie

# 7. how to create linear regression using CairoMakie

# select font(s)

font1 = "Comic Sans MS-Regular"
font2 = "Comic Sans MS-Bold"
font3 = "Comic Sans MS-Bold-Italic"
font4 = "Comic Sans MS-Italic"
font5 = "Times New Roman-Regular"

# initialize plot

fig = Figure(resolution = (1280, 720), font = font5)

ax1 = fig[1, 1] = Axis(fig,
    title = "CairoMakie Linear Regression",
    xlabel = "Time",
    ylabel = "Observations"
)
fig

# generate scatter plot of data

scat1 = scatter!(ax1, t, observations,
    color = (:dodgerblue, 0.5), markersize = 12
)
fig

# add mean and standard deviations

using Statistics

avg = mean(observations)
stdev = std(observations)

line1 = hlines!(ax1, [avg - stdev, avg, avg + stdev],
    color = :green, linewidth = 2, linestyle = :dash
)
fig

# add a linear regression line

using GLM
using TypedTables

data = Table(X = t, Y = observations) # TypedTables

ols = lm(@formula(Y ~ X), data) # GLM

line2 = lines!(ax1, t, predict(ols), color = (:red, 0.5), linewidth = 3)
fig

# save plot

save("regression_cairomakie.svg", fig)

# 8. how to create histogram using CairoMakie

fig = Figure(resolution = (1280, 720), font = font5)

ax1 = fig[1, 1] = Axis(fig,
    title = "CairoMakie Histogram",
    xlabel = "Observations",
    ylabel = "Count"
)
fig

# Sturge's Rule

K = Int(round(1 + 3.322 * log(length(observations))))

# generate histogram of data

hist1 = hist!(ax1, observations,
    color = (:dodgerblue, 0.5),
    strokecolor = :black, strokewidth = 1;
    bins = K
)
fig

# add mean and standard deviations

line1 = vlines!(ax1, [avg - stdev, avg, avg + stdev],
    color = :green, linewidth = 2, linestyle = :dash
)
fig

# save plot

save("histogram_cairomakie.svg", fig)

# 9. how to create density plot using CairoMakie

fig = Figure(resolution = (1280, 720), font = font5)

ax1 = fig[1, 1] = Axis(fig,
    title = "CairoMakie Density Plot",
    xlabel = "Observations",
    ylabel = "Density"
)
fig

# generate plot

den1 = density!(ax1, observations,
    color = (:dodgerblue, 0.5),
    strokecolor = :black, strokewidth = 1
)
fig

# add mean and standard deviations

line1 = vlines!(ax1, [avg - stdev, avg, avg + stdev],
    color = :green, linewidth = 2, linestyle = :dash
)
fig

# save plot

save("density_cairomakie.svg", fig)
