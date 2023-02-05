########################################
# Single-Process vs. Multi-Process
########################################

using Distributed

addprocs(10)

########################################
# Expectation
########################################

# Single-Process

@time for i in 2:nprocs()
    sleep(1)
end

# Multi-Process

@time @sync for i in 2:nprocs()
    @spawnat i sleep(1)
end

########################################
# Reality
########################################

# Single-Process

@time for i in 2:nprocs()
    println("Hello, World!")
end

# Multi-Process

@time @sync for i in 2:nprocs()
    @spawnat i println("Hello, World!")
end
