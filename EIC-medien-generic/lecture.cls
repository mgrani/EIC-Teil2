%%% DATE. January 4th, 2013.

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{lecture}
 [2013/1/04 v1.7 Basic class for presentation slides]

\usepackage[german,american]{babel}
\usepackage[T1]{fontenc}
\usepackage{textcomp}
\usepackage{ae,aecompl}
\usepackage[latin1]{inputenc}% For umlauts (OT1) and the ß (OT1, T1).
\usepackage{type1cm}% CM-Fonts including Math-Fonts in all sizes.
\usepackage{ifpdf}
\IfFileExists{\jobname.sty}{\usepackage{\jobname}}{}% Include part-specific latex code.



%%% Options.
%%% Provide font size (which determines text area) and aspect ratio. Compute slide width as sqrt(area)*sqrt(ratio) and slide height as sqrt(area)/sqrt(ratio). Since tex cannot compute exponential series, the square roots are computed beforehand.
\newcommand\ptsize{}
\newcommand\figurescale{}
\newcommand\widthscale{}
\newcommand\heightscale{}

\DeclareOption{14pt}{% Future base font.
  \renewcommand\ptsize{14r}
  \@tempdima=6.67in% area=44.5in^2.
  \renewcommand\figurescale{0.81}}
\DeclareOption{17pt}{% Font for bs-reading.cls.
  \renewcommand\ptsize{17r}
  \@tempdima=7.94in% area=63.0in^2.
  \renewcommand\figurescale{1.0}}

\DeclareOption{5:4}{% 1.25
  \renewcommand\widthscale{1.1180}% sqrt(5/4)
  \renewcommand\heightscale{0.8944}}% sqrt(4/5)
\DeclareOption{9:7}{% 1.29, bs-reading.cls
  \renewcommand\widthscale{1.1339}% sqrt(9/7)
  \renewcommand\heightscale{0.8819}% sqrt(7/9)
  \ifx\ptsize{17pt}% OLD. For non pdflatex. (\ifx to be deleted in the future)
    \special{papersize=9in,7in}% Inform dvips. Shell: dvips -T 9in,7in <texfile>
    \edef\@pdfpagescrop{0 0 650 506}% Inform ps2pdf. Shell: ps2pdf -dDEVICEWIDTHPOINTS=650 -dDEVICEHEIGHTPOINTS=506 <texfile>.ps.
  \fi}
\DeclareOption{4:3}{% 1.33, beamer.cls
  \renewcommand\widthscale{1.1547}% sqrt(4/3)
  \renewcommand\heightscale{0.8660}}% sqrt(3/4)
\DeclareOption{17:12}{% 1.41, A4 landscape
  \renewcommand\widthscale{1.1892}% sqrt(sqrt(2))
  \renewcommand\heightscale{0.8409}}% sqrt(1/sqrt(2))
\DeclareOption{3:2}{% 1.5
  \renewcommand\widthscale{1.2247}% sqrt(3/2)
  \renewcommand\heightscale{0.8165}}% sqrt(2/3)
\DeclareOption{8:5}{% 1.6
  \renewcommand\widthscale{1.2649}% sqrt(8/5)
  \renewcommand\heightscale{0.7906}}% sqrt(5/8)
\DeclareOption{16:9}{% 1.78
  \renewcommand\widthscale{1.3333}% sqrt(16/9)
  \renewcommand\heightscale{0.7500}}% sqrt(9/16)

\DeclareOption{american}{\AtBeginDocument{\selectlanguage{american}}}
\DeclareOption{english}{\AtBeginDocument{\selectlanguage{english}}}
\DeclareOption{german}{\AtBeginDocument{\selectlanguage{german}}}

\ExecuteOptions{17pt,9:7,german}
\ProcessOptions



