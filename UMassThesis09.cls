% class file UMassThesis_09.cls
% ----------------------------------------------------------------------------
%
% In what follows, "Standards-UMB" refers to "Standards for the Preparation of
% Theses and Dissertations at the University of Massachusetts Boston,"
% version May 2023. The current version of this document should be
% downloadable, as a pdf file, from
% https://www.umb.edu/media/umassboston/content-assets/admissions/graduate-students/UMass_Boston_Dissertation_Thesis_Submission_Standards_(Revised_May_2023)_1.pdf % .
% One can navigate there from the UMass Boston home page as follows: 
% Admissions -> Graduate Students -> Graduate Student Resources & Assistantships . 
% On that page, under 'Theses and Dissertations', click on 'Standards for the Preparation
% of Theses and Dissertations at the University of MStandards for the Preparation of Theses 
% and Dissertations at the University of M'. 
% (This is clearly a typo and presumably they will fix it eventually)
%
% However, the location of the document changes every so often. A perhaps more reliable option is 
% % to Google the following search string:
% 
% standards theses site:www.umb.edu
% 
% As of 2025/01/14, the very first result is the standards pdf document.

%
\NeedsTeXFormat{LaTeX2e}[1994/06/01]
\ProvidesClass{UMassThesis09}[2015/07/25 UMassThesis01; revised 2021/04/27, 2022/11/26, 2025/01/14]


% this is for testing purposes only (testing the positioning of front matter material)
\newif\iftestA
\newcommand{\testword}{WTQIENDEOJFPQJENTHDGWOJEIASBRKKDWPOLWQNGDHYEI}
% \testAtrue
\testAfalse




% This LaTeX class is based on the standard LaTeX 'report' class (report.cls), which we will load in a moment, once we process some options.
% The default behavior of our class will be that the 'report' class will be loaded with its default options---except for the font size. We want our class's default to be 12 pt, instead of report's default 10pt.

\newif\ifamsthm % This conditional will allow us to control whether the package 'amsthm' is loaded.
% LaTeX has conditionals, but they work just a little bit differently than what you might have seen in other programming languages. We'll describe how they work on this example. 
% Executing \newif\ifamsthm creates two new commands: \amsthmtrue and  \amsthmfalse. What is weird about this is that the string 'amsthm' is here really an argument, even though it enters as part of the command name! (So, for example, if we execute \newif\ifBlaBLA, this will create \BlaBLAtrue and  \BlaBLAfalse.) Anyway, \amsthmtrue and \amsthmfalse control what happens when, later in the code, we encounter the structure \ifamsthm ... \fi. If, some time prior to reaching this structure, we executed \amsthmtrue, then, upon reaching the structure, LaTeX will execute whatever code is between '\ifamsthm' and '\fi'. On the other hand, if we had executed \amsthmfalse, then LaTeX will not execute the code between '\ifamsthm' and '\fi'. If we executed both \amsthmtrue and \amsthmfalse, it is the most recently executed one that will count (in other words, \amsthmtrue and  \amsthmfalse act as 'switches'). There is also the structure \ifamsthm ... \else ... \fi, whose behavior is controlled in the same way.
%
% The way these commands get used is as follows:
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%% options controlling the loading of the package 'amsthm' %%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
\DeclareOption{amsthm}{\amsthmtrue} % if this option is invoked, LaTeX will execute \amsthmtrue. That will, in the code below, through \ifamsthm, cause  the 'amsthm' package to be loaded.
\DeclareOption{noamsthm}{\amsthmfalse} % if this option is invoked, LaTeX will execute \amsthmfalse. That will, in the code below, through \ifamsthm, cause  the 'amsthm' package to NOT be loaded.
%
% What if neither option is invoked? We should set up the default behavior. This is usually done through the \ExecuteOptions command. In our case, we want the default behavior to be that the 'amsthm' package is loaded. To do that, we will add 'amsthm' as an argument to the \ExecuteOptions command, below. This will cause LaTeX to execute that option, which means that \amsthmtrue will be executed even the option 'amsthm' wasn't invoked.
% Now suppose 'noamsthm' was invoked when calling the class. How does that override the default? Well, true, the \ExecuteOptions command will end up executing \amsthmtrue. But immediately after that, LaTeX will execute \ProcessOptions\relax. That command will execute the options that were actually invoked. And since 'noamsthm' was invoked, that means that \amsthmfalse will be executed. Thus, \amsthmfalse will get executed *after* \amsthmtrue, and so it is \amsthmfalse that will be 'in force' when LaTeX later encounters an \ifamsthm ... \fi block.
% In other words, this way of setting the default behavior works best if the commands that get executed are 'switches' of some sort.
%
% Let's now set up the other options.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%% options controlling the justification %%%%%%%%%%%%%%%%%%%%
%%%%%%%%% (especially the loading of the package 'ragged2e') %%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
\newif\ifJustified 
\DeclareOption{justified}{\Justifiedtrue} % if this option is invoked, the code will execute \Justifiedtrue. That will, through \ifJustified, later cause (among other things) the package 'ragged2e' to NOT be loaded, so the document will be justified. 
% We will make this be the default by including 'justified' among the options listed in \ExecuteOptions, below. 
\DeclareOption{raggedright}{\Justifiedfalse} % This will, through \ifJustified, later cause the package 'ragged2e' to be loaded (among other things), so the document will be flush left. 
\DeclareOption{flushleft}{\Justifiedfalse} % same as 'raggedright'
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%% options controlling the document font size %%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% We want 12pt to be the default. But the default for the 'report' class in 10pt, and so we have to make sure that the '12pt' option is passed to the 'report' class. 
%
% We won't be able to implement this default in the 'usual' way, by adding '12pt' as an argument to \ExecuteOptions. The reason is as follows.
%
% So, we have to pass '12pt' as an option to the report class by default, but this should be overridden if '10pt' or '11pt' options are invoked. We may try to accomplish this as follows. First, we make sure the '12pt' option is declared, and, when invoked, passed to the 'report' class. So we include \DeclareOption{12pt}{\PassOptionsToClass{12pt}{report}}, and then  add '12pt' as an argument to \ExecuteOptions. In this case, if none of the 'pt' options ('10pt', '11pt', or '12pt') are invoked when our class is loaded, the following happens:  \ExecuteOptions  will execute \PassOptionsToClass{12pt}{report}, and \ProcessOptions\relax will *not* execute either \PassOptionsToClass{10pt}{report} or \PassOptionsToClass{11pt}{report}. As a result, only the '12pt' option will be passed on to the 'report' class when we call it. And so the \LoadClass{report} command will load the 'report' class with '12pt' as an option. So far, so good. Now, as far as making it possible to override the default with '11pt' and '10pt', we can either declare them explicitly (e.g. \DeclareOption{11pt}{\PassOptionsToClass{11pt}{report}}) or we can just let them be handled by the catch-all command \DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}. The latter command handles all options that, in the present class, are invoked but not declared: namely, it just passes them all on to the 'report' class. This means that \LoadClass{report} will load the 'report' class with all such undeclared but invoked options, plus all the options we explicitly passed on via separate \PassOptionsToClass{ ... }{report} commands.
%
% Let's see how this would play out.
% First, suppose we don't invoke any of the 'pt' options ('10pt', '11pt', or '12pt'), or else we invoke the '12pt' option explicitly. In that case, everything will work as it should: the 'report' class will get loaded with the '12pt' option. 
%
% Now let's see what would happen if we invoked e.g. the '11pt' option in the present class. Well, regardless of whether we have an explicit declaration of that option (\DeclareOption{11pt}{\PassOptionsToClass{11pt}{report}}) or if we let \DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}} handle it, the same thing will happen: \ProcessOptions\relax will execute \PassOptionsToClass{11pt}{report}, and so \LoadClass{report} will load the 'report' class with the '11pt' option. This sounds like exactly what we want, but it's not the end of the story! Since we also have '12pt' as an argument to \ExecuteOptions, \PassOptionsToClass{12pt}{report} will *also* get executed. So \LoadClass{report} will actually load the 'report' class with *both* the '11pt' and '12pt' options. What happens in that case? Well, the 'report' class uses \ProcessOptions to process *its* options, and those options are processed in the order in which they are declared in that class. In that class, the '12pt' option is declared after the '11pt' option, and so the class will implement the '12pt' option---not what we wanted in this case. 
%
% (Note that there is also a 'starred' version of the \ProcessOptions command, \ProcessOptions*, which processes options in the order in which they were invoked. If the 'report' class used this starred version, then indeed the '11pt' option would get implemented, because, in the *present* class, things happen in the following order: first, \ExecuteOptions executes \PassOptionsToClass{12pt}{report}, and then \ProcessOptions executes PassOptionsToClass{11pt}{report}. So '11pt' is passed on after '12pt'.)
%
% All this to say, we'll have to do something different to implement the '12pt' option as the default. 
%
%
%
\newif\ifNotTwelvePt
\NotTwelvePtfalse % we execute this right away, in effect making it the default. It can be changed by executing \NotTwelvePttrue later.
% This will be used below in the following way:
%
% \ifNotTwelvePt
%     \LoadClass{report}
% \else
%     \LoadClass[12pt]{report}
% \fi

