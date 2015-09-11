%%% DATE. December 14th, 2012.

\LoadClass[11pt,a4paper]{article}
\ProvidesClass{exercise}
 [2012/12/03 v1.2 Basic class for lab class handouts]

\usepackage[german,american]{babel}
\usepackage[T1]{fontenc}
\usepackage{ae,aecompl}
\usepackage[latin1]{inputenc}% For umlauts (OT1) and the ß (OT1, T1).
\usepackage{type1cm}% CM-Fonts including Math-Fonts in all sizes.
\usepackage{ifpdf}



%%% Options.
\newif\ifbsanswer\bsanswerfalse
\newif\ifbsaddition\bsadditionfalse

\DeclareOption{american}{\AtBeginDocument{\selectlanguage{american}}}
\DeclareOption{english}{\AtBeginDocument{\selectlanguage{english}}}
\DeclareOption{german}{\AtBeginDocument{\selectlanguage{german}}}

\DeclareOption{answers}{\bsanswertrue}% Show answers.
\DeclareOption{additions}{\bsadditiontrue}% Show additional exercises.

\ExecuteOptions{german}
\ProcessOptions



%%% Text area.
\hoffset=-1in% Correct the default printer offsets. \cf[appendix]{Kopka}
\voffset=-1in

\oddsidemargin=0.8in
\evensidemargin=\oddsidemargin
\topmargin=12pt

\setlength\headsep{24pt}
\setlength\topskip{24pt}
\setlength\footskip{48pt}

\textwidth=6.5in
\textheight=10in

\parindent=0pt
\setlength\parskip{0.5\baselineskip}

\onecolumn
\raggedright
\raggedbottom
\sloppy



%%% Font families.
\usepackage{times}
\DeclareMathAlphabet{\mathcalbf}{OMS}{pzc}{b}{n}
\DeclareMathAlphabet{\mathit}{T1}{phv}{m}{it}
\DeclareMathAlphabet{\mathrm}{T1}{phv}{m}{n}
\renewcommand{\ttdefault}{pcr}% Unfavorable font family but necessary for \tt\bfseries.



