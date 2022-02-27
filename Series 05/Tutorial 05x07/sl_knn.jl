################################################################################
# ML > Supervised Learning > k-Nearest Neighbors
################################################################################

################################################################################
# Part 1: Concepts
################################################################################

# load packages

using NearestNeighbors, Plots

using Random

# initialize plot

gr(size = (600, 600))

# generate random points for reference

Random.seed!(1)

f1_train = rand(100)

f2_train = rand(100)

p_knn = scatter(f1_train, f2_train,
    xlabel = "Feature 1",
    ylabel = "Feature 2",
    title = "k-NN & k-D Tree Demo",
    legend = false,
    color = :blue
)

# build tree

X_train = [f1_train f2_train]

X_train_t = permutedims(X_train)

kdtree = KDTree(X_train_t)

# initialize k for k-NN

k = 11

# generate random point for testing

f1_test = rand()

f2_test = rand()

X_test = [f1_test, f2_test]

# add test point to plot

scatter!([f1_test], [f2_test],
    color = :red, markersize = 10
)

# find nearest neighbors using k-NN & k-d tree

index_knn, distances = knn(kdtree, X_test, k, true)

# display output

output = [index_knn distances]

vscodedisplay(output)

# plot nearest neighbors

f1_knn = [f1_train[i] for i in index_knn]

f2_knn = [f2_train[i] for i in index_knn]

scatter!(f1_knn, f2_knn,
    color = :yellow, markersize = 10, alpha = 0.5
)

# connect test point with nearest neighbors

for i in 1:k
    plot!([f1_test, f1_knn[i]], [f2_test, f2_knn[i]],
        color = :green
    )
end

p_knn

# save plot

savefig(p_knn, "knn_concept_plot.svg")

################################################################################
# Part 2: Application
################################################################################

# load packages

using RDatasets, StatsBase

using Statistics

# load data

iris = dataset("datasets", "iris")

X = Matrix(iris[:, 1:4])

y = Vector{String}(iris.Species)

# define function to split data (source: Huda Nassar)

function perclass_splits(y, percent)
    uniq_class = unique(y)
    keep_index = []
    for class in uniq_class
        class_index = findall(y .== class)
        row_index = randsubseq(class_index, percent)
        push!(keep_index, row_index...)
    end
    return keep_index
end

# identify index numbers for training and testing

Random.seed!(1)

index_train = perclass_splits(y, 0.67)

index_test = setdiff(1:length(y), index_train)

# split data between training and testing

X_train = X[index_train, :]

X_test = X[index_test, :]

y_train = y[index_train]

y_test = y[index_test]

# transpose data

X_train_t = permutedims(X_train)

X_test_t = permutedims(X_test)

# build tree

kdtree = KDTree(X_train_t)

# run model

k = 5

index_knn, distances = knn(kdtree, X_test_t, k, true)

# display output

output = [index_test index_knn distances]

vscodedisplay(output)

# post-processing

index_knn_matrix = hcat(index_knn...)

index_knn_matrix_t = permutedims(index_knn_matrix)

vscodedisplay(index_knn_matrix_t)

knn_classes = y_train[index_knn_matrix_t]

vscodedisplay(knn_classes)

# use StatsBase to make predictions

y_hat = [
    argmax(countmap(knn_classes[i, :]))
    for i in 1:length(y_test)
]

# demonstrate countmap() and argmax()

demo = knn_classes[53, :]

countmap_demo = countmap(demo)

argmax(countmap_demo)

maximum(countmap_demo)

# check accuracy

accuracy = mean(y_hat .== y_test)

# display results

check = [y_hat[i] == y_test[i] for i in 1:length(y_hat)]

check_display = [y_hat y_test check]

vscodedisplay(check_display)
