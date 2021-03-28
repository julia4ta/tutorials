# Tutorial 02x11: GLMakie Animation

# Julia v1.5.3

#=
    Packages used in this tutorial:
        CSV v0.8.4
        DataFrames v0.22.6
        GLMakie v0.1.30
=#

# Makie.jl Citation: https://doi.org/10.5281/zenodo.4450294

################################################################################

################################################################################
# animate population by region by year
################################################################################

# load data

using DataFrames, CSV

df = DataFrame(CSV.File("population_by_year.csv"))

vscodedisplay(df)

regions = propertynames(df)[2:end]

# initialize plot

using GLMakie

fig = Figure(resolution = (3840, 2160))

# add axis

ax1 = fig[1, 1] = Axis(fig,
    # title
    title =
    "Black = World | Magenta = Asia | Red = Africa | Yellow = Europe
Green = L_America | Cyan = N_America | Blue = Oceania",
    titlegap = 48, titlesize = 48,
    # x-axis
    xgridcolor = :darkgray, xgridwidth = 2,
    xlabel = "Year", xlabelsize = 48,
    xticklabelsize = 36, xticks = LinearTicks(20),
    # y-axis
    ygridcolor = :darkgray, ygridwidth = 2,
    ylabel = "Population in Millions",
    ylabelsize = 48, ytickformat = "{:d}",
    yticklabelsize = 36, yticks = LinearTicks(10)
)

# prep for recording

frames = 1:(length(df.Year))

colors = [:black, :red, :magenta, :yellow, :green, :cyan, :blue]

# record animation

record(fig, "a_population_by_region.mp4", frames; framerate = 12) do i
    for j in 1:length(regions)
        lines!(ax1, df[1:i, 1], df[1:i, (j + 1)],
            color = (colors[j], 0.5), linestyle = :dash, linewidth = 2
        )
        scatter!(ax1, df[1:i, 1], df[1:i, (j + 1)],
            color = colors[j], markersize = 18
        )
    end
end

################################################################################
# animate pi estimation
################################################################################

# initialize plot

fig = Figure(resolution = (3840, 2160))

# add axis for dartboard

ax1 = fig[1, 1] = Axis(fig,
    # borders
    aspect = 1, targetlimits = BBox(-1, 1, -1, 1),
    # title
    title = "Dartboard",
    titlegap = 48, titlesize = 60,
    # x-axis
    xautolimitmargin = (0, 0), xgridcolor = :black, xgridwidth = 2,
    xticklabelsize = 36, xticks = LinearTicks(10), xticksize = 18,
    # y-axis
    yautolimitmargin = (0, 0), ygridcolor = :black, ygridwidth = 2,
    yticklabelsize = 36, yticks = LinearTicks(10), yticksize = 18
)

# add axis for pi estimate

ax2 = fig[1, 2] = Axis(fig,
    # borders
    width = 1400,
    # title
    title = "pi Estimate",
    titlegap = 48, titlesize = 60,
    # x-axis
    xautolimitmargin = (0, 0), xgridwidth = 2,
    xticklabelsize = 36, xticks = LinearTicks(5), xticksize = 18,
    # y-axis
    yautolimitmargin = (0, 0), ygridwidth = 2,
    yticklabelsize = 36, yticks = LinearTicks(10), yticksize = 18
)

# refine layout

sublayout = GridLayout(width = 75)

fig[1, 3] = sublayout

# add target for pi

hlines!(ax2, [pi], linewidth = 5, color = :green)

# generate random data

using Random

Random.seed!(31416)

n = 144_000

x = [rand() * rand((-1, 1)) for _ in 1:n]

vscodedisplay(x)

y = [rand() * rand((-1, 1)) for _ in 1:n]

vscodedisplay(y)

circle = [x[i]^2 + y[i]^2 <= 1 for i in 1:n]

vscodedisplay(circle)

circle_sum = Int64[]

push!(circle_sum, circle[1])

for i in 1:(n - 1)
    new_sum = circle_sum[i] + circle[i + 1]
    push!(circle_sum, new_sum)
end

vscodedisplay(circle_sum)

circle_sum[end]

sum(circle)

pi_est = [4 * circle_sum[i] / i for i in 1:n]

vscodedisplay(pi_est)

pi_est[end]

(pi - pi_est[end]) / pi * 100

# prep for recording

colors = Symbol[]

for i in 1:length(circle)
    circle[i] ? c = :green : c = :red
    push!(colors, c)
end

vscodedisplay(colors)

index = 1:n

frames = 1:720

# record animation

record(fig, "a_pi_est.mp4", frames; framerate = 24) do i
    # create plotting range
    stop = i * 200
    start = stop - 199
    range = start:stop
    # add plot for dartboard
    scatter!(ax1,
        x[range], y[range], color = colors[range], markersize = 5
    )
    # add plot for pi estimate
    scatter!(ax2,
        index[range], pi_est[range], color = :blue, markersize = 5
    )
end
