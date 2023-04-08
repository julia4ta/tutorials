#=
    Note: set number of threads and
    restart vs code (if necessary)
=#

# Define Function to Record Simulation

# Source: https://github.com/weymouth/WaterLily.jl/blob/master/examples/ThreeD_Plots.jl

using GLMakie

function record_volume(sim, data_func;
        name = "file.mp4",
        duration = 1,
        step = 0.1
    )
    # set up visualization data and figure
    data = Observable(data_func(sim))
    set_theme!(
        theme_dark(),
        resolution = (1080, 1080)
    )
    fig = volume(
        data,
        colorrange = (pi, 3pi),
        algorithm = :absorption
    )
    # run simulation and update figure data
    t0 = round(sim_time(sim))
    t = range(t0, t0 + duration; step)
    record(fig, name, t) do ti
        sim_step!(sim, ti)
        data[] = data_func(sim)
        println(
            "simulation ",
            round(Int, (ti - t0) / duration * 100),
            "% complete"
        )
    end
    return sim, fig
end
