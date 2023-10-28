%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Yi Pusen's Lecture Note
% Maintainer: Yi Pusen (bbcovd@126.com)
% 
% Document class to produce simple lecture note 
%
% This package is licensed under CC BY 4.0. To view a copy of this
% license, visit http://creativecommons.org/licenses/by/4.0/
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% Identification

\NeedsTeXFormat{LaTeX2e} % we need to have LaTeX2e for this to compile
\ProvidesClass{lecturenote}[2022/02/24]
% lecturenote is the name we need to provide to the documentclass command on the .tex file

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% Preliminary declarations:
%%%% These are some commands where we declare new commands for the class.
%%%% These are used for the titlepage.

% define the titlepage
\newcommand{\coursename}[1]{\newcommand{\coursenameLoc}{#1}}
\newcommand{\courseteacher}[1]{\newcommand{\courseteacherLoc}{#1}}
\newcommand{\coursenumber}[1]{\newcommand{\coursenumberLoc}{#1}}
\newcommand{\institute}[1]{\newcommand{\instituteloc}{#1}}
\newcommand{\optionalinfo}[2]{\ifx#1\undefined{}\else{#2} \fi}

% these are auxiliary definitions used in the title section
\newcommand{\courseNum}{Num}
\newcommand{\courseLang}{Course}
% This is the definitions used in the header
\newcommand{\lectureLang}[1]{Lecture #1}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% Options
%%%% We now pass the options of the class

% Two Columns are difficult to read and grade, we will not use them
\DeclareOption{twocolumn}{\OptionNotUsed}

% Two sided paper are difficult to read and grade, we will not use them
\DeclareOption{twoside}{\OptionNotUsed}

% we hardcode some language options
\DeclareOption{Chinese}{
    \renewcommand{\courseLang}{课程}
    \renewcommand{\courseNum}{编号}
    \renewcommand{\lectureLang}[1]{第 #1 讲}
}

\PassOptionsToClass{a4paper}{article}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}

\ProcessOptions\relax

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% Bulk Declarations
%%%% Here we do more declarations and call other files


% we need to load 
\LoadClass{article}

% Geometry lets us modify the sizes of the document nicely
\RequirePackage{geometry}
% Decent margins for the documents, as it is meant to be printed
\geometry{left=3.18cm,right=3.18cm,top=2.54cm,bottom=2.54cm, headheight=15pt}

% Course contains basic information about the course.
% \RequirePackage{course}
% This command will generate the info on headers and footers
% whenevr taking a new lecture
\RequirePackage{xifthen} % for a more powerful if-else statement
\newcommand{\lecturetitle}[1]{}
\newcommand{\lecture}[3]{
    \ifthenelse{\isempty{#3}}{
      % \def\@lecture{Lecture #1}
      \renewcommand{\lecturetitle}[1]{\lectureLang{#1}}
    }{
      % \def\@lecture{Lecture #1: #3}%
      \renewcommand{\lecturetitle}[1]{\lectureLang{#1}: #3}
    }
    \section{\lecturetitle{}}
    \marginpar{\small\textsf{\mbox{#2}}}
}
  
% Header and footers, we will use the lecturetitles also
\RequirePackage{fancyhdr}
\pagestyle{fancy}
\fancypagestyle{note}{
  \pagenumbering{arabic}
  \fancyhead[L]{\lecturetitle}
  \fancyhead[R]{\coursenameLoc}
  \fancyfoot[C]{\thepage}
\renewcommand{\headrulewidth}{0.4pt}
\renewcommand{\footrulewidth}{0.4pt}
}
\fancypagestyle{ToC}{
  \pagenumbering{roman}
  \fancyhead[R]{\coursenameLoc}
  \fancyfoot[C]{\thepage}
}

% make title page, I will give no footnotes here, since it is just a
% personal note documents.
\renewcommand{\maketitle}{
  \begin{titlepage}
    \centering
    % title
    {\huge {\bfseries \@title} \par}
    \vspace{8pt}
    % author
    {\large
      \begin{tabular}[t]{c}
        \@author
      \end{tabular}\par}
    \vspace{8pt}
    \rule{\textwidth}{0.8pt}
    \vspace{10pt}
    % Course information
    {\large \courseLang : \coursenameLoc{}}
    \optionalinfo{\courseteacherLoc}{--
      {\slshape \courseteacherLoc{}}\\
    }
    \optionalinfo{\coursenumberLoc}{{\upshape \courseNum :} {\itshape \coursenumberLoc} \\
    }
    \optionalinfo{\instituteloc}{\scshape \instituteloc}
    % white space between course information and date
    \vfill
    \rule{\textwidth}{1pt}
    {\large \@date}
  \end{titlepage}
}

%%% We finish the class with this command
\endinput