%%% Exercise environment.
\newcommand{\bsauthor}[1]{\renewcommand{\bsauthoraux}{\ifx\\#1\\\else{\textcopyright\,#1}\fi}}
\newcommand{\bsauthoraux}{\textbackslash bsauthor}

\newcommand{\bsyear}[1]{\renewcommand{\bsyearaux}{#1}}
\newcommand{\bsyearaux}{\textbackslash bsyear}


\newcommand{\bsfoot}[1]{\renewcommand{\bsfootaux}{#1}}
\newcommand{\bsfootaux}{\textbackslash bsfoot\hfill}
\newcommand{\footfont}{\fontfamily{phv}\fontsize{8}{0}\fontseries{m}\fontshape{n}\selectfont\color{mediumgray}}
\def\ps@plain{\def\@oddfoot{\footfont\bsfootaux}}
\pagestyle{plain}

\bsfoot{\thepage\hfill\bsauthoraux~\bsyearaux}



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
  \scalebox{1.0}{\includegraphics[#1]{#2}}}


\usepackage{booktabs}
\lightrulewidth=0.5pt
\heavyrulewidth=1pt
\aboverulesep=1pt
\belowrulesep=1pt

\setlength\fboxsep{3\p@}
\setlength\fboxrule{1\p@}



%%% Color declarations and commands.
\RequirePackage{xcolor}

\definecolor{upbblue}{rgb}{0.04,0.12,0.38}%             Pantone solid coated 281
\definecolor{upbtextgreen}{rgb}{0.31,0.68,0.15}%        Pantone solid coated 361
\definecolor{upbtextorange}{rgb}{0.93,0.32,0.0}%        Pantone solid coated 159
\definecolor{mediumgray}{gray}{0.60}%                   Pantone solid coated 877
\definecolor{darkgray}{gray}{0.40}%                     Pantone solid coated cool gray 10 (near 424)

\newcommand{\defaultcolor}{upbblue}
\newcommand{\emcolor}{upbtextorange}
\newcommand{\altcolor}{upbtextgreen}

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

\newcommand{\bslabel}[1]{\noindent\textsl{#1.}}
\renewcommand{\labelenumi}{(\alph{enumi})}
\renewcommand{\labelenumii}{(\alph{enumi}\arabic{enumii})}

\newcommand{\bscite}[1]{\mbox{\fontfamily{\rmdefault}\fontseries{m}\fontshape{n}\selectfont\footnotesize[#1]}}

\hypersetup{extension=}
\hyperbaseurl{http://www.uni-weimar.de/medien/webis/teaching/lecturenotes/}% Fragment identifiers don't work with iframes and url forwarding.
\let\baseurl\@baseurl
\newcommand{\bshyperref}[4][\bshyperreftexthook]{\hyperref{#2}{}{#3}{{#1{#4}}}}
  % #1 Hook for optional render commands (underline, color, font size).
  % #2 Relative URL path (without baseurl) of pdf file.
  % #3 Fragment identifier.
  % #4 Clickable text.
\newcommand{\bshyperreftexthook}{\uline}
\usepackage[normalem]{ulem}
%%% Underlining. \def\ULthickness{0.2pt}, \def\ULdepth{3pt}, \usepackage{soul}, \newbox\bsbox, \setbox\bsbox=\hbox{test}, \the\dp\bsbox, \smash.

\newcommand{\Ni}{(1)~}
\newcommand{\Nii}{(2)~}
\newcommand{\Niii}{(3)~}
\newcommand{\Niv}{(4)~}
\newcommand{\Nv}{(5)~}
\newcommand{\Nvi}{(6)~}



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



%%% Exercises and examinations.
\usepackage{currfile}% Implements the \currfilebase-command.

\newcommand{\bsreadingtitle}[1]{\renewcommand{\bsreadingtitleaux}{#1}}
\newcommand{\bsreadingtitleaux}{\textbackslash bsreadingtitle}

\newcommand{\exerciseheader}[2][\today]{%
  \setcounter{exerciseCounter}{0}
  \clearpage
  \bgroup
    \fontfamily{phv}\selectfont
    \vspace*{-48pt}
    {\small{\bfseries\bsreadingtitleaux}\hfill#1\par}
    {\large\bfseries#2\par}
    \vspace{48pt}
 \egroup}

\newcounter{exerciseCounter}[section]
\newenvironment{exercise}[2][]
  {\refstepcounter{exerciseCounter}
   \par\bigskip\pagebreak[2]
   \iflanguage{german}{Aufgabe}{Exercise}
   \arabic{exerciseCounter}\label{\currfilebase}
   \ifx\\#2\\\else: #2\fi
   \ifx\\#1\\\else\ (#1 \iflanguage{german}{Punkte}{Points})\fi
   \begin{addition}\ \ \iflanguage{german}{Datei:}{File:} \currfilebase\end{addition}
   \par}
  {}

\newcommand{\answer}[1]{%
  \ifx\\#1\\\else{\ifbsanswer
    \renewcommand{\labelenumi}{ad\,\alph{enumi})}
    \par\textcolor{\altcolor}{\fbox{\iflanguage{german}{Antwort}{Answer}}}\par#1\fi}\fi}

\usepackage{collect}
\newenvironment{addition}{%
  \let\item\grayitem\color{mediumgray}%
  \collectinmacro{\@addition}{}{}}
  {\endcollectinmacro\ifbsaddition\@addition\fi}

\usepackage{latexsym}
\newcommand{\bsCheckBoxN}{\raisebox{-1pt}{\parbox{1.5em}{\huge $\Box$}}}
\newcommand{\bsCheckBoxY}{\raisebox{-1pt}{\parbox{1.5em}{{\huge $\Box$}\raisebox{3pt}{\large\kern-1em X}}}}

\newenvironment{multiplechoice}
  {\begin{itemize}\setlength{\itemsep}{0ex}\vspace{-1ex}}
  {\end{itemize}}
\newcommand{\choice}[1][]{
  \item[\ifbsanswer{\ifx\\#1\\\bsCheckBoxN\else\bsCheckBoxY\fi}\else\bsCheckBoxN\fi]}

\newcommand{\multipleChoiceText}{Beachten Sie, dass zu einer Frage mehrere Antworten zutreffen können. Ein Frage gilt als richtig beantwortet, falls alle zutreffenden und keine unzutreffende Antwort angekreuzt ist.}
\newcommand{\prosaText}{Versuchen Sie, die Fragen mit wenigen, klaren Sätzen zu beantworten.}


\endinput
%%
