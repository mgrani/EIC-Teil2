%%% bs-reading.cls (Release 10)
%%% DATE. December 2nd, 2012.


%%% Base class and styles.
\LoadClass{article}

\usepackage[german,american]{babel}
\usepackage[T1]{fontenc}\usepackage{ae,aecompl}
\usepackage[latin1]{inputenc}% For umlauts (OT1) and the ß (OT1, T1).
\usepackage{type1cm}% CM-Fonts including Math-Fonts in all sizes.
\usepackage{ifpdf}% Implements the \ifpdf-command.
\IfFileExists{\jobname.sty}{\usepackage{\jobname}}{}% Look for part-specific tex code.



%%% Option processing.
\DeclareOption{american}{\AtBeginDocument{\selectlanguage{american}}}
\DeclareOption{english}{\AtBeginDocument{\selectlanguage{english}}}
\DeclareOption{german}{\AtBeginDocument{\selectlanguage{german}}}

\ExecuteOptions{german}
\ProcessOptions



%%% Hyperref. \cf{http://www.tug.org/applications/hyperref/manual.html}
%%%
%%% colorlinks=false enables pdfborder, colorlinks=true disables pdfborder. From within document: \setkeys{Hyp}{colorlinks=false}
\ifpdf
  \usepackage[pdftex,colorlinks=true,pdfborder={0 0 0},linkcolor=upbblue,urlcolor=upbblue]{hyperref}
  \pdfoutput=1
  \pdfcompresslevel=9
\else
  \usepackage[dvips,colorlinks=true,pdfborder={0 0 0},linkcolor=upbblue,urlcolor=upbblue]{hyperref}
\fi



%%% Medium size. \cf{http://de.wikipedia.org/wiki/Grafikstandard}, \cf{http://de.wikipedia.org/wiki/Grafikmodus}
%%%
%%%  width x height         aspect ratio
%%%
%%% 1280pt x 1024pt SXGA     5:4 = 1.25     
%%%  640pt x  480pt VGA      4:3 = 1.33
%%% 1024pt x  768pt XGA      4:3 = 1.33
%%% 1440pt x  960pt Apple    3:2 = 1.5
%%% 1920pt x 1200pt WUXGA    8:5 = 1.6
%%% 2560pt x 1600pt WQXGA    8:5 = 1.6
%%% 1280pt x  720pt HD      16:9 = 1.78
%%% 1920pt x 1080pt Full HD 16:9 = 1.78
%%%
%%%    9in x    7in          9:7 = 1.29  ~ 648 x 504 device points. Current slide.
%%% 5.04in x 3.78in          4:3 = 1.33  ~ <texmf>/tex/latex/beamer slide.
%%% 8.25in x  5.5in          3:2 = 1.5   ~ 594 x 396 device points ~ A4 width (21.0cm) x 0.5 Letter height. Future slide.

\paperwidth=9in
\paperheight=7in
\ifpdf\else% Produce pdf from ps.
  \special{papersize=9in,7in}% Inform dvips. Via commandline: dvips -T 9in,7in <texfile>
  \edef\@pdfpagescrop{0 0 648 504}% Inform ps2pdf. Via commandline: ps2pdf -dDEVICEWIDTHPOINTS=648 -dDEVICEHEIGHTPOINTS=504 <texfile>.ps. \pdfpagescrop requires dvips driver.
\fi

\hoffset=-1in% Correct the default printer offsets. \cf[appendix]{Kopka}
\voffset=-1in

\oddsidemargin=10pt% Left and right border between slide and content.
\evensidemargin=\oddsidemargin
\topmargin=4pt% Top and bottom border between slide and content.

\setlength\headheight{0pt}
\setlength\headsep{0pt}
\setlength\topskip{24pt}
\setlength\footskip{12pt}

\textwidth=\paperwidth
\textheight=\paperheight
\advance\textwidth by -2.0\oddsidemargin% Left+right -> 2.0
\advance\textheight by -2.0\topmargin% Top+bottom -> 2.0
\advance\textheight by -\headheight
\advance\textheight by -\headsep
\advance\textheight by -\footskip

\parindent=0pt
\setlength\parskip{0.5\baselineskip}

\newlength{\bsparskip}
\newcommand{\bspar}[1]{% A skip that is evaluated at type-setting time.
  \bsparskip=0.5\baselineskip
  \par\vspace*{#1\bsparskip}}

\input{sizebeamer.clo}% Affects all em- and ex-specifications. Use pt-specifications till this \input-command.

\raggedright
\raggedbottom
\sloppy



%%% Fonts.
%%%
%%% ppl=Palatino, pag=Avantgarde, ptm=Times, pcr=Courier, phv=Helvetica, pbk=Bookman, pnc=NewCenturySchlbk, psy=ymbol, out=Utopia, pzc=ZapfChancery, pzd=ZapfDingbats, far=ArialCyrMT, fcr=CourierCyrPS.

\renewcommand{\rmdefault}{phv}
\DeclareMathAlphabet{\mathcalbf}{OMS}{pzc}{b}{n}
\DeclareMathAlphabet{\mathit}{T1}{phv}{m}{it}
\DeclareMathAlphabet{\mathitbf}{OT1}{cmr}{bx}{it}
\DeclareMathAlphabet{\mathptmbf}{T1}{ptm}{b}{it}
\DeclareMathAlphabet{\mathrm}{T1}{phv}{m}{n}
\renewcommand{\ttdefault}{pcr}% Unfavorable font family but necessary for \tt\bfseries.
%%% \renewcommand{\ttdefault}{aett}% Reinstall classical Latex \tt.
%%% TODO. Install mathematical fonts from the cmbright-package under Helvetica. See bs-styles-history/bs-slides.cls for a combined use of cmtt and pcr. \cf{http://www.dante.de/faq/de-tex-faq/html/fonts2.html#19}



%%% Slide environment.
\usepackage{collect}
\usepackage{expandonce}

\newenvironment{bsslide}[1][]{%
  % #1 slide head text.
  \newpage\normalsize
  \def\slideheadtext{#1}
  \collectinmacro\@lastslide{}{}}
  {\endcollectinmacro%
    \expandonce\@lastslide\@lastslide\lastslide% Expand \lastslide in \@lastslide and redefine \@lastslide.
    \slidehead{\slideheadtext}% Output starts always at \topskip.
    \@lastslide% Output \lastslide.
    \global\let\lastslide\@lastslide}

\newcommand{\slidehead}[1]{%
  \expandonce#1#1\lasthead% Expand \lasthead in #1 and redefine #1.
  \ifx\\#1\\\else{\slideheadstyle#1\par}\global\let\lasthead#1\fi}% See \ifx-comment below.
\newcommand{\slideheadstyle}{\large\bfseries}


\newcommand{\bscollection}[1]{\renewcommand{\bscollectionaux}{\ifx\\#1\\\else#1:\fi}}
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


\newcommand{\bsauthor}[1]{\renewcommand{\bsauthoraux}{\ifx\\#1\\\else\raisebox{1pt}{\textcopyright}#1\fi}}
\newcommand{\bsauthoraux}{\textbackslash bsauthor}

\newcommand{\bsyear}[1]{\renewcommand{\bsyearaux}{#1}}
\newcommand{\bsyearaux}{\textbackslash bsyear}


\newcommand{\bsfoot}[1]{\renewcommand{\bsfootaux}{#1}}
\newcommand{\bsfootaux}{\textbackslash bsfoot\hfill}

\newcommand{\footfont}{\fontfamily{\rmdefault}\fontsize{8}{0}\fontseries{m}\fontshape{n}\selectfont\color{\footcoloraux}}
\newcommand{\footcolor}[1]{\renewcommand{\footcoloraux}{#1}}
\newcommand{\footcoloraux}{mediumgray}

\makeatletter
\def\ps@plain{\def\@oddfoot{\footfont\bsfootaux}}
\makeatother
\pagestyle{plain}


\bsfoot{%
  \bscollectionaux%
  \ifnum\value{page}>0{\ifnum\value{bspart}>0\Roman{bspart}-\fi\arabic{page}}\quad\fi%
  \bspartnameaux\hfill\bsauthoraux~\bsyearaux}



%%% Figures and tables.
%%% \DeclareGraphicsExtensions -> Sourcing sequence
%%% \graphicspath -> Search sequence
\ifpdf
  \usepackage[pdftex]{graphicx}
  \DeclareGraphicsRule{.ai}{pdf}{*}{}% Handle ai files as pdf files.
  \DeclareGraphicsExtensions{.pdf,.ai,.jpg,.png}
  \graphicspath{{../figures/ai-version-cs2/}{../figures/ai-version-10/}{../figures/figures-others/}}
  \pdfpagebox 5% Use ArtBox instead MediaBox. 1=MediaBox, 2=CropBox, 3=BleedBox, 4=TrimBox, 5=ArtBox.
  % Obsolete previous commands of \pdfpagebox are \pdfforcepagebox and \pdfoptionalwaysusepdfpagebox.
  % AI 7 pdf files have an undesired y-offset. With AI CS both ai and pdf are correct. Tex allows pdf version 1.4, AI CS4 defaults to 1.5.
  % AI pdf files may have wrong bounding boxes due to hidden layers.
  % pdfinfo -box <pdf-file>.
  % ps2pdf <file>.ai <file>.pdf. Problem: -dEPSCrop does not work.
  % pdfcrop <pdf-file>. Problem: struts (invisible whitespace) are also removed.
\else
  \usepackage{graphicx}
  \DeclareGraphicsExtensions{.ps,.eps,.ai}
  \graphicspath{{../figures/ai-version-7/}{../figures/figures-others/}}
\fi

%%% Addresses a viewer bug. Normalizes rendering of fonts if bitmaps and transparency effects are combined.
% \pdfpageattr{/Group << /S /Transparency /I true /CS /DeviceRGB>>}

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

\fboxrule=0.5pt
%\setlength{\fboxsep}{8pt}



%%% Color declarations and commands.
\ifpdf
  \RequirePackage[pdftex]{color}
\else
  \RequirePackage{color}
\fi

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
\newcommand{\bsbullet}{{\footnotesize\ding{113}}}
\renewcommand{\labelitemi}{\bsbullet}
\newcommand{\bsbb}{\quad$\leadsto$ {\fontencoding{OMS}\fontfamily{pzc}\fontshape{n}\selectfont\iflanguage{german}{TAFEL}{BO\kern-3ptARD}}}
\newcommand{\bscite}[1]{\mbox{\fontfamily{\rmdefault}\fontseries{m}\fontshape{n}\selectfont\footnotesize[#1]}}
\newcommand{\bscont}{{\footnotesize\mdseries\upshape\ \iflanguage{german}{(Fortsetzung)}{(continued)}}}

\hypersetup{extension=}
\hyperbaseurl{http://www.uni-weimar.de/medien/webis/teaching/lecturenotes/}
\makeatletter\let\baseurl\@baseurl\makeatother
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
    \iflanguage{german}{Beweisidee}{Proof Sketch}\ifx\\#1\\\else\ {(#1)}\fi\\}}{}
\newenvironment{bsfact}[1][]
  {{\fontseries{b}\fontshape{n}\selectfont\color{upbblue}\par%
    Fakt\ifx\\#1\\\else\ {(#1)}\fi\\}}{}



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



%%% NOTES.

%%% Fonts.
%%%
%%% Distinguish between _encoding_ (OT1 = old Tex, T1 = new Cork) and _Type_ (Type-1 = Postscript, Type-3 = Bitmap). Under the OT1-encoding (default or \usepackage[OT1]{fontenc}) Knuth's CM-Fonts are used as Type-1 fonts. Under the T1-encoding (\usepackage[T1]{fontenc}), Knuth's CM-Fonts are called EC-fonts, and they are used as Type-3 fonts. However, Type-1 versions of the EC-fonts are in development and recently available; a common workaround for using EC-fonts as Type-1 fonts provides the {ae}-package (or the packages {cm-super,lfonts}). Hence, the packages [T1]{fontenc} and {ae,aecompl} must be used together. The {type1cm}-package provides Knuth's CM-Fonts in arbitrary sizes. There is also a {type1ec}-package whose purpose I don't know. Knuth's cmtt-font seems not to be available in \bfseries; as a workaround the PS-family pcr may be used. Under the OT1-encoding the [latin1]{inputenc}-package provides umlauts and the ß; under the T1-encoding it provides the ß. \cf{http://www.dante.de/faq/de-tex-faq/html/fonts2.html}


%%% Test for empty optional parameters.
%%%
%%% (a) \ifx\\#1\\\else<else-code with #1>\fi
%%% Note that \ifx\\#1\\ has 3 token if #1 is not empty (which may be confusing), else 2 token. This construction does not work if #1 starts with \\.
%%% (b) \def\bstest{#1}\ifx\bstest\empty\else<else-code with #1>\fi
%%% \cf[116]{http://www.ruhr-uni-bochum.de/schwarz/TeX/einfuehrung-in-tex.pdf}


%%% Work explicitly with the medium 9x7in (beamer) under the procedure dvi -> ps -> pdf. \cf{~/tex/tex-infos/slides/downey-page-orientation-tex.ps}
%%%
%%% ps-creation.
%%% Via commandline with medium name: dvips -t beamer <texfile>
%%% Via commandline with medium size (width, height): dvips -T 9in,7in <texfile>
%%% Within document (width, height): \special{papersize=9in,7in} => dvips <texfile>
%%% Note that for both alternatives dvips must be informed about the paper size. Add the following lines in <texmf>/dvips/config/config.ps (width, height):
%%%    @ beamer 9in 7in
%%%    @+ %%PaperSize: beamer
%%% The Syntax is "@ [name [width height]]". When dvips has a paper format name given on the command line, it looks for a match by the name; when it has a `papersize' special, it looks for a match by dimensions. \cf{dvips-users-guide}
%%%
%%% pdf-creation.
%%% Via commandline with medium name: ps2pdf -sPAPERSIZE=beamer <texfile>.ps
%%% pdf-creation. Via commandline with medium size: ps2pdf -dDEVICEWIDTHPOINTS=648 -dDEVICEHEIGHTPOINTS=504 <texfile>.ps \cf{http://www.cs.wisc.edu/~ghost, http://www.cs.wisc.edu/~ghost/doc/AFPL/8.50/Use.htm#Paper_size}
%%% pdf-creation. Within document (lx, ly, rx, ry): \edef\@pdfpagescrop{0 0 648 504} => ps2pdf <texfile>.ps
%%% Note that for the commandline alternative gs must be informed about the paper size. Add the following lines in /usr/share/ghostscript/<version>/lib/gs_statd.ps (width, height):
%%%    /beamer {648 504 //.setpagesize exec} bind def % BS. ~ 9x7
%%%    ...
%%%    /beamer % BS. ~ 9x7
%%% To make gs_statd.ps user-specific, create a directory for the ghostscript configuration files, e.g. ~/texmf/ghostscript/lib/, and define the environment variable GS_LIB:
%%%    .bash_profile. GS_LIB=.//:$HOME/tex/texmf/ghostscript/lib/: # User's initialization files for ghostscript.
%%%                   export  GS_LIB
%%%
%%% Xdvi viewer. Via commandline (width, height): xdvi -paper 9x7in -s 4 <texfile>
%%% 
%%% Ghostview Linux (gv). Size information for the media-menu is specified in ~/.gv (user-specific) or in /usr/X11R6/lib/X11/[gv/gv_user.ad | app-defaults/GV] (system-wide). Add the following line in the GV.medias section (width, height):
%%%    beamer,  648 504\n\ # BS.
%%% Ghostview Windows XP (gsview32). Size information for the media-menu is specified in "C:\Dokumente und Einstellungen\<user>\gsview32.ini" in the section "[UserMedia]" by adding the line "beamer=648,504" (width, height).
%%% Ghostview Windows Vista (gsview64). Size information for the media-menu is specified in "C:\Users\<user>\gsview64.ini" in the section "[UserMedia]" by adding the line "beamer=648,504" (width, height). 


%%% Global skips.
%%%
%%% Most dimensions and settings are defined before \begin{document}; check these values via \the\<dimension>. These values are frozen. I.e., if a size is defined relative to a font such as \parskip=2ex, the currently active font is chosen as reference. A later redefinition of the font will never change the already defined values. Example: \parskip=1ex. This will define a parskip of 1ex relative to some font which is declared as \normalsize in the moment when \parskip=1ex is evaluated.
%%%
%%% The \parskip in the document defaults to 0.0pt plus 1.0pt. The \parskip in minipages defaults to 0.0pt, irrespective of the \parskip setting for the document.


%%% Find invalidly encoded file names.
%%%
%%% 1. $ find ~stein -name "*" > names1.txt
%%% 2. $ find ~stein > names2.txt
%%% 3. diff names1.txt names2.txt



%%% End.

