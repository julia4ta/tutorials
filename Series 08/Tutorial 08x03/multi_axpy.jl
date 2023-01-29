########################################
# Use Multi-Threading, 32-bit, in-place
########################################

# define variables

const n::Int32 = 100_000_000

const a::Float32 = 2.718

using Random

Random.seed!(1)

x = rand(Float32, n)

y = rand(Float32, n)

# define function

function multi_axpy!(a, x, y)
    Threads.@threads for i in eachindex(x)
        y[i] = a * x[i] + y[i]
        # @inbounds y[i] = a * x[i] + y[i]
    end
    return y
end

# 1st time will compile functions and macros

@time multi_axpy!(a, x, y)

# 2nd time

Random.seed!(1)

x = rand(Float32, n)

y = rand(Float32, n)

@time multi_axpy!(a, x, y)

# 3rd time

Random.seed!(1)

x = rand(Float32, n)

y = rand(Float32, n)

@time multi_axpy!(a, x, y)
