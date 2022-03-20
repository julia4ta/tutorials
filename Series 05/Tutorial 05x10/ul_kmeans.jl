################################################################################
# ML > Unsupervised Learning > k-means Clustering
################################################################################

################################################################################
# Part 1: Concepts
################################################################################

# load packages

using Clustering, Plots

using Random

# initialize plot

gr(size = (600, 600))

# generate random points

Random.seed!(1)

f1 = rand(100)

f2 = rand(100)

# plot data

p_rand = scatter(f1, f2,
    xlabel = "Feature 1",
    ylabel = "Feature 2",
    title = "Random Data",
    legend = false
)

# pre-process data

X = [f1 f2]'

# initialize variables

k = 5

itr = 100

# cluster data using k-means clustering algorithm

Random.seed!(1)

result = kmeans(X, k; maxiter = itr, display = :iter)

a = assignments(result)

c = counts(result)

mu = result.centers

# plot results

p_kmeans_demo = scatter(f1, f2,
    xlabel = "Feature 1",
    ylabel = "Feature 2",
    title = "k-means Clustering Demo",
    legend = false,
    group = a,
    markersize = 10,
    alpha = 0.7
)

# plot centroids

scatter!(mu[1, :], mu[2, :],
    color = :yellow,
    markersize = 20,
    alpha = 0.7
)

# save plot

savefig(p_kmeans_demo, "kmeans_concept_plot.svg")

################################################################################
# Part 2: Application
################################################################################

# load package

using RDatasets

# load data

cats = dataset("boot", "catsM")

# view data

vscodedisplay(cats)

# plot data

p_cats = scatter(cats.BWt, cats.HWt,
    xlabel = "Body Weight (kg)",
    ylabel = "Heart Weight (g)",
    title = "Weight Data for Domestic Cats (raw data)",
    legend = false
)

# scale features (min-max normalization)

f1 = cats.BWt
f2 = cats.HWt

f1_min = minimum(f1)
f2_min = minimum(f2)

f1_max = maximum(f1)
f2_max = maximum(f2)

f1_n = (f1 .- f1_min) ./ (f1_max - f1_min)
f2_n = (f2 .- f2_min) ./ (f2_max - f2_min)

X = [f1_n f2_n]'

# plot normalized data

p_cats = scatter(f1_n, f2_n,
    xlabel = "Body Weight",
    ylabel = "Heart Weight",
    title = "Weight Data for Domestic Cats (normalized)",
    legend = false
)

# initialize variables

k = 3

itr = 4

# cluster data using k-means clustering algorithm

Random.seed!(1)

result = kmeans(X, k; maxiter = itr, display = :iter)

a = assignments(result)

c = counts(result)

mu = result.centers

# plot results

p_cats_n = scatter(f1_n, f2_n,
    xlabel = "Body Weight",
    ylabel = "Heart Weight",
    title = "Weight Data for Domestic Cats (iter = $itr)",
    legend = false,
    group = a,
    markersize = 10,
    alpha = 0.7
)

# plot centroids

scatter!(mu[1, :], mu[2, :],
    color = :yellow,
    markersize = 20,
    alpha = 0.7
)

# save plot

savefig(p_cats_n, "kmeans_cats_plot.svg")
