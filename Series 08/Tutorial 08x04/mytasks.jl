########################################
# Multi-Processing Demo
########################################

# add workers

using Distributed
addprocs(4)
w = workers()

# generate random data

using SharedArrays
n = 1_000
data = SharedMatrix(rand(n, n))
x = data[:, 1]
y = data[:, 2]

# load module

@everywhere include("MyFunctions.jl")
using .MyFunctions

# load package

@everywhere import Pkg
@everywhere Pkg.activate(".")
@everywhere using Plots

# launch tasks

t1 = @spawnat w[1] MyFunctions.task1(data)
t2 = @spawnat w[2] MyFunctions.task2(data)
t3 = @spawnat w[3] MyFunctions.task3(data)

t4 = @spawnat w[4] scatter(
    (x, y),
    legend = false,
    aspect_ratio = 1
)

# fetch results

fetch(t1)
fetch(t2)
fetch(t3)
fetch(t4)
