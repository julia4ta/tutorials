########################################
# Use Broadcasting + 32-bit Numbers
########################################

# define variables

const n::Int32 = 100_000_000

const a::Float32 = 2.718

using Random

Random.seed!(1)

x = rand(Float32, n)

y = rand(Float32, n)

# 1st time will compile functions and macros

@time z = a .* x .+ y

# 2nd time

@time z = a .* x .+ y

# 3rd time

@time z = a .* x .+ y
