########################################
# Write Naive Code
########################################

# define variables

n = 100_000_000

a = 2.718

using Random

Random.seed!(1)

x = rand(n)

y = rand(n)

z = []

# 1st time will compile functions and macros

@time for i in 1:n
    temp = a * x[i] + y[i]
    push!(z, temp)
end

z

# 2nd time

z = []

@time for i in 1:n
    temp = a * x[i] + y[i]
    push!(z, temp)
end

z

# 3rd time

z = []

@time for i in 1:n
    temp = a * x[i] + y[i]
    push!(z, temp)
end
