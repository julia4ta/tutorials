# basics

versioninfo()

Threads.nthreads()

Threads.threadid()

# single-threaded

for i in 1:Threads.nthreads()
    println("i: ", i, "\t Thread ID: ", Threads.threadid())
end

# multi-threaded

Threads.@threads for i in 1:Threads.nthreads()
    println("i: ", i, "\t Thread ID: ", Threads.threadid())
end
