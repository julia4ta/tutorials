################################################################################
# ML > Unsupervised Learning > Principal Component Analysis (PCA)
################################################################################

################################################################################
# Part 1: Concepts
################################################################################

# load packages

using MultivariateStats, Plots

using Random

# generate random data

Random.seed!(1)

f0 = collect(0.05:0.05:5)

f1 = f0 .+ rand(100)

f2 = f0 .+ rand(100)

# initialize plot

plotlyjs(size = (480, 480))

# plot random data

p_random = scatter(f1, f2,
    xlabel = "Feature 1",
    ylabel = "Feature 2",
    title = "Random Data",
    legend = false
)

# pre-process data

X = [f1 f2]'

# generate PCA model

model = fit(PCA, X; maxoutdim = 1)

# transform data

X_transform = transform(model, X)

# plot transform data

y = zeros(100)

p_transform = scatter(X_transform', y,
    xlabel = "PC1",
    title = "Random Data Transform",
    legend = false,
    color = :red,
    alpha = 0.5
)

# reconstruct data

X_reconstruct = reconstruct(model, X_transform)

# plot reconstruct data

scatter!(p_random,
    X_reconstruct[1, :], X_reconstruct[2, :],
    color = :red,
    alpha = 0.5
)

# save plot

savefig(p_random, "pca_concept_plot.svg")

################################################################################
# Part 2: Application
################################################################################

# load package

using RDatasets

# load data

iris = dataset("datasets", "iris")

# pre-process data

X = Matrix(iris[:, 1:4])'

y = Vector{String}(iris.Species)

species = reshape(unique(iris.Species), (1, 3))

# generate PCA model

model = fit(PCA, X; maxoutdim = 3)

# transform data

X_transform = transform(model, X)

PC1 = X_transform[1, :]

PC2 = X_transform[2, :]

PC3 = X_transform[3, :]

# initialize plot

plotlyjs(size = (640, 480))

# plot transform data

p_transform = scatter(PC1, PC2, PC3,
    xlabel = "PC1", ylabel = "PC2", zlabel = "PC3",
    title = "Iris Data Set PCA Transform",
    markersize = 2,
    group = y,
    label = species
)

# save plot

savefig(p_transform, "iris_PCA_plot.svg")
