########################################
# Bayesian Differential Equations
########################################

#=

References:

# Turing.jl Tutorials. "Bayesian Estimation of Differential Equations."
https://turinglang.org/dev/tutorials/10-bayesian-differential-equations/

# SciML. DiffEqBayes.jl Documentation. "Bayesian Inference of ODE."
https://docs.sciml.ai/DiffEqBayes/stable/examples/

# doggo dot jl. "[07x08] Solve System of Differential Equations in Julia using DifferentialEquations.jl and Pluto". 2022. (YouTube)
https://youtu.be/BhVaXgSs944

=#

# load packages

using CSV, OrdinaryDiffEq, StatsPlots, Turing

using Random; Random.seed!(2)

# download data

url = "https://raw.githubusercontent.com/julia4ta/tutorials/master/Series%2009/Files/baboons_cheetahs.csv"

data = CSV.File(download(url);
    header = false
) |> CSV.Tables.matrix

# visualize data

ts = 0:0.1:10

p_data = plot(ts, data',
	linewidth = 2, linestyle = :dot,
	title = "Bayesian Differential Equations",
	xaxis = "t",
	yaxis = "Population",
	labels = ["Rabbits" "Foxes"],
	formatter = :plain,
	widen = true,
	xlims = (0.0, 10.0), ylims = (0.0, 10.0),
	xticks = collect(0:10),	yticks = collect(0:10)
)

########################################
# OrdinaryDiffEq.jl
########################################

# define differential equations

function lotka_volterra(du, u, p, t)
	x, y = u
	alpha, beta, delta, gamma = p
	du[1] = dx = alpha * x - beta * x * y
	du[2] = dy = delta * x * y - gamma * y
end

# assign variables

# u: populations

# x_begin: initial population of rabbits

x_begin = data[1, 1]

# y_begin: initial population of foxes

y_begin = data[2, 1]

# u_begin: initial population

u_begin = [x_begin, y_begin]

# p:parameters

# alpha: rabbit population growth rate

alpha = 1.0

# beta: rabbit decline rate

beta = 1.0

# delta: fox population growth rate

delta = 1.0

# gamma: fox population decline rate

gamma = 1.0

# parameters vector

p = [alpha, beta, delta, gamma]

# t: time

t_begin = 0.0

t_end = 10.0

tspan = (t_begin, t_end)

# define system of first order ODEs problem

prob = ODEProblem(lotka_volterra, u_begin, tspan, p)

########################################
# Turing.jl
########################################

# define model

@model function mymodel(data, prob)
	# prior
	alpha ~ truncated(Normal(1.5, 1); lower = 0, upper = 5)
	beta ~ truncated(Normal(1.5, 1); lower = 0, upper = 5)
	delta ~ truncated(Normal(1.5, 1); lower = 0, upper = 5)
	gamma ~ truncated(Normal(1.5, 1); lower = 0, upper = 5)
	sigma ~ Uniform(0, 1)
	# likelihood
	p = [alpha, beta, delta, gamma]
	sol = solve(prob, Tsit5(); p = p, saveat = 0.1)
	for i in 1:length(sol)
		data[:, i] ~ MvNormal(sol[i], sigma)
	end
end

# infer posterior probability

model = mymodel(data, prob)

sampler = NUTS()

samples = 1_000

chain = sample(model, sampler, samples)

# visualize results

plot(chain)

########################################
# Retrodiction
########################################

# sample from posterior distributions

posterior_samples = sample(
	chain[[:alpha, :beta, :delta, :gamma]], 300;
	replace = false
)

# visualize posterior samples

plot(posterior_samples)

for i in eachrow(Array(posterior_samples))
	sol_samples = solve(prob, Tsit5();
		p = i, saveat = 0.1
	)
	plot!(p_data, sol_samples;
		label = "",
		color = [1 2],
		alpha = 0.05
	)
end

p_data
