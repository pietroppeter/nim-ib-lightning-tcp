import nimib, nimislides
import std / strformat

template slideIframe*(url: string) =
  nbRawHtml: "<section data-background-iframe=\"" & url & "\" data-background-interactive></section>"

template slideIframeFromNblog*(filename: string) =
  slideIframe("https://nimib-land.github.io/nblog/drafts/" & filename & ".html")

# small text
template addNbTextSmall* =
  nb.partials["nbTextSmall"] = "<small>" & nb.partials["nbText"] & "</small>"
  nb.renderPlans["nbTextSmall"] = nb.renderPlans["nbText"]

template nbTextSmall*(text: string) =
  nbText: text
  nb.blk.command = "nbTextSmall"

# ---------------------------------------
template slideTitle =
  slide:
    bigText: "Why Invest in a Niche Tech?"
    nbText: "## The case of Nim(ib)"
    nbText: "A TCP lightning chat"
    nbText: "[github.com/pietroppeter/nim-ib-lightning-tcp](https://github.com/pietroppeter/nim-ib-lightning-tcp)"
    speakerNote: """
- former title: Why Nim is interesting and what I do with it
- slides are on github
"""

template slideNiche =
  slide:
    bigText: "What is a Niche Tech?"
    speakerNote: """
in terms of programming languages:
- Nim is Niche, Python is mainstream
- Zig is Niche, C is mainstream
- Gleam is Niche, Javascript is mainstream

Rust... depends where you sit.
Nicheness is a continuumm a loosely defined
From my point of view it is graduating from Niche to Mainstream
With the side effect that C++ might become legacy...

I will be define it in subjective terms:
- you know very little people that do it (less than 5, normally 0)
- you can access a (small) community of enthusiasts

The goal of course is to conquer the world!

Will Nim become the next Python?

Spoiler: NO

But my goal is to convince you today that it might be interesting
to invest in a niche tech even discounting ultimate success
"""

# ---------------------------------------

template slideTech =
  slide:
    nbText "## [The Tech]()"

template reference(text: string) =
  nbTextSmall: text

template slideHelloNim =
  slide:
    nbText: "## What is Nim 👑"
    columns:
      column:
        nbCodeInBlock:
          let 💬 = "Hi Crafters!"
          for i in 0 ..< 💬.len:
            echo 💬[0 .. i]
      column:
        nbText: "<span data-id=\"nimis\">Nim is a</span>" &
        "<span data-id=\"static\"><br>statically typed</span>" &
        "<span data-id=\"compiled\"><br>compiled</span>" &
        "<span data-id=\"proglang\"><br>programming language</span>" &
        "<span data-id=\"everything\"><br>for everything</span>"
    reference "[A Programming Language Underdog (2018)](url.info)" # small
    speakerNote: """
- an interesting second (or 3rd or nth) proglang to learn after python
- programming languages are fun!
- nim is my way of procrastinating learning Rust
- it is much more niche, I learn it for fun not for money
"""

template slideSyntax =
  slide:
    nbText: "### Pythonic Syntax with 🦸 Superpowers"
    columns:
      column:
        nbCode:
          type
            Grid = array[3, array[3, Cell]]
            Cell = enum X, O

          func initGrid: Grid =
            [[X,O,X],[O,X,O],[X,O,X]]

          proc show(g: Grid) =
            for row in g:
              echo row
          
          proc update(g: var Grid) =
            for i in g.low .. g.high:
              for j in g[i].low .. g[i].high:
                g[i][j] = if g[i][j] == X: O else: X
        nbTextSmall: "- 🦸 syntax fits well with **metaprogramming**\n" &
        "- 💡 UFCS (Uniform Function Call Syntax)"
        nbTextSmall: "[Zen of Nim (2021)](https://nim-lang.org/blog/2021/11/15/zen-of-nim.html)"

      column:
        nbText: "⠀" # https://www.compart.com/en/unicode/U+2800
      column:
        #nbText: "Indentation based syntax that fits Nim's macro system"
        nbCode:
          var g = initGrid()
          show g # command
        nbCode:          
          g.update # method
          g.show
        nbCode:
          update(g) # function
          show(g)
    

