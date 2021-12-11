# initialize screen

WIDTH = 600
HEIGHT = 720
BACKGROUND = colorant"antiquewhite"

header = 120

# define snake actor

snake_pos_x = WIDTH / 2
snake_pos_y = (HEIGHT - header) / 2 + header

snake_size = 20    # default = 20 | try 10, 30, 50

snake_color = colorant"green"

snake_head = Rect(
    snake_pos_x, snake_pos_y, snake_size, snake_size
)

# grow snake

snake_body = []

function grow()
    push!(snake_body,
        Rect(
            snake_head.x, snake_head.y, snake_size, snake_size
        )
    )
end

grow()

# define apple actor

function spawn()
    # all possible locations
    xrange = collect(0:snake_size:(WIDTH - snake_size))
    yrange = collect(header:snake_size:(HEIGHT - snake_size))
    x = rand(xrange)
    y = rand(yrange)
    # array of snake_body locations
    occupied = []
    for i in 1:length(snake_body)
        push!(occupied, (snake_body[i].x, snake_body[i].y))
    end
    # select spawning location
    if (x, y) in occupied
        spawn()
    else
        return x, y
    end
end

apple_pos_x, apple_pos_y = spawn()

apple_size = snake_size

apple_color = colorant"red"

apple = Rect(
    apple_pos_x, apple_pos_y, apple_size, apple_size
)

# define header box actor

headerbox = Rect(0, 0, WIDTH, header)

# initialize other game variables

score = 0

gameover = false

# draw actors

function draw(g::Game)
    # snake
    draw(snake_head, snake_color, fill = true)
    for i in 1:length(snake_body)
        draw(snake_body[i], snake_color, fill = true)
    end
    # apple
    draw(apple, apple_color, fill = true)
    # headerbox
    draw(headerbox, colorant"navyblue", fill = true)
    # display score
    if gameover == false
        display = "Score = $score"
    else
        display = "GAME OVER! Final Score = $score"
        # play again instructions
        replay = TextActor("Click to Play Again", "comicbd";
            font_size = 36, color = Int[0, 0, 0, 255]
        )
        replay.pos = (135, 390)
        draw(replay)
    end
    txt = TextActor(display, "comicbd";
        font_size = 36, color = Int[255, 255, 0, 255]
    )
    txt.pos = (30, 30)
    draw(txt)
end

# move snake

speed = snake_size

vx = speed
vy = 0

function move()
    snake_head.x += vx
    snake_head.y += vy
end

# set variables to regulate snake speed

delay = 0.2    # delay in seconds

delay_limit = 0.05

# define border function

function border()
    global gameover
    if snake_head.x == WIDTH ||
        snake_head.x < 0 ||
        snake_head.y == HEIGHT ||
        snake_head.y < header
            gameover = true
    end
end

# define collision functions

function collide_head_body()
    global gameover
    for i in 1:length(snake_body)
        if collide(snake_head, snake_body[i])
            gameover = true
        end
    end
end

function collide_head_apple()
    global delay
    if collide(snake_head, apple)
        # spawn new apple
        apple.x, apple.y = spawn()
        # grow snake body
        grow()
        # reduce delay
        if delay > delay_limit
            delay -= 0.01
        end
    end
end

# define update function

function update(g::Game)
    if gameover == false
        global snake_body, score
        move()
        border()
        collide_head_body()
        collide_head_apple()
        grow()
        popat!(snake_body, 1)
        score = length(snake_body) - 1
        sleep(delay)
    end
end

# define keyboard interaction

function direction(x, y)
    global vx, vy
    vx = x
    vy = y
end

right() = direction(speed, 0)
left() = direction(-speed, 0)
down() = direction(0, speed)
up() = direction(0, -speed)

function on_key_down(g::Game, k)
    if g.keyboard.RIGHT
        if vx !== -speed
            right()
        end
    elseif g.keyboard.LEFT
        if vx !== speed
            left()
        end
    elseif g.keyboard.DOWN
        if vy !== -speed
            down()
        end
    elseif g.keyboard.UP
        if vy !== speed
            up()
        end
    end
end

# define reset function

function reset()
    # reset all global variables

    global snake_head, snake_body
    snake_head = Rect(
        snake_pos_x, snake_pos_y, snake_size, snake_size
    )
    snake_body = []
    grow()

    global apple_pos_x, apple_pos_y, apple
    apple_pos_x, apple_pos_y = spawn()
    apple = Rect(
        apple_pos_x, apple_pos_y, apple_size, apple_size
    )

    global score, vx, vy, delay
    score = 0
    vx = speed
    vy = 0
    delay = 0.2

    global gameover
    gameover = false

end

# define mouse interaction

function on_mouse_down(g::Game)
    if gameover == true
        reset()
    end
end
