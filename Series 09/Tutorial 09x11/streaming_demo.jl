########################################
# RxInfer.jl with Streaming Data
########################################

#=

# Bagaev, Dmitry. Presentation Video. "ReactiveMP.jl tutorial: Scalable variational Bayesian inference by reactive message passing". 2021.
https://youtu.be/YwjddthBKnM

# RxInfer.jl Documentation.
https://biaslab.github.io/RxInfer.jl/stable/

# Bagaev et al. "Reactive Message Passing for Scalable Bayesian Inference". Scientific Programming. 2023.
https://www.hindawi.com/journals/sp/2023/6601690/

=#

########################################
# Packages
########################################

# load packages

using RxInfer, StatsPlots

using Printf, Random; Random.seed!(8)

########################################
# Data
########################################

# generate stream of random data

true_success_rate = 0.75

distribution = Bernoulli(true_success_rate)

datastream = timer(500, 500) |>
    map(Bool,
        x -> rand(distribution)) |>
    tap(x -> @printf "%5s" x
)

actor = data -> update!(y, data)

########################################
# Model
########################################

# define model

@model function mymodel()
    # prior
    a = datavar(Float64)
    b = datavar(Float64)
    p ~ Beta(a, b)
    # likelihood
    y = datavar(Bool)
    y ~ Bernoulli(p)
    # return
    return a, b, p, y
end

# access variables from model

model, (a, b, p, y) = create_model(
    mymodel()
)

########################################
# Subscribe to Updated Posteriors
########################################

# define convenience functions

function display_toss(m, m_a, m_b)
    counter = m_a + m_b - 2
    print(" | ");  @printf "%05i" counter
    print(" | ");  @printf "%.3f" mean(m)
    print(" | ");  @printf "%.3f" std(m)
    print(" | ");  @printf "%05i" m_a
    print(" | ");  @printf "%05i" m_b
    println()
end

function save_posterior(p, post_vector)
    p_buffer = buffer(Marginal, 1)
    subscribe!(getmarginals([p]) |>
        take(1), p_buffer
    )
    getvalues(p_buffer)
    posterior = p_buffer[1].data
    push!(post_vector, posterior)
end

# subscribe to updated posteriors

p_subscription = subscribe!(
    getmarginal(p), m -> begin
        m_a, m_b = params(m)
        update!(a, m_a)
        update!(b, m_b)
        # display results
        display_toss(m, m_a, m_b)
        # save marginal to vector
        save_posterior(p, post_vector)
    end
)

########################################
# Subscribe to Data Stream
########################################

# initialize variables

post_vector = Beta{Float64}[]

update!(a, 1.0)

update!(b, 1.0)

# !!! subscribe to data stream !!!

data_subscription = subscribe!(
    datastream, actor
)

########################################
# Unsubscribe
########################################

unsubscribe!(data_subscription)

unsubscribe!(p_subscription)

########################################
# Visualization
########################################

# define animation recipe

n = length(post_vector)

animation = @animate for i in 1:n
    plot(post_vector[i];
        label = "",
        xlims = (0, 1), ylims = (0, 10),
        title = "Posterior After $i Tosses",
        fill = true, alpha = 0.3, color = 3
    )
    vline!([true_success_rate];
        label = "True Success Rate",
        color = 1, linestyle = :dash
    )
end

# create animation

gif(animation, "posterior.gif", fps = 6)
