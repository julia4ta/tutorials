# hello world
println("Hello, World!")

# comment (ctrl+/)
# this is a comment
#=
    this is a
    multiline comment
=#

# ctrl+l to clear repl

# arithmetic
1 + 1
2 - 1
2 * 3
4 / 2
5 / 2
2^3
5 % 2
1 + (2 * 3)^4 * 5

# boolean
3 < 2
3 >= 3
4 == 2 * 2
2 * 2 != 4
true && false
true || false
false + true

# variable
x = 1
y = 2
z = x + y
x
y
z
x = 2
x
y
z
z = x + y
z

const d = 4
# d = 40 will result in error

#variable part 2
i = 1
i = i + 1
i += 1
# i++ does not work in Julia

height = 2
width = 3
area = height * width

# number
typeof(-3)
typeof(1.2)
0.1 + 0.2
typeof(pi)
1000000 == 1_000_000
sqrt(4)
round(3.14149, digits = 2)

# = variable assignment operator
# == equality test
# === identity test
123 == "123"
123 === "123"
# 123 + "123" does not work in Julia
# 123 - "123" does not work in Julia

# string part 1
typeof('a')
typeof("a")
# typeof('Hello') does not work in Julia
typeof("Hello")
println("""This is "great".""")
println("1\n2\n3")
println("1\t2\t3")

# string part 2
s1 = "Hello,"
s2 = "World!"
s1_s2_concat = s1 * " " * s2
s3 = "Dabbling"
println("My name is $s3 Doggo.")

# string part 3
number123 = 123
string123 = "123"
number_to_string = string(number123)
string_to_number = parse(Int64, string123)

# dictionary part 1
dog = Dict(
    "name" => "eggdog",
    "age" => 2,
    "breed" => "egg-dog mix"
)
dog["name"]

# dictionary part 2
dog["name"] = "Doggo"
dog["email"] = "doggo@doggo.doggo"
dog
pop!(dog, "email")
dog

# struct
mutable struct Dog
    name::String
    age::Integer
    breed::String
end
dog1 = Dog("eggdog", 2, "egg-dog mix")
dog1.name
dog1.name = "Doggo"
# dog1.email = "doggo@doggo.doggo" does not work in Julia

# array part 1
scalar = [1]
vector = [1, 2, 3]
vector[2]
vector[3] * 4
length(vector)

# array part 2
sum(vector)

# array part 3
sort(vector, rev = true)
vector
sort!(vector, rev = true)
vector

# array part 4
push!(vector, 4)
pop!(vector)
vector
matrix = [1 2 3; 4 5 6]

# control flow (conditional)
x = 1
y = 2
if x > y
    println("$x is greater than $y")
elseif x < y
    println("$x is less than $y")
else
    println("$x is equal to $y")
end

x, y = y, x
if x > y
    println("$x is greater than $y")
elseif x < y
    println("$x is less than $y")
else
    println("$x is equal to $y")
end

x = y
if x > y
    println("$x is greater than $y")
elseif x < y
    println("$x is less than $y")
else
    println("$x is equal to $y")
end

# control flow (ternary)
x = 1
y = 2
x > y ? println("$x > $y") : println("$x <= $y")

x, y = y, x
x > y ? println("$x > $y") : println("$x <= $y")

x = y
x > y ? println("$x > $y") : println("$x <= $y")

# control flow (while loop)
i = 1
while i <= 10
    println(i)
    i += 1
end
# use ctrl+c to abort infinite loop

# control flow (for loop)
for i in 1:10
    println(i)
end

# control flow (for/in loop over dictionary)
dog = Dict(
    "name" => "eggdog",
    "age" => 2,
    "breed" => "egg-dog mix"
)
for (key, value) in dog
    println("key = $key\tvalue = $value")
end

# control flow (for/in loop over array)
array = [10, 20, 30]
for i in array
    println(i)
end

# control flow (array/list comprehension)
[i for i in 1:10]

# control flow (for/in loop over string)
s = "Hello, World!"
for i in s
    println(i)
end

# function
function myadd(x, y)
    x + y
end
myadd(2, 3)

# anonymous function
staff = [
    "Dabbling",
    "Dodgy",
    "Dapper"
]
map(length, staff)
map(x -> x * " Doggo", staff)
