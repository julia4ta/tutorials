# Guess-and-Check Algorithm

function cbrtguessandcheck(x)
    # initialize variable
    counter = 1
    # algorithm
    for guess in 0:abs(x)
        if guess^3 > abs(x)
            println("\n$x is not a perfect cube. Sorry.")
            break
        end
        if guess^3 != abs(x)
            println(counter, "\tGuess = $guess\tGuess Cubed = $(guess^3)")
            counter += 1
        else
            # display result
            if x < 0
                guess = -guess
            end
            println(counter, "\tGuess = $guess\tGuess Cubed = $(guess^3)")
            println("\nThe cube root of $x is $guess.")
            break
        end
    end
end

# Approximate Solutions Algorithm

function cbrtapproxsolutions(x)
    # initialize variables
    guess = 0.0
    counter = 1
    increment = 0.01
    sensitivity = 0.1
    # algorithm
    while abs(guess^3 - x) >= sensitivity && abs(guess^3) <= abs(x)
        println(counter, "\tGuess = $guess\tGuess Cubed = $(guess^3)")
        guess += increment
        counter += 1
    end
    # display result
    println(counter, "\tGuess = $guess\tGuess Cubed = $(guess^3)")
    guess = round(guess, digits = 2)
    x < 0 ? guess = -guess : guess = guess
    println("\nThe cube root of $x is approximately $guess.")
end

# Binary Search Algorithm

function cbrtbinarysearch(x)
    # initialize variables
    low = 0
    high = x
    guess = (low + high) / 2
    counter = 1
    sensitivity = 0.01
    # algorithm
    while abs(guess^3 - x) >= sensitivity
        println(counter, "\tGuess = $guess\tGuess Cubed = $(guess^3)")
        if abs(guess^3) < abs(x)
            low = guess
        else
            high = guess
        end
        guess = (low + high) / 2
        counter += 1
    end
    # display result
    println(counter, "\tGuess = $guess\tGuess Cubed = $(guess^3)")
    guess = round(guess, digits = 3)
    println("\nThe cube root of $x is $guess.")
end
