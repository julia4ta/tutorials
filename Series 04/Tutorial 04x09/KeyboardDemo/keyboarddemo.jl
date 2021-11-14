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
end

# define keyboard inputs (version 1)

# function on_key_down(g::Game)
#     if g.keyboard.UP
#         mouse.y -= 1
#     elseif g.keyboard.DOWN
#         mouse.y += 1
#     elseif g.keyboard.LEFT
#         mouse.x -= 1
#     elseif g.keyboard.RIGHT
#         mouse.x += 1
#     end
# end

# define keyboard inputs (version 2)

# function on_key_down(g::Game)
#     if g.keyboard.UP
#         mouse.y -= 10
#     elseif g.keyboard.DOWN
#         mouse.y += 10
#     elseif g.keyboard.LEFT
#         mouse.x -= 10
#     elseif g.keyboard.RIGHT
#         mouse.x += 10
#     end
# end

# define keyboard inputs (version 3)

function on_key_down(g::Game)
    if g.keyboard.UP
        mouse.top != 0 ? mouse.y -= 10 : mouse.y = mouse.y
    elseif g.keyboard.DOWN
        mouse.bottom != 600 ? mouse.y += 10 : mouse.y = mouse.y
    elseif g.keyboard.LEFT
        mouse.left != 0 ? mouse.x -= 10 : mouse.x = mouse.x
    elseif g.keyboard.RIGHT
        mouse.right != 600 ? mouse.x += 10 : mouse.x = mouse.x
    end
end
