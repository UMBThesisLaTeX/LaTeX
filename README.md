# Download directions

Click the green button labeled `<> Code`. and then click on `Download ZIP`. 

# Purpose

A LaTeX class and template for producing a master's thesis or a doctoral dissertation at UMass Boston.

## Limitations

### Only the _traditional format_

Only the _traditional format,_ with a single bibliography at the end, is supported out of the box. 

<sub>The other officially sanctioned format, the _multi-monograph (alternative) format,_ actually wouldn't be very difficult to produce; the key would be to use the ```chapterbib``` package. Indeed, some people have already done that on their own with older versions of this class and template. I just haven't gotten around to implementing that.</sub>

### Limited support for "parts"

If your thesis or dissertation includes multiple "parts" (a grouping above chapters), please note that the formatting of the Table of Contents (ToC) may end up requiring nontrivial manual LaTeX hacks. 

<sub>I am trying to get it automated, but it is _very_ challenging. The problem is the 'CHAPTER/Page' heading (see pdf page 21 of the UMass Boston style manual, which is labeled as p. 20). In general, this 'CHAPTER/Page' heading should be the top line on every non-first ToC page. However, if there are Parts, there is an exception: on those non-first ToC pages on which a Part appears as the first entry, it's the Part that should be the top entry, _followed_ by the 'CHAPTER/Page' heading (see pdf page 29 of the UMass Boston style manual). LaTeX doesn't have ready-made tools to handle this exceptional case.</sub>

### Untested support for BibLaTeX

The class and template have only been tested with BibTeX. _In principle,_ switching to [BibLaTeX](https://www.overleaf.com/learn/latex/Bibliography_management_with_biblatex) shouldn't be a problem. I just haven't tried it yet!

# Target  institution

UMass Boston

## Target style manual

_Standards for the Preparation of Theses and Dissertations at the University of Massachusetts Boston_ 

Link: likely the first hit [here](https://www.google.com/search?q=Standards%20for%20the%20Preparation%20of%20Theses%20and%20Dissertations%20at%20the%20University%20of%20Massachusetts%20Boston&client=ubuntu-sn&channel=fs&sclient=gws-wiz-serp). I don't provide a direct link because it changes too frequently; Google is our best bet to find it reliably.

### Version of style manual

May 2023

# Requirements

A reasonably recent version of a LaTeX distribution, namely, MikTeX, MacTeX, or TeXLive. 

For TeXLive and MacTeX, this means 2019 or newer. (MacTeX is just a macOS-specific redistribution of TeXLive.)

For MikTeX, this probably means 20.6 or newer (see [here](https://github.com/MiKTeX/miktex/issues/554) and [here](https://github.com/MiKTeX/miktex/tags?after=21.2)). This is a guess based on test results for TeXLive.<sup>1</sup> 

<sub><sup>1</sup>It is only for TeXLive that I can easily test if the class and template work on older versions, thanks to _Overleaf_ (see below).</sub>

If you are using a CGI editor such as LyX or even Scientific Word, note that they all use an underlying TeXLive or MikTeX distribution, and it is this underlying distribution that needs to be recent enough.

As far as I know, [all the other distributions](https://tex.stackexchange.com/questions/239199/latex-distributions-what-are-their-main-differences) have been retired/discontinued and are no longer updated. Of these, proTeXt (itself based on MikTeX) was retired in 2022, so the class and template might work with the more recent versions of it. As for the other ones (teTeX, fpTeX, emTeX, gwTeX, oztex, AmigaTeX, PasTeX, TrueTeX, pcTeX), they were all discontinued so long ago that even their most recent versions will probably not be recent enough for this class and template.

## Check your distribution version

First, open a terminal window (directions: [Windows](https://www.wikihow.com/Open-Terminal-in-Windows), [macOS](https://support.apple.com/en-az/guide/terminal/apd5265185d-f365-44cb-8b09-71a064a42125/mac)). Then, on the command line in the terminal, type

`pdflatex --version`

and press Enter.

There will be several lines of output, but we are only interested in the first one. It should be something like:

### For MikTeX,

`MiKTeX-pdfTeX 4.21 (MiKTeX 25.3)`

In this case, the MiKTeX version would be 25.3.

### For TeXLive or MacTeX,

`pdfTeX 3.141592653-2.6-1.40.26 (TeX Live 2024)`

In this case, the TeXLive version would be 2024.

## Update your distribution if necessary

If your LaTeX distribution is too old, please update it. Directions: [MikTeX](https://miktex.org/howto/miktex-console); [MacTex](https://tex.stackexchange.com/questions/688954/mactex-upgrade-from-2022-to-2023) (macOS); [TeXLive](https://tex.stackexchange.com/questions/543284/kile-or-any-tex-software-cannot-find-tex-live-binaries-manually-installed-wh/736182#736182).

## Alternatively, try _Overleaf_

If you are unable to update your distribution, consider using the free cloud-based LaTeX editor [_Overleaf_](https://www.overleaf.com/). By default, this editor uses a TeXLive distribution that is no more than a year old. 

For most people, the free version of _Overleaf_ should be sufficient. However, if you anticipate that your thesis or dissertation will be several hundred pages long and/or contain many large (in terms of file sizes) images, you may need a paid version. 

# Warning

**Make sure you _visually inspect_ every page of your document to make sure it adheres to the style manual.**

True, there is a high probability that this class and template will automatically produce a completely correctly formatted document. However, it is also perfectly possible that manual intervention might be necessary. 

For one thing, there might still be undiscovered bugs in the class and template. For another, as powerful as LaTeX is, some things it can't do on its own. 

For example, it is [basically impossible](https://tex.stackexchange.com/questions/4152/how-do-i-prevent-widow-orphan-lines) to automatically eliminate 'widows' and 'orphans' in every conceivable case. One can make them _very unlikely_ (as this template does, by loading the ```nowidow``` package), but there can always be stubborn cases where they persist. In such cases, the only practical solution may be to rewrite the text!

In addition to inspecting for widows and orphans, here are some other issues to watch out for, as far as formatting:

* intrusions into margins; the usual suspects are long words, URLs, equations, tables, or graphics. See e.g. [here](https://tex.stackexchange.com/questions/256526/enforce-strict-margin-boundaries).
* defects in the Table of Contents (and/or the List of Figures and/or List of Tables). The likelihood of this increases when there is an unusually high number of sections or figures or tables, or when the name of a section has just the 'magic' length to trip up LaTeX's algorithm. I have done a lot of work to make this sort of error unlikely, but it could still reappear.


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

Please note that there are two periods when I am unlikely to be available to help: roughly, Dec 15-Jan 15 and the month of August. 


