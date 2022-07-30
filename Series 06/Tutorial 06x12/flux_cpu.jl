##################################################
# Artificial Neural Network (on CPU)
##################################################

# load packages

using Flux, MLDatasets

using Flux: crossentropy, flatten, onehotbatch, params, train!

using Random

# set random seed

Random.seed!(1)

# load data (on CPU)

X_train_raw, y_train_raw = MLDatasets.MNIST(:train)[:]

X_test_raw, y_test_raw = MLDatasets.MNIST(:test)[:]

typeof(X_train_raw)

# flatten input data

X_train = flatten(X_train_raw)

X_test = flatten(X_test_raw)

# one-hot encode labels

y_train = onehotbatch(y_train_raw, 0:9)

y_test = onehotbatch(y_test_raw, 0:9)

# define model architecture (on CPU)

model = Chain(
    Dense(28 * 28, 32, relu),
    Dense(32, 10),
    softmax
)

typeof(model)

# define loss function

loss(x, y) = crossentropy(model(x), y)

# track parameters

ps = params(model)

# select optimizer (Float32)

learning_rate = Float32(0.01)

opt = ADAM(learning_rate)

# train model

epochs = 500

@time for epoch in 1:epochs
    train!(loss, ps, [(X_train, y_train)], opt)
end

# cpu time in seconds

cpu_elapsed_time = 91.983028

cpu_compile_time = cpu_elapsed_time * 17.61 / 100

cpu_run_time = cpu_elapsed_time - cpu_compile_time
