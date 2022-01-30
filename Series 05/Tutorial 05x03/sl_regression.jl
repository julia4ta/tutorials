################################################################################
# ML > SL > Classification > Logistic Regression
################################################################################

using Plots

gr(size = (600, 600))

# plot logistic (sigmoid) curve

logistic(x) = 1 / (1 + exp(-x))

# plot logistic function

p_logistic = plot(-6:0.1:6, logistic,
    xlabel = "Inputs (x)",
    ylabel = "Outputs (y)",
    title = "Logistic (Sigmoid) Curve",
    legend = false,
    color = :blue
)

# modify logistic curve

# initialize parameters

theta_0 = 0.0    # y-intercept (default = 0 | try 1 & -1)

theta_1 = 1.0    # slope (default = 1 | try 0.5 & -0.5)

# hypothesis function

z(x) = theta_0 .+ theta_1 * x

h(x) = 1 ./ (1 .+ exp.(-z(x)))

# re-plot

plot!(h, color = :red, linestyle = :dash)

# use CSV package to import data from CSV file

using CSV

data = CSV.File("wolfspider.csv")

X = data.feature

Y_temp = data.class

Y = []

for i in 1:length(Y_temp)
    if Y_temp[i] == "present"
        y = 1.0
    else
        y = 0.0
    end
    push!(Y, y)
end

# plot data

p_data = scatter(X, Y,
    xlabel = "Size of Grains of Sand (mm)",
    ylabel = 
        "Probability of Observation (Absent = 0 | Present = 1)",
    title = "Wolf Spider Presence Classifier",
    legend = false,
    color = :red,
    markersize = 5
)

################################################################################
# Logistic Regression Model
################################################################################

# initialize parameters

theta_0 = 0.0    # y-intercept (default = 0)

theta_1 = 1.0    # slope (default = 1)

# track parameter value history

t0_history = []

t1_history = []

push!(t0_history, theta_0)

push!(t1_history, theta_1)

# define hypothesis function

z(x) = theta_0 .+ theta_1 * x

h(x) = 1 ./ (1 .+ exp.(-z(x)))

# plot initial hypothesis

plot!(0:0.1:1.2, h, color = :green)

# use cost function from Andrew Ng

m = length(X)

y_hat = h(X)

function cost()
    (-1 / m) * sum(
        Y .* log.(y_hat) +
        (1 .- Y) .* log.(1 .- y_hat)
    )
end

J = cost()

# track cost value history

J_history = []

push!(J_history, J)

# define batch gradient descent algorithm

# use partial derivative formulae from Andrew Ng

function pd_theta_0()
    sum(y_hat - Y)
end

function pd_theta_1()
    sum((y_hat - Y) .* X)
end

# set learning rate (alpha)

alpha = 0.01

# initialize epochs

epochs = 0

################################################################################
# begin iterations (repeat until convergence)
################################################################################

for i in 1:1000

    # calculate partial derivatives

    theta_0_temp = pd_theta_0()

    theta_1_temp = pd_theta_1()

    # adjust parameters by the learning rate

    theta_0 -= alpha * theta_0_temp

    theta_1 -= alpha * theta_1_temp

    push!(t0_history, theta_0)

    push!(t1_history, theta_1)

    # recalculate cost

    y_hat = h(X)

    J = cost()

    push!(J_history, J)

    # replot prediction

    epochs += 1

    plot!(0:0.1:1.2, h, color = :blue, alpha = 0.025,
        title = 
            "Wolf Spider Presence Classifier (epochs = $epochs)"
    )

end

p_data

################################################################################
# end iterations
################################################################################

# plot learning curve

p_l_curve = plot(0:epochs, J_history,
    xlabel = "Epochs",
    ylabel = "Cost",
    title = "Learning Curve",
    legend = false,
    color = :blue,
    linewidth = 2
)

# plot parameters

p_params = scatter(t1_history, t0_history,
    xlabel = "theta_1",
    ylabel = "theta_0",
    title = "Gradient Descent Path",
    legend = false,
    color = :blue,
    alpha = 0.05
)

# make predictions

newX = [0.25, 0.5, 0.75, 1.0]

h(newX)
