# initialize screen

WIDTH = 1280
HEIGHT = 720
BACKGROUND = colorant"antiquewhite"

# set number of actors

n = 100   # try 1, 10, 100

# select random starting points

x = rand(30:5:1250, n)
y = rand(20:10:200, n)

# define initial state of actors

r = 20

c = []

for i in 1:n
    push!(c, Circle(x[i], y[i], r))
end

# select random colors for actors

colors = [colorant"red", colorant"green", colorant"blue"]

c_color = []

for i in 1:n
    push!(c_color, rand(colors))
end

# draw actors

function draw(g::Game)
    for i in 1:n
        draw(c[i], c_color[i], fill = true)
    end
end

# select random initial velocities

vx = Float64[]

for i in 1:n
    push!(vx, rand((-5.0, 5.0)))
end

vy = fill(0.0, (n, 1))

# set values for gravity and friction

gravity = 0.2
friction = 0.9

# update position of actors

function update(g::Game)
    for i in 1:n
        global vx, vy
        # impact of friction
        if c[i].y >= HEIGHT - r
            # conditional for small values of vy
            if abs(vy[i]) < 2
                c[i].y = HEIGHT - r
                vy[i] = 0
                vx[i] = vx[i] * friction
            else
                vx[i] = vx[i] * friction
                vy[i] = -vy[i] * friction
                c[i].y = Int(round(HEIGHT - r + vy[i]))
            end
        # impact of gravity
        else
            vy[i] += gravity
            c[i].y = Int(round(c[i].y + vy[i]))
        end
        # collision with side borders
        if c[i].x > WIDTH - r || c[i].x < r
            vx[i] = -vx[i]
        end
        # conditional for small values of vx
        if abs(vx[i]) < 0.5
            c[i].x += Int(sign(vx[i]))
            vx[i] = round(vx[i] - 0.001 * sign(vx[i]), digits = 3)
        # horizontal movement
        else
            c[i].x = Int(round(c[i].x + vx[i]))
        end
    end
end
