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

# define keyboard inputs

function on_key_down(g::Game)
    if g.keyboard.Z
        open()
        play_sound("00-pop")
        schedule_once(closed, 0.2)
    end
end
