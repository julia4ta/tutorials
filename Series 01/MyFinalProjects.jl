"""
    song(n::Integer)

Repeat lyrics to song starting at `n` and counting down to 1.
Credit: Rosetta Code
"""
function song(start::Integer)
    lines(i) = i == 0 ? "No more lines" : i == 1 ? "1 line" : "$i lines"
    for i in start:-1:1
        println("""
                    $(lines(i)) of Code on the Screen,
                    $(lines(i)) of Code...
                    \tControl the Flow,
                    \tDelete one Row,
                    $(lines(i - 1)) of Code on the Screen!!!
                """)
    end
end

"""
    nimgame()

Play nim game:
Game starts with 12 tokens.
User goes first.
Julia goes second.
Each player takes 1, 2 or 3 tokens, in turn.
The player who takes the last token is the winner.
Credit: Rosetta Code
"""
function nimgame()
    tokencount = 12
    takenum = 0
    while true
        while true
            permitted = collect(1:min(3, tokencount))
            println("\nOf the remaining $tokencount tokens,")
            print("how many do you take ($permitted)? ")
            takenum = parse(Int, readline())
            if takenum in permitted
                break
            end
        end
        tokencount -= 4
        println("\n  Julia takes $(4 - takenum),")
        println("  so there are $tokencount tokens left.")
        if tokencount < 1
            println("\nJulia always wins! (lol)")
            break
        end
    end
end

"""
    magic8ball()

Return response to user's yes or no question.
Repeat process as long as user continues to ask questions.
Exit if user enters a blank.
Credit: Rosetta Code
"""
function magic8ball()
    responses = [
                    "It is certain"
                    "It is decidely so"
                    "Without a doubt"
                    "Yes, definitely"
                    "You may rely on it"
                    "As I see it, yes"
                    "Most likely"
                    "Outlook good"
                    "Signs point to yes"
                    "Yes"
                    "Reply hazy, try again"
                    "Ask again later"
                    "Better not tell you now"
                    "Cannot predict now"
                    "Concentrate and ask again"
                    "Don't bet on it"
                    "My reply is no"
                    "My sources say no"
                    "Outlook not so good"
                    "Very doubtful"
    ]
    while true
        println("Ask a yes/no question (blank to exit):")
        if readline() == ""
            break
        end
        println("\n  ", rand(responses), "\n")
    end
end

"""
    randomwalker(n::Integer)

Return `x` and `y` coordinates of a random walk of `n` steps.
Both `x` and `y` are Arrays.
Walker starts at coordinate (0, 0) and takes 1 step randomly,
either left, right, forward or backwards.
Walker repeats this process `n` times.
The `x` and `y` coordinate of each step
is recorded in the Arrays `x` and `y`.
"""
function randomwalker(n::Integer)
    x = [0]
    y = [0]
    for i in 1:n
        step = rand((-1, 1))
        direction = rand(("x", "y"))
        if direction == "x"
            push!(x, x[i] + step)
            push!(y, y[i])
        else
            push!(x, x[i])
            push!(y, y[i] + step)
        end
    end
    return x, y
end

"""
    randomwalkerplots(walkers::Integer, steps::Integer)

Generate Plots based on the `x` and `y` Arrays
generated by the randomwalker() Function.
Different Plots in different colors
are generated for different Walkers
and displayed onto a single Plot.

#Examples
```jldoctest
julia>randomwalkerplots(1, 100)

julia>randomwalkerplots(3, 1000)
```

The 1st example will generate a Plot
for 1 Walker taking 100 random steps.
The 2nd example will generate a Plot
for 3 Walkers taking 1000 random steps each.
"""
function randomwalkerplots(walkers::Integer, steps::Integer)
    scene = Scene()
    for i in 1:walkers
        x, y = randomwalker(steps)
        lines!(x, y, linewidth = 5, color = (rand(RGBf0), 0.5))
    end
    scene
end