template slidePerformant =
  slide:
    nbText: "### 🏎️ Performant: compiles to C"
    #nbText: "_todo: matrix multiplications_"
    nbCode:
      const N = 3
      type Matrix = array[N, array[N, int]]

      let
        A = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
        B = [[1, 1, 1], [0, 1, 1], [0, 0, 1]]

      func `*`(a, b: Matrix): Matrix =
        for i in 0 ..< N:
          for j in 0 ..< N:
            for k in 0 ..< N:
              result[i][j] += a[i][k]*b[k][j]

      echo A*B

    reference "[HPC from Python to Nim (Fosdem 2022)](https://archive.fosdem.org/2022/schedule/event/nim_hpcfrompythontonim/)"

const
  tripleBackticks = "```" # hack to avoid issues when showing source
  bOpen = "{"
  bClose = "}"

template slidePragmatic =

  slide:
    nbText: "### 🤝 Interop with Python"
    nbText: fmt"""

`fibonacci.nim`
{tripleBackticks}nim
import nimpy

func fib*(n: int): int {bOpen}. exportpy .{bClose} =
  if n < 2: 1 else: fib(n - 1) + fib(n - 2)
{tripleBackticks}

`main.py`
{tripleBackticks}python
import nimporter
from fibonacci import fib

print(fib(10))
{tripleBackticks}

{tripleBackticks}
python3 main.py
{tripleBackticks}

{tripleBackticks}
89
{tripleBackticks}

"""

    reference "[nimporter](https://github.com/Pebaz/nimporter)"
    reference "[nimpy](https://github.com/yglukhov/nimpy)"

template slideJavascript =
  slide:
    nbText: "### 🤯 Compiles to Javascript!"
  slideIframe("okazzu.html")

template slidePlant =
  slideIframeFromNblog("plant_app")


# WIP
template slideEverything =
  slide:
    nbText: "### For everything"
    unorderedList:
      listItem: nbText"gamedev: nico, godot bindings (Turing Complete)"
      listItem: nbText"langdev: arturo, min"

template slideSource =
  slide:
    nbText: "### 🛷 Slides source"
    nbText: "```nim\n" & nb.source & "\n```\n"
    reference "[nimislides by Hugo Granström](https://github.com/HugoGranstrom/nimiSlides)"


### from nimib 5'talk

template slideTitle2 =
    slide:
        nbText: "# [**NimibLand**]()\n## Literate Programming and Explorable Explanations"
        speakerNote: """
- I have a talk proposal with more or less of this title which I am waiting to see if it will be accepted to be presented at FOSDEM
- This presentation is also accountability for the commitment I would like to have to focus on these stuff for the rest of the batch
"""

template slideLiterate =
    slide:
        nbText: """### [Literate Programming](https://en.wikipedia.org/wiki/Literate_programming)

Programming paradigm by Donald Knuth (1984)

<small>
a computer program is given as an explanation of how it works
in a natural language, such as English,
interspersed (embedded) with snippets of macros
and traditional source code,
from which compilable source code can be generated.
</small>

Inspired:
- Jupyter NoteBook
- Quarto (RMarkdown)
- Nbdev
- ...
- [Nimib]()
"""
        speakerNote: """
- quote is from wikipedia. TODO: check original source

1. Weaving: Generating a comprehensive document about the program and its maintenance.
2. Tangling: Generating machine executable code

- Jupyter is more Interactive Computing
- N and B in Nimib come from NoteBook
- Nbdev closest to original literate programming
- Observable most important and not quoted
"""

