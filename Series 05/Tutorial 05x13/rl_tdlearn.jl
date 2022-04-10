################################################################################
# ML > Reinforcement Learning > SARSA and Q-learning Algorithms
################################################################################

# load packages

using POMDPs, POMDPModelTools, QuickPOMDPs

# load solvers

using DiscreteValueIteration, TabularTDLearning

# load policy

using POMDPPolicies

# load standard library

using Random

# define State data type

struct State
    x::Int
end

# define Action data type (@enum from Julia Base.Enums)

@enum Action LEFT RIGHT

# define state space

null = State(-1)

S = [[State(x) for x = 1:7]..., null]

# define action space

A = [LEFT, RIGHT]

# define transition function

const MOVEMENTS = Dict(
    LEFT => State(-1),
    RIGHT => State(1)
)

Base.:+(s1::State, s2::State) = State(s1.x + s2.x)

function T(s::State, a::Action)
    # Deterministic() from POMDPModelTools.jl
    if R(s) != 0
        return Deterministic(null)
    end

    # initialize variables (index 1 is current state)
    len_a = length(A)
    next_states = Vector{State}(undef, len_a + 1)
    probabilities = zeros(len_a + 1)

    # enumerate() from Julia Base.Iterators
    for (index, a_prime) in enumerate(A)
        prob = (a_prime == a) ? 0.8 : 0.2
        dest = s + MOVEMENTS[a_prime]
        next_states[index + 1] = dest

        if 1 <= dest.x <= 7
            probabilities[index + 1] += prob
        end
    end

    # handle out-of-bounds transitions
    next_states[1] = s
    probabilities[1] = 1 - sum(probabilities)

    # SparseCat from POMDPModelTools.jl
    return SparseCat(next_states, probabilities)
end

# define reward function

function R(s, a = missing)
    if s == State(1)
        return -1
    elseif s == State(7)
        return 1
    end
    return 0
end

# set discount factor

gamma = 0.95

# prep mdp

termination(s::State) = s == null

abstract type GridWorld <: MDP{State, Action} end

################################################################################
# Value Iteration Algorithm
################################################################################

# define mdp using QuickPOMDPs.jl

mdp = QuickMDP(GridWorld,
    states = S,
    actions = A,
    transition = T,
    reward = R,
    discount = gamma,
    isterminal = termination
)

# select solver from DiscreteValueIteration.jl

solver = ValueIterationSolver(max_iterations = 30)

# solve mdp

policy = solve(solver, mdp)

################################################################################
# SARSA Algorithm
################################################################################

# define mdp using QuickPOMDPs.jl

s_mdp = QuickMDP(GridWorld,
    states = S,
    actions = A,
    transition = T,
    reward = R,
    discount = gamma,
    initialstate = S, # new line
    isterminal = termination
)

# select solver from TabularTDLearning.jl
# select policy from POMDPPolicies.jl

Random.seed!(1)

s_alpha = 0.9

# try 1, 10, 15

s_n_episodes = 15

s_solver = SARSASolver(
    n_episodes = s_n_episodes,
    learning_rate = s_alpha,
    exploration_policy = EpsGreedyPolicy(s_mdp, 0.5),
    verbose = false
)

# solve mdp

s_policy = solve(s_solver, s_mdp)

################################################################################
# Q-learning Algorithm
################################################################################

# define mdp using QuickPOMDPs.jl

q_mdp = QuickMDP(GridWorld,
    states = S,
    actions = A,
    transition = T,
    reward = R,
    discount = gamma,
    initialstate = S, # new line
    isterminal = termination
)

# select solver from TabularTDLearning.jl
# select policy from POMDPPolicies.jl

Random.seed!(1)

q_alpha = 0.9

# try 1, 10, 15, 20

q_n_episodes = 20

q_solver = QLearningSolver(
    n_episodes = q_n_episodes,
    learning_rate = q_alpha,
    exploration_policy = EpsGreedyPolicy(q_mdp, 0.5),
    verbose = false
)

# solve mdp

q_policy = solve(q_solver, q_mdp)
