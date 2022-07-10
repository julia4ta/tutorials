##################################################
# Example: Function Overloading
##################################################

# assign variable names

filename = "MyAdd.cxx"

lib = "libMyAdd"

func = :myadd

# write c++ code

using CxxCall

eval(cxxsetup())

# add header(s)

eval(cxxnewfile(filename,
    """
    #include <iostream>
    using namespace std;
    """
))

# add function declaration(s) & definition(s)

@cxx lib function $func(x::Cint, y::Cint)::Cint
    """
    return x + y;
    """
end

@cxx lib function $func(x::Cdouble, y::Cdouble)::Cdouble
    """
    return x + y;
    """
end

# create cxx file

cxx_write_code!()

# create shared library (windows)

run(`g++ -fpic -shared $filename -o $lib.dll`)

# use julia's dynamic link standard library

using Libdl

# create pointer to shared library

dlopen(lib)

# test c++ function(s) in julia

myadd(2, 3)

myadd(Cint(2), Cint(3))

myadd(Cdouble(0.1), Cdouble(0.2))
