# Weighted Graphs

# Load Packages

using Graphs, SimpleWeightedGraphs, GraphRecipes, Plots

# Set Random Seed

using Random; Random.seed!(1)

# Define Sources and Destinations

sources =       [1, 1, 2, 2, 3, 4, 4, 5, 5, 6, 7, 8]
destinations =  [2, 4, 3, 5, 6, 5, 7, 6, 8, 9, 8, 9]

# Generate Random Weights

weights = round.(rand(length(sources)), digits = 2)

# Construct Weighted Graph

g = SimpleWeightedGraph(sources, destinations, weights)

# Define Edge Labels

function makelabels(sources, destinations, weights)
    edgelabels = Dict()
    for i in 1:length(sources)
        edgelabels[(sources[i], destinations[i])] = weights[i]
    end
    return edgelabels
end

edgelabels = makelabels(sources, destinations, weights)

# Create Plotting Recipes

nodefillcolor = fill(:lightgray, length(sources))

function viewgraph(g, nodefillcolor, edgelabels)
    graphplot(g,
        # nodes
        names = 1:nv(g),
        fontsize = 10,
        nodeshape = :circle,
        markersize = 0.25,
        markerstrokewidth = 2,
        markercolor = nodefillcolor,
        # edges
        edgelabel = edgelabels,
        linewidth = 2,
        curves = false
    )
end

# View Initial Graph

viewgraph(g, nodefillcolor, edgelabels)

# Find Shortest, Weighted Path from Node 1 to Node 9

path = enumerate_paths(dijkstra_shortest_paths(g, 1), 9)

# View Graph Showing Shortest Path

nodefillcolor = [
    node in path ? :red : :lightgray for node in 1:nv(g)
]

viewgraph(g, nodefillcolor, edgelabels)

# Create Simulation Model

function run_simulation()
    # Define Sources and Destinations
    sources =       [1, 1, 2, 2, 3, 4, 4, 5, 5, 6, 7, 8]
    destinations =  [2, 4, 3, 5, 6, 5, 7, 6, 8, 9, 8, 9]
    # Generate Random Weights
    weights = round.(rand(length(sources)), digits = 2)
    # Construct Weighted Graph
    g = SimpleWeightedGraph(sources, destinations, weights)
    # Define Edge Labels
    edgelabels = makelabels(sources, destinations, weights)
    # Find Shortest, Weighted Path from Node 1 to Node 9
    path = enumerate_paths(dijkstra_shortest_paths(g, 1), 9)
    @show path
    # View Graph Showing Shortest Path
    nodefillcolor = [
        node in path ? :red : :lightgray for node in 1:nv(g)
    ]
    viewgraph(g, nodefillcolor, edgelabels)
end

run_simulation()
