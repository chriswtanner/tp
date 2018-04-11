\def\fileversion{v1.51}
\def\filedate{1998/16/12}

\NeedsTeXFormat{LaTeX2e}[1996/12/01]
\ProvidesClass{brownthesis}[\filedate\space\fileversion\space Brown University PhD Thesis Class]

\newif\if@draft
\newif\ifc@pyright
\newif\ifl@fpage
\newif\ifl@tpage
\newif\ifl@epage
\newif\ift@cpage
\newif\if@sigpage

\DeclareOption{draft}{\@drafttrue\PassOptionsToClass{draft,twoside}{book}}
\DeclareOption{final}{\@draftfalse\PassOptionsToClass{final,oneside}{book}}
\DeclareOption{twoside}{\PassOptionsToClass{twoside}{book}}
\DeclareOption{oneside}{\PassOptionsToClass{oneside}{book}}
\DeclareOption{contents}{\t@cpagetrue}
\DeclareOption{nocontents}{\t@cpagefalse}
\DeclareOption{figures}{\l@fpagetrue}
\DeclareOption{nofigures}{\l@fpagefalse}
\DeclareOption{tables}{\l@tpagetrue}
\DeclareOption{notables}{\l@tpagefalse}
\DeclareOption{examples}{\l@epagetrue}
\DeclareOption{noexamples}{\l@epagefalse}
\DeclareOption{copyright}{\c@pyrighttrue}
\DeclareOption{nocopyright}{\c@pyrightfalse}
\DeclareOption{signature}{\@sigpagetrue}
\DeclareOption{nosignature}{\@sigpagefalse}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{book}}
\ExecuteOptions{11pt,final,copyright,contents,figures,tables,noexamples,signature}
\ProcessOptions\relax

\LoadClass{book}

% Page geometry
\topmargin 0pt
\footskip 18pt
\textwidth 6in
\textheight 8.5in
\headheight 12pt
\headsep 24pt
\oddsidemargin 0.5in
\evensidemargin 0pt
  
% Disallow page breaks at hyphens (this will give some underfull vbox's,
% so an alternative is to use \brokenpenalty=100 and manually search
% for and fix such page breaks)
\brokenpenalty=10000
 
% For the final version use 1.3 times the normal baseline-to-baseline skip
% However if this is a draft we use single spacing to save some trees
\def\single@spacing{\def\baselinestretch{2}}
\def\final@spacing{\def\baselinestretch{1.3}}
\if@draft\single@spacing\else\final@spacing\fi
 
% Reset interline spacing to normal inside float environments
% We do this by extending the \@floatboxreset macro
\let\old@floatboxreset=\@floatboxreset
\def\@floatboxreset{\single@spacing\old@floatboxreset}

% Redefine the macro used for footnotes to use single spacing
\long\def\@footnotetext#1{\insert\footins{%
    \hangindent\parindent % -- Manos
    \single@spacing\reset@font\footnotesize
    \interlinepenalty\interfootnotelinepenalty
    \splittopskip\footnotesep
    \splitmaxdepth \dp\strutbox \floatingpenalty \@MM
    \hsize\columnwidth \@parboxrestore
    \protected@edef\@currentlabel{%
       \csname p@footnote\endcsname\@thefnmark
    }% 
    \color@begingroup
      \@makefntext{%
        %\rule\z@\footnotesep%
	\ignorespaces#1\@finalstrut\strutbox}%
	\vspace{0.5\footnotesep}%
    \color@endgroup}}
% However, footnotes need a blank line between them -- Manos
%\setlength{\footnotesep}{1.3\baselineskip}

% Redefine thebibliography to add an entry in the table of contents
\let\@ldthebibliography=\thebibliography
\def\thebibliography#1{\@ldthebibliography{#1}%
  \addcontentsline{toc}{chapter}{\bibname}}

% --  Manos
% A paragraph must be inserted after the toc, that gives the 
% places where parts of the thesis have been published before
\def\disclaimer#1{\gdef\@disclaimer{#1}}
%the default, however, is nothing
\let\@disclaimer\@empty

\def\@dept{Computer Science}
\def\@degrees{}
\def\@principaladviser{}
\def\@dean{}
\def\@submitdate{\ifcase\the\month\or
   January\or February\or March\or April\or May\or June\or
   July\or August\or September\or October\or November\or December\fi
   \space \number\the\year}
\ifnum\month=12
\fi
 
%\def\prefacesection#1{\chapter*{#1}\addcontentsline{toc}{chapter}{#1}}
% We don't really won't the preface sections to appear in the TOC

\long
\def\afterpreface{\cleardoublepage
  \ift@cpage
  \tableofcontents
  \ifx\@disclaimer\@empty
      \else
      \vspace{0.5cm}
      \single@spacing
      \noindent
      \hangindent\parindent
      \makebox[\parindent][l]{\raisebox{0.2ex}{\large{$\star$}} }\@disclaimer
      \if@draft\single@spacing\else\final@spacing\fi
  \fi
  \cleardoublepage\fi
  \ifl@tpage\addcontentsline{toc}{chapter}{List of Tables}\listoftables
    \cleardoublepage\fi
  \ifl@fpage\addcontentsline{toc}{chapter}{List of Figures}\listoffigures
    \cleardoublepage\fi
  \ifl@epage\addcontentsline{toc}{chapter}{List of Examples}\listofexamples
    \cleardoublepage\fi
  \pagenumbering{arabic}\pagestyle{myheadings}}
 
\endinput