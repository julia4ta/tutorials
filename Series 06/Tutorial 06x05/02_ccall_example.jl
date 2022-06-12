##################################################
# option 1: using ccall() function
##################################################

# use Dynamic Linker standard library

using Libdl

# create library pointer

lib = dlopen("libexample")

# create function pointer

func = dlsym(lib, "myswitch")

# create wrapper

function compass(direction)
    ccall(func, Cvoid, (Cint,), direction)
end

# test function in julia

compass(1)
compass(2)
compass(3)
compass(4)
compass(5)

# exit Julia REPL (ctrl+d or exit())

##################################################
# option 2: using @ccall macro
##################################################

# use Dynamic Linker standard library

using Libdl

# create library pointer

lib = dlopen("libexample")

# create function pointer

func = dlsym(lib, "myswitch")

# create wrapper

function compass(direction)
    # ccall(func, Cvoid, (Cint,), direction)
    @ccall $func(direction::Cint,)::Cvoid
end

# test function in julia

compass(1)
compass(2)
compass(3)
compass(4)
compass(5)
