########################################
# Multi-Processing Cheatsheet
########################################

using Distributed

# how to add workers

addprocs(5)

# how to view processes and workers

nprocs()

procs()

workers()

# how to remove a worker

rmprocs(6)

# how to view processes and workers

nprocs()

procs()

workers()

# how to track workers (optional)

w = workers()

w[1]

# how to assign a task to a worker

ans1 = @spawnat w[1] rand(3, 4)

# how to fetch a result from a worker

fetch(ans1)

# how to assign a task to any available worker

ans2 = @spawnat :any sum(1:100)

fetch(ans2)

# how to combine @spawnat and fetch()

ans3 = @spawnat w[2] 3.14

fetch(ans3)

ans4 = @spawnat w[3] 1 + fetch(ans3)

fetch(ans4)

# how to add standard library to all workers

@everywhere using Statistics

ans5 = @spawnat w[4] mean(rand(100))

fetch(ans5)

# how to add standard library to a specific worker

@everywhere w[1] using LinearAlgebra

ans6 = @spawnat w[1] axpy!(fetch(ans3), ones(10), ones(10))

fetch(ans6)

ans7 = @spawnat w[2] axpy!(fetch(ans3), ones(10), ones(10))

fetch(ans7)

# how to use SharedArrays

using SharedArrays

data = SharedArray(rand(10))

# how to add external package to all workers

@everywhere import Pkg

@everywhere Pkg.activate(".")

@everywhere using Plots

ans8 = @spawnat w[3] plot(data)

fetch(ans8)

# how to add module to all workers

@everywhere include("ToyModule.jl")

using .ToyModule

ans9 = @spawnat w[4] ToyModule.myfunc()

fetch(ans9)
