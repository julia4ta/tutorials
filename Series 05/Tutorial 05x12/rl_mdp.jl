################################################################################
# ML > Reinforcement Learning > Markov Decision Process (MDP)
################################################################################

# load packages

using POMDPs, POMDPModelTools, QuickPOMDPs

# load solver

using DiscreteValueIteration

# define State data type

struct State
    x::Int
    y::Int
end

# define Action data type (@enum from Julia Base.Enums)

@enum Action UP DOWN LEFT RIGHT

Action

# define state space

null = State(-1, -1)

S = [
    [State(x, y) for x = 1:4, y = 1:3]..., null
]

# define action space

A = [UP, DOWN, LEFT, RIGHT]

# define transition function

const MOVEMENTS = Dict(
    UP => State(0, 1),
    DOWN => State(0, -1),
    LEFT => State(-1, 0),
    RIGHT => State(1, 0)
)

Base.:+(s1::State, s2::State) = State(
    s1.x + s2.x, s1.y + s2.y
)

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
        prob = (a_prime == a) ? 0.7 : 0.1
        dest = s + MOVEMENTS[a_prime]
        next_states[index + 1] = dest

        if dest.x == 2 && dest.y == 2
            probabilities[index + 1] = 0
        elseif 1 <= dest.x <= 4 && 1 <= dest.y <= 3
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
    if s == State(4, 2)
        return -100
    elseif s == State(4, 3)
        return 10
    end
    return 0
end

# set discount factor

gamma = 0.95

# define mdp using QuickPOMDPs.jl

termination(s::State) = s == null

abstract type GridWorld <: MDP{State, Action} end

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

# view values (utility)

value_view = [S policy.util]
