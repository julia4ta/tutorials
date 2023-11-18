# function overloading

function mytypeof(x::Int64)
    return "Int64"
end

function mytypeof(x::Number)
    return "Number"
end

function mytypeof(x::Any)
    return "not defined yet"
end

# multiple dispatch

function mygenericfunction(x)
    println("$x is type: ",
        mytypeof(x)
    )
end

mygenericfunction(1)

mygenericfunction(π)

mygenericfunction([1, 2, 3])

# new data type & new method

struct Dog
    name::String
end

function mytypeof(x::Dog)
    return "Dog"
end

mydog = Dog("eggdog")

mygenericfunction(mydog)

# methods()

methods(mytypeof)

methods(mygenericfunction)

methods(+)
