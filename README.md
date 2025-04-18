# Download directions

Click the green button labeled `<> Code`. and then click on `Download ZIP`. 

# Purpose

Producing a master's thesis or a doctoral dissertation in LaTeX.

# Target  institution

UMass Boston

## Target style manual

_Standards for the Preparation of Theses and Dissertations at the University of Massachusetts Boston_ 

(Link: likely the first hit [here](https://www.google.com/search?q=Standards%20for%20the%20Preparation%20of%20Theses%20and%20Dissertations%20at%20the%20University%20of%20Massachusetts%20Boston&client=ubuntu-sn&channel=fs&sclient=gws-wiz-serp). I don't provide a direct link because it changes too frequently; Google is our best bet to find it reliably.)

### Version of style manual

May 2023

# Requirements

A reasonably recent verson of a LaTeX distribution, namley, MikTeX, MacTeX, or TeXLive. 

For TeXLive and MacTeX, this means 2019 or newer. (MacTeX is just a macOS-specific redistribution of TeXLive.)

For MikTeX, this probably means 20.6 or newer (see [here](https://github.com/MiKTeX/miktex/issues/554) and [here](https://github.com/MiKTeX/miktex/tags?after=21.2)). This is a guess based on test results for TeXLive.<sup>1</sup> 

<sub><sup>1</sup>It is only for TeXLive that I can easily test if the template works on older versions, thanks to OverLeaf (see below).</sub>

If you are using a CGI editor such as LyX or even Scientific Word, note that they all use an underlying TeXLive or MikTeX distribution, and it is this underlying distribution that needs to be recent enough.

As far as I know, [all the other distributions](https://tex.stackexchange.com/questions/239199/latex-distributions-what-are-their-main-differences) have been retired/discontinued and are no longer updated. Of these, proTeXt (itself based on MikTeX) was retired in 2022, so the template might work with the more recent versions of it. As for the other ones (teTeX, fpTeX, emTeX, gwTeX, oztex, AmigaTeX, PasTeX, TrueTeX, pcTeX), they were all discontinued so long ago that even their most recent versions will probably not be recent enough for this template.

## Check your distribution version

First, open a terminal window (directions: [Windows](https://www.wikihow.com/Open-Terminal-in-Windows), [macOS](https://support.apple.com/en-az/guide/terminal/apd5265185d-f365-44cb-8b09-71a064a42125/mac)). Then, on the command line in the terminal, type

`pdflatex --version`

and press enter.

There will be several lines of output, but we are only interested in the first one. It should be something like:

### For MikTeX,

`MiKTeX-pdfTeX 4.21 (MiKTeX 25.3)`

In this case, the MiKTeX version would be 25.3.

### For TeXLive or MacTeX,

`pdfTeX 3.141592653-2.6-1.40.26 (TeX Live 2024)`

In this case, the TeXLive version would be 2024.

## Update your distribution if necessary

If your LaTeX distribution is too old, please update it. Directions: [MikTeX](https://miktex.org/howto/miktex-console); [MacTex](https://tex.stackexchange.com/questions/688954/mactex-upgrade-from-2022-to-2023) (macOS); [TeXLive](https://tex.stackexchange.com/questions/543284/kile-or-any-tex-software-cannot-find-tex-live-binaries-manually-installed-wh/736182#736182).

## Alternatively, try OverLeaf

If you are unable to update your distribution, consider using the free cloud-based LaTeX editor [OverLeaf](https://www.overleaf.com/). By default, this editor uses a TeXLive distribution that is no more than a year old. 

For most people, the free version of OverLeaf should be sufficient. However, if you anticipate that your thesis or dissertation will be several hundreds of pages long and/or contain many large (in terms of file sizes) images, you may need a paid version. 


# Repository contents 

1. Main LaTeX files: 

* class (.cls) 
* template (.tex) 

2. Other files needed to compile the template: 

* a .bib file
* a .pdf figure

# Maintainer

Vanja Dunjko

# Report problems

Send an email to umbthesislatex@gmail.com .


