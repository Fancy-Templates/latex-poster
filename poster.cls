\ProvidesClass{poster}[2022/07/19 non-official LaTeX poster done roughly in the design of the uulm]

% first of all, we define some switches
% they control which packages to load and configure
% automatically
\newif\if@uulm@cs@poster@hyper@
\DeclareOption{hyper}{\@uulm@cs@poster@hyper@true}
\DeclareOption{nohyper}{\@uulm@cs@poster@hyper@false}

\newif\if@uulm@cs@poster@enumitem@
\DeclareOption{enumitem}{\@uulm@cs@poster@enumitem@true}
\DeclareOption{noenumitem}{\@uulm@cs@poster@enumitem@false}

\newif\if@uulm@cs@poster@biblatex@
\DeclareOption{biblatex}{\@uulm@cs@poster@biblatex@true}
\DeclareOption{nobiblatex}{\@uulm@cs@poster@biblatex@false}

\newif\if@uulm@cs@poster@default@
\DeclareOption{default}{\@uulm@cs@poster@default@true}
\DeclareOption{nodefault}{\@uulm@cs@poster@default@false}

\DeclareOption{english}{\def\uulm@cs@poster@defaultlang{english}}
\DeclareOption{ngerman}{\def\uulm@cs@poster@defaultlang{ngerman}}

\ExecuteOptions{hyper,enumitem,biblatex,english}
\ProcessOptions*

% loaded implicitly, but this is safer
\RequirePackage{etoolbox}

% ensure the presence of a language
\PassOptionsToPackage{\uulm@cs@poster@defaultlang}{babel}

% the first variant was based on article, and i see no reason to change
% that afterward
\LoadClass[oneside]{article}

% it is a poster...
\newdimen\uulm@margin \uulm@margin2cm
\RequirePackage[margin=\uulm@margin]{geometry} % wellp

% Who wants to have a parindent with the poster?
\RequirePackage[skip=.5\baselineskip]{parskip}


\RequirePackage{xcolor}
% set official Ulm University colors (style-guide)
\definecolor{black}     {HTML}{000000}
\definecolor{uulmmain}  {HTML}{89a2b3}
\definecolor{uulmblue}  {HTML}{7D9AAA}
\definecolor{uulmaccent}{HTML}{A9A28D}
\definecolor{green}     {HTML}{56AA1C}
\definecolor{red}       {HTML}{A32638}
\definecolor{orange}    {HTML}{DF6D07}
\definecolor{blue}      {HTML}{26547C}

% who wants meta? Let's use Fira (GO, in the future?)!
\RequirePackage[default]{FiraSans}
\RequirePackage[lining]{FiraMono}
\RequirePackage{sansmathfonts}
% \RequirePackage{sansmath}

% I find boldface to be too heavy sometimes, therefore:
% lets have fun with semi-bold!
\def\sbseries{\fontseries{sb}\selectfont}
\def\textsb#1{\ifmmode\nfss@text{\sbseries#1}\else\hmode@bgroup\text@command{#1}\sbseries \check@icl#1\check@icr\expandafter\egroup\fi}

% additional registers
\def\logo#1{\def\@logo{#1}} \let\@logo\@empty
\def\subtitle#1{\def\@subtitle{#1}} \let\@subtitle\@empty
\def\institute#1{\def\@institute{#1}} \let\@institute\@empty
\def\university#1{\def\@university{#1}} \let\@university\@empty
\def\footline#1{\def\@footline{#1}} \def\@footline{\@date\hfill\@institute\hfill\@university}

\def\and{,\space}% TODO: maybe more elaborate with automatic and?

% a custom title for the world!
\def\maketitle{\begingroup\leavevmode
\parskip\z@\relax
\vskip\dimexpr-\parskip-\baselineskip-11mm\relax\par
% upper row of icons
\null\parbox[c]{.2\linewidth}{\smash{\@logo}}\hfill\uulmlogo\vskip.75\uulm@margin\vskip-3.5mm\par
\hspace{-\uulm@margin}%
\fboxsep\z@\fcolorbox{red}{red}{
\minipage[b]\paperwidth
\vspace*{.5cm}\@declaredcolor{white}%
\hspace\uulm@margin\begin{minipage}{\dimexpr\paperwidth-2\uulm@margin}
  \fontsize{36pt}{36pt}\textsc{\textbf{\@title}}\par%
  \LARGE\ifx\@subtitle\@empty\else\kern1.33pt\@subtitle\hfill\fi\@author\par
\end{minipage}~%
\vspace*{.5cm}%
\endminipage}\vskip1cm\par\endgroup}

\pagestyle{empty}
% hehe, low-level foot-line inject
\def\@thefoot{%
\hskip-\uulm@margin\relax% \vskip\uulm@margin\relax
\raisebox{.5pt}{\fcolorbox{red}{red}{\@declaredcolor{white}\hb@xt@\paperwidth\relax{\hskip\dimexpr\uulm@margin-.6ex\relax\strut\@footline\hskip\dimexpr\uulm@margin+.6ex\relax\null}}}\relax
}


