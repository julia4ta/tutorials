@def title = "My Franklin Sandbox"
@def hasmath = true
@def hascode = true

# Set up

## Update title

## Update config.md file

* change author

* add site name for GitHub

## Create a table of contents (optional)

\toc

## Upload using GitHub Desktop

# Examples

## How to enter text

 Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis porta facilisis ante, vel sollicitudin est molestie a. Morbi vulputate odio pharetra metus varius, in rhoncus justo euismod. Fusce pretium auctor laoreet. Phasellus sed risus non metus finibus facilisis. Fusce in dolor vitae purus sagittis aliquam. Nunc a dictum purus. Ut in sapien metus. Vestibulum eu cursus orci, ac auctor enim. Maecenas rutrum semper luctus. Donec sed sem sed metus accumsan maximus. Mauris tortor nulla, fringilla eget dictum id, convallis in sem. Pellentesque felis mauris, fermentum at accumsan vitae, ultrices at lectus.

Quisque mauris lorem, aliquet eu finibus eget, maximus non justo. Nam finibus malesuada arcu ut efficitur. Integer faucibus viverra luctus. Suspendisse molestie, odio non facilisis facilisis, nulla nulla sodales dui, id faucibus nisi lacus sit amet erat. Curabitur felis ex, vehicula ornare aliquam sit amet, tristique quis lacus. Quisque mauris ex, egestas at erat et, interdum malesuada nisl. Aenean congue risus rhoncus ullamcorper varius. 

## How to render math equations

Examples from the last tutorial:

$$ a^2 + b^2 = c^2 $$

$$ \frac{d}{dx} \int_a^x f(t)dt = f(x) $$

$$ \bar{x} = \frac{1}{n} \Bigg(\sum_{i=1}^n x_i \Bigg) = \frac{x_1 + x_2 + \cdots + x_n}{n} $$

$$
    \begin{alignedat}{3}
        2&x + y \space- &z &= &8 \\
        -3&x -y + 2&z &= \space&-11 \\
        -2&x + y + 2&z &= &-3
    \end{alignedat}
$$

$$
    M =
        \begin{bmatrix}
            \begin{aligned}
                &2 & &1 & -&1\space \\
                \space-&3 & -&1 & &2 \\
                -&2 & &1 & &2
            \end{aligned}
        \end{bmatrix}
$$

(optional: disable numbering)

## How to insert Julia code (with outputs!)

Hello, World!

```julia:./ex11
println("Hello, World!")
```

\show{./ex11}

Basic Math

```julia:./ex12
1 + 1
```

\show{./ex12}

Create Function

```julia:./ex13
function add(x, y)
    x + y
end
```

\show{./ex13}

Call Function

```julia:./ex14
add(2, 3)
```

\show{./ex14}

Random Numbers

```julia:./ex15
rand(5, 5)
```

\show{./ex15}

## How to insert a table from a CSV file

World Population by Region by Year:

\tableinput{}{./tableinput/population_by_year.csv}

@@source
Source: Wikipedia
@@

## How to insert an image file

![beeswarm plot of population by region](/assets/p_beeswarm_region.svg)

@@source
Source: Wikipedia
@@

## How to insert a clickable thumbnail to a YouTube video

[![YT thumbnail](https://img.youtube.com/vi/AilZwXgglsI/0.jpg)](https://youtu.be/AilZwXgglsI)

## How to inject raw HTML

~~~
<iframe width="640" height="360" src="https://www.youtube.com/embed/AilZwXgglsI" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
~~~



<!-- # Franklin syntax sandbox

This page is meant as a sandbox for Franklin Syntax so that you can quickly practice or experience things.

## Sandbox

Write whatever you want here to practice Franklin Syntax:

```julia:./ex1
using LinearAlgebra, Random
Random.seed!(135)
a, b = randn(50), randn(50)
println(dot(a, b))
println(sum(ai * bi for (ai, bi) ∈ zip(a, b)))
```

\output{./ex1}

(yet another example that floating point arithmetics can be complicated).

$$ \forall x \in \R:\quad \scal{x, x} \ge 0 $$

\newcommand{\E}{\mathbb E}

Surely some people remember the ordering, but I always forget:

$$ \varphi(\E[X]) \le \E[\varphi(X)] $$

for $\varphi$ convex. -->
