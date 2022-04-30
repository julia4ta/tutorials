################################################################################
# pi estimation without animation
################################################################################

# initialize plot

using GLMakie

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

y = [rand() * rand((-1, 1)) for _ in 1:n]

circle = [x[i]^2 + y[i]^2 <= 1 for i in 1:n]

circle_sum = Int64[]

push!(circle_sum, circle[1])

for i in 1:(n - 1)
    new_sum = circle_sum[i] + circle[i + 1]
    push!(circle_sum, new_sum)
end

circle_sum[end]

sum(circle)

pi_est = [4 * circle_sum[i] / i for i in 1:n]

pi_est[end]

(pi - pi_est[end]) / pi * 100

# prep for plotting

colors = Symbol[]

for i in 1:length(circle)
    circle[i] ? c = :green : c = :red
    push!(colors, c)
end

# prep for plotting

index = 1:n

# add plot for dartboard

scatter!(ax1,
    x, y, color = colors, markersize = 5
)

# add plot for pi estimate

scatter!(ax2,
    index, pi_est, color = :blue, markersize = 5
)
