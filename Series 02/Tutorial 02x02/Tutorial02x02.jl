# Tutorial 02x02

# Julia Version 1.5.3

# Supply and Demand Example

# Supply Curve from Wikipedia

Q(P) = 3P - 6

P = 5
Q(P)

P = 10
Q(P)

# Demand Curve from Wikipedia

Q(P) = 32 - 2P

P = 5
Q(P)

P = 10
Q(P)

# Plot Supply and Demand Curves

# Supply Curve from Wikipedia

# Q_supply(P) = 3P - 6

P_supply(Q) = (Q + 6) / 3

# Demand Curve from Wikipedia

# Q_demand(P) = 32 - 2P

P_demand(Q) = (-Q + 32) / 2

# visualize curves

using CairoMakie    # v0.3.12

# initialize empty scene and layout

scene, layout = layoutscene(resolution = (325, 325))
scene

# add axis

ax = layout[1, 1] = Axis(scene,
    xlabel = "Quantity", xlabelsize = 10, xticklabelsize = 9, xticksize = 3,
    ylabel = "Price", ylabelsize = 10, yticklabelsize = 9, yticksize = 3,
    ytickformat = "\${:d}",
    title = "Supply and Demand", titlesize = 12
)
scene

# set x-axis range

Q_range = 1:25

# plot Supply Curve

lineobject1 = lines!(ax, Q_range, P_supply, linewidth = 1, color = :blue)
scene

# plot Demand Curve

lineobject2 = lines!(ax, Q_range, P_demand, linewidth = 1, color = :red)
scene

# add legend

leg = Legend(scene, [lineobject1, lineobject2],
    ["Supply", "Demand"], halign = :right, valign = :top,
    tellheight = false, tellwidth = false, margin = (10, 10, 10, 10),
    labelsize = 7, linewidth = 1, padding = (10, 10, 5, 5),
    patchsize = (20, 10)
)
layout[1, 1] = leg
scene

# reconfigure supply and demand curve formulae to match Ax = b format

# Supply Curve from Wikipedia

# Q_supply(P) = 3P - 6

# Q - 3P = -6

# Demand Curve from Wikipedia

# Q_demand(P) = 32 - 2P

# Q + 2P = 32

# initialize Ax = b

A = [1 -3; 1 2]
b = [-6, 32]

# solve for x

using LinearAlgebra     # included in Julia's standard library

e_Q, e_P = A \ b
println("Equilibrium Price:\t", e_P)
println("Equilibrium Quantity:\t", e_Q)

# plot equilibrium price and quantity

vlines!(ax, [e_Q], ymax = [0.411],
    linewidth = 1, linestyle = :dash, color = :green
)
hlines!(ax, [e_P], xmax = [0.645],
    linewidth = 1, linestyle = :dash, color = :green
)
scene

# save plot

save("supply-demand.svg", scene)

# exit REPL








# start REPL

# Mortgage Calculator Example

# payment function from Wikipedia

function pmt(r, N, P)
    c = r * P / (1 - (1 + r)^-N)
end

# initialize variables

r = 3.92 / 100/ 12  # convert % to decimal then convert annual to monthly
N = 30 * 12         # convert years to months
P = 100_000

# calculate payment

c = pmt(r, N, P)

# calculate total cost of mortgage

total = c * N

# mortgage table function

function pmt_table(APR, years, amount)
    # initialize variables
    r = APR / 100 / 12
    N = years * 12
    P = amount
    c = pmt(r, N, P)
    # initialize BASE
    B = P                   # Beginning balance
    A = r * B               # Add monthly interest charge
    S = c                   # Subtract monthly payment
    E = B + A - S           # Ending balance
    data = [B, A, S, E]
    # use for-loop to generate column vector
    for i in 1:(N - 1)
        B = E
        A = r * B
        S = c
        E = B + A - S
        push!(data, B, A, S, E)
    end
    # reshape column vector
    wide = reshape(data, 4, N)
    tall = transpose(wide)
    # convert tall table into Array
    tallarray = Array(tall)
    return tallarray
end

# initialize variables

APR = 3.92
years = 30
amount = 100_000

# generate mortgage table

data = pmt_table(APR, years, amount)

# display mortgage table

vscodedisplay(data)

# save as csv file

using DelimitedFiles    # included in Julia's standard library
writedlm("pmt_table.csv", data, ',')

# prep data for plotting

# assign columns to variables

interest = data[:, 2]
payment = data[:, 3]

# calculate principal payments (payment - interest)

p_pmt = payment - interest

# visualize data

using CairoMakie    # v0.3.12

# initialize empty scene and layout

scene, layout = layoutscene(resolution = (750, 325))
scene

# add first axis

ax1 = layout[1, 1] = Axis(scene,
    xlabel = "Months", xlabelsize = 10, xticklabelsize = 9, xticksize = 3,
    ylabel = "Dollars", ylabelsize = 10, yticklabelsize = 9, yticksize = 3,
    ytickformat = "\${:d}",
    title = "Monthly Payments", titlesize = 12
)
scene

# add line plots

lineobject1 = lines!(ax1, p_pmt, linewidth = 1, color = :blue)
lineobject2 = lines!(ax1, interest, linewidth = 1, color = :red)
lineobject3 = lines!(ax1, payment, linewidth = 1, color = :green)
scene

# add legend

leg1 = Legend(scene, [lineobject1, lineobject2, lineobject3],
    ["Principal", "Interest", "Total Pmt"], halign = :right, valign = :center,
    tellheight = false, tellwidth = false, margin = (10, 10, 10, 10),
    labelsize = 5, linewidth = 1, padding = (10, 10, 5, 5),
    patchsize = (15, 5)
)
layout[1, 1] = leg1
scene

# plot cumulative principal and interest payments

# calculate cumulative principal payments

function total_p_pmt(p_pmt)
    runningtotal = p_pmt[1]
    data = [runningtotal]
    for i in 2:length(p_pmt)
        runningtotal = runningtotal + p_pmt[i]
        push!(data, runningtotal)
    end
    return data
end

p_pmtsum = total_p_pmt(p_pmt)
vscodedisplay(p_pmtsum)

# calculate cumulative interest payments

function total_int(interest)
    runningtotal = interest[1]
    data = [runningtotal]
    for i in 2:length(interest)
        runningtotal = runningtotal + interest[i]
        push!(data, runningtotal)
    end
    return data
end

intsum = total_int(interest)
vscodedisplay(intsum)

# plot data

# add first axis

ax2 = layout[1, 2] = Axis(scene,
    xlabel = "Months", xlabelsize = 10, xticklabelsize = 9, xticksize = 3,
    yticklabelsize = 7, yticksize = 3,
    ytickformat = "\${:d}",
    title = "Cumulative Payments", titlesize = 12
)
scene

# add line plots

lineobject1 = lines!(ax2, p_pmtsum, linewidth = 1, color = :blue)
lineobject2 = lines!(ax2, intsum, linewidth = 1, color = :red)
scene

# add legend

leg2 = Legend(scene, [lineobject1, lineobject2],
    ["Principal", "Interest"], halign = :center, valign = :top,
    tellheight = false, tellwidth = false, margin = (10, 10, 10, 10),
    labelsize = 5, linewidth = 1, padding = (10, 10, 5, 5),
    patchsize = (15, 5)
)
layout[1, 2] = leg2
scene

# save plot

save("mortgage-calculator.svg", scene)
