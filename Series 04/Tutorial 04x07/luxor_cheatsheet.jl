# Luxor.jl Cheat Sheet

using Luxor

# default window is 600x600

########################################
# lines, arrows & circles
########################################

# how to draw a horizontal line
@draw line(Point(-250, 0), Point(250, 0), :stroke)

# how to draw a vertical line
@draw line(Point(0, -250), Point(0, 250), :stroke)

# how to draw a diagonal line
@draw line(Point(-250, -250), Point(250, 250), :stroke)

# how to draw a diagonal arrow
@draw arrow(Point(-250, -250), Point(250, 250))

# how to draw a circle
@draw circle(Point(0, 0), 200, :stroke)

# how to draw a box
@draw box(Point(0, 0), 500, 300, :stroke)

# how to draw a dashed circle
@draw begin
    setdash("dot")
    circle(Point(0, 0), 200, :stroke)
end

# putting it all together
@draw begin
    setdash("dot")
    arrow(Point(-250, 0), Point(250, 0))
    arrow(Point(0, -250), Point(0, 250))
    circle(Point(0, 0), 200, :stroke)
    box(Point(0, 0), 400, 400, :stroke)
end

# guidelines() function
function guidelines()
    setdash("dot")
    arrow(Point(-250, 0), Point(250, 0))
    arrow(Point(0, -250), Point(0, 250))
    circle(Point(0, 0), 200, :stroke)
    box(Point(0, 0), 400, 400, :stroke)
    setdash("solid")
end

########################################
# polygons
########################################

# how to draw a triangle (default)
@draw begin
    guidelines()
    ngon(Point(0, 0), 200, 3, 0; action = :stroke)
end

# how to draw a triangle (rotated)
@draw begin
    guidelines()
    ngon(Point(0, 0), 200, 3, -pi/2; action = :stroke)
end

# how to draw a square (default)
@draw begin
    guidelines()
    ngon(Point(0, 0), 200, 4, 0; action = :stroke)
end

# how to draw a square (rotated)
@draw begin
    guidelines()
    ngon(Point(0, 0), 200, 4, -pi/4; action = :stroke)
end

# how to draw a pentagon (default)
@draw begin
    guidelines()
    ngon(Point(0, 0), 200, 5, 0; action = :stroke)
end

# how to draw a pentagon (rotated)
@draw begin
    guidelines()
    ngon(Point(0, 0), 200, 5, -pi/2; action = :stroke)
end

########################################
# ellipses & arcs
########################################

# how to draw a horizontal ellipse
@draw begin
    guidelines()
    ellipse(Point(0, 0), 400, 200, :stroke)
end

# how to draw a vertical ellipse
@draw begin
    guidelines()
    ellipse(Point(0, 0), 200, 400, :stroke)
end

# how to draw a semicircle
@draw begin
    guidelines()
    arc2r(Point(0, 0), Point(0, -200), Point(0, 200), :stroke)
end

# how to draw a quarter circle
@draw begin
    guidelines()
    arc2r(Point(0, 0), Point(0, -200), Point(200, 0), :stroke)
end

########################################
# text
########################################

# how to add text (default)
@draw begin
    guidelines()
    text("Hello, Luxor!")
end

# how to add text (custom)
@draw begin
    guidelines()
    setfont("Comic Sans MS Bold", 48)
    settext(
        "Hello, Luxor!",
        halign = "center", valign = "center"
    )
end

########################################
# colors, line width & fill
########################################

# how to set color
@draw begin
    guidelines()
    setcolor("red")
    circle(Point(0, 0), 200, :stroke)
end

# how to set line width
@draw begin
    guidelines()
    setcolor("red")
    setline(10)
    circle(Point(0, 0), 200, :stroke)
end

# how to use :fill
@draw begin
    guidelines()
    setcolor("red")
    circle(Point(0, 0), 200, :fill)
end

# putting it all together
@draw begin
    # guidelines()
    # shape fill
    setcolor("yellow")
    ellipse(Point(0, 0), 400, 200, :fill)
    # shape stroke
    setcolor("red")
    setline(10)
    ellipse(Point(0, 0), 400, 200, :stroke)
    # text
    setcolor("blue")
    setfont("Comic Sans MS Bold", 48)
    settext("Generic Logo",
        halign = "center", valign = "center"
    )
end

########################################
# export options
########################################

# export triangle as svg
@svg begin
    guidelines()
    ngon(Point(0, 0), 200, 3, -pi/2; action = :stroke)
end 600 600 "mytriangle.svg"

# change fill-opacity from 1 to 0 to make image transparent

# export triangle as png
@png begin
    guidelines()
    ngon(Point(0, 0), 200, 3, -pi/2; action = :stroke)
end 600 600 "mytriangle.png"

# export triangle as pdf
@pdf begin
    guidelines()
    ngon(Point(0, 0), 200, 3, -pi/2; action = :stroke)
end 600 600 "mytriangle.pdf"

# export triangle as eps
@eps begin
    guidelines()
    ngon(Point(0, 0), 200, 3, -pi/2; action = :stroke)
end 600 600 "mytriangle.eps"

########################################
# programmatic drawing
########################################

# how to draw an astroid using lines
@draw begin
    background("antiquewhite")
    guidelines()
    setcolor("darkblue")
    setline(0.5)
    # horizontal and vertical lines
    line(Point(-200, 0), Point(200, 0), :stroke)
    line(Point(0, -200), Point(0, 200), :stroke)
    # astroid
    for i in 0:10:200
        line(Point(200 - i, 0), Point(0, i + 10), :stroke)
        line(Point(0, 200 - i), Point(-10 - i, 0), :stroke)
        line(Point(-200 + i, 0), Point(0, -10 - i), :stroke)
        line(Point(0, -200 + i), Point(10 + i, 0), :stroke)
    end
end

# export astroid as svg
@svg begin
    background("antiquewhite")
    guidelines()
    setcolor("darkblue")
    setline(0.5)
    # horizontal and vertical lines
    line(Point(-200, 0), Point(200, 0), :stroke)
    line(Point(0, -200), Point(0, 200), :stroke)
    # astroid
    for i in 0:10:200
        line(Point(200 - i, 0), Point(0, i + 10), :stroke)
        line(Point(0, 200 - i), Point(-10 - i, 0), :stroke)
        line(Point(-200 + i, 0), Point(0, -10 - i), :stroke)
        line(Point(0, -200 + i), Point(10 + i, 0), :stroke)
    end
end 600 600 "astroid.svg"
