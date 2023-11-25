# plots demo

using Plots

# line plot

f(x) = x^3 - 2x

plot(f)

plot(f;
    legend = false,
    linewidth = 5,
    color = :red,
    lims = (-2, 2),
    aspect_ratio = 1
)

# scatter plot

using Random

Random.seed!(1)

xs = randn(1_000)

ys = randn(1_000)

scatter(xs, ys;
    legend = false,
    alpha = 0.5,
    aspect_ratio = 1
)
