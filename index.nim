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

template reference(text: string) =
  nbTextSmall: text

template slideWhatIsNim =
  slide(slideOptions(autoAnimate=true)):
    nbText: "## What is Nim 👑"
    columns:
      column:
        nbCodeInBlock:
          let message = "Hi_PyConSE23!"
          for i in 0 ..< message.len:
            echo message[0 .. i]
      column:
        nbText: "<span data-id=\"nimis\">Nim is a</span>" &
        "<span data-id=\"proglang\"><br>programming language</span>" #&
    reference "[A Programming Language Underdog (2018)](url.info)" # small
    speakerNote: """
- an interesting second (or 3rd or nth) proglang to learn after python
- programming languages are fun!
- nim is my way of procrastinating learning Rust
- it is much more niche, I learn it for fun not for money
"""

  slide(slideOptions(autoAnimate=true)):
    nbText: "## What is Nim 👑"
    columns:
      column:
        nbCodeInBlock:
          let message = "Hi_PyConSE23!"
          for i in 0 ..< message.len:
            echo message[0 .. i]
      column:
        nbText: "<span data-id=\"nimis\">Nim is a</span>" &
        "<span data-id=\"compiled\"><br>compiled</span>" &
        "<span data-id=\"proglang\"><br>programming language</span>"
    reference "[A Programming Language Underdog (2018)](url.info)" # small

  slide(slideOptions(autoAnimate=true)):
    nbText: "## What is Nim 👑"
    columns:
      column:
        nbCodeInBlock:
          let message = "Hi_PyConSE23!"
          for i in 0 ..< message.len:
            echo message[0 .. i]
      column:
        nbText: "<span data-id=\"nimis\">Nim is a</span>" &
        "<span data-id=\"static\"><br>statically typed</span>" &
        "<span data-id=\"compiled\"><br>compiled</span>" &
        "<span data-id=\"proglang\"><br>programming language</span>"
        #"<span data-id=\"everything\"><br>for everything</span>"
    reference "[A Programming Language Underdog (2018)](url.info)" # small

  slide(slideOptions(autoAnimate=true)):
    nbText: "## What is Nim 👑"
    columns:
      column:
        nbCodeInBlock:
          let message = "Hi_PyConSE23!"
          for i in 0 ..< message.len:
            echo message[0 .. i]
      column:
        nbText: "<span data-id=\"nimis\">Nim is a</span>" &
        "<span data-id=\"static\"><br>statically typed</span>" &
        "<span data-id=\"compiled\"><br>compiled</span>" &
        "<span data-id=\"proglang\"><br>programming language</span>" &
        "<span data-id=\"everything\"><br>for everything</span>"
    reference "[A Programming Language Underdog (2018)](url.info)" # small

template slideAlternativeToRust =
  slide:
    nbText: "_(an alternative to Rust)_" # have it appear later and small
    # with different tradeoffs

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

template slidePortable =
  slide:
    slide:
      nbText: "### 🤯 Compiles to Javascript!"
      fragment:
        nbText: "### [🌱✨ plant app](https://pietroppeter.github.io/nblog/drafts/plant_app.html?utm_source=github-pietroppeter) 👇"    
  
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
    slide:
        slide:
            nbText: "### [🌱✨ Explorable Example with Nimib]()"
        slideIframeFromNblog("plant_app")

template slideFirstTask =
    slide:
        nbText: "### **FIRST TASK**\n[Groviglio](): wrapper for [Tangle.js]() for Nimib"
        speakerNote: """
- Tangle.js is a Javascript library by your very own Bret Victor for explorable explanations
- Discovered this week, does not seem very much known/used but looks like a good starting point
"""

template aChristmasTwist =
    slide:
        nbText: """
_something else happened during Christmas period..._
"""

template slideNimipPy =
    slide:
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

template slideEnterPyscript =
    slide:
        nbText: """### [Pyscript]()
- Python in the browser
- PyConUS 2022 (Peter Wang, Anaconda): "Python for the 99%"
- Started using Pyodide (Python in WASM): heavy asset (MBs), slow loading times (seconds)
- _recently_: added a **Micropython**🤯 backend: <200kb, <200ms
"""
        speakerNote: """
- Born in Anaconda but run as a community project
- Creation of Fabio Pliger
"""

template slideNimipPyscript =
    slide:
        slide:
            nbFile("bunny_meets_whaley.py"): """
import nimib as nb

nb.init(pyscript=True)

nb.text("## Bunny 🐰 meets Whaley 🐳!")
nb.text("Hello world example for pyscript with nimib.py.")

nb.html("<button id=\"click-me\">Click me! 🐰🐳</button><br/>")
nb.html("<div id=\"emoji-container\"></div>")

nb.text("This code adds functionality to the button (try block is a workaround):")
with nb.code(pyscript=True):
    try:
        from js import document

        def handler(e):
            output = document.createElement("span")
            output.innerHTML = "🐳"
            container = document.querySelector("div#emoji-container")
            container.appendChild(output)

        button = document.querySelector("button#click-me")
        button.addEventListener("click", handler)
    except ImportError:
        print("running pyscript block not in js")

nb.save()
"""
            nbText: "**TASK**: make it idiomatic"
            speakerNote """
- context manager cannot avoid yielding
- will change to decorators
"""
        slideIframe("../../nimib.py/bunny_meets_whaley.html")

template slideAboutNim =
    slide:
        nbText: """### THANKS FOR LISTENING 🙏
"""
        speakerNote: """
"""

when isMainModule:
  nbInit(theme = revealTheme)
  setSlidesTheme(League)
  addNbTextSmall

  # intro: setting the stage
  slideTitle
  slideNiche
  # the characters are: the tech, the community... and me


  when false:
    discard
    slideWhatIsNim 
    #slideAlternativeToRust
    slideSyntax
    slidePerformant # compiles to C
    slidePragmatic # FFI: e.g. nimporter and nimpy
    slidePortable # Compiles to Javascript!
    #slideEverything
    #slideProductive
    slideSource

    slideTitle2
    slideLiterate
    slideNimibAsLiterate
    slideExplorable
    slideNimibAsExplorable
    slideFirstTask
    aChristmasTwist
    slideNimipPy
    slideEnterPyscript
    slideNimipPyscript
    slideAboutNim
  nbSave