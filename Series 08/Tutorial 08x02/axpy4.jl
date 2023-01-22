########################################
# Use Broadcasting
########################################

# define variables

n = 100_000_000

a = 2.718

using Random

Random.seed!(1)

x = rand(n)

y = rand(n)

# 1st time will compile functions and macros

@time z = a .* x .+ y

# 2nd time

@time z = a .* x .+ y

# 3rd time

@time z = a .* x .+ y
