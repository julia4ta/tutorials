################################################################################
# Non-Machine Learning Approach
################################################################################

# packages

using CSV, GLM, Plots, TypedTables

# use CSV package to import data from CSV file

data = CSV.File("housingdata.csv")

X = data.size

Y = round.(Int, data.price / 1000)

t = Table(X = X, Y = Y)

# use Plots package to generate scatter plot of data

gr(size = (600, 600))

# create scatter plot

p_scatter = scatter(X, Y,
    xlims = (0, 5000),
    ylims = (0, 800),
    xlabel = "Size (sqft)",
    ylabel = "Price (in thousands of dollars)",
    title = "Housing Prices in Portland",
    legend = false,
    color = :red
)

# use GLM package for Linear Regression model

ols = lm(@formula(Y ~ X), t)

# add linear regression line to plot

plot!(X, predict(ols), color = :green, linewidth = 3)

# predict price based on a new value for size

newX = Table(X = [1250])

predict(ols, newX)

################################################################################
# Machine Learning Approach
################################################################################

epochs = 0

# use Plots package to generate scatter plot of data

gr(size = (600, 600))

# create scatter plot

p_scatter = scatter(X, Y,
    xlims = (0, 5000),
    ylims = (0, 800),
    xlabel = "Size (sqft)",
    ylabel = "Price (in thousands of dollars)",
    title = "Housing Prices in Portland (epochs = $epochs)",
    legend = false,
    color = :red
)

# initialize parameters

theta_0 = 0.0    # y-intercept

theta_1 = 0.0    # slope

# define linear regression model

h(x) = theta_0 .+ theta_1 * x

# add linear regression line to plot

plot!(X, h(X), color = :blue, linewidth = 3)

# use cost function from Andrew Ng

m = length(X)

y_hat = h(X)

function cost(X, Y)
    (1 / (2 * m)) * sum((y_hat - Y).^2)
end

J = cost(X, Y)

# push cost value into vector

J_history = []

push!(J_history, J)

# define batch gradient descent algorithm

# use partial derivative formulae from Andrew Ng

function pd_theta_0(X, Y)
    (1 / m) * sum(y_hat - Y)
end

function pd_theta_1(X, Y)
    (1 / m) * sum((y_hat - Y) .* X)
end

# set learning rates (alpha)

alpha_0 = 0.09

alpha_1 = 0.00000008

################################################################################
# begin iterations (repeat until convergence)
################################################################################

# calculate partial derivatives

theta_0_temp = pd_theta_0(X, Y)

theta_1_temp = pd_theta_1(X, Y)

# adjust parameters by the learning rate

theta_0 -= alpha_0 * theta_0_temp

theta_1 -= alpha_1 * theta_1_temp

# recalculate cost

y_hat = h(X)

J = cost(X, Y)

push!(J_history, J)

# replot prediction

epochs += 1

plot!(X, y_hat, color = :blue, alpha = 0.5,
    title = "Housing Prices in Portland (epochs = $epochs)"
)

################################################################################
# end iterations
################################################################################

# measure performance

plot!(X, predict(ols), color = :green, linewidth = 3)

# plot learning curve

gr(size = (600, 600))

p_line = plot(0:epochs, J_history,
    xlabel = "Epochs",
    ylabel = "Cost",
    title = "Learning Curve",
    legend = false,
    color = :blue,
    linewidth = 2
)

# predict price based on a new value for size

newX_ml = [1250]

h(newX_ml)

# check ml prediction against non-ml prediction (GLM)

predict(ols, newX)
