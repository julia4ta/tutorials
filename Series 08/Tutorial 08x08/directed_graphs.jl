# Directed Graphs

# Load Packages

using Graphs, GraphRecipes, Plots

# Method 1: Automatic

g1 = DiGraph(3, 2)

## Use GraphRecipes.jl to View Graph

edgelabels = Dict(
    (1, 3) => 1,
    (2, 3) => 2
)

function viewgraph(g)
    graphplot(g,
        # nodes
        names = 1:nv(g),
        fontsize = 10,
        nodeshape = :circle,
        markersize = 0.15,
        markerstrokewidth = 2,
        # edges
        edgelabel = edgelabels,
        linewidth = 2,
        curves = false
    )
end

p1 = viewgraph(g1)

# Method 2: Manual

g2 = DiGraph()

add_vertices!(g2, 3)

add_edge!(g2, 1, 3)

add_edge!(g2, 2, 3)

p2 = viewgraph(g2)

add_edge!(g2, 3, 2)

p2 = viewgraph(g2)

rem_edge!(g2, 3, 2)

p2 = viewgraph(g2)

# Save Graph

savegraph("directed_graph_g2.lgz", g2)

# Load Graph

g3 = loadgraph("directed_graph_g2.lgz")

# View Graph Loaded from Disk

p3 = viewgraph(g3)