template slideExplorable =
    slide:
        nbText: """### [Explorable Explanations]()

Essay by Bret Victor (2011)

<small>
"Explorable Explanations is my umbrella project for ideas
that enable and encourage truly active reading.
The goal is to change people's relationship with text.
People currently think of text as information to be consumed.
I want text to be used as an environment to think in."
</small>

See more at [explorabl.es](https://explorabl.es/)

**Goal**: make in [NimibLand]() better tools for explorable explanations.
"""
        speakerNote: """
- NimibLand concretely is a github organization where me and Hugo are
moving Nimib related projects
- The funny part is we decided on the name NimibLand
before knowing about DynamicLand and MathLand
(which I discovered about them this week)
"""

template slideNimibAsLiterate =
  slide:
    nbText: "### Nimib as 'Literate Programming'"
    nbFile("hello.nim"): """
import nimib

nbInit

nbText: "A sample program with _Nimib_"

nbCode:
    echo "hello RC!"

nbSave
"""
    nbText: "`nim r hello`"
    speakerNote: """
"""
  slideIframe("hello.html")

template slideNimibAsExplorable =
  slideIframeFromNblog("plant_app")

template slideNimibPy =
  slide:
    nbText: """### [Nimib.py]()
"""
    nbFile("hi.py"): """
import nimib as nb

nb.init()

nb.text("Welcome to `nimib.py`!")

message = "hello"

with nb.code():
    print(message)

nb.save()
"""
    nbText: "`python hi.py`"
    speakerNote: """
Thanks to advent of code
"""
  slideIframe("../../nimib.py/hi.html")

template slideCulture =
  slide:
    nbText "## [The Culture]()"

template slidePeople =
  slide:
    nbText "## [The People]()"


template slideZenOfPy =
  slide:
    nbText: "### Zen of Python"
    nbText: """
```md
Beautiful is better than ugly.
Explicit is better than implicit.
Simple is better than complex.
Complex is better than complicated.
Flat is better than nested.
Sparse is better than dense.
Readability counts.
Special cases aren't special enough to break the rules.
Although practicality beats purity.
Errors should never pass silently.
Unless explicitly silenced.
In the face of ambiguity, refuse the temptation to guess.
There should be one-- and preferably only one --obvious way to do it.
Although that way may not be obvious at first unless you're Dutch.
Now is better than never.
Although never is often better than *right* now.
If the implementation is hard to explain, it's a bad idea.
If the implementation is easy to explain, it may be a good idea.
Namespaces are one honking great idea -- let's do more of those!```
"""

template slideZenOfNim =
  slide:
    nbText: "### Zen of Nim"
    nbText: """
```md
1. Copying bad design is not good design.
2. If the compiler cannot reason about the code,
   neither can the programmer.
3. Don’t get in the programmer’s way.
4. Move work to compile-time:
   Programs are run more often than they are compiled.
5. Customizable memory management.
6. Concise code is not in conflict with readability,
   it enables readability.
7. (Leverage meta programming to keep the language small.)
8. Optimization is specialization:
   When you need more speed, write custom code.
9. There should be one and only one programming language
   for everything.
   That language is Nim.
```
"""

when isMainModule:
  import p5

  nbInit(theme = revealTheme)
  nbUseP5
  setSlidesTheme(League)
  addNbTextSmall

  # intro: setting the stage
  slide:
    slideTitle
    slideNiche
  # the characters are: the tech, the community... and me

  slide:
    slideTech
    slideHelloNim 
    slidePerformant # compiles to C
    slideSyntax
    slidePragmatic # FFI: e.g. nimporter and nimpy
    slideJavascript # Okazzu!
    slide:
      nbText: "[I can do Open Source!]()"
    slideNimibAsLiterate
    slideExplorable
    slidePlant
    slideNimibPy

  slide:
    slideCulture
    slideZenOfPy
    slideZenOfNim
    # a pragmatic, down to earth
    slide:
      nbText: "[Same for a Mainstream tech?]()"
      # the culture is forming in a niche
      # I can bring my own culture
    slideIframe("https://forum.nim-lang.org/t/8780")
  
  slide:
    slidePeople
    # slideADPH
  
  nbSave