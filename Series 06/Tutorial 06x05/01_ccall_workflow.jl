##################################################
# option 1: using ccall() function
##################################################

# use Dynamic Linker standard library

using Libdl

# create library pointer

lib = dlopen("libworkflow")

# create function pointer

func = dlsym(lib, "myadd")

# initialize variables

x = y = 0

# create wrapper

function myadd(x, y)
    ccall(func, Cint, (Cint, Cint), x, y)
end

# test function in julia

myadd(2, 3)

myadd(-7, 4)

# should get error

myadd(0.1, 0.2)

# start new REPL session (ctrl+d or exit())

##################################################
# option 2: using @ccall macro
##################################################

# use Dynamic Linker standard library

using Libdl

# create library pointer

lib = dlopen("libworkflow")

# create function pointer

func = dlsym(lib, "myadd")

# initialize variables

x = y = 0

# create wrapper

function myadd(x, y)
    # ccall(func, Cint, (Cint, Cint), x, y)
    @ccall $func(x::Cint, y::Cint)::Cint
end

# test function in julia

myadd(2, 3)

myadd(-7, 4)

# should get error

myadd(0.1, 0.2)
