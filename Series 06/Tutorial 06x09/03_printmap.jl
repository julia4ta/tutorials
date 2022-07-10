##################################################
# Example: Printing a Map
##################################################

# assign variable names

filename = "PrintMap.cxx"

lib = "libPrintMap"

func = :printmap

# write c++ code

using CxxCall

eval(cxxsetup())

# add header(s)

eval(cxxnewfile(filename,
    """
    #include <iostream>
    #include <map>
    using namespace std;
    """
))

# add function declaration(s) & definition(s)

@cxx lib function $func()::Cvoid
    """
    map<string, string> dog =
    {
        {"name", "eggdog"},
        {"age", "2"},
        {"breed", "egg-dog mix"}
    };

    for (auto const& [key, val] : dog)
    {
        cout << key << ":\t" << val << endl;
    }
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

printmap()
