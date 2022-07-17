##################################################
# Install CUDA
##################################################

using CUDA

CUDA.versioninfo()

##################################################
# Load Package and Define Constants
##################################################

using BenchmarkTools

# define constants

const dim = 100_000_000

const a = 3.1416

##################################################
# SAXPY (CPU)
##################################################

# create vectors on CPU

x = ones(Float32, dim)

y = ones(Float32, dim)

z = zeros(Float32, dim)

typeof(x)

# perform SAXPY on CPU

@btime z .= a .* x .+ y

# record CPU time

cpu_time = 54.232

##################################################
# SAXPY (GPU)
##################################################

# create vectors on GPU

x = CUDA.ones(Float32, dim)

y = CUDA.ones(Float32, dim)

z = CUDA.zeros(Float32, dim)

typeof(x)

# perform SAXPY on GPU

@btime CUDA.@sync z .= a .* x .+ y

# record GPU time

gpu_time = 2.931

# compare performance

performance = cpu_time / gpu_time
