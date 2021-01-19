# Linear Search Algorithm

function linearsearch(haystack, needle)
    flag = false
    for i in 1:length(haystack)
        check = haystack[i] == needle
        if check
            flag = true
        end
        println("Index[$i] = $(haystack[i]) == $needle? ", check)
    end
    if flag
        println("\n$needle is in the collection.\n")
    else
        println("\n$needle is not in the collection.\n")
    end
    return flag
end

# Binary Search Algorithm -- Guessing Game

"""
    guessinggame()
Use the Binary Search Algorithm to guess a user's whole
number between 1 and 100 based on the user's feedback.

After the guess is displayed, the user enters l, h or c
for lower, higher or correct.

Repeat this process until the correct number is guessed.
Credit: Rosetta Code (rosettacode.org), with some modifications.
"""
function guessinggame()
    # initialize variables
    lower = 0
    upper = 100
    attempts = 1
    println("\nThink of a number between 1 and 100")
    println("and I will guess it within 7 guesses.")
    println("Press ENTER when you are ready.")
    readline()
    # algorithm
    while true
        guess = lower + round(Int, (upper - lower) / 2, RoundUp)
        if attempts > 7
            break
        end
        print("I guess ", guess, ".\n[l]ower, [h]igher or [c]orrect? ")
        input = readline()
        while input ∉ ["l", "h", "c"]
            print("Please enter [l], [h] or [c]: ")
            input = readline()
        end
        if input == "l"
            upper = guess
        elseif input == "h"
            lower = guess
        else
            break
        end
        attempts += 1
    end
    # display result
    if attempts > 7
        println("\nI give up. Did you forget your number?")
    elseif attempts == 1
        println("\nI win! It only took me 1 guess!")
    else
        println("\nI win! It took me $attempts guesses.")
    end
end
