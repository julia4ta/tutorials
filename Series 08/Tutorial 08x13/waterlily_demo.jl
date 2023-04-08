# WaterLily.jl Demonstration

# Source: https://github.com/weymouth/WaterLily.jl/blob/master/examples/ThreeD_TaylorGreenVortex.jl

# load packages

using WaterLily

include("RecordVolume.jl")

# define simulation function

function TGV(p = 6, Re = 100_000)
    # define vortex size, velocity, viscosity
    L = 2^p
    U = 1
    ν = U * L / Re # \nu not v
    # Taylor-Green Vortex initial velocity field
    function uλ(i, vx)
        # scaled coordinates
        x, y, z = @. (vx - 1.5) * pi / L
        # u_x
        i == 1 && return -U * sin(x) * cos(y) * cos(z)
        # u_y
        i == 2 && return  U * cos(x) * sin(y) * cos(z)
        # u_z
        return 0.0
    end
    # initialize simulation
    return Simulation(
        (L + 2, L + 2, L + 2), zeros(3), L;
        U, uλ, ν # \nu not v
    )
end

# define data function

function omega_mag_data(sim)
    # plot the vorticity modulus
    # \sigma not o; \omega not w
    @inside sim.flow.σ[I] = 
        WaterLily.ω_mag(I, sim.flow.u) * sim.L / sim.U
    return @view sim.flow.σ[2:end-1, 2:end-1, 2:end-1]
end

# generate animation

sim, fig = record_volume(TGV(), omega_mag_data;
    name = "TGV.mp4",
    duration = 20,
    step = 0.025
)
