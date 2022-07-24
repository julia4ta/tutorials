##################################################
# Load Packages and Define Constants
##################################################

using BenchmarkTools, CUDA

# define constants

const dim = 100_000_000

const a = 3.1416

# times from last tutorial (in ms)

cpu_time = 54.232

broadcast_time = 2.931

##################################################
# SAXPY (CUDA Kernel)
##################################################

# create vectors on GPU

x = CUDA.ones(Float32, dim)

y = CUDA.ones(Float32, dim)

z = CUDA.zeros(Float32, dim)

# calculate threads/block and blocks/grid

nthreads = CUDA.attribute(
    device(),
    CUDA.DEVICE_ATTRIBUTE_MAX_THREADS_PER_BLOCK
)

nblocks = cld(dim, nthreads)

# define CUDA Kernel

function saxpy_gpu_kernel!(z, a, x, y)
    # calculate index number
    i = (blockIdx().x - 1) * blockDim().x + threadIdx().x
    # calculate SAXPY
    if i <= length(z)
        # eliminate array bounds check
        @inbounds z[i] = a * x[i] + y[i]
    end
    return nothing
end

# launch CUDA Kernel

@btime CUDA.@sync @cuda(
    threads = nthreads,
    blocks = nblocks,
    saxpy_gpu_kernel!(z, a, x, y)
)

# record CUDA Kernel time

kernel_time = 2.796

# check z

z

# compare performance

kernel_v_cpu = cpu_time / kernel_time

kernel_v_broadcast = broadcast_time / kernel_time

##################################################
# SAXPY (CUDA Library)
##################################################

using CUDA.CUBLAS

CUBLAS.axpy!(dim, a, x, y)

# check y

y

# call CUDA Library function

y = CUDA.ones(Float32, dim)

@btime CUDA.@sync CUBLAS.axpy!(dim, a, x, y)

# record CUDA Library time

library_time = 2.308

# check y

y

# compare performance

library_v_cpu = cpu_time / library_time

library_v_broadcast = broadcast_time / library_time

library_v_kernel = kernel_time / library_time
