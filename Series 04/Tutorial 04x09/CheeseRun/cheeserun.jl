# initialize screen

WIDTH = 600
HEIGHT = 600
BACKGROUND = colorant"antiquewhite"

# define game state

game_ongoing = true

# define initial state of actors

cheese = Rect(450, 60, 100, 100)
wall1 = Rect(200, 200, 400, 25)
wall2 = Rect(0, 375, 400, 25)
mouse = Circle(100, 500, 50)
score = 1000

# draw actors

function draw(g::Game)
    draw(cheese, colorant"yellow", fill = true)
    draw(wall1, colorant"red", fill = true)
    draw(wall2, colorant"red", fill = true)
    draw(mouse, colorant"blue", fill = true)
    if collide(mouse, cheese)
        txt = TextActor("You Win! Your Score = $score", "comicbd";
            font_size = 36, color = Int[0, 128, 0, 255]
        )
        txt.pos = (10, 5)
        draw(txt)
    else
        txt = TextActor("Score = $score", "comicbd";
            font_size = 36, color = Int[0, 0, 0, 255]
        )
        txt.pos = (10, 5)
        draw(txt)
    end
end

# define keyboard inputs

function on_key_down(g::Game)
    if collide(mouse, cheese)
        global game_ongoing = false
    elseif g.keyboard.UP
        collide(mouse, wall1) || collide(mouse, wall2) ?
            mouse.y = mouse.y + 10 : mouse.top != 0 ?
                mouse.y -= 10 : mouse.y = mouse.y
        global score -= 1
    elseif g.keyboard.DOWN
        collide(mouse, wall1) || collide(mouse, wall2) ?
            mouse.y = mouse.y - 10 : mouse.bottom != 600 ?
                mouse.y += 10 : mouse.y = mouse.y
        global score -= 1
    elseif g.keyboard.LEFT
        collide(mouse, wall1) || collide(mouse, wall2) ?
            mouse.x = mouse.x + 10 : mouse.left != 0 ?
                mouse.x -= 10 : mouse.x = mouse.x
        global score -= 1
    elseif g.keyboard.RIGHT
        collide(mouse, wall1) || collide(mouse, wall2) ?
            mouse.x = mouse.x - 10 : mouse.right != 600 ?
                mouse.x += 10 : mouse.x = mouse.x
        global score -= 1
    end
end
