# loop over array

myarray = [10, 20, 30]

for element in myarray
    println(element)
end

# loop over string

mystring = "Hello, World!"

for character in mystring
    println(character)
end

# loop over dictionary

mydog = Dict(
    :name => "eggdog",
    :age => 3,
    :breed => "egg-dog mix"
)

for (key, value) in mydog
    println("$key:\t$value")
end
