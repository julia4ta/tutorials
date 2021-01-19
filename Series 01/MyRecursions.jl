# Example 1 Multiplication

function mult_i(x, y)
    # initialize variables
    result = 0
    # iterative algorithm
    for i in 1:y
        result += x
        println("$i\t$x * $i\t= $result")
    end
    # display and return final result
    println("\n$x * $y = $result\n")
    return result
end

function mult_r(x, y)
    if y == 1
        # base case
        println("mult_r($x, $y)\t= $x\n")
        return x
    else
        # recursive case
        println("mult_r($x, $y)\t= $x + mult_r($x, $(y - 1))")
        return x + mult_r(x, y - 1)
    end
end

# Example 2 Factorial

function fact_i(x)
    # initialize variable
    result = 1
    # iterative algorithm
    for i in 1:x
        result *= i
        println("$i factorial = $result")
    end
    # display and return final result
    println("\nThe Factorial of $x is $result\n")
    return result
end

function fact_r(x)
    if x == 1
        # base case
        println("fact_r($x) = $x\n")
        return 1
    else
        # recursive case
        println("fact_r($x) = $x * fact_r($(x - 1))")
        return x * fact_r(x - 1)
    end
end

# Example 3 Fibonacci Number

function fib_i(x)
    # initialize variables
    f1, f2 = (0, 1)
    println("\nF_0 = 0")
    # iterative algorithm
    for i in 1:x
        f1, f2 = (f2, f1 + f2)
        println("F_$i = $f1")
    end
    # display and return final result
    println("\nF sub $x is $f1\n")
    return f1
end

function fib_r(x)
    if x < 2
        # base case
        println("B_$x = $x")
        return x
    else
        # recursive case
        println("F_$x = F_$(x - 1) + F_$(x - 2)")
        fib_r(x - 1) + fib_r(x - 2)
    end
end

function fib_m(x, d)
    if x in keys(d)
        # base case
        println("B_$x = $(d[x])")
        return d[x]
    else
        # recursive case
        println("F_$x = F_$(x - 1) + F_$(x - 2)")
        d[x] = fib_m(x - 1, d) + fib_m(x - 2, d)
    end
end

function fib_memoization(x)
    # initialize Dictionary
    d = Dict(0 => 0, 1 => 1)
    # call fib_m() function
    fib_m(x, d)
end

# Example 4 Tower of Hanoi

function towers(disks, from, to, spare)
    if disks == 1
        # base case
        println("Move disk from $from to $to")
    else
        # recursive case
        towers(disks - 1, from, spare, to)
        towers(1, from, to, spare)
        towers(disks - 1, spare, to, from)
    end
end
