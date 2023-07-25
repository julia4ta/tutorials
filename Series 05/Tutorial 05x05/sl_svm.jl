# 2023-07-25 Note: the LIBSVM.jl package is no longer being maintain.









################################################################################
# ML > SL > Classification > Support-Vector Machine
################################################################################

# load packages

using LIBSVM, RDatasets

using LinearAlgebra, Random, Statistics

# load data

iris = dataset("datasets", "iris")

vscodedisplay(iris)

X = Matrix(iris[:, 1:4])

y = iris.Species

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

# split data between train and test

Random.seed!(1)

train_index = perclass_splits(y, 0.67)

test_index = setdiff(1:length(y), train_index)

################################################################################
# Support-Vector Machine
################################################################################

Xtrain = X[train_index, :]

Xtest = X[test_index, :]

ytrain = y[train_index]

ytest = y[test_index]

# transpose data

Xtrain_t = Xtrain'

Xtest_t = Xtest'

# run model

model = svmtrain(Xtrain_t, ytrain)

y_hat, decision_values = svmpredict(model, Xtest_t)

# check accuracy

accuracy = mean(y_hat .== ytest)

# display results

check = [y_hat[i] == ytest[i] for i in 1:length(y_hat)]

check_display = [y_hat ytest check]

vscodedisplay(check_display)

################################################################################
# Feature Scaling
################################################################################

# split features into separate vectors

f1 = iris.SepalLength
f2 = iris.SepalWidth
f3 = iris.PetalLength
f4 = iris.PetalWidth

# rescaling (min-max normalization)

f1_min = minimum(f1)
f2_min = minimum(f2)
f3_min = minimum(f3)
f4_min = minimum(f4)

f1_max = maximum(f1)
f2_max = maximum(f2)
f3_max = maximum(f3)
f4_max = maximum(f4)

f1_n = (f1 .- f1_min) ./ (f1_max - f1_min)
f2_n = (f2 .- f2_min) ./ (f2_max - f2_min)
f3_n = (f3 .- f3_min) ./ (f3_max - f3_min)
f4_n = (f4 .- f4_min) ./ (f4_max - f4_min)

X = [f1_n f2_n f3_n f4_n]

vscodedisplay(X)

# standardization (z-score normalization)

f1_bar = mean(f1)
f2_bar = mean(f2)
f3_bar = mean(f3)
f4_bar = mean(f4)

f1_std = std(f1)
f2_std = std(f2)
f3_std = std(f3)
f4_std = std(f4)

f1_s = (f1 .- f1_bar) ./ f1_std
f2_s = (f2 .- f2_bar) ./ f2_std
f3_s = (f3 .- f3_bar) ./ f3_std
f4_s = (f4 .- f4_bar) ./ f4_std

X = [f1_s f2_s f3_s f4_s]

vscodedisplay(X)
