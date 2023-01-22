# define function

function myfunc()
    A = rand(200, 200, 400)
    maximum(A)
end

# time function

@time myfunc()

@time myfunc()

@time myfunc()

########################################
# Profile using Julia Base
########################################

using Profile

@profile myfunc()

Profile.print()

########################################
# Profile using VS Code
########################################

@profview myfunc()

@profview_allocs myfunc() sample_rate = 1
