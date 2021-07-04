<!-- Source: GitHub Guides -->

Hello, World!

<!-- Headers -->

# This is an `<h1>` tag
## This is an `<h2>` tag
###### This is an `<h6>` tag

<!-- Emphasis -->

*This text will be italic*
_This will also be italic_

**This text will be bold**
__This will also be bold__

_You **can** combine them_

<!-- Lists -->

<!-- Unordered -->

* Item 1
* Item 2
  * Item 2a
  * Item 2b

<!-- Ordered -->

1. Item 1
1. Item 2
1. Item 3
   1. Item 3a
   1. Item 3b

<!-- Images -->

<!-- ![GitHub Logo](/images/logo.png)
Format: ![Alt Text](url) -->

![GitHub Logo](https://github.githubassets.com/images/modules/logos_page/Octocat.png)

<!-- Links -->

http://github.com - automatic!
[GitHub](http://github.com)

<!-- Clickable Image -->

[![GitHub Logo](https://github.githubassets.com/images/modules/logos_page/Octocat.png)](http://github.com)

<!-- Blockquotes -->

As Kanye West said:

> We're living the future so
> the present is our past.

<!-- Inline code -->

I think you should use an
`<addr>` element here instead.

<!-- GitHub Flavored Markdown -->

<!-- Syntax highlighting -->

```javascript
function fancyAlert(arg) {
  if(arg) {
    $.facebox({div:'#foo'})
  }
}
```

    function fancyAlert(arg) {
      if(arg) {
        $.facebox({div:'#foo'})
      }
    }

<!-- Task Lists -->

- [x] @mentions, #refs, [links](), **formatting**, and <del>tags</del> supported
- [x] list syntax required (any unordered or ordered list supported)
- [x] this is a complete item
- [ ] this is an incomplete item

<!-- Tables -->

First Header | Second Header
------------ | -------------
Content from cell 1 | Content from cell 2
Content in the first column | Content in the second column

<!-- Strikethrough -->

Any word wrapped with two tildes (like ~~this~~) will appear crossed out.

<!-- Emoji -->

:dog:

:trollface:

<!-- Math -->

$\alpha$
$\beta$
$\omega$

$\pi$

Area = $\pi$ * $r^2$

E = m$c^2$

$\sqrt{4}$ = 2

<!-- Horizontal Rule -->

---

___

<!-- Julia Markdown -->

<!-- Bold -->

A paragraph containing a **bold** word.

<!-- Italics -->

A paragraph containing an *italicized* word.

<!-- Literals -->

A paragraph containing a `literal` word.

A paragraph containing ``` `backtick` characters ```.

<!-- LaTeX -->

A paragraph containing some ``\LaTeX`` markup.

$\LaTeX$

<!-- Links -->

A paragraph containing a link to [Julia](http://www.julialang.org).

<!-- Footnote references -->

A paragraph containing a numbered footnote [^1] and a named one [^named].

<!-- Toplevel elements -->

<!-- Paragraphs -->

This is a paragraph.

And this is *another* paragraph containing some emphasized text.
A new line, but still part of the same paragraph.

<!-- Headers -->

# Level One
## Level Two
### Level Three
#### Level Four
##### Level Five
###### Level Six

<!-- Code blocks -->

This is a paragraph.

    function func(x)
        # ...
    end

Another paragraph.

A code block without a "language":

```
function func(x)
    # ...
end
```

and another one with the "language" specified as `julia`:

```julia
function func(x)
    # ...
end
```

<!-- Block quotes -->

Here's a quote:

> Julia is a high-level, high-performance dynamic programming language for
> technical computing, with syntax that is familiar to users of other
> technical computing environments.

<!-- Images -->

<!-- ![alternative text](link/to/image.png) -->

<!-- Lists -->

A list of items:

  * item one
  * item two
  * item three

Another list:

  * item one

  * item two

    ```
    f(x) = x
    ```

  * And a sublist:

      + sub-item one
      + sub-item two

Two ordered lists:

 1. item one
 2. item two
 3. item three

 5) item five
 6) item six
 7) item seven

 <!-- Display equations -->

```math
f(a) = \frac{1}{2\pi}\int_{0}^{2\pi} (\alpha+R\cos(\theta))d\theta
```

<!-- Footnotes -->

[^1]: Numbered footnote text.

[^named]:

    Named footnote text containing several toplevel elements.

      * item one
      * item two
      * item three

    ```julia
    function func(x)
        # ...
    end
    ```

<!-- Horizontal rules -->

Text above the line.

---

And text below the line.

<!-- Tables -->

| Column One | Column Two | Column Three |
|:---------- | ----------: |:------------:|
| Row `1`    | Column `2` |              |
| *Row* 2    | **Row** 2  | Column ``3`` |

<!-- Admonitions -->

!!! note

    This is the content of the note.

!!! warning "Beware!"

    And this is another one.

    This warning admonition has a custom title: `"Beware!"`.

!!! terminology "julia vs Julia"

    Strictly speaking, "Julia" refers to the language,
    and "julia" to the standard implementation.

