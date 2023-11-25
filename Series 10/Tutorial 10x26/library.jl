# example 1

rand(10)

# Random Numbers Library

using Random

Random.seed!(1)

rand(10)

# example 2

Random.seed!(42)

data = randn(1_000)

function average(x::Vector)
    sum(x) / length(x)
end

average(data)

# Statistics Library

using Statistics

mean(data)

median(data)

std(data)