% We also need
\DeclareOption{10pt}{\NotTwelvePttrue\PassOptionsToClass{10pt}{report}}
\DeclareOption{11pt}{\NotTwelvePttrue\PassOptionsToClass{11pt}{report}}
\DeclareOption{12pt}{} % At this point, we could have alternatively put \DeclareOption{12pt}{\NotTwelvePtfalse}. Moreover, we could have left the '12pt' option undeclared. Then, if that option was invoked, it would be handled by the catch-all command \DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}, meaning that it would get passed to 'report'. But this is actually redundant, because the command that is eventually evaluated in this case is \LoadClass[12pt]{report} (since \NotTwelvePtfalse remains in force). 
%
% Why does this work? Well, if no 'pt' options ('10pt', '11pt', or '12pt') were invoked, \NotTwelvePtfalse remains in force. So once LaTeX reaches \ifNotTwelvePt, it will execute \LoadClass[12pt]{report}. The same happens if the '12pt' option is invoked: \NotTwelvePtfalse remains in force, and the '12pt' option is passed to 'report' both explicitly (\LoadClass[12pt]{report}) and through \PassOptionsToClass. On the other hand, suppose we invoked one of the other 'pt' options, say '11pt'. Then \ProcessOptions\relax will execute both \NotTwelvePttrue and \PassOptionsToClass{11pt}{report}. The former will make it so that once LaTeX reaches \ifNotTwelvePt, it will execute \LoadClass{report}. But since \PassOptionsToClass{11pt}{report} was also executed, the 'report' will be loaded with the '11pt' option.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%% options controlling the document paper size %%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
\def\UMB@papersize{letterpaper} % \UMB@papersize stores the papersize that will be used by the geometry package, below. As we can see, by default, this will be lettersize. This can be changed if one of the other 'paper' options (a4paper, legalpaper, etc.) is invoked. If one of these other options is invoked, it will also be passed to the report class when that class is loaded, below.
\DeclareOption{a4paper}{\def\UMB@papersize{a4paper}\PassOptionsToClass{a4paper}{report}}
\DeclareOption{a5paper}{\def\UMB@papersize{a5paper}\PassOptionsToClass{a5paper}{report}}
\DeclareOption{b5paper}{\def\UMB@papersize{b5paper}\PassOptionsToClass{b5paper}{report}}
\DeclareOption{letterpaper}{\def\UMB@papersize{letterpaper}\PassOptionsToClass{letterpaper}{report}}
\DeclareOption{legalpaper}{\def\UMB@papersize{legalpaper}\PassOptionsToClass{legalpaper}{report}}
\DeclareOption{executivepaper}{\def\UMB@papersize{executivepaper}\PassOptionsToClass{executivepaper}{report}}
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%% options controlling the document paper orientation %%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
\DeclareOption{portrait}{} % portrait orientation is the default, so just do nothing if that option is invoked
\def\UMB@orientation{portrait} % similar story as with paper size. This makes it so that the geometry package sets paper to be in the portrait orientation.
\DeclareOption{landscape}{\def\UMB@orientation{landscape}\PassOptionsToClass{landscape}{report}} % if the 'landscape' option is invoked, both the 'report' class and the geometry package will set the paper orientation to 'landscape'.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%% options passed to amsmath %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% 'amsmath' is required by 'newtxmath', and the latter is the main package that makes the math font go well with Times New Roman (well, the clone of Times New Roman, which is set as the document font by \newtxtext. These are all the options available in amsmath. 
%
\DeclareOption{intlimits}{\PassOptionsToClass{amsmath}{intlimits}}
\DeclareOption{nointlimits}{\PassOptionsToClass{amsmath}{nointlimits}}
\DeclareOption{sumlimits}{\PassOptionsToClass{amsmath}{sumlimits}}
\DeclareOption{nosumlimits}{\PassOptionsToClass{amsmath}{nosumlimits}}
\DeclareOption{namelimits}{\PassOptionsToClass{amsmath}{namelimits}}
\DeclareOption{nonamelimits}{\PassOptionsToClass{amsmath}{nonamelimits}}
\DeclareOption{leqno}{\PassOptionsToClass{amsmath}{leqno}}
\DeclareOption{reqno}{\PassOptionsToClass{amsmath}{reqno}}
\DeclareOption{centertags}{\PassOptionsToClass{amsmath}{centertags}}
\DeclareOption{tbtags}{\PassOptionsToClass{amsmath}{tbtags}}
\DeclareOption{cmex10}{\PassOptionsToClass{amsmath}{cmex10}}
\DeclareOption{fleqn}{\PassOptionsToClass{amsmath}{fleqn}}
\DeclareOption{alignedleftspaceyes}{\PassOptionsToClass{amsmath}{alignedleftspaceyes}}
\DeclareOption{alignedleftspaceno}{\PassOptionsToClass{amsmath}{alignedleftspaceno}}
\DeclareOption{alignedleftspaceyesifneg}{\PassOptionsToClass{amsmath}{alignedleftspaceyesifneg}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newif\ifHyperref
\Hyperreftrue
\DeclareOption{nohyperref}{\Hyperreffalse}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newif\ifAltSigSpacing
\AltSigSpacingfalse
\DeclareOption{altsigspacing}{\AltSigSpacingtrue}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}} % any other options should be just passed to the 'report' class

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%% processing the options %%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\ExecuteOptions{justified,amsthm} % these options will get executed no matter what. Because of how these are coded, these will serve as default values
\ProcessOptions\relax % executes the options that were actually invoked

% \LoadClass{report}

\ifNotTwelvePt
    \LoadClass{report}
\else
    \LoadClass[12pt]{report}
\fi

\RequirePackage{amsmath}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%% justification: justified or flush left (a.k.a. ragged right) %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% This block handles the loading (or lack thereof) of the package ragged2e, and also the loading of the package 'footmisc' (because 'ragged2e' loads it).
% If we want the document to be flush left (a.k.a. ragged right), we load the package 'ragged2e'.
% The 'footmisc' package allows us to customize the appearance of footnotes.

% A previous edition of the Standards-UMB had the following guideline (2012 edition, p. 11):
%
%         JUSTIFICATION: Do not justify the right hand margin of the page, because almost all
%         word processors achieve this justification by creating irregular spaces between words.
%         This irregular spacing is not acceptable.
%
% However, this recommendation is gone in the 2019 edition (which, as of Fall 2022, is the current edition). And in any event, LaTeX, especially when used with the 'microtype' package, does an excellent job of evening out these irregular spaces between words. Consequently, the default behavior of this class is to produce a justified document. If, for some reason, you nevertheless want it to be flush left, invoke the class either with the option 'raggedright' or with the option 'flushleft' (they are just aliases).

% In the following block, we will use \ifJustified, which was defined during the processing of options, above.
% When \ifJustified is true (which is the default for our class), then we want the document to be flush left. This is accomplished by loading the package 'ragged2e'. 
%
% It turns out that if the package 'ragged2e' is loaded with option 'document' (as we will do), this will also cause the package 'footmisc' to be loaded, with the option 'ragged'. 
%
% Now, we would also like 'footmisc' to be loaded with the option 'bottom', which forces footnotes (but not the floats) to the bottom of the page. It turns out that we can do that by adding 'bottom' as an option when loading 'ragged2e'; that package then passes that option to 'footmisc' when it calls it.

% The package 'ragged2e' also sets \parindent to 0pt, so that paragraphs would not be
% indented. However, the command "\setlength{\parindent}{\oldparindent}" 
% below, right after "\begin{document}, resets \parindent to its normal 
% value.
%
%

% here we use \ifJustified. If \ifJustified evaluates to 'true' (which will be so by default), then we will not load the package 'ragged2e'. On the other hand, it evaluates to 'false' (which will be so if the class UMassThesis_02 is loaded with the option 'raggedright' or its alias, the option 'flushleft'), we will load the package 'ragged2e' with the appropriate options. In either case, we need to define appropriately the command \JustificationTypeInCaption, which is used in the main document.

\newlength{\oldparindent}
\setlength{\oldparindent}{\parindent}
\ifJustified
    % the document should be justified, so we do not load ragged2e.
   \newcommand{\JustificationTypeInCaption}{justified}
% We didn't load ragged2e (which would, because of the option 'document, also load the package 'footmisc'), but nevertheless, we do want the footnotes to be at the bottom of the page. Thus, we need to load 'footmisc' ourselves, with the option 'bottom'
   \RequirePackage[bottom]{footmisc}
\else
% the document should be flush left, so we load ragged2e
   \RequirePackage[document,bottom]{ragged2e}
   \newcommand{\JustificationTypeInCaption}{RaggedRight}
\fi
%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% load the package 'setspace'. We will use it to regulate which parts of the 
% document are double-spaced (most of it), and which use some other spacing
%
\RequirePackage{setspace}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%
% The default behavior is that the first paragraph after the section header is
% NOT indented (whereas the subsequent paragraphs are). This package makes 
% it so that all paragraphs are indented, including the first.
%
\RequirePackage{indentfirst}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%
% the xspace command, defined by the eponymous package, corrects the
% otherwise incorrect placement of space after user-defined macros. See the
% documentation, xspace.pdf (just google it) for details.
%
% By the way, instead of googling the documentation of the various packages,
% all of their documentation should actually already be part of your LaTeX
% distribution, in the "doc" subdirectory. For example, in MikTeX 2.9 under
% Windows XP, the package documentation is found in the directory
% C:\Program Files\MiKTeX 2.9\doc .
%
\RequirePackage{xspace}
%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% the purpose of the package "fontenc" is explained here:
%
% http://tex.stackexchange.com/questions/664/why-should-i-use-usepackaget1fontenc
%
\RequirePackage[T1]{fontenc}
%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%% setting the document font to be (a clone of) Times New Roman %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% handling the packages 'amsthm' and 'amssymb' %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% the LaTeX default font is Knuth's 'Computer Modern' font. But Standards-UMB
% requires that the document be typeset in the Times New Roman font. 

% As of 2021, the recommended way to change the text font to (a free clone of)
% Times New Roman is to use the 'newtx' package. 

% if you want to use the package 'amsthm', you need to use load it before 'newtxtext', here:

\ifamsthm\RequirePackage{amsthm}\fi

% (see the documentation for newtx, http://mirrors.ctan.org/fonts/newtx/doc/newtxdoc.pdf ;
% search for 'amsthm').

% Here we load newtx. It consists of newtxtext (for setting the text font) and 
% newtxmath (for setting the math font). In principle, you can load one of them 
% and not the other, if you want a different combination of text and 
% math fonts. But these two are designed to work well together. Read newtxdoc.pdf 
% for other options. However, keep in mind that Standards-UMB requires Times New Roman
% for the text font. The package newtxtext selects the font 'TeXGyre Termes', 
% a free (near) clone of Times New Roman.




