# Tutorial 02x10: GLMakie Interactive

# Julia v1.5.3

#=
    Package used in this tutorial:
        GLMakie v0.1.30
=#

# Makie.jl Citation: https://doi.org/10.5281/zenodo.4450294

################################################################################

################################################################################
# Observables
################################################################################

using GLMakie

################################################################################
# Sliders
################################################################################

# initialize plot

fig = Figure(resolution = (3840, 2160))

# add axis

ax1 = fig[1, 1] = Axis(fig,
    # borders
    aspect = 1, targetlimits = BBox(-10, 10, -10, 10),
    # title
    title = "Sliders Tutorial",
    titlegap = 48, titlesize = 60,
    # x-axis
    xautolimitmargin = (0, 0), xgridwidth = 2, xticklabelsize = 36,
    xticks = LinearTicks(20), xticksize = 18,
    # y-axis
    yautolimitmargin = (0, 0), ygridwidth = 2, yticklabelpad = 14,
    yticklabelsize = 36, yticks = LinearTicks(20), yticksize = 18
)

# darken axes

vlines!(ax1, [0], linewidth = 2)
hlines!(ax1, [0], linewidth = 2)

# create sliders

lsgrid = labelslidergrid!(fig,
    ["slope", "y-intercept"],
    Ref(LinRange(-10:0.01:10));
    formats = [x -> "$(round(x, digits = 2))"],
    labelkw = Dict([(:textsize, 30)]),
    sliderkw = Dict([(:linewidth, 24)]),
    valuekw = Dict([(:textsize, 30)])
)

# set starting position for slope

set_close_to!(lsgrid.sliders[1], 1.0)

# layout sliders

sl_sublayout = GridLayout(height = 150)
fig[2, 1] = sl_sublayout
fig[2, 1] = lsgrid.layout

# create listener

slope = lsgrid.sliders[1].value

intercept = lsgrid.sliders[2].value

x = -10:0.01:10

y = @lift($slope .* x .+ $intercept)

# add line plot

line1 = lines!(ax1, x, y, color = :blue, linewidth = 5)

# reset axes limits, if necessary

xlims!(ax1, -10, 10)
ylims!(ax1, -10, 10)

# add scatter plot

rx = -10:0.5:10
ry = rand(length(rx)) .+ -rx * 0.5 .+ 3
scatter1 = scatter!(ax1, rx, ry, color = :red, markersize = 15)

# reset axes limits, if necessary

xlims!(ax1, -10, 10)
ylims!(ax1, -10, 10)

# save plot

save("sliders.png", fig)

################################################################################
# Buttons
################################################################################

# initialize plot

fig = Figure(resolution = (3840, 2160))

# add axis

ax1 = fig[1, 1] = Axis(fig,
    # borders
    aspect = 1, targetlimits = BBox(-10, 10, -10, 10),
    # title
    title = "Buttons Tutorial",
    titlegap = 48, titlesize = 60,
    # x-axis
    xautolimitmargin = (0, 0), xgridwidth = 2, xticklabelsize = 36,
    xticks = LinearTicks(20), xticksize = 18,
    # y-axis
    yautolimitmargin = (0, 0), ygridwidth = 2, yticklabelpad = 14,
    yticklabelsize = 36, yticks = LinearTicks(20), yticksize = 18
)

# darken axes

vlines!(ax1, [0], linewidth = 2)
hlines!(ax1, [0], linewidth = 2)

# create button grid

fig[2, 1] = buttongrid = GridLayout(tellwidth = false)

labels = ["Red-8", "Magenta-12", "Green-18", "Cyan-24", "Blue-30"]

buttons = buttongrid[1, 1:5] = [
    Button(fig,
        label = l, height = 60, width = 250, textsize = 30
    )
    for l in labels
]

# layout buttons

bt_sublayout = GridLayout(height = 150)
fig[2, 1] = bt_sublayout

# create random data sets

x = -10:0.1:10

data = []

for i in 1:5
    d = rand(-10:0.1:10, length(x))
    push!(data, d)
end

y = Node(data[1])

# set up colors

colors = [:red, :magenta, :green, :cyan, :blue]

c = Node(colors[1])

# set up markersizes

markersizes = [8, 12, 18, 24, 30]

ms = Node(markersizes[1])

# add scatter plot

scat1 = scatter!(ax1, x, y, color = c, markersize = ms)

# reset axes limits, if necessary

xlims!(ax1, -10, 10)
ylims!(ax1, -10, 10)

# button instructions

for i in 1:5
    on(buttons[i].clicks) do click
        y[] = data[i]
        c[] = colors[i]
        ms[] = markersizes[i]
    end
end

# save plot

save("buttons.png", fig)

################################################################################
# Menus
################################################################################

# initialize plot

fig = Figure(resolution = (3840, 2160))

# add axis

ax1 = fig[1, 1] = Axis(fig,
    # borders
    aspect = 1, targetlimits = BBox(-10, 10, -10, 10),
    # title
    title = "Multiverse Tutorial",
    titlegap = 48, titlesize = 60,
    # x-axis
    xautolimitmargin = (0, 0), xgridwidth = 2, xticklabelsize = 36,
    xticks = LinearTicks(20), xticksize = 18,
    # y-axis
    yautolimitmargin = (0, 0), ygridwidth = 2, yticklabelpad = 14,
    yticklabelsize = 36, yticks = LinearTicks(20), yticksize = 18,
    # background color
    backgroundcolor = :black
)

# set up colors

colors = [:white, :red, :green, :blue, :cyan, :yellow, :magenta, :black]

# set up markersizes

markersizes = [6, 8, 10, 12, 14, 18, 24, 30, 36, 42, 60, 72, 84, 96]

# create menus

datamenu = Menu(fig, options = [1, 2, 3, 4, 5], textsize = 30)
colormenu = Menu(fig, options = colors, textsize = 30)
msmenu = Menu(fig, options = markersizes, textsize = 30)

# create menu grid

fig[1, 2] = vgrid!(
    Label(fig, "Universe:", textsize = 30, width = 400), datamenu,
    Label(fig, "Color:", textsize = 30, width = 400), colormenu,
    Label(fig, "Markersize:", textsize = 30, width = 400), msmenu;
    tellheight = false, width = 500
)

# initialize plotting variables

x = -10:0.1:10
y = Node(data[1])
c = Node(colors[1])
ms = Node(markersizes[1])

# add scatter plot

scat1 = scatter!(ax1, x, y, color = c, markersize = ms)

# reset axes limits, if necessary

xlims!(ax1, -10, 10)
ylims!(ax1, -10, 10)

# menu instructions

# for data

on(datamenu.selection) do select
    y[] = data[select]
end

# for color

on(colormenu.selection) do select
    c[] = select
end

# for markersize

on(msmenu.selection) do select
    ms[] = select
end

# save plot

save("menus.png", fig)
