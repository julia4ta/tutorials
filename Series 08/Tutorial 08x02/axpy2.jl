########################################
# Wrap Code in Function
########################################

# define variables

n = 100_000_000

a = 2.718

using Random

Random.seed!(1)

x = rand(n)

y = rand(n)

# define function

function axpy(a, x, y)
    z = []
    for i in 1:length(x)
        temp = a * x[i] + y[i]
        push!(z, temp)
    end
    return z
end

# 1st time will compile functions and macros

@time axpy(a, x, y)

# 2nd time

@time axpy(a, x, y)

# 3rd time

@time axpy(a, x, y)
