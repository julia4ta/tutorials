##################################################
# Template: How to Embed C++ Code in Julia
##################################################

# assign variable names

filename = "Hello.cxx"

lib = "libHello"

func = :hello

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

@cxx lib function $func(s::Cstring)::Cvoid
    """
    cout << "Hello, " << s << "!" << endl;
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

hello("World")

hello("Julia & C++")
