# arrays

# construct column vector

col_vector = [1, 2, 3]

typeof(col_vector)

# construct row vector (matrix)

row_vector = Float32[4.0 5.0 6.0]

typeof(row_vector)

# access vector element

col_vector[2]

# mutate vector element

col_vector[2] = 20

col_vector

# find # of elements in a vector

length(col_vector)

# sum vector elements

sum(col_vector)

# sort vector elements
# (descending, nondestructive)

sort(col_vector; rev = true)

col_vector

# sort vector elements
# (descending, destructive)

sort!(col_vector; rev = true)

col_vector

# add new element to end of vector

push!(col_vector, 100)

# remove element from end of vector

pop!(col_vector)

col_vector

# construct a matrix
# with 2 rows and 3 columns

matrix = [1 3 5; 2 4 6]

typeof(matrix)

# access element in row 1 column 3

matrix[1, 3]

# access element using
# column-major order

matrix[5]

# construct array with elements
# of different data types

multi_types = [
    1, 1.0, 1//3, π,
    'a', "doggo", [7 8 9]
]

typeof(multi_types)
