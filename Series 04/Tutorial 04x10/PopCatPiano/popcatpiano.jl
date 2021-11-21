# initialize screen

WIDTH = 600
HEIGHT = 600

# define initial state of actor

popcat = Actor("01-closed")

# draw actor

function draw(g::Game)
    draw(popcat)
end

# define functions to switch images

closed() = popcat.image = "01-closed"
open() = popcat.image = "02-open"

# define sound files

piano_key = [
    "01-c",
    "02-c-sharp",
    "03-d",
    "04-d-sharp",
    "05-e",
    "06-f",
    "07-f-sharp",
    "08-g",
    "09-g-sharp",
    "10-a",
    "11-a-sharp",
    "12-b",
    "13-c",
    "14-c-sharp",
    "15-d",
    "16-d-sharp",
    "17-e"
]

# define keyboard characters

keyboard_key = [
    "Z", "S", "X", "D", "C", "V", "G", "B", "H", "N", "J", "M",
    "COMMA", "L", "PERIOD", "SEMICOLON", "SLASH"
]

# define keyboard inputs

function on_key_down(g::Game, k)
    kstring = string(k)
    if kstring in keyboard_key
        index = findfirst(x -> x == kstring, keyboard_key)
        play_sound(piano_key[index])
        open()
        schedule_once(closed, 0.2)
    end
end
