# initialize screen

WIDTH = 600
HEIGHT = 600
BACKGROUND = colorant"antiquewhite"

# define initial state of actors

hline = Line(0, 300, 600, 300)
vline = Line(300, 0, 300, 600)
mouse = Circle(300, 300, 50)

# draw actors

function draw(g::Game)
    draw(hline, colorant"black")
    draw(vline, colorant"black")
    draw(mouse, colorant"blue", fill = true)
    txt = TextActor("x = $(mouse.x) | y = $(mouse.y)", "comicbd";
        font_size = 36, color = Int[0, 0, 0, 255]
    )
    txt.pos = (10, 10)
    draw(txt)
end

# define mouse inputs

function on_mouse_move(g::Game, pos)
    mouse.x = pos[1]
    mouse.y = pos[2]
end
