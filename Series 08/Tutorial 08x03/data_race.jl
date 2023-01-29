########################################
# Data-Race example
########################################

n = 2_000_000_000

myvector = collect(1:n)

# single-threaded

sum(myvector)

# single-threaded

function multi_sum1(myvector)
    temp = 0
    for i in eachindex(myvector)
        temp += myvector[i]
    end
    return temp
end

multi_sum1(myvector)

# multi-threaded with data-race

function multi_sum2(myvector)
    temp = 0
    Threads.@threads for i in eachindex(myvector)
        temp += myvector[i]
    end
    return temp
end

multi_sum2(myvector)

# multi-threaded without data-race

function multi_sum3(myvector)
    temp = zeros(Int, Threads.nthreads())
    Threads.@threads for i in eachindex(myvector)
        temp[Threads.threadid()] += myvector[i]
    end
    # for i in eachindex(temp)
    #     println(i, "\t = ", temp[i])
    # end
    return sum(temp)
end

multi_sum3(myvector)

# time

@time multi_sum3(myvector)

@time sum(myvector)