% styling of sections, subsections, and paragraphs
\RequirePackage{titlesec}
\def\belowsecrule{\titlerule[\columnseprule]}
\titleformat\section[hang]
  {\centering\normalfont\bfseries\Large\@declaredcolor{red}}
  {\thesection}{1em}{}[\@declaredcolor{uulmaccent}\belowsecrule]
\titlespacing*\section\z@{2em\@plus1fil\@minus1em}{*1}

\titleformat\subsection
  {\normalfont\bfseries\normalsize\@declaredcolor{red}}
  {\thesection}{1em}{}
\titlespacing*\subsection\z@{*1.5}{*.33}

\titleformat\paragraph[runin]
  {\normalfont\bfseries\normalsize\@declaredcolor{red}}
  {\thesection}{1em}{}
\titlespacing*\paragraph\z@\parskip{1em\@plus.5em\@minus.5em}

% captions :3
\RequirePackage{caption}
\DeclareCaptionFont{main}{\@declaredcolor{red}}
\captionsetup{labelfont={main,bf},font={small}}

% reacting on some toggles
\if@uulm@cs@poster@hyper@
  \AtEndPreamble{%
    \PassOptionsToPackage{pdfusetitle}{hyperref}%
    \RequirePackage{hyperref}%
    \hypersetup{pdfborder=0 0 0,colorlinks=true,allcolors=uulmaccent}%
    \PassOptionsToPackage{capitalise}{cleveref}%
    \RequirePackage{cleveref}%
  }
\fi

\if@uulm@cs@poster@enumitem@
  \PassOptionsToPackage{inline}{enumitem}
  \RequirePackage{enumitem}
  \RequirePackage{translations}
  \RequirePackage{amssymb}
  \DeclareTranslationFallback{t-and}{, and\space}
  \DeclareTranslation{English}{t-and}{, and\space}
  \DeclareTranslation{German}{t-and}{ und\space}
  % I am a huge fan of inline lists :D
  \newlist{inlist}{enumerate*}{1}
  \setlist[inlist]{%
    itemjoin={{, }},%
    itemjoin*={{\GetTranslation{t-and}}},%
    label=\roman*),%
    mode=boxed%
  }
  \setlist[itemize,1]{%
      label=\@declaredcolor{uulmaccent}%
      \scalebox{.8}{$\blacksquare$},%
      nosep,%
      leftmargin=*,%
      topsep=-\parskip%
  }
\fi

% these defaults are arbitrary and just what I like to use
\if@uulm@cs@poster@default@
  \RequirePackage[T1]{fontenc}
  \RequirePackage[utf8]{inputenc}
  \RequirePackage{babel}

  \PassOptionsToPackage{activate={true,nocompatibility},tracking,expansion,final,babel}{microtype}
  % we want no tracking for the title
  \AtEndPreamble{\preto\@title{\microtypesetup{tracking=false}}}
\fi

\if@uulm@cs@poster@biblatex@
  \RequirePackage{csquotes}
  \RequirePackage{biblatex}
  \RequirePackage{babel}
  \let\finentrypunct\@empty
  \def\uulm@cs@poster@lhook#1{\href{\thefield{url}}{#1}}%
  % configuring a concise bibtex style,
  % I am not really happy with it and might change the "look and feel."
  \DeclareBibliographyDriver{uulm@cs@poster@bibtheme}{%
    \let\@tmp\@empty
    \ifhyperref{\iffieldundef{url}{}{\let\@tmp\uulm@cs@poster@lhook}}\relax
    \@tmp{\usebibmacro{bibindex}%
    \usebibmacro{begentry}%
    \usebibmacro{author/editor}%
    \setunit{\labelnamepunct}\newblock
    \usebibmacro{title}%
    \newblock
    \printtext{\space}% so it will be executed in sync
    \mbox{\textcolor{uulmaccent}{\usebibmacro{date}}}%
    \newblock
    \usebibmacro{finentry}}%
  }%
  % assign the style to everything
  \@for\@type:={article,book,booklet,collection,inbook,incollection,inproceedings,manual,misc,online,patent,periodical,proceedings,report,thesis,unpublished,*}\do{\DeclareBibliographyAlias{\@type}{uulm@cs@poster@bibtheme}}%
  \def\bibfont{\tiny}

  % hierarchically lower the bib heading and adapt spacing
  \defbibheading{bibliography}[\bibname]{\subsection*{#1}\vspace*{-1.5\p@}}

  % guard so that the auto-links are not shown
  \if@uulm@cs@poster@hyper@
    \preto\printbibliography{\hypersetup{allcolors=.}}
  \fi
\fi

% setting up multicol for multiple columns
\RequirePackage[grid]{multicol}
\columnseprule.4pt
\columnsep3em
\def\columnseprulecolor{\@declaredcolor{uulmaccent}}

% every document needs microtype
\RequirePackage{microtype}
% I prefer a little bit more space on posters
\linespread{1.1}

% load the uulm and the sp logo using them this way has no direct advantage over
% using pdfs, but this way, it is included in a single file and no blob!
\RequirePackage{uulm-logo}
\endinput