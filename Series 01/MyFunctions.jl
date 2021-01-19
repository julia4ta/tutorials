# These are my favorite functions.

function mymult(x, y)
    x * y
end

function myforloop(start, stop; step = 1)
    for i in start:step:stop
        println(i)
    end
end

function addtable(row, column)
    A = fill(0, (row, column))
    for i in 1:row
        for j in 1:column
            A[i, j] = i + j
        end
    end
    return A
end
