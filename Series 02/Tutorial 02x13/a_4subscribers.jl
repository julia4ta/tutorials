# Tutorial 02x13: Gift for Subscribers

# Julia v1.6.0

#=
    Packages used:
        DataFrames v0.22.7
        GLMakie v0.2.5
=#

# Makie.jl Citation: https://doi.org/10.5281/zenodo.4450294

################################################################################

# load packages

using DataFrames, GLMakie

# initialize plot

fig = Figure(resolution = (3840, 2160))

# add axis

ax1 = fig[1, 1] = Axis(fig,
    # borders
    aspect = 1.618,
    # title
    title = "To My Subscribers: Thank You, Congratulations & Good Luck!!!",
    titlegap = 48, titlesize = 60,
    # x-axis
    xlabel = "Forward Step (+ 1)", xlabelsize = 48,
    xgridcolor = RGBf0(71/255, 74/255, 79/255),
    xgridwidth = 2, xticklabelsize = 36,
    xticks = LinearTicks(13), xticksize = 18,
    # y-axis
    ylabel = "Random Step (+/- 1)", ylabelpadding = 30, ylabelsize = 48,
    ygridcolor = RGBf0(71/255, 74/255, 79/255),
    ygridwidth = 2, yticklabelpad = 14,
    yticklabelsize = 36, yticks = LinearTicks(8), yticksize = 18,
    # set limits
    limits = (0, 650, -80, 80),
    # background color
    backgroundcolor = RGBf0(40/255, 44/255, 52/255)
)

# update subscriber count as of 2021-04-07

subscribers = 619

# set up x-coordinates

x = Int32[]

for i in 1:subscribers
    for j in 0:subscribers
        push!(x, j)
    end
end

# set up y-coordinates

y = Int32[]

price = Int32(0)

# generate random walk

for i in 1:subscribers
    price = Int32(0)
    push!(y, price)
    for j in 1:subscribers
        direction = rand((-1, 1))
        price = price + direction
        push!(y, price)
    end
end

# set up colors

colors = Tuple{RGBf0, Float64}[]

for i in 1:subscribers
    color = (rand(RGBf0), 0.1)
    for j in 0:subscribers
        push!(colors, color)
    end
end

# create DataFrame of plotting variables

df = DataFrame(x = x, y = y, colors = colors)

df_sort = sort!(df, :x)

# record animation

frames = 1:(subscribers + 1)

record(fig, "a_4subscribers.mp4", frames; framerate = 12) do i
    # create plotting range
    stop = i * subscribers
    start = stop - (subscribers - 1)
    range = start:stop
    # add plot
    scatter!(ax1,
        df_sort.x[range], df_sort.y[range], color = df_sort.colors[range],
        markersize = 10
    )
end

################################################################################
# Thank you, Subscribers!!!
################################################################################