\newcommand\hmmax{0} % (sometimes) needed if using newtx, especially if the package 'bm' is used  
\newcommand\bmmax{0} % (sometimes) needed if using newtx, especially if the package 'bm' is used 
\RequirePackage[scaled=1.03]{newtxtext} % part of newtx; needs \newcommand\hmmax{0} and \newcommand\bmmax{0},above
\RequirePackage[scaled=1.03]{newtxmath} % part of newtx; needs \newcommand\hmmax{0} and \newcommand\bmmax{0},above

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%% dealing with 'amssymb'  %%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%% (given that we are using 'newtxtext' and  'newtxmath') %%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% The package 'newtxmath', which we've just loaded, has an unusual relationship to the package 'amssymb'. 
% Namely, 'newtxmath' defines every symbol that 'amssymb' does.
% The reason is that the glyphs in 'amssymb' are designed to go with Computer Modern font, whereas the corresponding symbols in 'newtxmath' are designed to match Times New Roman. Since we are using 'newtxtext' and 'newtxmath' precisely for making the document font be (a clone of) Times New Roman, it makes sense to use the 'newtxmath' version of these symbol fonts. Moreover, if you try to load 'amssymb' after loading 'newtxmath', LaTeX will report an error.
%
% At first glance, it seems that it is simple to handle all this: just don't load 'amssymb' if you're going to use newtxtmath!
%
% However, the problem is that there are some other packages that require 'amssymb', in the sense that they execute the command \RequirePackage{amssymb}. (Examples of such packages include 'dynkin-diagrams','phfqit', and some others.) An attempt to load 'amssymb' like that (after loading 'newtxmath') will result in an error, as we've already noted. 
%
% So how can we use these packages that attempt to load 'amssymb'? One solution is to make LaTeX 'think' that the 'amssymb' package has already been loaded even though it actually hasn't been. (This should be safe since all the symbols in 'amssymb' will be defined anyway.) Then any subsequent calls of \RequirePackage{amssymb} and \usepackage{amssymb} won't do anything.
%
% This is exaclty what the command \dontusepackage will do. First, we define it here (from https://tex.stackexchange.com/a/39418/192504 ):

\newcommand{\dontusepackage}[2][]{%
  \@namedef{ver@#2.sty}{9999/12/31}%
  \@namedef{opt@#2.sty}{#1}}

% And now we use it on 'amssymb':

\dontusepackage{amssymb}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%
% Next, we load the package "calc", which makes programming in LaTeX
% easier. Google it (like this: "calc package") to
% find its documentation. Or, look up its documentation in the "doc"
% subdirectory of your LaTeX distribution---see the comment preceding the
% \RequirePackage{xspace} command.
%
\RequirePackage{calc}
%


%%%%%%%%%%%%%%%%%%%%%%%%%% setting up the layout of the pages %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%% using the 'geometry' package %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% This loading of the package "geometry," together with the options given,
% sets the basic layout of the pages of the document---the document margins
% and some other stuff---so that it conforms to the Standards-UMB.
%
%
%  On p. 11 of the Standards-UMB, section "PAGINATION," it is stated that
% "[a]ll page numbers must be at least 1.25'' from the bottom of the page
% (measured from the bottom of the page number to the bottom of the 
% page)..."
% Moreover, on p. 12, it is stated that the bottom margin should be 1.25 in.
%

\newlength{\ExpectedBaselineSkip}
\setlength{\ExpectedBaselineSkip}{24pt}


% Remember that footnotes, despite their name, don't go into the footer. Footnotes go to the bottom of the page, but in such a way that the space occupied by a footnote would be occupied by regular text if the footnote was absent.
%
% In contrast, if the main text has a footer, it is by default present on every page (except possibly some special pages such as the first page of a chapter, the page announcing a different 'part', and so on). A footer may contain items such as the page number, or a 'running foot' containing some unchanging text or graphics. The footer appears below the text, and so below any footnotes.
%
% In the 'geometry' package, 'footskip' is the distance between the baseline of any text in the footer (e.g. the page number) and the baseline of the last line of the text on the same page. 



\RequirePackage[paper=\UMB@papersize,includefoot=true,left=1.25in,right=1in,top=1in,bottom=1.25in,footskip=1.5\ExpectedBaselineSkip,\UMB@orientation]{geometry}

% (the macros \UMB@papersize and \UMB@orientation were defined above, in the options processing section, i.e. where all the \DeclareOption commands are.)

% if the page number needs to be typeset in a special way:
% \patchcmd{\ps@plain}{\thepage}{\textcolor{red}{\thepage}}{}{} % makes the page numbers red
% \patchcmd{\ps@plain}{\thepage}{page~\raisebox{0.1\ExpectedBaselineSkip}{\thepage}}{}{} % typesets 'page' and then the page number, slightly raised.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% we will use the textpos package for the positioning of the
% various items in the 'front matter' of the thesis (i.e. in the
% Title Page, Copyright Page, Signatory Page, and Abstract.
\usepackage[absolute,overlay]{textpos}
\setlength{\TPHorizModule}{1bp}%
\setlength{\TPVertModule}{1bp}%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% The following commands are defined the same way that standard LaTeX defines the \author command, which is
%  \DeclareRobustCommand*\author[1]{\gdef\@author{#1}}
% The name of the author is thus stored in the variable \@author .


\DeclareRobustCommand*\AuthorDegrees[1]{\gdef\@AuthorDegrees{#1}}
\DeclareRobustCommand*\DirectedBy[1]{\gdef\@DirectedBy{#1}}
\DeclareRobustCommand*\ProgramName[1]{\gdef\@ProgramName{#1}}
\DeclareRobustCommand*\ThesisOrDissertation[1]{\gdef\@ThesisOrDissertation{#1}}
\DeclareRobustCommand*\DegreeName[1]{\gdef\@DegreeName{#1}}
\DeclareRobustCommand*\ProgramDirector[1]{\gdef\@ProgramDirector{#1}}
\DeclareRobustCommand*\DeptChairperson[1]{\gdef\@DeptChairperson{#1}}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% from the documentation for the package 'textcase': The textcase package offers commands \MakeTextUppercase and \MakeTextLowercase, which are similar to the standard \MakeUppercase and \MakeLowercase, but they do not change the case of any sections of mathematics, or the arguments of \cite, \label and \ref commands within the argument.
% Starting with the LaTeX distribution of June, 2022, the LaTeX commands MakeUppercase and \MakeLowercase been updated and they are identical to \MakeTextUppercase and \MakeTextLowercase
\usepackage{textcase}
%
%

% The following is experimental. It would be used if thesis/dissertation were in the 'multi-monograph (alternative) format'. This class currently assumes that the thesis/dissertation is in the 'traditional format'
% \usepackage{multibib}
% \newcites{citations}{CITATIONS}
% \newcites{references}{LIST OF REFERENCES}
% \let\oldcite\cite
% \renewcommand{\cite}[1]{\citecitations{#1}\nocitereferences{#1}}

% We need to change the name of the bibliography section to "CITATIONS", as
% required by Standards-UMB
%
% \renewcommand{\bibname}{CITATIONS}
%

% The following will include the bibliography (i.e. CITATIONS) in the Table of Contents.
% The option 'nottoc' is needed to prevent the inclusion of the Table of Contents 
% itself into the Table of Contents. 
% \usepackage[nottoc]{tocbibind} 
%
%
\newenvironment{UMBbibliography}[1]{
\addcontentsline{toc}{chapter}{CITATIONS}
\titleformat{\chapter}[display]{\normalfont\center}{}{0in}{}
\titlespacing*{\chapter}{0in}{-1.8\baselineskip}{3\baselineskip}
\begin{thebibliography}{#1}}
{\end{thebibliography}}
%
% We need to modify the default appearance of chapter headings in the body
% matter so that they conform to the Standards-UMB (i.e. so that they are 2 in
% from the top edge of the page, they say CHAPTER so-and-so, then skip
% doublespace, then the chapter name, and then some further skipping before
% the first paragraph). We use the package "titlesec" to accomplish this. 
%
\RequirePackage[newparttoc]{titlesec}
% \titleformat{\chapter}[display]{\center}{CHAPTER \thechapter}{0.5\baselineskip}{\MakeTextUppercase}
\titleformat{\chapter}[display]{\center}{CHAPTER \thechapter}{0.5\baselineskip}{}
\titlespacing{\chapter}{0in}{0.45in}{1.5\baselineskip}


\titleformat{\part}[display]
{\thispagestyle{empty}\huge\centering}
{\MakeTextUppercase{\partname}\nobreakspace\thepart.}
{0pt}
{\huge}


%\titleformat{\chapter}[display]{\rm\center}{CHAPTER \thechapter}{0.3in}{}

%\titlespacing*{\chapter}{0in}{0.52in}{0.3in}

\titleformat{\section}{}{\thesection}{0.17in}{}

\titleformat{\subsection}{\itshape}{\thesubsection}{0.17in}{}

\titleformat{\subsubsection}{\bfseries}{}{0.17in}{}
% \titleformat{\subsubsection}{\normalfont}{}{0.17in}{}
%
% We define a new chapter-like section, namely "topmatter". In this thesis,
% we use it only for the acknowledgment section. Most of the code concerns the
% appearance in the table of contents (the \addtocontents{toc} and
% \addcontentsline{toc} commands.) The \cftchapdotsep and \cftchapafterpnum
% are used by the "tocloft" package, which is the package we will use to
% fine-tune the formatting of the table of contents and the table of
% figures.
%
\titleformat{name=\chapter, numberless}[block]
{\normalfont\filright}
{}
{0ex}
{}%[\raisebox{1cm}{}]
\titlespacing{name=\chapter, numberless}{0pt}{-\baselineskip}{26.9pt}


% \newcommand{\oldcftchapdotsep}{}


\newcommand{\topmatter}[1]{
% \renewcommand{\oldcftchapdotsep}{\cftchapdotsep}
\clearpage
\pagestyle{plain}
\begin{center}
% \textls[500]{\MakeUppercase{#1}}
\MakeUppercase{#1}
\end{center}
% \addtocontents{toc}{\protect\renewcommand{\protect\cftchapafterpnum}{}}


% \titlecontents{chapter}[0bp]{\normalfont}%
%     {\contentslabel{0bp}\MakeTextUppercase}%
%     {\hspace*{-0bp}}%
%     {\titlerule*[3.3pt]{.}\contentspage[\thecontentspage]}

% Current:
\titlecontents{chapter}[0bp]{\normalfont}%
    {\contentslabel{0bp}}%
    {\hspace*{-0bp}}%
    {\titlerule*[3.3pt]{.}\contentspage[\thecontentspage]}
%


\addcontentsline{toc}{chapter}{#1}
\addtocontents{toc}{\protect\addvspace{12bp}}
% \addtocontents{toc}{\protect\renewcommand{\protect\cftchapafterpnum}{
% \hbox{\hspace{\ToCPageNumToRightMargin}}
% }}
}
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%% setting the table of contents (ToC), the list of figures (LoF),
%%%%%%%% and the list of tables (LoT)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%
%
% \RequirePackage{tocloft} % this package *can* be used, but it not recommended to be used at the same time as 'titlesec'. 
\RequirePackage{titletoc} % given that we are using 'titlesec', it is recommended we use this companion package.
%
%
%
\def\LoFName{LIST OF FIGURES}
\def\LoTName{LIST OF TABLES}

\iftestA
\renewcommand{\contentsname}{\mbox{}\hfill\testword\hfill\mbox{}}


\renewcommand{\listfigurename}{\mbox{}\hfill\testword\hfill\mbox{}}
\renewcommand{\listtablename}{\mbox{}\hfill\testword\hfill\mbox{}}
\else
\renewcommand{\contentsname}{\mbox{}\hfill TABLE OF CONTENTS\hfill\mbox{}}
\renewcommand{\listfigurename}{\mbox{}\hfill\LoFName\hfill\mbox{}}
\renewcommand{\listtablename}{\mbox{}\hfill\LoTName\hfill\mbox{}}
\fi

% According to the Standards-UMB, the TOC should look e.g. like this:
%
% ACKNOWLEDGMENTS ......................................     v
%
% LIST OF FIGURES ......................................     x
%
% LIST OF ABBREVIATIONS.................................  xiii
%
% CHAPTER                                                 Page
%
%    1. INTRODUCTION ...................................    1
%           Goals of the Study..........................    3
%
%
% Note that the page numbers v, x, xiii, and "Page" are all
% right-justified, but the page numbers 1 and 3 are indented
% a bit from the right. Here this is presented so that they
% are vertically aligned with the "g" of "Page", rather than
% with the "e". In fact, in the sample TOC in the Standards-UMB
% document itself, they are vertically aligned with a point
% in between the letters "g" and "e". In other words, with
% page numbers below 'Page', there is a little gap between the 
% page number and the right margin.
%
% Let's store the length of that gap into a new length,
% which we'll call \ToCPageNumToRightMargin :

\newlength{\ToCPageNumToRightMargin}
\setlength{\ToCPageNumToRightMargin}{\widthof{e}}

% The length \ToCDottedLineRightMargin is regulates how far the dotted line
% goes to the right; it is the distance between the last dot
% and the right margin.
\newlength{\ToCDottedLineRightMargin}
\setlength{\ToCDottedLineRightMargin}{\widthof{Page}}


\newlength{\ToCTextRightMarginRelativeToRightEndOfDots}
% \setlength{\ToCTextRightMarginRelativeToRightEndOfDots}{70bp}
\setlength{\ToCTextRightMarginRelativeToRightEndOfDots}{74bp}
\contentsmargin[\ToCTextRightMarginRelativeToRightEndOfDots]{\ToCDottedLineRightMargin}



% The following is how you could insert \MakeTextUppercase into a ToC formatting command. It works *provided* you don't use hyperref to make the ToC clickable. Unfortunately, if you do try to use hyperref for that purposes, it breaks, and not even the command \pdfstringdefDisableCommands{\def\MakeTextUppercase{}} will help.
 
% \titlecontents{chapter}[\ToCIndentChapterText]{\mbox{}\hspace{-\ToCTextOverhang}\normalfont}%
%     {\contentslabel[%
%     \setlength{\WidthA}{\widthof{\thecontentslabel}}%
%     \setlength{\WidthB}{\WidthA-5bp}%
%     \mbox{}\hspace{-\WidthB}\thecontentslabel]{13bp}\MakeTextUppercase}%
%     {\hspace*{-13bp}}%
%     {\titlerule*[3.3pt]{.}\contentspage[\thecontentspage\hbox{\hspace{\ToCPageNumToRightMargin}}]}
% }

% These two are auxilliary lengths that help us make the section labels (like '2.1') flush right. By default, they are flush left.
\newlength{\WidthA}\newlength{\WidthB}

% These length regulate various marging and indentations. Their names should give a pretty good idea of what they do, but the best way to see what each does is to change it slightly and see the effect
\newlength{\ToCTextOverhang}
\newlength{\ToCIndentChapterText}
\newlength{\ToCFurtherIndentSection}
\newlength{\ToCFurtherIndentSubSection}
\newlength{\ToCFurtherIndentSubSubSection}

\setlength{\ToCTextOverhang}{12pt}
\setlength{\ToCIndentChapterText}{43bp}
\setlength{\ToCFurtherIndentSection}{4em}
\setlength{\ToCFurtherIndentSubSection}{4.5em}
\setlength{\ToCFurtherIndentSubSubSection}{4em}


\titlecontents{section}[\ToCIndentChapterText+\ToCFurtherIndentSection]{\mbox{}\hspace{-\ToCTextOverhang}\normalfont}%
    {\contentslabel[%
    \setlength{\WidthA}{\widthof{\thecontentslabel}}\setlength{\WidthB}{\WidthA-5bp}\mbox{}\hspace{-\WidthB}\thecontentslabel%
    ]{13bp}}%
    {\hspace*{-13bp}}%
    {\titlerule*[3.3pt]{.}\contentspage[\thecontentspage\hbox{\hspace{\ToCPageNumToRightMargin}}]}

% \titlecontents{section}[\ToCIndentChapterText+\ToCFurtherIndentSection]{\mbox{}\hspace{-\ToCTextOverhang}\normalfont}%
%     {}%
%     {\hspace*{-13bp}}%
%     {\titlerule*[3.3pt]{.}\contentspage[\thecontentspage\hbox{\hspace{\ToCPageNumToRightMargin}}]}


\titlecontents{subsection}[\ToCIndentChapterText+\ToCFurtherIndentSection+\ToCFurtherIndentSubSection]{\mbox{}\hspace{-\ToCTextOverhang}\normalfont}%
    {\contentslabel[%
    \setlength{\WidthA}{\widthof{\thecontentslabel}}\setlength{\WidthB}{\WidthA-5bp}\mbox{}\hspace{-\WidthB}\thecontentslabel%
    ]{13bp}}%
    {\hspace*{-13bp}}%
    {\titlerule*[3.3pt]{.}\contentspage[\thecontentspage\hbox{\hspace{\ToCPageNumToRightMargin}}]}
    
\titlecontents{subsubsection}[\ToCIndentChapterText+\ToCFurtherIndentSection+\ToCFurtherIndentSubSection+\ToCFurtherIndentSubSubSection]{\mbox{}\hspace{0in}\normalfont}%
    {\contentslabel[%
    \setlength{\WidthA}{\widthof{\thecontentslabel}}\setlength{\WidthB}{\WidthA-5bp}\mbox{}\hspace{-\WidthB}\thecontentslabel%
    ]{13bp}}%
    {\hspace*{-13bp}}%
    {\titlerule*[3.3pt]{.}\contentspage[\thecontentspage\hbox{\hspace{\ToCPageNumToRightMargin}}]}


    
\titlecontents{part}[1in]{\normalfont\mbox{}\hspace{0.8in}\mbox{}\hfill}%
{\contentslabel[%
% \setlength{\WidthA}{\widthof{\thecontentslabel}}\setlength{\WidthB}{\WidthA+1in}\mbox{}\hspace{-\WidthB}
PART~\thecontentslabel.%
]{43bp}}%
{\hspace*{-43bp}}%
{\hfill\mbox{}}

    
%  setting part entry

% \def\@part[#1]#2{%
%     \ifnum \c@secnumdepth >-2\relax
%       \refstepcounter{part}%
%       \addtocontents{toc}{\mbox{}\par}
%       \addtocontents{toc}{\normalfont\protect\centering\MakeTextUppercase{\partname}~\thepart.~{}\MakeTextUppercase{#1}\par}%
%     \else
%       \addcontentsline{toc}{part}{#1}%
%     \fi
%     \markboth{}{}%
%     {\centering
%      \interlinepenalty \@M
%      \normalfont
%      \ifnum \c@secnumdepth >-2\relax
%        \huge \partname\nobreakspace\thepart
%        \par
%        \vskip 20\p@
%      \fi
%      \Huge #2\par}%
%     \@endpart}
    
    
% \usepackage{xpatch}
% 
% \xpatchcmd{\@part}{%
%   \addcontentsline{toc}{part}{\thepart\hspace{1em}#1}%
% }{%
%   \addtocontents{toc}{\mbox{}\par}
%   \addtocontents{toc}{\normalfont\protect\centering\MakeTextUppercase{\partname}~\thepart.~{}\MakeTextUppercase{#1}\par}%
% }{}{}
% 
% \xpatchcmd{\@part}{%
%   \huge\bfseries \partname\nobreakspace\thepart
% }{%
%   \huge \partname\nobreakspace\thepart
% }{}{}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% The following commands make it so that in the figure 
% captions, we have correct left-justification of the figure and subfigure 
% labels (in other words, of "Figure" for the main caption, and of the "(a)", % "(b)", etc. labels for the subcaptions). Namely, without intervention, 
% "Figure" and "(a)" etc. appear indented in the captions. The commands 
% "\hspace{-3ex}" and "\hspace{-4ex}" correct for that.
%
% Unless the 'justified' option was invoked when loading the class package, \JustificationTypeInCaption will be equal to 'RaggedRight'. This type of justification is provided by the ragged2e package, which the UMassThesis_01 class has already loaded (again, unless the 'justified' option was invoked).
% On the other hand, if  'justified' option was invoked, then \JustificationTypeInCaption will be equal to 'justified'.



% \RequirePackage{caption}
\RequirePackage{subcaption} % This package allows us to format the captions of figures and subfigures. It loads the package 'captions', too.

\DeclareCaptionFormat{MyPlain}{#1#2#3\par\addtocontents{lof}{\protect\addvspace{10pt}}\addtocontents{lot}{\protect\addvspace{10pt}}}

\captionsetup{margin=0.25in,format=MyPlain,labelformat=simple,justification=justified,font={singlespacing,small}}

% \captionsetup{margin=0.25in,format=plain,labelformat=simple,justification=\JustificationTypeInCaption,font={singlespacing,small}}
%
% \renewcommand{\figurename}{\normalfont \mbox{}\hspace{-3ex}Figure}
\renewcommand{\figurename}{\normalfont Figure}
%
\DeclareCaptionLabelFormat{left-justify_label}{\mbox{}\hspace{-4ex}(#2)} 
%


\newlength{\FigMainIndent}\setlength{\FigMainIndent}{49.3bp+10pt}
\newlength{\FigPullIndent}\setlength{\FigPullIndent}{2em}
\newlength{\FigLabelShift}
% \setlength{\FigLabelShift}{23bp}
\setlength{\FigLabelShift}{33bp}

% \RequirePackage{xstring}
%
% \newlength{\WidthA}\newlength{\WidthB}
% \newlength{\WidthC}\newlength{\WidthD}
% \newlength{\FigLabelSpace}
% \titlecontents{figure}[\FigMainIndent]{\mbox{}\hspace{-\FigPullIndent}\normalfont}%
%     {\contentslabel[%
%       \def\afact{\StrBehind{\thecontentslabel}{.}}
%       \setlength{\WidthA}{\widthof{\afact}}
%       \setlength{\WidthB}{20bp-\WidthA}
%       \def\bfact{\StrBefore{\thecontentslabel}{.}}
%       \setlength{\WidthC}{\widthof{\bfact}}
%       \setlength{\WidthD}{-\WidthC}
% %       \def\LenAfact{\StrLen{\afact}}
% %     \def\afact{\mymath 3 pt - \StrLen{\StrBehind{\thecontentslabel}{.}} pt}%
% %     \setlength{\FigLabelSpace}{\afact\WidthOfZero}%
%     \mbox{}\hspace{\WidthD}\thecontentslabel\hspace{%
% %     \FigLabelSpace%
%     \WidthB%
%     }\mbox{}%
%     ]{\FigLabelShift}}%
%     {\hspace*{-\FigLabelShift}}%
%     {\titlerule*[3.3pt]{.}\contentspage[\thecontentspage\hbox{\hspace{\ToCPageNumToRightMargin}}]}



\titlecontents{figure}[\FigMainIndent]{\mbox{}\hspace{-\FigPullIndent}\normalfont}%
    {\contentslabel[%
    \setlength{\WidthA}{\widthof{\thecontentslabel}}%
    \setlength{\WidthB}{\WidthA-25bp}%
    \mbox{}\hspace{-\WidthB}%
    \thecontentslabel]{\FigLabelShift}}%
    {\hspace*{-\FigLabelShift}}%
    {\titlerule*[3.3pt]{.}\contentspage[\thecontentspage\hbox{\hspace{\ToCPageNumToRightMargin}}]}


% \newlength{\FigMainIndent}\setlength{\FigMainIndent}{49.3bp+10pt}
% \newlength{\FigPullIndent}\setlength{\FigPullIndent}{2em}
% \newlength{\FigLabelShift}\setlength{\FigLabelShift}{23bp}
% \titlecontents{table}[\FigMainIndent]{\mbox{}\hspace{-\FigPullIndent}\normalfont}%
%     {\contentslabel[\thecontentslabel]{\FigLabelShift}}%
%     {\hspace*{-\FigLabelShift}}%
%     {\titlerule*[3.3pt]{.}\contentspage[\thecontentspage\hbox{\hspace{\ToCPageNumToRightMargin}}]}

\titlecontents{table}[\FigMainIndent]{\mbox{}\hspace{-\FigPullIndent}\normalfont}%
    {\contentslabel[%
    \setlength{\WidthA}{\widthof{\thecontentslabel}}%
    \setlength{\WidthB}{\WidthA-25bp}%
    \mbox{}\hspace{-\WidthB}%
    \thecontentslabel]{\FigLabelShift}}%
    {\hspace*{-\FigLabelShift}}%
    {\titlerule*[3.3pt]{.}\contentspage[\thecontentspage\hbox{\hspace{\ToCPageNumToRightMargin}}]}


% this is, in effect, a change in the command \chapter, made to prevent extra vertical
% spaces appearing in the list of figures between chapters
%
% \newcommand{\UMBchapter}[1]{\chapter{\protect\MakeTextUppercase{#1}}\addtocontents{lof}{\protect\addvspace{-10pt}}}
% \newcommand{\UMBchapter}[1]{\chapter{\MakeTextUppercase{#1}}\addtocontents{lof}{\protect\addvspace{-10pt}}}


% \newcommand{\UMBchapter}[1]{\addtocontents{toc}{\protect\addvspace{12.3bp}}\chapter{#1}}
% Current:
\newcommand{\UMBchapter}[1]{\addtocontents{toc}{\protect\addvspace{12.3bp}}\chapter{\MakeTextUppercase{#1}}}
% \let\UMBchapter\chapter
%
% You may wonder why we didn't just redefine the command \chapter, like this:
%
% \let\oldchapter\chapter (this makes a clone of \chapter as it is at that moment)
% \renewcommand{\chapter}[1]{the same code as in the definition of \UMBchapter above, 
% but instead of \chapter we use \oldchapter}
%
% The reason we don't do that is that the command \chapter is a workhorse that is used
% by other commands, and redefining it may have unwanted effects on those other 
% commands. For example, in report.cls (which we are in fact using, see above), the
% following commands are all defined in terms of \chapter: \listoffigures,
% \listoftables, and the environment 'thebibliography'. Of course, we could just copy
% their definitions here and replace all occurrences of \chapter in them by \oldchapter.
% But what happens if someone tries to use a package that also uses \chapter in a 
% nontrivial way? We would have to fix the commands in that package, too. Clearly, that
% way madness lies. We don't want to mess with a workhorse command such as \chapter.
% Instead, we define a new customized version of it, \UMBchapter.


\let\UMBpart\part
% \newcommand{\UMBpart}[1]{%
% \part{\MakeTextUppercase{#1}}
% }
% \addtocontents{toc}{\protect\contentsline{chapter}{CHAPTER}{Page}{}}
% \addtocontents{toc}{\protect\mbox{}\protect\hfill \protect\partname~\protect\thepart \protect\hfill\protect\mbox{}}
% \addcontentsline{toc}{chapter}{\protect\numberline{}Preface}
% \addcontentsline{toc}{chapter}{\protect Preface}
% }

% \addtocontents{toc}{\protect\contentsline{chapter}{CHAPTER}{Page}{}}

%

%
%%%%

%
% The following code is useful when one needs to intervene in LaTeX's
% formatting of paragraphs, say by forcing linebreaks: any text enclosed
% between "\startsquarepar" and "\stopsquarepar" will be formatted as if the
% paragraph doesn't end with whatever text is right before "\stopsquarepar,"
% even if it does. 
% It's also useful when one is setting the positions of floats (e.g. figures
% and tables) by hand, using the command [H] from the float package. Namely,
% sometimes one wants to put the float right in the middle of a paragraph.
% Normally this will result in LaTeX dividing that paragraph into two---the
% part before the float, and the part after, with the corresponding formatting.
% The solution is to put the text before the float in between
% "\startsquarepar" and "\stopsquarepar", and start the text after the
% float with "\noindent".
%
\newcommand{\startsquarepar}{%
    \par\begingroup \parfillskip 0pt \relax}
%
\newcommand{\stopsquarepar}{%
    \par\endgroup}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Parameters for formatting the signatory page: the location and look of the signature lines, people names, ranks, and (for external members) affiliations.

\newlength{\SignaturePersonLineThickness}
\setlength{\SignaturePersonLineThickness}{0.4pt}
\newlength{\SignaturePersonLineRaiseHeight}
\setlength{\SignaturePersonLineRaiseHeight}{-2pt}
% \newcommand{\SignaturePersonLineToNameVertDist}{7.5}
% \newcommand{\AnOffs}{1.6}
% \newcommand{\SignaturePersonLineToNameVertDist}{\mymath 7.5 pt - \AnOffs pt}
\newcommand{\SignaturePersonLineToNameVertDist}{5.9}
\newcommand{\SignaturePersonSpacing}{1.15}
\newcommand{\SigVertDistInternal}{}

\newlength{\SignaturePersonLineLength}
\setlength{\SignaturePersonLineLength}{290pt}

\newcommand{\SignaturePersonText}[1]{%
\begin{spacing}{\SignaturePersonSpacing}
\setlength{\parindent}{0pt}
#1
\end{spacing}
}




\newcommand{\SignaturePerson}[1]{%
\renewcommand{\SigVertDistInternal}{\CurrentSignaturePersonVerticalPosition}
\begin{textblock}{\SignaturePersonTextwidthInBp}(\SignaturePersonLeftMarginInBp,\SigVertDistInternal)
% \setlength{\parindent}{0pt}
\noindent
% \rule[\SignaturePersonLineRaiseHeight]{\SignaturePersonLineLength}{\SignaturePersonLineThickness}
\rule{\SignaturePersonLineLength}{\SignaturePersonLineThickness}
\end{textblock}
\begin{textblock}{\SignaturePersonTextwidthInBp}(\SignaturePersonLeftMarginInBp,{\mymath \SigVertDistInternal pt+ \SignaturePersonLineToNameVertDist pt})
\begin{spacing}{\SignaturePersonSpacing}
\setlength{\parindent}{0pt}
#1
\end{spacing}
\end{textblock}
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% we need the following to handle cases where the ToC and/or LoF and/or LoT go across more than one page. For the TOC, in that case we need to repeat the line that  "CHAPTER" at far left and "Page" at far right (and similarly for the LoF and LoT). In those cases, \MyShipoutHook will be redefined at an appropriate point.
\usepackage{atbegshi}
\newcommand\MyShipoutHook{}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% The following command, \mymath, strips off the unit of a length, converting it to a string (which looks like a real number or integer).
% It can be used to do simple arithmetic. 
%
% An example: suppose \FirstNumber and \SecondNumber are strings that look like real numbers or integers. We might define them like this:
% \newcommand{\FirstNumber}{35.141}
% \newcommand{\SecondNumber}{-2.615}
% Then, to get a string that is equal to, e.g., (3.7\FirstNumber -5.86\SecondNumber)*8, we write 
% \mymath ((\FirstNumber pt)*37/10-(\SecondNumber pt)*586/100)*8
% The output is '1162.76526'; the correct result is 1162.7648. 
%
% Note that multiplication and division must be by integers, and these operations must come after the variables. So the following would not work: 
% '\mymath 2*(\FirstNumber pt)'. Instead, the multiplication by 2 must come at the end: '\mymath (\FirstNumber pt)*2' .
%
% The idea behind this is the following. The package 'calc' (which we've already loaded) can do arithmetic with lengths. So we first convert our numbers (which are actually strings) to lengths (by simply adding 'pt' to the strings). Then we do the arithmetic, which returns a length as the result. Finally, we use \mymath to convert this resulting length to a string.
%
% \makeatletter
\newcommand{\mymath}{\strip@pt\dimexpr}
% \makeatother


% this stores the month in \DegreeMonth and the year in \DegreeYear
\newcommand{\DegreeMonthYear}[2]{\def\DegreeMonth{#1}\def\DegreeYear{#2}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newlength{\HeightBoxOne}
\newlength{\HeightBoxTwo}
\newlength{\HeightBoxThree}
\newlength{\HeightBoxFour}
\newlength{\HeightBoxFive}
\newlength{\HeightBoxSix}
\newlength{\HeighProgDir}
\newlength{\HeighDeptChair}
\newlength{\HeightBox}

\newlength{\CummulativeHeightOfBoxes}
\newlength{\CummulativeHeightOfMemberBoxes}
\newlength{\TotalHeightLength}
\newlength{\DepthLength}
\newsavebox{\boxToBeMeasured}
\setlength{\CummulativeHeightOfMemberBoxes}{0pt}
\setlength{\TotalHeightLength}{0pt}
\setlength{\HeightBoxOne}{0pt}
\setlength{\HeightBoxTwo}{0pt}
\setlength{\HeightBoxThree}{0pt}
\setlength{\HeightBoxFour}{0pt}
\setlength{\HeightBoxFive}{0pt}
\setlength{\HeightBoxSix}{0pt}
\setlength{\HeighProgDir}{0pt}
\setlength{\HeighDeptChair}{0pt}


\newcommand{\MeasureBox}[1]{%
\savebox{\boxToBeMeasured}{\noindent%
\begin{minipage}[b]{\textwidth}
\color{red}
#1
\end{minipage}
}
\setlength{\TotalHeightLength}{\totalheightof{\usebox{\boxToBeMeasured}}}
\setlength{\DepthLength}{\depthof{\usebox{\boxToBeMeasured}}}
\global\TotalHeightLength=\TotalHeightLength
\global\DepthLength=\DepthLength
% \global\boxToBeMeasured=\boxToBeMeasured
}


\newcount\numCommMembr % Define a counter
\numCommMembr=0 % Initialize the counter to 0

% \def\AddCommitteeMember#1{%
%   \advance\numCommMembr by 1 % Increment the counter
%   \expandafter\def\csname CommitteeMember\the\numCommMembr\endcsname{#1}%
% }

\newlength{\auxlength}
\def\AddCommitteeMember#1{%
  \advance\numCommMembr by 1 % Increment the counter
  \expandafter\def\csname CommitteeMember\the\numCommMembr\endcsname{#1}%
  \begin{spacing}{\SignaturePersonSpacing}
  \MeasureBox{\csname CommitteeMember\the\numCommMembr\endcsname}
  \end{spacing}
  \setlength{\auxlength}{\TotalHeightLength + \SignaturePersonLineToNameVertDist bp}
  \expandafter\xdef\csname HeightBox\the\numCommMembr\endcsname{\mymath \auxlength}
  \setlength{\CummulativeHeightOfBoxes}{\CummulativeHeightOfBoxes+\auxlength}
  \global\CummulativeHeightOfBoxes=\CummulativeHeightOfBoxes
%   \expandafter\newlength{\csname HeightBox\the\numCommMembr\endcsname}
%   \setlength{\HeightBox}{\TotalHeightLength + \SignaturePersonLineToNameVertDist bp}
% %   \setlength{\CummulativeHeightOfMemberBoxes}{\CummulativeHeightOfMemberBoxes+\HeightBox}
%   \expandafter\global{\csname HeightBox\the\numCommMembr\endcsname}=\HeightBox
%   \expandafter\global\expandafter\setlength\csname HeightBox\the\numCommMembr\endcsname{\dimexpr\TotalHeightLength + \SignaturePersonLineToNameVertDist bp\relax}
}


% The following command increases \CurrentSignaturePersonVerticalPosition by \CommitteLinesVertDist
\newcommand{\advanceVericalPosition}{%
\edef\CurrentSignaturePersonVerticalPosition{\mymath \CurrentSignaturePersonVerticalPosition pt + \CommitteLinesVertDist pt}
}
% \edef is a bit like LaTeX's \newcommand (and even more like TeX's
% \def command), in that it defines a macro, here
% \CurrentSignaturePersonVerticalPosition. The difference is that \edef evaluates the
% definition of the macro (here \mymath \CurrentSignaturePersonVerticalPosition pt + \CommitteLinesVertDist pt) right
% away, at the time of definition. In contrast, \newcommand (and
% \def) would keep \CurrentSignaturePersonVerticalPosition just as it is, and only evaluate it later. 
% But because the definition is recursive, \newcommand and \def would be caught in an infinite loop, attempting to expand the definition forever.
% To see why, consider the following example:
% \def\ax{c}
% \def\ax{d\ax}
% \ax
% When LaTeX encounters the second \def command, is defines \ax literally as 'd\ax'; it does not attemt to expand \ax at that point.
% Now, what happens when LaTeX encounters the command '\ax' in the next line? It sees that it's a macro, so it expands it, literally to 'd\ax'. Since the expansion contains other macros (namely, \ax), LaTeX will expands those, so we get 'dd\ax'. This still has a macro in it, so it has to be expanded, to 'ddd\ax'. With \ax, this process never ends. There is a built-in limit of how many expansion steps are possible, and once this limit is reached, LaTeX quits and reports an error: 'TeX capacity exceeded, sorry [input stack size=5000].'
% Now let's replace the \def in the recursive step with \edef:
% \def\ax{c}
% \edef\ax{d\ax}
% \ax
% In this case, when LaTeX encounters the \edef command, it defines \ax to be what 'd\ax' expands to right there and then. At that point, \ax expands to 'c', so the new definition of \ax becomes 'dc'. Finally, the command \ax in the next row expands to 'dc', so this is what LaTeX returns.


%define the command \verythinspace (with a width equal to 0.3 times the width of \, )
\protected\def\verythinspace{%
  \ifmmode
    \mskip0.3\thinmuskip
  \else
    \ifhmode
      \kern0.050004em
    \fi
  \fi
}

\protected\def\mvthspace{%
  \ifmmode
    \mskip0.6\thinmuskip
  \else
    \ifhmode
      \kern0.1em
    \fi
  \fi
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% the command \convertto is used to express a length in terms of some specified unit. It returns a pure string, not a length.
% For example, \convertto{bp}{1.25in} will return the string '90.00104' (should be just '90', because 1 in = 72 bp and 1.25 x 72 = 90; but the 'LaTeX calculator' is only precise to about four significant figures in these sorts of calculations)

% \makeatletter % it is not clear to me why this is necessary given that we are in a class file. But without it, we get an error in the main document.
\def\convertto#1#2{\strip@pt\dimexpr #2*65536/\number\dimexpr 1#1}
% \makeatother % Apparently, using \makeatother in a class file is bad (luckily, we don't need it). See https://tex.stackexchange.com/questions/62583/is-it-really-bad-to-use-makeatletter-and-makeatother-in-a-package-or-class-fil 


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\edef\LeftMarginInBp{\convertto{bp}{1.25in}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% The title page
\edef\TitlePageTextWidthInBp{\convertto{bp}{6.5in}}
\edef\TitlePageLeftMarginInBp{\convertto{bp}{1in}}

\newcommand{\PrintTitlePage}{%
\thispagestyle{empty}

% We will need the following width:
\edef\textwidthInBp{\convertto{bp}{\textwidth}}
% \edef is a bit like LaTeX's \newcommand (and even more like TeX's
% \def command), in that it defines a macro, here
% \textwidthInBp. The difference is that \edef evaluates (expands) the
% definition of the macro (which is \convertto{bp}{\textwidth}) right
% away, at the time of definition. In contrast, \newcommand (and
% \def) would keep the definition unexpanded, and only expand it when the command is actually used. 
% But that means that the underlying TeX engine would have to
% compute \convertto{bp}{\textwidth} each time \textwidthInBp is
% used, and we use it several times. With \edef, it needs to be
% computed only once, at the time of definition.
%

% Incidentally, \edef is what we have to use in any recursive definition. See the comments following the definition of '\advanceVericalPosition' in the class file (UMassThesis_08.cls). 
% 


% print the title
\begin{textblock}{\TitlePageTextWidthInBp}(\TitlePageLeftMarginInBp,133.2)
\centering
% \begin{spacing}{1.15}
\begin{doublespace}
 \titlels{\MakeUppercase{\TitleName}}
 \end{doublespace}
% \end{spacing}
\end{textblock}

\newcommand{\@AuthorNameByVOffset}{0.025}
\newlength{\AuthorNameByVOffset}

% print 'Dissertation presented by ...' or 'Thesis presented by ...'
\begin{textblock}{\TitlePageTextWidthInBp}(\TitlePageLeftMarginInBp,215.9)
\centering
\begin{spacing}{1.15}
 \setlength{\AuthorNameByVOffset}{\@AuthorNameByVOffset\baselineskip-\baselineskip}
 A \@ThesisOrDissertation\ Presented \\
 by\\
 \mbox{}\vskip\AuthorNameByVOffset\authorls{\MakeUppercase{\@author}}   % YOUR NAME is in CAPITALS
\end{spacing}
\end{textblock}

\begin{textblock}{\TitlePageTextWidthInBp}(\TitlePageLeftMarginInBp,314.73)
\centering
\begin{spacing}{1.15}
Submitted to the Office of Graduate Studies, \\
University of Massachusetts Boston, \\
in partial fulfillment of the requirements for the degree of
\end{spacing}
\end{textblock}

% print the name of degree; 'doctor or philosophy', or 'master of science', etc.
\begin{textblock}{\TitlePageTextWidthInBp}(\TitlePageLeftMarginInBp,430.3)
\centering
\titlels{\MakeUppercase{\@DegreeName}}
\end{textblock}

% print month and year
\begin{textblock}{\TitlePageTextWidthInBp}(\TitlePageLeftMarginInBp,463.5)
\centering
\DegreeMonth\xspace\DegreeYear
\end{textblock}

% print the name of your program, e.g. 'Applied Physics Program', 'Computational Sciences Program', etc.
\begin{textblock}{\TitlePageTextWidthInBp}(\TitlePageLeftMarginInBp,546.0)
\centering
\makeatletter
\@ProgramName
\makeatother
\end{textblock}
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% the copyright page
\newcommand{\PrintCopyrightPage}{%
\edef\textwidthInBp{\convertto{bp}{\textwidth}}
\begin{textblock}{\TitlePageTextWidthInBp}(\TitlePageLeftMarginInBp,210.6)
\centering
\begin{spacing}{1.15}
\noindent \copyright~\DegreeYear\xspace by \@author \\% Your Name *not* all caps
 All rights reserved
\end{spacing}
\end{textblock}
}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% the signature page

% adapted from https://tex.stackexchange.com/a/184997/192504
\newcommand{\providelength}[2]{%
  \@ifundefined{\expandafter\@gobble\string#1}
   {% if #1 is undefined, do \newlength
    \newlength{#1}\setlength{#1}{#2}%
   }
   {}%
}

\newlength{\SigPagePresentedByOffset}
\setlength{\SigPagePresentedByOffset}{0bp}

\newlength{\DeptChairVOffset}
\newlength{\ProgDirVOffset}
\newlength{\MemberOneVOffset}
\newlength{\MemberTwoVOffset}
\newlength{\MemberThreeVOffset}
\newlength{\MemberFourVOffset}
\newlength{\MemberFiveVOffset}
\newlength{\MemberSixVOffset}
\newlength{\TopRefSigLineVOffset}
\newlength{\BottomRefSigLineVOffset}

% \newlength{\HeightBoxOne}
% \newlength{\HeightBoxTwo}
% \newlength{\HeightBoxThree}
% \newlength{\HeightBoxFour}
% \newlength{\HeightBoxFive}
% \newlength{\HeightBoxSix}
% \newlength{\HeighProgDir}
% \newlength{\HeighDeptChair}

% \newlength{\CummulativeHeightOfBoxes}
% \newlength{\TotalHeightLength}
% \newlength{\DepthLength}
% \newsavebox{\boxToBeMeasured}
% \setlength{\TotalHeightLength}{0pt}
% \setlength{\HeightBoxOne}{0pt}
% \setlength{\HeightBoxTwo}{0pt}
% \setlength{\HeightBoxThree}{0pt}
% \setlength{\HeightBoxFour}{0pt}
% \setlength{\HeightBoxFive}{0pt}
% \setlength{\HeightBoxSix}{0pt}
% \setlength{\HeighProgDir}{0pt}
% \setlength{\HeighDeptChair}{0pt}

\setlength{\DeptChairVOffset}{0pt}
\setlength{\ProgDirVOffset}{0pt}
\setlength{\MemberOneVOffset}{0pt}
\setlength{\MemberTwoVOffset}{0pt}
\setlength{\MemberThreeVOffset}{0pt}
\setlength{\MemberFourVOffset}{0pt}
\setlength{\MemberFiveVOffset}{0pt}
\setlength{\MemberSixVOffset}{0pt}
\setlength{\TopRefSigLineVOffset}{0pt}
\setlength{\BottomRefSigLineVOffset}{0pt}



% \newcommand{\MeasureBox}[1]{%
% \savebox{\boxToBeMeasured}{\noindent%
% \begin{minipage}[b]{\textwidth}
% \color{red}
% #1
% \end{minipage}
% }
% \setlength{\TotalHeightLength}{\totalheightof{\usebox{\boxToBeMeasured}}}
% \setlength{\DepthLength}{\depthof{\usebox{\boxToBeMeasured}}}
% \global\TotalHeightLength=\TotalHeightLength
% \global\DepthLength=\DepthLength
% % \global\boxToBeMeasured=\boxToBeMeasured
% }

\newcommand{\PrintSignaturetPage}{%
\edef\textwidthInBp{\convertto{bp}{\textwidth}}
\begin{textblock}{\textwidthInBp}(\LeftMarginInBp,74.5)
\centering
% \begin{spacing}{1.1}
\begin{doublespace}
\titlels{\MakeUppercase{\TitleName}}
\end{doublespace}
% \end{spacing}
{%
% \vspace{15bp}
% \SigPagePresentedByOffset should be defined in the main .tex doucument. By default it's 0bp.
% \providelength{\SigPagePresentedByOffset}{0bp} % this is in case it hasn't been defined yet
\newlength{\TMPLengthA}\setlength{\TMPLengthA}{25bp+\SigPagePresentedByOffset}
\vspace{\TMPLengthA} 
% \vspace{25bp} 
\centering
\begin{spacing}{1.14}
 A\xspace \@ThesisOrDissertation\xspace Presented \\
 by\\
 \authorls{\MakeUppercase{\@author}}   % YOUR NAME is in CAPITALS
\end{spacing}
}
\vspace{18bp}
Approved as to style and content by:
\end{textblock}

\newcommand{\CommitteeChairLineVertDistRef}{\mymath 300.1 pt + \convertto{pt}{\TopRefSigLineVOffset} pt}
\newcommand{\DeptChairLineVertDistRef}{\mymath 646.6 pt + \convertto{pt}{\BottomRefSigLineVOffset} pt}




\ifAltSigSpacing
\begin{spacing}{\SignaturePersonSpacing}
%
\ifnum\the\numCommMembr>0
\MeasureBox{\csname CommitteeMember1\endcsname}
\setlength{\HeightBoxOne}{\TotalHeightLength + \SignaturePersonLineToNameVertDist bp}
\global\HeightBoxOne=\HeightBoxOne
\fi
%
\ifnum\the\numCommMembr>1
\MeasureBox{\csname CommitteeMember2\endcsname}
\setlength{\HeightBoxTwo}{\TotalHeightLength + \SignaturePersonLineToNameVertDist bp}
\global\HeightBoxTwo=\HeightBoxTwo
\fi
%
\ifnum\the\numCommMembr>2
\MeasureBox{\csname CommitteeMember3\endcsname}
\setlength{\HeightBoxThree}{\TotalHeightLength + \SignaturePersonLineToNameVertDist bp}
\global\HeightBoxThree=\HeightBoxThree
\fi
%
\ifnum\the\numCommMembr>3
\MeasureBox{\csname CommitteeMember4\endcsname}
\setlength{\HeightBoxFour}{\TotalHeightLength + \SignaturePersonLineToNameVertDist bp}
\global\HeightBoxFour=\HeightBoxFour
\fi
%
\ifnum\the\numCommMembr>4
\MeasureBox{\csname CommitteeMember5\endcsname}
\setlength{\HeightBoxFive}{\TotalHeightLength + \SignaturePersonLineToNameVertDist bp}
\global\HeightBoxFive=\HeightBoxFive
\fi
%
\ifnum\the\numCommMembr>5
\MeasureBox{\csname CommitteeMember6\endcsname}
\setlength{\HeightBoxSix}{\TotalHeightLength + \SignaturePersonLineToNameVertDist bp}
\global\HeightBoxSix=\HeightBoxSix
\fi
%
% \makeatletter
% \ifdefined\@ProgramDirector
\MeasureBox{\@ProgramDirector}
\setlength{\HeighProgDir}{\TotalHeightLength + \SignaturePersonLineToNameVertDist bp}
\global\HeighProgDir=\HeighProgDir
% \fi
% \makeatother
%
% \ifdefined\@DeptChairperson
% \MeasureBox{\@DeptChairperson}
% \setlength{\HeighDeptChair}{\TotalHeightLength + \SignaturePersonLineToNameVertDist bp}
% \global\HeighDeptChair=\HeighDeptChair
% \fi
%
\end{spacing}
\fi


\setlength{\CummulativeHeightOfBoxes}{\HeightBoxOne+\HeightBoxTwo+\HeightBoxThree+\HeightBoxFour+\HeightBoxFive+\HeightBoxSix+\HeighProgDir}

% \CummulativeHeightOfMemberBoxes

\newcommand{\ProgDirCount}{0}
\ifdefined\@ProgramDirector
\renewcommand{\ProgDirCount}{1}
\fi

\newcommand{\ChairCount}{0}
\ifdefined\@DeptChairperson
\renewcommand{\ChairCount}{1}
\fi

\newcommand{\CommitteLinesVertDist}{\mymath(\DeptChairLineVertDistRef pt - \CommitteeChairLineVertDistRef pt - \convertto{pt}{\CummulativeHeightOfBoxes} pt)/(\mymath(\numCommMembr pt +\ProgDirCount pt + \ChairCount pt - 1 pt))}

\mbox{}\vskip 1in
\CommitteLinesVertDist\\
num=\mymath(\numCommMembr pt + 1 pt)

% \newcommand{\CommitteLinesVertDist}{\mymath(\DeptChairLineVertDistRef pt - \CommitteeChairLineVertDistRef pt)/(\mymath(\numCommMembr pt + 1 pt))}


\newcommand{\SignaturePersonTextwidthInBp}{\textwidthInBp}
\newcommand{\SignaturePersonLeftMarginInBp}{\LeftMarginInBp}

\newcommand{\CurrentSignaturePersonVerticalPosition}{\mymath \CommitteeChairLineVertDistRef pt + \convertto{pt}{\MemberOneVOffset} pt}
\ifnum\the\numCommMembr>0 % the following will print the first committee member, if it's defined
\SignaturePerson{\csname CommitteeMember1\endcsname} % this actually prints the horizontal line and information about the person, as stored in the macro '\csname CommitteeMember1\endcsname'
\fi

\ifnum\the\numCommMembr>1 % the following will print the second committee member, if it's defined
\renewcommand{\CurrentSignaturePersonVerticalPosition}{\mymath \CommitteeChairLineVertDistRef pt + \CommitteLinesVertDist pt + \convertto{pt}{\HeightBoxOne} pt + \convertto{pt}{\MemberTwoVOffset} pt}
\SignaturePerson{\csname CommitteeMember2\endcsname} % this actually prints the horizontal line and information about the person, as stored in the macro '\csname CommitteeMember2\endcsname'
\fi

\ifnum\the\numCommMembr>2
\renewcommand{\CurrentSignaturePersonVerticalPosition}{\mymath \CommitteeChairLineVertDistRef pt + (\CommitteLinesVertDist pt)*2 + \convertto{pt}{\HeightBoxOne} pt + \convertto{pt}{\HeightBoxTwo} pt + \convertto{pt}{\MemberThreeVOffset} pt}
\SignaturePerson{\csname CommitteeMember3\endcsname}
\fi

\ifnum\the\numCommMembr>3
\renewcommand{\CurrentSignaturePersonVerticalPosition}{\mymath \CommitteeChairLineVertDistRef pt + (\CommitteLinesVertDist pt)*3 + \convertto{pt}{\HeightBoxOne} pt + \convertto{pt}{\HeightBoxTwo} pt + \convertto{pt}{\HeightBoxThree} pt + \convertto{pt}{\MemberFourVOffset} pt}
\SignaturePerson{\csname CommitteeMember4\endcsname}
\fi

% \csname CommitteeMember5\endcsname
% 
% \newif\ifmemberFive
% \expandafter\ifdefined\csname CommitteeMember5\endcsname
% \memberFivetrue
% Five is true
% \else
% \memberFivefalse
% Five is false
% \fi
% \vskip 1in
% \the\numCommMembr

% \mbox{}\vskip 1in
% \noindent Something\\
% % \csname CommitteeMember4\endcsname
% % \mbox{}\\
% % Something else\\
% \expandafter\ifx\csname CommitteeMember4\endcsname\relax
% Undefined
% \else
% Defined
% \fi
% %

% \newcounter{acounter}
% \setcounter{acounter}{2}
% \theacounter
% \\
% \ifnum\theacounter=1
% true
% \else
% false
% \fi

% \newcount\acounter
% \acounter=1
% \the\acounter
% \\
% \ifnum\the\acounter<2
% true
% \else
% false
% \fi

% \mbox{}\vskip 1in
% \CommitteeChairLineVertDistRef


\ifnum\the\numCommMembr>4
\renewcommand{\CurrentSignaturePersonVerticalPosition}{\mymath \CommitteeChairLineVertDistRef pt + (\CommitteLinesVertDist pt)*4 + \convertto{pt}{\HeightBoxOne} pt + \convertto{pt}{\HeightBoxTwo} pt + \convertto{pt}{\HeightBoxThree} pt + \convertto{pt}{\HeightBoxFour} pt + \convertto{pt}{\MemberFiveVOffset} pt}
\SignaturePerson{\csname CommitteeMember5\endcsname}
\fi
% 
\ifnum\the\numCommMembr>5
\renewcommand{\CurrentSignaturePersonVerticalPosition}{\mymath \CommitteeChairLineVertDistRef pt + (\CommitteLinesVertDist pt)*5 + \convertto{pt}{\HeightBoxOne} pt + \convertto{pt}{\HeightBoxTwo} pt + \convertto{pt}{\HeightBoxThree} pt + \convertto{pt}{\HeightBoxFour} pt + \convertto{pt}{\HeightBoxFive} pt + \convertto{pt}{\MemberSixVOffset} pt}
\SignaturePerson{\csname CommitteeMember6\endcsname}
\fi

% For the last two signature persons, shift the entries to the right
% We also change the length of thr signature line just a bit, to better match what's in
\setlength{\SignaturePersonLineLength}{247.5pt}
\renewcommand{\SignaturePersonLeftMarginInBp}{288.0}

\ifdefined\@ProgramDirector
\renewcommand{\CurrentSignaturePersonVerticalPosition}{\mymath \CommitteeChairLineVertDistRef pt + (\CommitteLinesVertDist pt)*\numCommMembr + \convertto{pt}{\HeightBoxOne} pt + \convertto{pt}{\HeightBoxTwo} pt + \convertto{pt}{\HeightBoxThree} pt + \convertto{pt}{\HeightBoxFour} pt + \convertto{pt}{\HeightBoxFive} pt + \convertto{pt}{\HeightBoxSix} pt + \convertto{pt}{\ProgDirVOffset} pt}
\SignaturePerson{\@ProgramDirector}
\fi

\ifdefined\@DeptChairperson
\renewcommand{\CurrentSignaturePersonVerticalPosition}{\mymath \DeptChairLineVertDistRef pt + \convertto{pt}{\DeptChairVOffset} pt}
\SignaturePerson{\@DeptChairperson}
\fi
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% the abstract
\newlength{\AbstractVerticalOffset}
\setlength{\AbstractVerticalOffset}{0pt}

% \edef\textwidthInBp{\convertto{bp}{\textwidth}}

\newenvironment{UMBAbstract}%
{%
% \begin{textblock}{\mymath (8.5 pt-2 pt)*72}(72,75) % this is how it is in the Standards-UMB, but it is probably a mistake
\begin{textblock}{\mymath (8.5 pt-2.25 pt)*72}(90,75.7)
\centering
\noindent 
\iftestA
\mbox{}\kern0.002em{}\testword
\else
\titlels{ABSTRACT}
\fi
\end{textblock}


\begin{textblock}{\mymath (8.5 pt-2.25 pt)*72}(90,141)
\setlength{\parindent}{0pt}
\centering
% \begin{spacing}{1.1}
\begin{doublespace}
\titlels{\MakeUppercase{\TitleName}}
\end{doublespace}
% \end{spacing}
\end{textblock}



\newcommand{\AdjustAbstractVerticalD}{\mymath -36 pt + \convertto{pt}{\AbstractVerticalOffset} pt }

\begin{textblock}{\mymath (8.5 pt-2.25 pt)*72}(90,\mymath 261 pt + \AdjustAbstractVerticalD pt)
\centering
\noindent 
\DegreeMonth\xspace\DegreeYear
\end{textblock}

\begin{textblock}{\mymath (8.5 pt-2.25 pt)*72}(90,\mymath 309.9 pt + \AdjustAbstractVerticalD pt)
\setlength{\parindent}{0pt}
\centering 
\begin{spacing}{1.15}
 \noindent \@author, \@AuthorDegrees 
\end{spacing}
\end{textblock}

\begin{textblock}{\mymath (8.5 pt-2.25 pt)*72}(90,\mymath 392.5 pt + \AdjustAbstractVerticalD pt)
\centering
\noindent 
Directed by \@DirectedBy
\end{textblock}

\newcommand{\absB}{\mymath 308 pt + \AdjustAbstractVerticalD pt} 
\newlength{\absLength}
\setlength{\absLength}{\absB bp}
\mbox{}\vskip \absLength\mbox{}
% \mbox{}\vskip 308bp\mbox{}
\begin{doublespace}

}{\end{doublespace}}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% https://tex.stackexchange.com/questions/33193/how-to-determine-whether-a-list-of-figures-is-empty-then-not-show-it-at-all

\newif\ifThereAreFigures\ThereAreFiguresfalse
\AtEndEnvironment{figure}{\gdef\there@is@a@figure{}} 
\AtEndDocument{\ifdefined\there@is@a@figure\label{fig:was:used:in:doc}\fi} 
\newcommand{\CheckIfThereAreFigures}{\@ifundefined{r@fig:was:used:in:doc}{}{\ThereAreFigurestrue}}%


\newif\ifThereAreTables\ThereAreTablesfalse
\AtEndEnvironment{table}{\gdef\there@is@a@table{}} 
\AtEndDocument{\ifdefined\there@is@a@table\label{tab:was:used:in:doc}\fi} 
\newcommand{\CheckIfThereAreTables}{\@ifundefined{r@tab:was:used:in:doc}{}{\ThereAreTablestrue}}%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcommand{\PrintToCLoFLoT}{%
% \renewcommand{\oldcftchapdotsep}{\cftchapdotsep}
\begin{singlespace}
% It is required that, on each new page of the ToC (except the very first one), at the top of the page we have 'CHAPTER' flush left and 'Page' flush right.
% Making this happen requires LaTeX programming that goes beyond the basics, and is accomplished using the package 'atbegshi' (loaded by our class) and its command \AtBeginShipout.
\iftestA
\renewcommand\MyShipoutHook{\chapter*{\mbox{}\protect{\vskip -\baselineskip}\mbox{}\hfill \hspace{0bp}\testword \hfill\mbox{}\protect{\vskip -2\baselineskip}}}
\else
\renewcommand\MyShipoutHook{\chapter*{\mbox{}\protect{\vskip -\baselineskip}CHAPTER\hfill Page\protect{\vskip -2\baselineskip}}}
\fi
\AtBeginShipout{\MyShipoutHook} 
\tableofcontents
\clearpage
\renewcommand\MyShipoutHook{}
\end{singlespace}

\CheckIfThereAreFigures
\ifThereAreFigures
    % Umass formatting for List of Figures
    \newpage
% Current:
    \titlecontents{chapter}[0pt]{\normalfont}%
        {}%
        {\hspace*{-0bp}}%
        {\titlerule*[3.3pt]{.}\contentspage[\thecontentspage]}
    \addcontentsline{toc}{chapter}{\LoFName}
    \addtocontents{toc}{\protect\addvspace{12.7bp}}
    \addtocontents{lof}{\vspace{-16.84bp}}
    \addtocontents{lof}{\noindent Figure\hfill Page\par}
%     \addtocontents{lof}{\vspace{0bp}}
    \begin{singlespace}
\iftestA
    \renewcommand\MyShipoutHook{\chapter*{\mbox{}\protect{\vskip -\baselineskip}\mbox{}\hfill \hspace{0bp}\testword \hfill\mbox{}\protect{\vskip -45.57bp}}}
\else
    \renewcommand\MyShipoutHook{\chapter*{\mbox{}\protect{\vskip -\baselineskip}Figure\hfill Page\protect{\vskip -45.57bp}}}
%     \renewcommand\MyShipoutHook{\chapter*{\mbox{}\protect{\vskip -5.7586\baselineskip}Figure\hfill Page\protect{\vskip -2.61\baselineskip}}}
\fi
    % \AtBeginShipout{\MyShipoutHook} % the previous invocation of this command is still in force. If we try to execute it again, it results in an error
    \listoffigures
    \clearpage
    \renewcommand\MyShipoutHook{}
    \end{singlespace}
\fi


\CheckIfThereAreTables
\ifThereAreTables
    % Umass formatting for List of Tables
    \newpage
% Current:
    \titlecontents{chapter}[0pt]{\normalfont}%
        {}%
        {\hspace*{-0bp}}%
        {\titlerule*[3.3pt]{.}\contentspage[\thecontentspage]}
    \addcontentsline{toc}{chapter}{\LoTName}
    \addtocontents{toc}{\protect\addvspace{12.3bp}}
   \addtocontents{lot}{\vspace{-16.84bp}}
    \addtocontents{lot}{\noindent Table\hfill Page\par}
%     \addtocontents{lot}{\vspace{5pt}}
    \begin{singlespace}
\iftestA
   \renewcommand\MyShipoutHook{\chapter*{\mbox{}\protect{\vskip -\baselineskip}\mbox{}\hfill \hspace{0bp}\testword \hfill\mbox{}\protect{\vskip -45.57bp}}}
\else
    \renewcommand\MyShipoutHook{\chapter*{\mbox{}\protect{\vskip -\baselineskip}Table\hfill Page\protect{\vskip -45.57bp}}}
%     \renewcommand\MyShipoutHook{\chapter*{\mbox{}\protect{\vskip -5.7586\baselineskip}Figure\hfill Page\protect{\vskip -2.61\baselineskip}}}
\fi
    % \AtBeginShipout{\MyShipoutHook} % the previous invocation of this command is still in force. If we try to execute it again, it results in an error
    \listoftables
    \clearpage
    \renewcommand\MyShipoutHook{}
    \end{singlespace}
\fi

%Umass formatting for Table of Contents
\dottedcontents{chapter}[0in]{\normalfont}
{0in}{3.3pt}

% Current:
\titlecontents{chapter}[0in]{\normalfont}{}{}{\hfill\contentspage}
\addtocontents{toc}{\protect\contentsline{chapter}{CHAPTER}{Page}{}}
% \addtocontents{toc}{\vspace{12.5pt}}
% \titlecontents{chapter}[\ToCIndentChapterText]{\contentsmargin[\ToCTextRightMarginRelativeToRightEndOfDots]{0.5\ToCDottedLineRightMargin}\mbox{}\hspace{-\ToCTextOverhang}\normalfont}%
%     {\contentslabel{13bp}}%
%     {\hspace*{-13bp}}%
%     {\titlerule*[3.3pt]{.}\contentspage[\thecontentspage\hbox{\hspace{\ToCPageNumToRightMargin}}]}

% \titlecontents{chapter}[\ToCIndentChapterText]{\mbox{}\hspace{-\ToCTextOverhang}\normalfont}%
%     {\contentslabel{13bp}\MakeTextUppercase}%
%     {\hspace*{-13bp}}%
%     {\titlerule*[3.3pt]{.}\contentspage[\thecontentspage\hbox{\hspace{\ToCPageNumToRightMargin}}]}




% \titlecontents{chapter}[\ToCIndentChapterText]{\mbox{}\hspace{-\ToCTextOverhang}\normalfont}%
%     {\contentslabel[%
%     \setlength{\WidthA}{\widthof{\thecontentslabel}}%
%     \setlength{\WidthB}{\WidthA-6.5bp}%
%     \mbox{}\hspace{-\WidthB}\thecontentslabel.]{13bp}\MakeTextUppercase}%
%     {\hspace*{-13bp}}%
%     {\titlerule*[3.3pt]{.}\contentspage[\thecontentspage\hbox{\hspace{\ToCPageNumToRightMargin}}]}



% Current:
\titlecontents{chapter}[\ToCIndentChapterText]{\mbox{}\hspace{-\ToCTextOverhang}\normalfont}%
    {\contentslabel[%
    \setlength{\WidthA}{\widthof{\thecontentslabel}}%
    \setlength{\WidthB}{\WidthA-6.5bp}%
    \mbox{}\hspace{-\WidthB}\thecontentslabel.]{13bp}}%
    {\hspace*{-13bp}}%
    {\titlerule*[3.3pt]{.}\contentspage[\thecontentspage\hbox{\hspace{\ToCPageNumToRightMargin}}]}


}


% \titlecontents{chapter}[\ToCIndentChapterText]{\mbox{}\hspace{-\ToCTextOverhang}\normalfont}%
%     {\contentslabel}%
%     [%
%     \setlength{\WidthA}{\widthof{\thecontentslabel}}%
%     \setlength{\WidthB}{\WidthA-25bp}%
%     \mbox{}\hspace{-\WidthB}%
%     \thecontentslabel]
%     {13bp}}%
%     {\hspace*{-13bp}}%
%     {\titlerule*[3.3pt]{.}\contentspage[\thecontentspage\hbox{\hspace{\ToCPageNumToRightMargin}}]}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\ifHyperref
% % 
% \usepackage[pdfpagelabels,draft,implicit=false]{hyperref}
% % \usepackage[pdfpagelabels]{hyperref}
% \usepackage{hyperref}
% % \hypersetup{linktoc=all,linktocpage}
% % We load this package here because, most of the time, the package 'hyperref' needs to be loaded only after we have loaded all the other packages. There are, however, some exceptions; see https://tex.stackexchange.com/questions/1863/which-packages-should-be-loaded-after-hyperref-instead-of-before
% \AtBeginDocument{%
%   \pdfstringdefDisableCommands{%
%     \def\MakeTextUppercase{}
%     \def\cftchapafterpnum{}
%   }%
% }
\AtEndPreamble{%
    \usepackage[pdfpagelabels,draft,implicit=false]{hyperref}

  }%
\fi

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% \renewcommand\bibname{\mbox{}\vskip -150bp{}CITATIONS}
% \renewcommand\bibname{\mbox{}\vskip -6bp{}LIST OF REFERENCES}
% \renewcommand\bibname{\mbox{}\vskip -6bp{}\mbox{}\hfill LIST OF REFERENCES\hfill\mbox{}}

% \renewcommand\bibname{\mbox{}\vskip -14.4bp{}\mbox{}\hfill LIST OF FIGURES\hfill\mbox{}}
\renewcommand\bibname{\mbox{}\vskip -14.4bp{}\mbox{}\hfill LIST OF REFERENCES\hfill\mbox{}}

\endinput