%%% Font size and parskips.
\input{size\ptsize.clo}
\setlength\lineskip{1\p@}
\setlength\normallineskip{1\p@}
\renewcommand\baselinestretch{}
\newskip\bsparskip
\setlength\bsparskip{0.4\baselineskip}
\newcommand{\bspar}[1]{\par\vspace*{#1\bsparskip}}% \bspar0 = \par
\setlength\parskip{\bsparskip}
\@lowpenalty   51
\@medpenalty  151
\@highpenalty 301
%%%%% OLD. (comment to be deleted in the future)
%%%%% bs-reading.cls. \parskip=0.25\baselineskip (wrongly set, should be 0.5), \bsparskip=0.5\baselineskip
%%%%% reading.cls.    \parskip=0.4\baselineskip, \bsparskip=0.4\baselineskip



%%% Text area.
\setlength\paperwidth{\widthscale\@tempdima}
\setlength\paperheight{\heightscale\@tempdima}

\hoffset=-1in% Correct the default printer offsets. \cf[appendix]{Kopka}
\voffset=-1in

\oddsidemargin=10pt% Left border to text area.
\evensidemargin=15pt% Right border to text area.
\topmargin=4pt% Top and bottom border to text area.

\setlength\headheight{0pt}
\setlength\headsep{0pt}
\setlength\topskip{0.9\baselineskip}
\setlength\footskip{0.5\baselineskip}

\textwidth=\paperwidth
\textheight=\paperheight
\advance\textwidth  by -\oddsidemargin% Left.
\advance\textwidth  by -\evensidemargin% Right.
\advance\textheight by -2.0\topmargin% Top + Bottom.
\advance\textheight by -\headheight
\advance\textheight by -\headsep
\advance\textheight by -\footskip

\onecolumn
\raggedright
\raggedbottom
\sloppy



%%% Indentation and labels.
\parindent=0pt
\setlength\leftmargini   {2.5em}
\leftmargin\leftmargini
\setlength\leftmarginii  {1.5em}
\setlength\leftmarginiii {1.5em}
\setlength\leftmarginiv  {1.0em}
\setlength\leftmarginv   {0.5em}
\setlength\leftmarginvi  {0.5em}
\setlength  \labelsep  {0.75em}
\setlength  \labelwidth{\leftmargini}
\addtolength\labelwidth{-\labelsep}

\@beginparpenalty -\@lowpenalty
\@endparpenalty   -\@lowpenalty
\@itempenalty     -\@lowpenalty
\renewcommand\theenumi{\@arabic\c@enumi}
\renewcommand\theenumii{\@alph\c@enumii}
\renewcommand\theenumiii{\@roman\c@enumiii}
\renewcommand\theenumiv{\@Alph\c@enumiv}
\newcommand\labelenumi{\theenumi.}
\newcommand\labelenumii{\small(\theenumii)}
\newcommand\labelenumiii{\small(\theenumiii)}
\newcommand\labelenumiv{\small\theenumiv.}
\renewcommand\p@enumii{\theenumi}
\renewcommand\p@enumiii{\theenumi(\theenumii)}
\renewcommand\p@enumiv{\p@enumiii\theenumiii}
\newcommand\labelitemi{\footnotesize\ding{113}}
\newcommand\labelitemii{\normalfont\bfseries \textendash}
\newcommand\labelitemiii{\textbullet}
\newcommand\labelitemiv{\textperiodcentered}

\setlength\arraycolsep{5\p@}
\setlength\tabcolsep{6\p@}
\setlength\arrayrulewidth{.4\p@}
\setlength\doublerulesep{2\p@}
\setlength\tabbingsep{\labelsep}
\skip\@mpfootins = \skip\footins
\setlength\fboxsep{3\p@}
\setlength\fboxrule{.5\p@}
\renewcommand \theequation {\@arabic\c@equation}

\setlength\columnsep{10\p@}
\setlength\columnseprule{0\p@}



%%% Font families.
\renewcommand{\rmdefault}{phv}
\DeclareMathAlphabet{\mathcalbf}{OMS}{pzc}{b}{n}
\DeclareMathAlphabet{\mathit}{T1}{phv}{m}{it}
\DeclareMathAlphabet{\mathitbf}{OT1}{cmr}{bx}{it}
\DeclareMathAlphabet{\mathptmbf}{T1}{ptm}{b}{it}
\DeclareMathAlphabet{\mathrm}{T1}{phv}{m}{n}
\renewcommand{\ttdefault}{pcr}% Unfavorable font family but necessary for \tt\bfseries.
%%% \renewcommand{\ttdefault}{aett}% Reinstall classical Latex \tt.

\DeclareOldFontCommand{\rm}{\normalfont\rmfamily}{\mathrm}
\DeclareOldFontCommand{\sf}{\normalfont\sffamily}{\mathsf}
\DeclareOldFontCommand{\tt}{\normalfont\ttfamily}{\mathtt}
\DeclareOldFontCommand{\bf}{\normalfont\bfseries}{\mathbf}
\DeclareOldFontCommand{\it}{\normalfont\itshape}{\mathit}
\DeclareOldFontCommand{\sl}{\normalfont\slshape}{\@nomath\sl}
\DeclareOldFontCommand{\sc}{\normalfont\scshape}{\@nomath\sc}
\DeclareRobustCommand*\cal{\@fontswitch\relax\mathcal}
\DeclareRobustCommand*\mit{\@fontswitch\relax\mathnormal}



%%% Slide environment.
\usepackage{collect}
\usepackage{expandonce}

\newenvironment{bsslide}[1][]{%
  % #1 slide head.
  \newpage\normalsize
  \def\slideheadtext{#1}
  \collectinmacro\@lastslide{}{}}
  {\endcollectinmacro%
    \expandonce\@lastslide\@lastslide\lastslide% Expand \lastslide in \@lastslide and redefine \@lastslide.
    \slidehead{\slideheadtext}% Output starts always at \topskip.
    \@lastslide% Output \lastslide.
    \global\let\lastslide\@lastslide}

\newcommand{\slidehead}[1]{%
  \ifx#1\empty\else{\large\bfseries#1\mbox{}\\[0.4ex]}\fi}


\newcommand{\bscollection}[1]{\renewcommand{\bscollectionaux}{\ifx\\#1\\\else{#1:}\fi}}
\newcommand{\bscollectionaux}{}

\newcounter{bspart}
\newcommand{\bsparthead}{\chaptername~\bscollectionaux\Roman{bspart}}

\newenvironment{bspartenumerate}[1][1]{% Usage pattern for partial toc: \begin{bspartenumerate}[\value{bspart}]
  \begin{enumerate}
    \renewcommand{\labelenumi}{\Roman{enumi}.}
    \setcounter{enumi}{#1}\addtocounter{enumi}{-1}}
  {\end{enumerate}}

\newcommand{\bspartname}[1]{\renewcommand{\bspartnameaux}{#1}}
\newcommand{\bspartnameaux}{}


\newcommand{\bsauthor}[1]{\renewcommand{\bsauthoraux}{\ifx\\#1\\\else{\textcopyright\,#1}\fi}}
\newcommand{\bsauthoraux}{\textbackslash bsauthor}

\newcommand{\bsyear}[1]{\renewcommand{\bsyearaux}{#1}}
\newcommand{\bsyearaux}{\textbackslash bsyear}


\newcommand{\bsfoot}[1]{\renewcommand{\bsfootaux}{#1}}
\newcommand{\bsfootaux}{\textbackslash bsfoot\hfill}
\newcommand{\footfont}{\fontfamily{\rmdefault}\fontsize{8}{0}\fontseries{m}\fontshape{n}\selectfont\color{mediumgray}}
\def\ps@plain{\def\@oddfoot{\footfont\bsfootaux}}
\pagestyle{plain}
\pagenumbering{arabic}% Defines \thepage. To use pdfpagelabels it must placed before inclusion of hyperref package.

\bsfoot{%
  \bscollectionaux\ifnum\value{page}>0{\ifnum\value{bspart}>0\Roman{bspart}-\fi\arabic{page}}\quad\fi
  \bspartnameaux\hfill\bsauthoraux~\bsyearaux}



%%% Figures and tables.
\usepackage[colorlinks=true,pdfborder={0 0 0},linkcolor=upbblue,urlcolor=upbblue]{hyperref}% colorlinks=false enables pdfborder, colorlinks=true disables pdfborder. From within document: \setkeys{Hyp}{colorlinks=false}

\usepackage{graphicx}
\ifpdf
  \DeclareGraphicsRule{.ai}{pdf}{*}{}% Handle ai files as pdf files.
  \DeclareGraphicsExtensions{.pdf,.ai,.jpg,.png}% Determines sourcing sequence. 
  \graphicspath{{../figures/ai-version-cs2/}{../figures/ai-version-10/}{../figures/figures-others/}}% Determines search sequence.
  \pdfpagebox 5% Use ArtBox instead MediaBox default. 1=MediaBox, 2=CropBox, 3=BleedBox, 4=TrimBox, 5=ArtBox.
\else
  \DeclareGraphicsExtensions{.ps,.eps,.ai}% Determines sourcing sequence. 
  \graphicspath{{../figures/ai-version-7/}{../figures/figures-others/}}% Determines search sequence.
\fi

\newcommand{\bsfigure}[2][]{%
  % #1 parameter=value list
  % #2 file name
  \par\vspace{\parskip}
  \centerline{\bsfigureaux[#1]{#2}}}
\newcommand{\bsfigureaux}[2][]{%
  % #1 parameter=value list
  % #2 file name
  \hypertarget{#2}{}%
  \scalebox{\figurescale}{\includegraphics[#1]{#2}}}


\usepackage{booktabs}
\lightrulewidth=0.5pt
\heavyrulewidth=1pt
\aboverulesep=1pt
\belowrulesep=1pt



%%% Color declarations and commands.
\RequirePackage{xcolor}

%%% All RGB cross reference values obtained via Adobe Illustrator CS5.
%%% Color palette of the Bauhaus-Universitaet Weimar CD. 
\definecolor{buwyellow}{rgb}{1.00,0.83,0.00}%           Pantone solid coated 116 (255,211,0)
\definecolor{buworange}{rgb}{0.95,0.06,0.06}%           Pantone solid coated 151 (243,153,16)
\definecolor{buwred}{rgb}{0.91,0.33,0.07}%              Pantone solid coated 179 (232,84,18)
\definecolor{buwmagenta}{rgb}{0.87,0.00,0.35}%          Pantone solid coated 206 (222,0,89)
\definecolor{buwblue}{rgb}{0.00,0.38,0.66}%             Pantone solid coated 293 (0,96,169)
\definecolor{buwdarkgreen}{rgb}{0.00,0.39,0.56}%        Pantone solid coated 308 (0,99,144)
\definecolor{buwgreen}{rgb}{0.00,0.53,0.53}%            Pantone solid coated 327 (0,134,136)
\definecolor{buwlightgreen}{rgb}{0.51,0.72,0.10}%       Pantone solid coated 368 (131,184,26)

%%% Color palette of Paderborn University CD, 2003.
\definecolor{upbyellow}{rgb}{1.00,0.84,0.30}%           Pantone solid coated 129 (255,214,77)
\definecolor{upborange}{rgb}{0.94,0.57,0.00}%           Pantone solid coated 152 (240,145,0)
\definecolor{upbblue}{rgb}{0.00,0.23,0.47}%             Pantone solid coated 281 (0,59,121)
\definecolor{upbblue}{rgb}{0.04,0.12,0.38}%             Previous setting
\definecolor{upbgreen}{rgb}{0.59,0.75,0.05}%            Pantone solid coated 376 (151,191,13)
\definecolor{upbgray}{rgb}{0.89,0.89,0.89}%             Pantone solid coated 420 (227,228,228)

%%% Text colors are derived from the UPB palette.
\definecolor{upbtextgreen}{rgb}{0.36,0.67,0.15}%        Pantone solid coated 361 (91,172,38)
\definecolor{upbtextorange}{rgb}{0.88,0.42,0.03}%       Pantone solid coated 159 (224,108,8)

%%% Additional colors.
\definecolor{violet}{rgb}{0.58,0.07,0.49}%              Pantone solid coated 254 (147,17,126)
\definecolor{ultralightyellow}{rgb}{1.00,0.98,0.87}%    Pantone solid coated 607 (255,250,221)
\definecolor{lightyellow}{rgb}{1.00,0.97,0.70}%         Pantone solid coated 601 (255,247,178)

%%% Shades of gray.
\definecolor{ultralightgray}{gray}{0.90}%               Pantone solid coated cool gray 2 (near 427)
\definecolor{lightgray}{gray}{0.80}%                    (near 428)
\definecolor{mediumgray}{gray}{0.60}%                   Pantone solid coated 877
\definecolor{darkgray}{gray}{0.40}%                     Pantone solid coated cool gray 10 (near 424)

\newcommand{\defaultcolor}{upbblue}
\newcommand{\emcolor}{upbtextorange}%                   Previous setting {rgb}{0.93,0.32,0.0}
\newcommand{\altcolor}{upbtextgreen}%                   Previous setting {rgb}{0.31,0.68,0.15}
\newcommand{\keywordcolor}{violet}

\newcommand{\colortext}[1]{{\color{\defaultcolor}#1}}
\newcommand{\emcolortext}[1]{{\color{\emcolor}#1}}
\newcommand{\altcolortext}[1]{{\color{\altcolor}#1}}
\newcommand{\keywordcolortext}[1]{{\color{\keywordcolor}#1}}

\newcommand{\blacktext}[1]{{\color{black}#1}}
\newcommand{\graytext}[1]{{\color{mediumgray}#1}}
\newcommand{\whitetext}[1]{{\color{white}#1}}

%%% To avoid hyperref warnings \coloritem must be defined after inclusion of hyperref package.
%%% Note. Develop slides without presuming the redefinition of \item.
\let\itemaux\item
\newcommand{\coloritem}[1][\defaultcolor]{\color{#1}\itemaux}
\newcommand{\blackitem}{\coloritem[black]}
\newcommand{\grayitem}{\coloritem[mediumgray]}
\let\item\blackitem



%%% Text elements.
\RequirePackage{xspace}
\RequirePackage{pifont}
\RequirePackage{latexsym}% Necessary for \leadsto.

\newcommand{\bsarrow}[1][mediumgray]{{\color{#1}\ding{220}}\xspace}
\newcommand{\bsbb}{\quad$\leadsto$ {\fontencoding{OMS}\fontfamily{pzc}\fontshape{n}\selectfont\iflanguage{german}{TAFEL}{BO\kern-3ptARD}}}
\newcommand{\bscite}[1]{\mbox{\fontfamily{\rmdefault}\fontseries{m}\fontshape{n}\selectfont\footnotesize[#1]}}
\newcommand{\bscont}{{\footnotesize\mdseries\upshape\ \iflanguage{german}{(Fortsetzung)}{(continued)}}}

\hypersetup{extension=}
\hyperbaseurl{http://www.uni-weimar.de/medien/webis/teaching/lecturenotes/}% Fragment identifiers don't work with iframes and url forwarding.
\let\baseurl\@baseurl
\newcommand{\bshyperref}[4][\bshyperrefstyle]{\hyperref{#2}{}{#3}{{#1{#4}}}}
  % #1 Optional style commands (underline, color, font size).
  % #2 Relative URL path (without baseurl) of pdf file.
  % #3 Fragment identifier.
  % #4 Clickable text.
\newcommand{\bshyperrefstyle}{\fontfamily{\rmdefault}\selectfont\uline}
\usepackage[normalem]{ulem}
%%% Underlining. \def\ULthickness{0.2pt}, \def\ULdepth{3pt}, \usepackage{soul}, \newbox\bsbox, \setbox\bsbox=\hbox{test}, \the\dp\bsbox, \smash.

\newcommand{\Ni}{(1)~}
\newcommand{\Nii}{(2)~}
\newcommand{\Niii}{(3)~}
\newcommand{\Niv}{(4)~}
\newcommand{\Nv}{(5)~}
\newcommand{\Nvi}{(6)~}


\newenvironment{quote}
 {\list{}{\rightmargin\leftmargin}\item\relax}
 {\endlist}

\renewcommand\footnoterule{%
  \kern-3\p@\hrule\@width.4\columnwidth\kern2.6\p@}
\newcommand\@makefntext[1]{%
    \parindent 1em%
    \noindent
    \hb@xt@1.8em{\hss\@makefnmark}#1}



%%% Auxiliary commands.
\newcommand{\textbufferA}{}
\newcommand{\textbufferB}{}
\newcommand{\textbufferC}{}
\newcommand{\textbufferD}{}
\newcommand{\textbufferE}{}
\newcommand{\textbufferF}{}
\newcommand{\textbufferG}{}
\newcommand{\textbufferH}{}
\newcommand{\textbufferI}{}

\newcommand{\textcolorA}{}
\newcommand{\textcolorB}{}
\newcommand{\textcolorC}{}
\newcommand{\textcolorD}{}
\newcommand{\textcolorE}{}
\newcommand{\textcolorF}{}
\newcommand{\textcolorG}{}
\newcommand{\textcolorH}{}
\newcommand{\textcolorI}{}



%%% Mathematical environments.
\RequirePackage{theorem}

{\theoremheaderfont{\fontseries{b}\fontshape{n}\selectfont\color{upbblue}}
 \theorembodyfont{\fontshape{n}\selectfont}
 \theoremstyle{break}
 \newtheorem{corollary}{\iflanguage{german}{Korollar}{Corollary}}
 \newtheorem{definition}{Definition}
 \newtheorem{lemma}{Lemma}
 \newtheorem{proof}{\iflanguage{german}{Beweis}{Proof}}
 \AtBeginDocument{\let\theproof\relax}
 \newtheorem{theorem}{\iflanguage{german}{Satz}{Theorem}}
}

\newenvironment{proofsketch}[1][]
  {{\fontseries{b}\fontshape{n}\selectfont\color{upbblue}\par%
    \iflanguage{german}{Beweisidee}{Proof Sketch}\ifx\\#1\\\else{\ {(#1)}}\fi\\}}{}



%%% Mathematical symbols.
\newcommand{\nat}{\mathbf{N}}
\newcommand{\integer}{\mathbf{Z}}
\newcommand{\rat}{\mathbf{Q}}
\newcommand{\real}{\mathbf{R}}
\newcommand{\realplus}{\mathbf{R^+}}

\renewcommand{\min}{\ensuremath{\mathop{\mathrm{min}}}}
\renewcommand{\max}{\ensuremath{\mathop{\mathrm{max}}}}
\renewcommand{\exp}{\ensuremath{\mathop{\mathrm{exp}}}}
\renewcommand{\log}{\ensuremath{\mathop{\mathrm{log}}}}


\endinput
%%

