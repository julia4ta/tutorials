# load standard library

using Printf

# basic syntax

text = "World!"

@printf "Hello, %s\n" text

# formatting examples (https://www.cplusplus.com/reference/cstdio/printf/)

# printf ("Characters: %c %c \n", 'a', 65);
@printf "Characters: %c %c \n" 'a' 65

# printf ("Decimals: %d %ld\n", 1977, 650000L);
# @printf "Decimals: %d %ld\n" 1977 650000L
@printf "Decimals: %d %ld\n" 1977 650000

# printf ("Preceding with blanks: %10d \n", 1977);
@printf "Preceding with blanks: %10d \n" 1977
@printf "Preceding with blanks: %-10d left\n" 1977

# printf ("Preceding with zeros: %010d \n", 1977);
@printf "Preceding with zeros: %010d \n" 1977

# printf ("Some different radices: %d %x %o %#x %#o \n", 100, 100, 100, 100, 100);
@printf "Some different radices: %d %x %o %#x %#o \n" 100 100 100 100 100

# printf ("floats: %4.2f %+.0e %E \n", 3.1416, 3.1416, 3.1416);
@printf "floats: %4.2f %+.0e %E \n" 3.1416 3.1416 3.1416

# printf ("Width trick: %*d \n", 5, 10);
# @printf "Width trick: %*d \n" 5 10
@printf "Width trick: %5d \n" 10

# printf ("%s \n", "A string");
@printf "%s \n" "A string"

# dollar sign 

@printf "\$100\n"

# wrap printf in function

v = [1.546, 2.6548, 27.5, 183.986, 0.5154]

function receipt(v::Vector)
    for i in v
        @printf "\$%8.2f\n" i
    end
    println("---------")
    @printf "\$%8.2f\n" sum(v)
    println("=========")
end

receipt(v)
