using Luxor

########################################
# Intro to Turtle Graphics
########################################

@draw begin
    t = Turtle()
    Message(t, "start")
end

typeof(t)

# how to draw a horizontal line to the right

@draw begin
    t = Turtle()
    Message(t, "start")
    Forward(t, 200)
    Message(t, "end")
end

# how to draw a horizontal line to the left (method 1)

@draw begin
    t = Turtle()
    Message(t, "start")
    Forward(t, -200)
    Message(t, "end")
end

# how to draw a horizontal line to the left (method 2)

@draw begin
    t = Turtle()
    Message(t, "start")
    Turn(t, 180)
    Forward(t, 200)
    Message(t, "end")
end

# how to draw a vertical line down

@draw begin
    t = Turtle()
    Message(t, "start")
    Turn(t, 90)
    Forward(t, 200)
    Message(t, "end")
end

# how to draw a vertical line up (method 1)

@draw begin
    t = Turtle()
    Message(t, "start")
    Turn(t, 90)
    Forward(t, -200)
    Message(t, "end")
end

# how to draw a vertical line up (method 2)

@draw begin
    t = Turtle()
    Message(t, "start")
    Turn(t, -90)
    Forward(t, 200)
    Message(t, "end")
end

# how to draw an equilateral triangle without fill

@draw begin
    t = Turtle()
    for i in 1:3
        Forward(t, 200)
        Turn(t, -120)
        Message(t, "$i")
    end
end

# how to draw a square without fill (clockwise)

@draw begin
    t = Turtle()
    for i in 1:4
        Forward(t, 200)
        Turn(t, 90)
        Message(t, "$i")
    end
end

# putting it all together

function square(t)
    for i in 1:4
        Forward(t, 200)
        Turn(t, 90)
    end
end

@draw begin
    background("antiquewhite")
    t = Turtle()
    n = 100
    Penwidth(t, 0.5)
    Pencolor(t, "darkblue")
    for i in 1:n
        square(t)
        Turn(t, 360/n)
    end
end

########################################
# Luxor Animation with Turtle Graphics
########################################

using Luxor

# turtle graphics animation

movie_turtle = Movie(600, 600, "movie_turtle", 1:100)

# define shapes

function backdrop(scene, frame)
    background("antiquewhite")
end

function square(t)
    for i in 1:4
        Forward(t, 200)
        Turn(t, 90)
    end
end

# define motion

function draw_pattern(scene, frame)
    t = Turtle()
    Penwidth(t, 0.5)
    Pencolor(t, "darkblue")
    for i in 1:frame
        square(t)
        Turn(t, 360/frame)
    end
end

# create animation

animate(movie_turtle, [
        Scene(movie_turtle, backdrop, 1:100),
        Scene(movie_turtle, draw_pattern, 1:100)
    ],
    creategif = true,
    framerate = 25,
    pathname = "movie_turtle.gif"
)

########################################
# Luxor Looping Animation (Circle)
########################################

using Luxor

movie_circle = Movie(600, 600, "movie_circle", 0:99)

# define shapes

function backdrop(scene, frame)
    background("white")
end

function mycircle(x)
    circle(Point(x, 0), 50, :stroke)
end

# define motion

function moveright(scene, frame)
    mycircle(-250 + (frame * 10))
end

function moveleft(scene, frame)
    mycircle(250 - (frame - 50) * 10)
end

# create animation

animate(movie_circle, [
        Scene(movie_circle, backdrop, 0:99),
        Scene(movie_circle, moveright, 0:50),
        Scene(movie_circle, moveleft, 51:99)
    ],
    creategif = true,
    framerate = 25,
    pathname = "movie_circle.gif"
)

########################################
# Luxor Looping Animation (Space)
########################################

using Luxor, Random

movie_space = Movie(600, 600, "movie_space", 0:99)

# define shapes

function stars(y)
    background("black")
    Random.seed!(1)
    rng = -300:300
    horizontal = collect(rand(rng, 200))
    vertical = collect(rand(rng, 200))
    for i in 1:200
        setcolor("white")
        circle(
            Point(horizontal[i], vertical[i] + y * 6),
            2, :fill
        )
        circle(
            Point(horizontal[i], vertical[i] + y * 6 - 600),
            2, :fill
        )
    end
end

function shuttle(x)
    setcolor("blue")
    circle(Point(x, 100), 50, :stroke)
    setcolor("yellow")
    ngon(Point(x, 100), 30, 3, -pi/2; action = :fill)
    setcolor("red")
    ngon(Point(x, 125), 15, 3, pi/2; action = :fill)
end

# define motion

function movedown(scene, frame)
    stars(frame)
end

function moveright(scene, frame)
    shuttle(-250 + (frame * 10))
end

function moveleft(scene, frame)
    shuttle(250 - (frame - 50) * 10)
end

# create animation

animate(movie_space, [
        Scene(movie_space, movedown, 0:99),
        Scene(movie_space, moveright, 0:50),
        Scene(movie_space, moveleft, 51:99)
    ],
    creategif = true,
    framerate = 25,
    pathname = "movie_space.gif"
)
