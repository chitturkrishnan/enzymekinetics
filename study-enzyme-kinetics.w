% https://www.polypompholyx.com/2013/05/misconceptions-mmm/ (mm kinetics not valid inside cell)
% https://www.ncbi.nlm.nih.gov/books/NBK22430/

% noweb is used as a literate programming tool
% noweb study-enzyme-kinetics.w will extract the files you need
% and this make file can help
% name this study-enzyme-kinetics.make

\documentclass[10pt]{tufte-handout}
\usepackage{noweb}
\newcommand\addtocSS[1]{\addcontentsline{toc}{subsection}{#1}}
\newcommand\addtocS[1]{\addcontentsline{toc}{section}{#1}}

\usepackage{fancyhdr}
\pagestyle{fancy}
\fancyhf{}
\rhead{Chittur/Zahorchak}
\lfoot{page~\thepage}
\cfoot{\hyperlink{toc}{\small{\textcolor{blue}{Jump to Table of Contents}}}}


%\renewcommand \baselinestretch {1.1}
\renewcommand\contentsname{Table of Contents}
\usepackage{imakeidx}

\usepackage{fancyvrb}
\usepackage{minted}
\usepackage{listings}
\lstset{language=Python,prebreak=\raisebox{0ex}[0ex][0ex]
        {\ensuremath{\rhookswarrow}}}
\lstset{language=Python,postbreak=\raisebox{0ex}[0ex][0ex]
        {\ensuremath{\rcurvearrowse\space}}}
\lstset{language=Python,breaklines=true,breakatwhitespace=true}
\lstset{language=Python,numbers=left, numberstyle=\scriptsize,linewidth=6in,basicstyle=\scriptsize}
\usepackage{amsmath, amsthm, amssymb}
\usepackage{MnSymbol}
\usepackage{morefloats}
\usepackage{ifthen}
\newcommand{\executepython}{no}
\newcommand{\listpython}{no}
\usepackage{color}   %May be necessary if you want to color links
\usepackage{hyperref}
\hypersetup{
    colorlinks=true, %set true if you want colored links
    linktoc=all,     %set to all if you want both sections and subsections linked
    linkcolor=blue,  %choose some color if you want links to stand out
}

\usepackage{graphicx} % allow embedded images
\graphicspath{./}
%  \setkeys{Gin}{width=\linewidth,totalheight=\textheight,keepaspectratio}
%  \graphicspath{{graphics/}} % set of paths to search for images
\usepackage{amsmath}  % extended mathematics
\usepackage{booktabs} % book-quality tables
\usepackage{units}    % non-stacked fractions and better unit spacing
\usepackage{multicol} % multiple column layout facilities
\usepackage{fancyvrb} % extended verbatim environments
  \fvset{fontsize=\normalsize}% default font size for fancy-verbatim environments

\usepackage{pythontex}
\setpythontexworkingdir{.}

\usepackage{enumitem,xcolor}
\usepackage[version=3]{mhchem}

\usepackage{multirow}
\usepackage{eqnarray}

\setlength{\parindent}{0pt}
\setlength{\parskip}{1.2ex}
\bibliographystyle{unsrt}
\usepackage{geometry}
%\geometry{textwidth=6.5in}
\usepackage{pdfpages}
\usepackage{comment}
\makeindex
\begin{document}
\title{A study of enzyme kinetics: Theory and Experiments (or what students can learn by
doing)} 
\author{Krishnan K. Chittur, Robert J. Zahorchak}
%\address[label1]{Chemical Engineering Department, University of Alabama Huntsville, Huntsville, AL 35899}
%\address[label2]{HudsonAlpha Institute for Biotechnology, 601 Genome Way, Huntsville, AL 35806}
\maketitle
\tableofcontents
\addtocontents{toc}{\protect\hypertarget{toc}{}}
\newpage
\section{Abstract}
%\addcontentsline{toc}{section}{Abstract}
Enzymes are fundamental to living cells and are becoming increasingly important tools in many biotechnological applications. 
Education regarding these important workhorses in chemical manufacturing is rapidly becoming paramount as the biotechnology 
revolution grows. The inclusion of coursework addressing enzymes and enzyme kinetics into the curricula of chemical 
engineering programs is now considered standard practice. We describe a laboratory exercise where students perform mostly 
self-designed experiments, analyze andexamine the data using a computer program to gain an deeper understanding and 
appreciation for the use and application of mathematical models to enzyme kinetics.

\section{Objective}
%\addtocS{Objective}
We strongly believe that there is a critical role 
for the teaching Laboratory for students in Science and Engineering.
The implementation of laboratory exercises as a teaching tool 
has been foundational to reinforcing concepts of science and engineering 
for over a hundred years (https://narst.org/research-matters/laboratory-in-science-teaching). 
As scientists and engineers, both of us have dedicated much of our careers to improving 
laboratory exercises as tools to prompt students to develop and improve 
critical learning  and problem solving skills. 
In the current arena, cross discipline exposure of many subdisciplines of 
science and engineering is critical for students to deeply understand the importance of these skills. 

Understanding enzymes and their functions remains important 
and parallel instruction regarding biological and engineering concepts is essential. 
One foundational concept that applies to bioprocessing involves the use of biological components such as enzymes to produce desired products.

In addition, today, students use computer software for both data collection and analysis.
Far too often, students use readily packaged software including spreadsheet programs which allow for
analysis of the data without the student having to discover what is behind the software.
We have taken a different approach, with python~\index{python} as the scripting language for data analysis.

\section{Open Source Experiment}
%\addtocS{Open Source}
This is an experiment in using open source tools and literate programming - it is our hope to attract
both users and developers to contribute to this document.  

\subsection{The document and the contents}
We have used what is termed as {\em literal programming} - where the 
documentation, code, sample data files are all in one file. 
The documentation is in~\LaTeX~a set of macros for the~\TeX~typesetting engine.
The code is in python3 (we have used the anaconda distribution).  
A program called
{\em noweb}~\index{noweb} is first used to extract the documentation, the code and the data files.
There is also a {\em make} file that can simplify the process of compiling the
documentation.  The open source programs you will need include

\begin{description}
\item[noweb] \href{https://www.cs.tufts.edu/~nr/noweb/}{noweb} is one of the simplest tool for
literate programming - you create a simple text file that contains the documentation (\LaTeX),
code (python) and data files - run noweb on this file and extract the \LaTeX file, python codes
and data files.  Use the make file to create the pdf, which will require the \LaTeX engine and the
python interpreter.
\item[python] There are many python packages you can use - our choice was
\href{anaconda}{anaconda.com} - download the package for your system (versions are 
available for Mac, PC/Windows, Linux.
\item[pythontex] Python\TeX~\index{pythontex}~is a \LaTeX package that allows python code 
in \LaTeX documents to be executed and provides access to the output. This allows us to create
the final document that combines results with the code required to generate them.
\end{description}

\subsection{How noweb works}
%\addtocSS{How noweb works}
Using a simple text editor, embed code as chunks between documentation.
This present document is perhaps the best example of how to use noweb.

\subsection{The Make file}
A {\em make} file contains instructions on how to assemble the code, documentation
(or whatever you are trying to do).  In this example, we have {\em code} (in python),
documentation in \LaTeX - we have also used 
pythontex which allows for the embedding of python within \LaTeX and display
results from the execution of the python code.

\subsection{How to extract and compile}
You will need \href{https://www.cs.tufts.edu/~nr/noweb/}{noweb} if you begin with this
file - the command {\em noweb analyze-enzyme-kinetics.w} will extract the
\TeX file, the python codes and the make file.  You can then run
{\em make -f sek.make} to {\bf make} the documentation and run the code.
Data files are also included here.

\subsection{Why use literate programming?}
%\addtocSS{Why Literate Programming}
How often do we wonder where some figure came from in a paper we read?
We wonder what the raw data used was and the programs to calculate and display the
figure. What we have done in this file is include ALL of the data files we 
collected, analyzed and the code used to create the figures, tables from such.
Adding new data OR making changes to the existing figures is easily done.

\section{What we have done so far}
%\addtocS{What we have done so far}
\begin{description}
\item[Data Collection] Several experiments were done on an enzyme, substrate system data was
obtained on the concentration of the product of the enzyme interacting with the substrate was
obtained
\item[Data Analysis] Using known concentrations of the starting substrate and enzyme concentrations,
the data were analyzed using several different ways 
\begin{description}
\item[Initial Rate] The initial rate of reactions were calculated and fit to a well known model
called the Michaelis Menten equation (Line Weaver Burke Plot)
\item[Direct Fit] The concentration versus time data were fit to the integrated form of the
Michaelis Menten equation 
\item[Differential Equation] A set of four differential equations was integrated and
numerically fit to the data to estimate the rate parameters
\item[Compare] All of the data from the three different approaches are presented - and
can be studied to get a better sense of how to understand enzyme substrate interactions
\item[Software] The code for analysis is provided - the user needs a python system on their
computers/laptops (we use anaconda)
\end{description}
\end{description}

\section{Introduction}
Enzymes make possible hundreds to thousands of chemical reactions in biological cells within reasonable time frames and 
temperatures. The discovery of these amazing molecular engines that can help hydrate, dehydrate, oxidize, reduce, chop or 
stitch molecules with high specificity helped usher the biotechnology revolution. It is important therefore for students to
understand how enzymes work and how they can be used in the design and operation of biological reactors or equipment that 
can use enzymes to produce the many chemicals we use daily.

Traditionally, students are introduced to enzymes and their properties. at the college level, through what is commonly 
called the Michaelis Menten~\index{MichaelisMenten}~form
 or model with some mathematical analysis. A typical pedagogical approach is to provide 
students with data of the rates of enzyme catalysed reactions at different substrate concentrations, linearized plots are 
created followed by some interpretation and that usually ends it. More recently widespread and easy availability of enzymes, 
substrates and equipment to monitor changes in chemical compositions has expanded the possibilities of teaching enzyme 
kinetics. Improvements in computer software including the ability to model and simulate complex kinetics has changed how 
students can study and understand enzyme kinetics.

Our objective was to incorporate all facets of the evaluation of an enzyme substrate system into a hands-on laboratory module
as part of a chemical engineering course. This included experimental design and implementation, collection of data, analysis 
and comparison of results with idealized models using software written in the python programming language.

\section*{Methods}
\addcontentsline{toc}{section}{Methods}
We felt that a highly desirable approach would be to immerse students into a study of the behavior of enzymes by having them 
conduct experiments where they generated their own data, analyzed the data and compared their results with idealized results 
and what others may have reported in the literature. We established the following as criteria to design this laboratory 
project:
\begin{enumerate}
\item Use an enzyme system that is easy to acquire and is relatively stable.
\item A substrate whose concentration can be easily measured using instrumentation generally available
\item Setting expectation boundaries for the students that are consistent with an inquiry based learning
\item Project deliverables defined to include critical analysis of data acquired and communicated to the rest of the class.
\item Software for data analysis written in python that is freely distributable and portable across several commonly used 
operating systems.
\end{enumerate}

Our choice of the enzyme was not very difficult. Alkaline phosphatase~\index{Alkaline Phosphatase}~is an 
enzyme that is used widely and has been shown to 
be very robust and stable\cite{alkphos2019}. 
A well defined system for use as an educational tool in high school Advanced Placement 
Biology laborotories~\cite{apple2011}
There are a 
number of publications in peer reviewed journals that has addressed the properties of this enzyme~\cite{alkphos2019} 
The activity of this 
enzyme is easily studied using para nitrophenol phosphate as a substrate. The substrate is colorless, while the product 
(para nitrophenol) has a yellow color with an absorbance maximum at about 405 nm. Thus the enzymatic conversion of the 
substrate(para nitrophenol phosphate) to the product (para nitrophenol) can be monitored spectrophotometrcally, by monitoring
the change in absorbance at 405 nm over time. The buffer required for this is not complex and students can gather a 
significant amount of data quickly, following a very short learning curve. 

Our overall strategy for this laboratory was simple. Students were introduced to enzyme kinetics in the conventional 
classroom lecture format. These lectures included the description of and derivation of models of enzyme kinetics including 
the familiar Michaelis Menten form. They were introduced to the concept of the Lineweaver Burke double reciprocal plots 
which allowed for the determination of enzyme constants such as Km and Vm. Problem sessions that had calculations with enzyme 
inhibitors were also included. After approximately five weeks, students were introduced to the laboratory exercise. There was
a short lecture on the specific enzyme (alkaline phosphatase) and a brief tutorial on measuring rates with this sytem using 
a spectrophotometer. Students were given aliquots from stock solutions of enzyme, substrate and a buffer solution 
(100 mM Tris, 1 mM MgCl2, pH 8.0) and tasked to design and implement a series fo experiments to collect data that would allow
them to calculate the enzyme kinetic properties (including Vm and Km).

Students in groups of two to four had to prepare a report detailing their design, the data they collected, their analysis and
conclusions and make a presentation to the class. As part of the analysis, students were challenged with comparing their 
results to a theoretical analysis using the classical Michaelis Menten equation to determine if that model could be used to 
explain their experimental data. In addition to the python software written for this purpose, students used MathCAD or 
Microsaoft Excel. In order to achieve all the defined goals, students had to make a number of decisions, including what 
concentrations to use and the time frame for the measurements. Along with these details, students also had to learn and 
understand the use of the available equipment as well as the advantages and limitations imposed. They had to decide, for 
example, the rate at which to collect the data, how to mix the enzyme and substrate solutions together and how to identify 
when the enzyme reaction started (i.e. when was time zero?).

\section*{Background}
\addcontentsline{toc}{section}{Background}
In class, lectures were used to give students background on enzymes which included details on mechanisms, different ways to 
inhibit enzyme activity and approaches to deriving and using rate equations. Consistent with our objective of helping 
students understand how enzymes work, we incorporated computer simulation tools as a powerful means to reinforce the 
laboratory experimentation. Students were given access to well documented python programs which they could run (or 
manipulate and then run) and examine predictions from theoretical models with their own experimental data. Our hypothesis was 
that provided with the opportunity to collect data on a fairly well defined enzyme substrate system along with access to an 
easy to use computer simulation tool, students will develop a deep and an abiding interest in enzymes and how they work.  
Through the use of computer simulation tools, students can develop an appreciation of the impact that specific assumptions of 
the Michaelis Menten form have on the interpretation of the results. By analysing their own experimental data with the 
Michaelis Menten model, they develop an appreciation of how difficult it could be to arrive at meaningful conclusions from 
even the simplest experimental systems.

\section*{The Enzyme Mechanism, as normally presented}
\addcontentsline{toc}{section}{Enzyme Mechanism}
The mechanism~\index{Enzyme Mechanism}~proposed for the conversion of a substrate $S$
to a product, $P$ is shown in ~\ref{conventional}.  

\begin{equation}
\ce{E + S <=>T[\cf{k_1}][\cf{k_{-1}}] E--S ->T[\cf{k_{2}}] E + P }
\label{conventional}
\end{equation}

The substrate is postulated to bind
to the enzyme (E) forming an enzyme 
substrate complex (E--S) which then breaks up into the original enzyme
and the product (P)

A widely accepted approach to arrive at a {\em rate equation} from the
mechanism shown as ~\ref{conventional}
uses either what is called a quasi steady state approximation (QSSA) or 
an equilibrium assumption (EA).  In the QSSA, the assumption is made that 
the enzyme substrate complex concentration does not change appreciably
with time (thatis $\frac{d[ES]}{dt} ~\approx 0.0$)  In the
EA, the assumption is that the binding of the enzyme to the free substrate 
happens rapidly and an equilibrium is established 
with the enzyme substrate complex (that is $\frac{[E][S]}{[ES]} = K_{eq}$)
Details
of these approximations and derivations
can be found for example in books on bioprocess
engineering~\cite{Shuler2006Bioprocess}
The final form of the rate 
equation is called the Michaelis Menten enzymatic rate equation 
and is shown as equation~\ref{michaelismentenrate}

\begin{equation}
\mbox{rate} = V = \frac{dP}{dt} = -\frac{dS}{dt} = \frac{V_m[S]}{[S] + K_m}
\label{michaelismentenrate}
\end{equation}

where $V_m = k_2 E_0$, $K_m = \frac{k_{-1} + k_2}{k_1}$ (for QSSA) 
and $K_m = \frac{k_{-1}}{k_1}$ (for EA).  
$E_0$ is the initial concentration of the enzyme and $S$ the concentration
of the substrate (which is a function of time).  

Typical enzyme kinetics experiments are designed to use 
the equation~\ref{michaelismentenrate} to calculate the
$V_m$ and $K_m$.  This is done by 
using what is called the
Lineweaver Burke Plot (also called the double reciprocal plot)

\begin{equation}
\frac{1}{\mbox{rate}} = \frac{1}{V} = \frac{1}{\frac{dP}{dt}} = \frac{K_m}{V_m}\frac{1}{S} + \frac{1}{V_m}
\label{lwbequation}
\end{equation}

We can see from equation~\ref{lwbequation} ~\index{LineWeaver Burke Equation}
that a plot of the reciprocal of the
rate with the reciprocal of the substrate concentration, the slope will be
$\frac{K_m}{V_m}$ and the intercept will be
$\frac{1}{V_m}$ - allowing you to calculate $V_m$ and $K_m$.  

The {\em rate} of the reaction is as we have seen a {\em derivative} (slope)
and is $-\frac{dS}{dt}$ (change of substrate concentration with time) or 
$\frac{dP}{dt}$ (change of product with time). 
In the para nitrophenol phosphate (PNPP) to 
para nitrophenol phosphate (PNP) system catalyzed by alkaline
phosphatase, there is a 
one to one stoichiometric relationship between the substrate (PNPP, colorless)
and the product (PNP, yellow in color) and so 
$-\frac{dS}{dt} = \frac{dP}{dt}$.

The substrate concentration at any time $t$ is simply
$S = S0 - P$ where $S0$ is the initial
concentration of the substrate and $P$ the product concentration.
Typically, absorbance values are collected as a function of time (at a wavelength of 
405 nm, where
the product, $P$ (PNP), absorbs) and converted to concentration using the
known value of the extinction coefficient of PNP.
Thus, the data collected in the laboratory is typically $P$ versus time ($t$) 
and so calculation of the {\em rate} requires that a 
{\em derivative} be calculated from the data.  Calculating {\em derivatives} can be
tricky and subject to noise - so one strategy used is to 
calculate the {\em initial} rate (or the derivative at time zero when the
substrate is at the initial substrate concentration) and that is
far easy to determine.
And thus, a plot of the reciprocal of the initial rate versus the 
reciprocal of the initial substrate concentration can be used to
calculate the $V_m$ and $K_m$ (as shown in equation~\ref{lwbequation}).

\subsection*{Calculating $K_m$ and $V_m$: Using the Integrated Rate Equation}
\label{one}
%\addtocSS{Integrated Rate Equation}
Using initial rates is typically used to calculate the $K_m$ and
$V_m$ - but the fact is that 
you can calculate the $K_m$ and $V_m$ directly - from a single experiment, if you choose
from an integrated form of the MM equation.
The Michaelis Menten rate equation~\ref{michaelismentenrate} can be integrated to derive a
relationship between substrate (or product) concentration and time. 
The equation ~\ref{michaelismentenrate} can be rearranged (and integrated) 

\begin{equation}
-\int_{S0}^{S}\left[\frac{[S]+K_m}{V_m[S]}\right] dS = \int_{0.0}^{t} dt
\label{mmintegrated}
\end{equation}

and 
integrated from initial time $t=0$ when $S = S0$ to time $t$ 
when substrate concentration is $S$
The integrated form of the Michaelis Menten rate equation is 

\begin{equation}
\frac{S - S0}{V_m} + \frac{K_m}{V_m}\mbox{ln}\left(\frac{S}{S0}\right) = - t
\label{mmintegrated1}
\end{equation}

and changing signs, we get 

\begin{equation}
\frac{S0 - S}{V_m} + \frac{K_m}{V_m}\mbox{ln}\left(\frac{S0}{S}\right) = t
\label{integratedform1}
\end{equation}

The integrated form, equation~\ref{integratedform1}~can be used to calculate the $S$ at any time $t$ given the
initial substrate concentration (knowing $V_m$ and $K_m$)
OR to calculate the time given the 
substrate concentration at any time and its initial concentration.

So if we had experimental data on 
$S$ verus $t$, we can calculate the {\em best fit} values
for $K_m$ and $V_m$. 
Instead of expressing $t$ as a function of $S$ (substrate concentration) we can convert
it in terms of $P$ (product) (because we know that there is a 1:1 stoichiometric relationship
between the substrate and product (as shown in equation~\ref{conventional}). 

We rearrange equation~\ref{integratedform1} by noting that 
$S0 - S = P$ and so $S = S0 - P$, we get

\begin{equation}
\frac{P}{V_m} + \frac{K_m}{V_m}\mbox{ln}\left(\frac{S0}{S0 - P}\right) = t
\label{mmintegrated}
\end{equation}
~\index{Integrated Form}

Experimental data that has $P$ versus time ($t$) can also be used to determine the
best values of $K_m$ and $V_m$ (without having to do the experiments at different
starting substrate concentrations, to get the initial rates).
The reasoning for this is as follows.
The initial substrate concentration is assumed to be known for each data set (what the
experimenters prepare and begin with).
The product concentration ($P$) is calculated from the
absorbance values using a known value of the extinction coefficient,
reported as 18,800.0 for the para nitrophenol.  Since we do not know the
precise value of this extinction coefficient or the actual, precise
initial substrate concentration (allowing for this
uncertainty) in the analysis of the data sets
using the integral forms as in ~\ref{integratedform1} 
we can if we choose to, allow the $S0$ to vary
and obtain values of $V_m$ and $K_m$ (or fix $S0$ and then do the
calculations) - that is, we can {\em fit} the experimental data set
allowing for the $S0$ to vary.  

\section*{Approach, codes}
%\addtocS{Approach and Codes}
We have attempted to be fairly exhaustive in our analytical approach.
A set of data was collected at several initial substrate and
enzyme concentrations.  $K_m$ and $V_m$ were calculated using both
initial rates (and using Lineweaver Burke reciprocal plots), the 
integrated form of the Michaelis Menten equation and fitting of the 
rate constants to the set of differential equations that can be used
to describe the system.

\subsection*{Lineweaver Burke Plots}

We saw how using the equation~\ref{lwbequation}, a plot of the reciprocal of 
the initial rate of reaction with the reciprocal of the initial substrate
concentration can be used to calculate the $K_m$ and the $V_m$.  We also noted that 
given the simple stoichiometry, the rate of reaction can be computed from the 
rate of appearance of the product.

The procedure is as follows:
\begin{enumerate}
\item Collect data on concentration of product as a function of time.
\item Calculate the initial rate of reaction - this is the rate of reaction at time points
close to zero - or close to when the substrate concentration is what was used initially.
Students normally examine the data visually after plotting the data on graph paper
(or on a computer).  The initial slope is then obtained from the plot.
\end{enumerate}

\subsection*{Getting the initial rate}
A key question is - how do we calculate the initial rate of reaction?
Data is collected as absorbance versus time (which can be converted to concentration using the
extinction coefficient) - but typically, the initial rate is calculated by drawing a 
tangent to the concentration versus time curve at time zero.  Typically, this is done by
plotting the data on a graph paper and making a good guess of where the tangent it.

What if a computer program has to calculate the slope?  There are many ways to do this - 
we have implemented two distinct methods (and compared them)

\begin{description}
\item[Initial Rate from initial data points] We can calculate the initial slope (rate) by
including the first three or four pairs of points - using linear regression calculating the
slope, intercept and an r squared value (which tells us how good the fit is)
\item[Polynomial fit] Fit the entire concentration versus time curve to a polynomial (say order
3) - calculate the derivative of the fitted polynomial and calculate the value of the derivative
at the starting point.
\end{description}

\section*{A make file}
%\addtocS{Make File}
A make file is where you set the rules for creating the final document.
The make file can include different programs, files and the rules for running them.
Here, we start with a file that contains the documentation (in ~\LaTeX~), code in
python and use of a program called python~\TeX~which allows you to embed
python with a ~\LaTeX~document.  The make file is called
sek.make 

\begin{comment}
<<sek.make>>=
# make all will make the pdf
all: study-enzyme-kinetics.pdf 

# study-enzyme-kinetics.tex is extracted using noweb from 
# study-enzyme-kinetics.w which has the documentation and codes
study-enzyme-kinetics.tex: study-enzyme-kinetics.w
	noweb study-enzyme-kinetics.w

# you can fit the integrated form of the Michaelis Menten equation 
# to Product versus time data 
# product concentration is simply the difference between 
# initial substrate and the substrate as a function of time
# because we have a 1 to 1 relationship between 
# substrate and product (for this case)

directfitresults.pdf: directfitSfixed.py
	python directfitSfixed.py

# using initial rate data calculate line weaver burke plot
lvbplot.png: initialrates.py
	python initialrates.py

diffeqresults.pdf: diffeqmodel.py
	python diffeqmodel.py

study-enzyme-kinetics.pdf: study-enzyme-kinetics.tex directfitresults.pdf \
	diffeqresults.pdf lvbplot.png
	pdflatex -shell-escape study-enzyme-kinetics.tex
	bibtex study-enzyme-kinetics
	pythontex --interpreter python:python study-enzyme-kinetics.tex
	pdflatex -shell-escape study-enzyme-kinetics.tex
	pdflatex -shell-escape study-enzyme-kinetics.tex
	pdflatex -shell-escape study-enzyme-kinetics.tex 
clean:
	rm -r -f *.aux *.toc sek.make study-enzyme-kinetics.pdf \
	study-enzyme-kinetics.make study-enzyme-kinetics.bbl \
	study-enzyme-kinetics.blg study-enzyme-kinetics.out \
	study-enzyme-kinetics.log study-enzyme-kinetics.tex _minted*
	rm -r -f pythontex-files-study-enzyme-kinetics
	rm -f study-enzyme-kinetics.pytxcode

@

\end{comment}
\section{Code Development}
%\addtocS{Code development}
The approach we have taken is to write the code in chunks 
and assemble the required chunks into a script that does what you want.

\subsection{Required Libraries}
%\addtocSS{Required python libraries}
A collection of python libraries that many of the scripts will need and is assembled in
a file we call requiredlibraries.  This is a chunk that can be used several times to 
assemble a working program as you can see in the document.  An advantage of this approach is that
once you have a chunk, you can use/reuse it - change it if you need to once and the changes will
show up in every instance the chunk is used.


\begin{comment}

<<requiredlibraries>>=
import numpy as np
from numpy import *
import matplotlib.pyplot as plt
import scipy
from scipy import *
import numpy
from numpy import *
from scipy.integrate import odeint
from scipy import integrate
from scipy.optimize import fmin
from scipy.optimize import leastsq
from scipy.optimize import curve_fit
#from scipy import stats, polyval, polyfit  
from scipy import stats
from numpy import polyval, polyfit
from matplotlib import rc
rc('font',**{'family':'serif','serif':['Palatino']})
rc('text', usetex=True)

import os.path

@

\end{comment}


\subsection{Reading blank lines}
%\addtocSS{Reading blank lines}
often we do not know how many lines a particular data file will have - the chunk
we call readnonblanklines 
reada a file line by line till it reaches a blank or the end

\begin{comment}
<<readnonblanklines>>=
def nonblank_lines(f):
    for l in f:
        line = l.rstrip()
        if line:
            yield line

@

\end{comment}

\subsection{Convert absorbance to concentration}
%\addtocSS{Convert absorbance to concentration}
Experimental data is collected as absorbance at 405 nm in a spectrometer. 
This absorbance is converted to a concentration using an extinction coefficient,
this chunk is called absorbance2concentration

\begin{comment}

<<absorbance2concentration>>=
def abs2conc(infile):
    inf = open(infile,'r')
    t = []
    a = []
    nl = 0
    for line in nonblank_lines(inf):
        nl = nl + 1 
        thisline = line.split();
        t.append(float(thisline[0]))
        a.append(float(thisline[1])/18800.0)
    return t, a

@

\end{comment}

\subsection{Correlation Coefficient}
%\addtocSS{Correlation coefficient}
When we fit data to a model (linear or polynomial or exponential) we would like
to know how good the fit is - that is what is the r squared value (as it is called)
between the experimental value and that fitted by the model - this chunk is called
corrcoeff

\begin{comment}
<<corrcoeff>>=
def corrcoeff(y1,y2):
    import numpy as np
    import math
    ym1 = np.mean(y1)
    ym2 = np.mean(y2)
    sumy1y2 = 0.0
    sumy1 = 0.0
    sumy2 = 0.0
    sumy1sq = 0.0
    sumy2sq = 0.0

    for i in range(len(y1)):
        sumy1 = sumy1 + y1[i]
        sumy2 = sumy2 + y2[i]
        sumy1y2 = sumy1y2 + y1[i]*y2[i]
        sumy1sq = sumy1sq + y1[i]*y1[i]
        sumy2sq = sumy2sq + y2[i]*y2[i]
    fly1 = float(len(y1))
    num = fly1*sumy1y2 - sumy1*sumy2
    denom1 = fly1*sumy1sq - sumy1*sumy2
    denom2 = fly1*sumy2sq - sumy2*sumy2
#    print (num, denom1, denom2)
    r = num/(math.sqrt(denom1*denom2))
    return r    

@

\end{comment}

\subsection{Polynomial Fit}
%\addtocSS{polynomial fit}

You need to specify the order of the polynomial, we have used 3, it seems to work well 
this chunk is called fitpolynomial 

\begin{comment}

<<fitpolynomial>>=
def fitpolynomial(x,y,n):
    import numpy as np
    z = np.polyfit(x,y,n)
    pfit = np.poly1d(z)
    rsq = corrcoeff(y,pfit(x))
    yfit = pfit(x)
    return yfit, rsq
@

\end{comment}

\subsection{First derivative of polynomial}
%\addtocSS{First derivative of polynomial}
This chunk called fitpolyderiv1 fits a polynomial to the data and
calculates the first derivative which can be used to calculate the
first derivative at any point on the X axis

\begin{comment}

<<fitpolyderiv1>>=
     
def fitpolyderiv1(x,y,n):
    import numpy as np
    z = np.polyfit(x,y,n)
    pfit = np.poly1d(z)
    fderiv = pfit.deriv()(x)
    max_value = max(fderiv)
    max_index = np.argmax(fderiv) 
    return fderiv, x[max_index]

@

\end{comment}

\subsection{Read data file}
%\addtocSS{read data file}

The chunk called readdata reads a data file (X and Y),
subtracts the first point on the Y axis (so effectively makes it look
like the data starts at zero (this may or may not be a good idea, so something
to look at carefully)

\begin{comment}
<<readdata>>=
def readdata(datafile,extinction):
    X = []
    Y1 = []
    Y = []
    myfile = open(datafile,'r')
    for line in nonblank_lines(myfile):
        X.append(float(line.split()[0]))
        Y1.append(float(line.split()[1]))
    for i in range(len(Y1)):
        Y.append((Y1[i] - Y1[0])/extinction)
    return X, Y

@

\end{comment}

\subsection{Read Data file X}
%\addtocSS{readdataX}
Minor change - do not subtract the first Y value from later values, use data as is

\begin{comment}
<<readdataX>>=
def readdataX(datafile,extinction):
    X = []
    Y1 = []
    Y = []
    myfile = open(datafile,'r')
    for line in nonblank_lines(myfile):
        X.append(float(line.split()[0]))
        Y1.append(float(line.split()[1]))
    for i in range(len(Y1)):
        Y.append((Y1[i])/extinction)
    return X, Y

@

\end{comment}


\section{Experimental Data set}
%\addtocS{Experimental Data set}
Consider a data set that 
had 24 experiments - four different starting enzyme
concentrations and six different starting substrate concentrations.  The concentrations
and the names of the files are given in the table~\ref{tab:dataset}

%\begin{fullwidth}
\begin{table*}
%\resizebox{\textwidth}{!}{
\makebox[\textwidth]{
\begin{tabular}{|c|c|c|c|c|c|c|}
\cline{1-7}
Enzyme Concentration & \multicolumn{6}{ c| }{Substrate Concentration} \\ 
(moles/liter) & \multicolumn{6}{ c| }{moles/liter} \\ \cline{2-7}
 & 0.0003 & 0.00015 & 0.000075 & 0.00003 & 0.000015 & 0.0000075 \\ \cline{1-7}
15.36 x 10$^{-9}$ & zs1e1.dat & zs2e1.dat & zs3e1.dat & zs4e1.dat & zs5e1.dat & zs6e1.dat \\ \cline{1-7}
7.68 x 10$^{-9}$ & zs1e2.dat & zs2e2.dat & zs3e2.dat & zs4e2.dat & zs5e2.dat & zs6e2.dat \\ \cline{1-7}
3.84 x 10$^{-9}$ & zs1e3.dat & zs2e3.dat & zs3e3.dat & zs4e3.dat & zs5e3.dat & zs6e3.dat \\ \cline{1-7}
1.92 x 10$^{-9}$ & zs1e3.dat & zs2e4.dat & zs3e4.dat & zs4e4.dat & zs5e4.dat & zs6e4.dat \\ \cline{1-7}
\hline
\end{tabular}
%\caption{Data sets at different starting enzyme and substrate concentrations}
}
\caption{Data sets at different starting enzyme and substrate concentrations}
\label{tab:dataset}
%\setfloatalignment{b}
\end{table*}


%\end{fullwidth}

\section{Code to calculate and use initial rates from data}

<<initialrates.py>>=
<<requiredlibraries>>
<<corrcoeff>>
<<fitpolynomial>>
<<fitpolyderiv1>>
<<readnonblanklines>>
<<readdata>>
<<readlistoffilenames>>
<<readlistfromfile>>
<<linreg>>
<<lwb>>
<<doinitialratecalcs>>

@

\subsection{Read list of file names}
%\addtocSS{Read list of file names}

The chunk names readlistoffilenames takes a list of file names,
reads in the filenames and the substrate concentration for that file

\begin{comment}
<<readlistoffilenames>>=

def readlistoffilenames(listoffiles):
    filenames = []
    S = []
    myfile = open(listoffiles,'r')
    for line in nonblank_lines(myfile):
        filenames.append(str(line.split()[0]))
        S.append(float(line.split()[1]))
    return filenames, S    

@

\end{comment}

\subsection{Read list from file}
%\addtocSS{read list from file}

The chunk readlistfromfile reads in a file and reads the file names,
substrate and enzyme concentration for that file 

\begin{comment}

<<readlistfromfile>>=

def readlistfromfile(listoffiles):
    filenames = []
    myS = []
    myE = []
    myfile = open(listoffiles,'r')
    for line in nonblank_lines(myfile):
        filenames.append(str(line.split()[0]))
        myS.append(float(line.split()[1]))
        myE.append(float(line.split()[2]))
    return filenames,myS,myE

@

\end{comment}

\subsection{Linear Regression}
%\addtocSS{Linear Regression}

The chunk named linreg does linear regression and returns the slope, intercept
and the r squared value 

\begin{comment}

<<linreg>>=
def linreg(X,Y):
    import numpy as np
    from scipy import stats
    slope, intcp, rsq, p_value, std_err = stats.linregress(X[0:3],Y[0:3])
    return slope, intcp, rsq

@

\end{comment}

\subsection{Lineweaver Burke Calculations}
%\addtocSS{Lineweaver Burke}

The chunk named lwb takes in a list of files, reads in values of the
substrate and enzyme and depending on the method specified, calculates the
initial rate of reaction.  If the method is polynomialfit, it fits the data
to a third order polynomial and calculates the first derivative at the first
value of X.  If the method is linearregression, it calculates the
linear regression using specified number of pairs (which can be specified in how the
routine is called)

\begin{comment}
<<lwb>>=
def lwb(listoffiles,extinction,method):
    import numpy as np
    myfiles, myS, myE = readlistfromfile(listoffiles)
    lwbx = []
    lwby = []
    for i in range(len(myfiles)):
        thisfile = myfiles[i]
        sconc = myS[i]
        X = readdata(thisfile,extinction)[0]
        Y = readdata(thisfile,extinction)[1]

        if (method == 'linearregression'):
            slope, intcp, rsq = linreg(X,Y)
        if (method == 'polynomialfit'):
            yfit,rsq = fitpolynomial(X,Y,3)
            fderiv, junk = fitpolyderiv1(X,Y,3)
            slope = fderiv[0]
        lwbx.append(1.0/sconc)
        lwby.append(1.0/slope)
        
    lwbpolycoeffs = numpy.polyfit(lwbx,lwby,1) 
    lwbyfit = numpy.polyval(lwbpolycoeffs,lwbx)  
    slope, intercept, r, p, err = stats.linregress(lwbx,lwby)
    Vm = 1.0/intercept 
    Km = slope/intercept
    k2 = Vm/myE
 
    plt.xlabel('Reciprocal of Substrate Concentration')
    plt.ylabel('Reciprocal of Initial Rate of Reaction')
    plt.title('Lineweaver Burke Plot and Linear Fit')
    plt.grid()
    label1 = 'Vm = '+str(Vm)
    plt.plot(lwbx,lwby,label=label1)
    label2 = 'Km = '+str(Km)
    plt.plot(lwbx,lwbyfit,linestyle='dashed',label=label2)
    if (method == 'linearregression'):
        prefix = 'LR'
    if (method == 'polynomialfit'):
        prefix = 'PN'
    outfilename = prefix+'lwbplot'+str(listoffiles)+'.png'
    thetitle = str(method) + ' ' + str(listoffiles) + 'at E0 = ' + str(myE[0])
    plt.title(thetitle)
    nl = len(lwbx)
    xspan = lwbx[nl-1] - lwbx[0]
    yspan = lwby[nl-1] - lwby[0]
    xloc1 = min(lwbx) + xspan*0.2
    xloc2 = min(lwbx) + xspan*0.2
    yloc1 = min(lwby) + yspan*0.9
    yloc2 = min(lwby) + yspan*0.7
#    plt.legend(loc='best')
    plt.text(xloc1,yloc1,label1)
    plt.text(xloc2,yloc2,label2)
    plt.savefig(outfilename)
    plt.clf()
    fname = 'resultsfile'
    rfile = open(fname, 'a+')
    rfile.write(listoffiles)
    rfile.write('\n')
    rfile.write(method)
    rfile.write('\n')
    rfile.write('Vm = ' + str(Vm) + '\n')
    rfile.write('Km = ' + str(Km) + '\n')
    rfile.write('k2 = ' + str(k2) + '\n')
    rfile.close()
    
    return Vm, Km, k2, myE

@

\end{comment}

\subsection{Setup and Do Initial Rate Calculations}
%\addtocSS{Setup and Do Initial Rate}

This chunk named doinitialratecalcs sets up the data files to be used,
the code to read them, do the calculations and create the outputs which are
an xlsx and a pdf file with the results.  
The Km, Vm and k2 from each data set (one set consists of a set of data files where
the substrate concentration varies at a given enzyme concentration)

\begin{comment}
<<doinitialratecalcs>>=

VmP = []
KmP = []
k2P = []
E0P = []

zfiles = ['zconcentration1.dat','zconcentration2.dat','zconcentration3.dat','zconcentration4.dat']

extinction = 18800.0

from openpyxl import Workbook
outwb = Workbook()
outsheet = outwb.create_sheet(title='LineWeaver Burke PolynomialFit')
outsheet.cell(row=1,column=1).value = 'Filename'
outsheet.cell(row=1,column=2).value = 'Km'
outsheet.cell(row=1,column=3).value = 'Vm'
outsheet.cell(row=1,column=4).value = 'E0'
outsheet.cell(row=1,column=5).value = 'k2'

ns = 2

for i in range(len(zfiles)):
    thisfile = zfiles[i]
    Vm,Km,k2, myE = lwb(thisfile,extinction,'polynomialfit')  
    outsheet.cell(row=ns,column=1).value = str(thisfile)
    outsheet.cell(row=ns,column=2).value = str(Km)
    outsheet.cell(row=ns,column=3).value = str(Vm)
    outsheet.cell(row=ns,column=4).value = str(myE[0])
    outsheet.cell(row=ns,column=5).value = str(k2[0])
    ns = ns + 1
    VmP.append(Vm)
    KmP.append(Km)
    E0P.append(myE)
    k2P.append(k2)

std = outwb['Sheet']
outwb.remove(std)
outwb.save('initialratespolynomial.xlsx')

xlsxfile = 'initialratespolynomial.xlsx'
import pandas as pd
import pdfkit
df = pd.read_excel(xlsxfile)
df.to_html("junk.html")
pdfkit.from_file("junk.html", "initialratespolynomial.pdf")



VmL = []
KmL = []
k2L = []
E0L = []

outwbL = Workbook()
outsheetL = outwbL.create_sheet(title='LineWeaver Burke LinearRegression')
outsheetL.cell(row=1,column=1).value = 'Filename'
outsheetL.cell(row=1,column=2).value = 'Km'
outsheetL.cell(row=1,column=3).value = 'Vm'
outsheetL.cell(row=1,column=4).value = 'E0'
outsheetL.cell(row=1,column=5).value = 'k2'

ns = 2

for i in range(len(zfiles)):
    thisfile = zfiles[i]
    Vm,Km,k2, myE = lwb(thisfile,extinction,'linearregression')  
    VmL.append(Vm)
    KmL.append(Km)
    E0L.append(myE)
    k2L.append(k2)
    outsheetL.cell(row=ns,column=1).value = str(thisfile)
    outsheetL.cell(row=ns,column=2).value = str(Km)
    outsheetL.cell(row=ns,column=3).value = str(Vm)
    outsheetL.cell(row=ns,column=4).value = str(myE[0])
    outsheetL.cell(row=ns,column=5).value = str(k2[0])
    ns = ns + 1

std = outwbL['Sheet']
outwbL.remove(std)
outwbL.save('initialrateslinearreg.xlsx')

xlsxfile = 'initialrateslinearreg.xlsx'
import pandas as pd
import pdfkit
df = pd.read_excel(xlsxfile)
df.to_html("junk.html")
pdfkit.from_file("junk.html", "initialrateslinearreg.pdf")


@

\end{comment}

\lstinputlisting[language=Python]{initialrates.py}
\addtocS{initial rates listing}


\begin{pycode}
from initialrates import *
\end{pycode}


%\includepdf[pages=-,pagecommand={},width=\textwidth]{initialrateslinearreg.pdf}
%\includepdf[pages=-,pagecommand={},width=\textwidth]{initialratespolynomial.pdf}

\begin{figure}
\makebox[\textwidth]{
\includegraphics[scale=0.75]{initialrateslinearreg.pdf}
}
\caption{Km, Vm from Initial Rates, using linear regression}
\end{figure}

\begin{figure}
\makebox[\textwidth]{
\includegraphics[scale=0.75]{initialratespolynomial.pdf}
}
\caption{Km, Vm from Initial Rates, using polynomial fit}
\end{figure}


\begin{table*}[!htp]
\makebox[\textwidth]{
\begin{tabular}{|c|c|c|c|}
\hline
$V_m$ & $k_2$ & $E_0$ & $K_m$ \\
\hline
\py{VmP[0]}& \py{k2P[0][0]} & \py{E0P[0][0]} & \py{KmP[0]} \\
\py{VmP[1]}& \py{k2P[1][0]} & \py{E0P[1][0]} & \py{KmP[1]} \\
\py{VmP[2]}& \py{k2P[2][0]} & \py{E0P[2][0]} & \py{KmP[2]} \\
\py{VmP[3]}& \py{k2P[3][0]} & \py{E0P[3][0]} & \py{KmP[3]} \\
\hline
\end{tabular}
}
\caption{\label{tab:initpolynomial}Initial Rate Calculations using polynomial fit}
\end{table*}


\begin{table*}[!htp]
\makebox[\textwidth]{
\begin{tabular}{|c|c|c|c|}
\hline
$V_m$ & $k_2$ & $E_0$ & $K_m$ \\
\hline
\py{VmL[0]}& \py{k2L[0][0]} & \py{E0L[0][0]} & \py{KmL[0]} \\
\py{VmL[1]}& \py{k2L[1][0]} & \py{E0L[1][0]} & \py{KmL[1]} \\
\py{VmL[2]}& \py{k2L[2][0]} & \py{E0L[2][0]} & \py{KmL[2]} \\
\py{VmL[3]}& \py{k2L[3][0]} & \py{E0L[3][0]} & \py{KmL[3]} \\
\hline
\end{tabular}
}
\caption{\label{tab:initpolynomial}Initial Rate Calculations using Linear fit}
\end{table*}



\section{Allowing $V_m$ and $K_m$ to vary, keeping $S0$ fixed}
%\addtocS{Direct fitting, keep initial substrate concentration fixed}

\subsection{Integrated Form}
%\addtocSS{Integrated Form}
The integrated form of the Michaelis Menten equation written with 
time as the independent variable and the product concentration as the
dependent variable.  This can be used to fit the data.

\begin{comment}

<<sintegrated>>=
def sintegrated(y,Km, Vm, S0):
    return (Km/Vm)*np.log(S0/(S0 - np.array(y))) + np.array(y)/Vm

@

\end{comment}

\subsection{Direct Fitting}
%\addtocSS{Direct fitting}
The integrated form of the Michaelis Menten equation is used to fit the data 
using a levemberg marquardt least squares fit.

\begin{comment}

<<directfit>>=
from lmfit import Model

# https://www.mandeepbasson.com/resources/python/curvefitting/curve_fitting/
def directfit(listoffiles,extinction,ns):
    ofile = open('finalresults','a+')
    import numpy as np
    myfiles, myS, myE = readlistfromfile(listoffiles)
    lwbx = []
    lwby = []
    for i in range(len(myfiles)):
        thisfile = myfiles[i]
        sconc = myS[i]
        X = readdataX(thisfile,extinction)[0]
        Y = readdataX(thisfile,extinction)[1]
        mymodel = Model(sintegrated,min_correl=0.98)

        params = mymodel.make_params(Km=4.0*10**(-6),Vm=5.0*10**(-7),S0=sconc)
        mymodel.set_param_hint('Km', min = 0, max=10**(-5), vary=True)
        mymodel.set_param_hint('Vm', min = 0, max=10**(-6), vary=True)
#        print (thisfile,sconc,myE[0])



        params['S0'].vary = False
        params['Km'].min = 1.0*10**(-8)
        params['Km'].max = 5.0*10.0**(-3)
        params['Vm'].min = 1.0*10**(-8)
        params['Vm'].max = 5.0*10**(-3)
        result = mymodel.fit(X, params, y=Y)
#        print (result.fit_report())
#        print ("Km and Vm ")
        Km = result.params['Km'].value
        Vm = result.params['Vm'].value
        k2 = Vm/myE[0]
        S0 = myS[i]
        myX = []
        for j in range(len(Y)):
            myX.append( (Km/Vm)*np.log(S0/(S0 - Y[j])) + Y[j]/Vm )
            
        thelabel=' S0 = '+str("{:.3e}".format(myS[i])) + ' E0 = '+str("{:.3e}".format(myE[i]))
        plt.plot(X,Y,label=thelabel)
        plt.plot(myX, Y, label='Fitted')
        rsq = corrcoeff(X,myX)
        thetitle = str(thisfile) + 'Km = '+str("{:.4e}".format(Km))+ ' Vm = ' + str("{:.4e}".format(Vm))+ 'rsq = '+str("{:.4e}".format(rsq))       
        
        plt.title(thetitle,fontsize=10)
        plt.legend(loc='best')
        plt.xlabel('Time in Seconds')
        plt.ylabel('Concentration moles/liter')
        
        outfilename = 'directfit'+thisfile+'.png'
        plt.savefig(outfilename)
        plt.clf()
        
        directfitting[thisfile] = [Km,Vm]
        outsheet.cell(row=ns,column=1).value = thisfile
        outsheet.cell(row=ns,column=2).value = Km
        outsheet.cell(row=ns,column=3).value = Vm
        outsheet.cell(row=ns,column=4).value = k2
        ns = ns + 1
        ofile.write(str(thisfile)+' '+str(Km)+' '+str(Vm)+'\n')

@

\end{comment}

\subsection{Setup directfit}
%\addtocSS{setup direct fit}
Setting up the direct fit scripts

\begin{comment}

<<setupdirectfit>>=
directfitting = {}

from openpyxl import Workbook
from openpyxl import load_workbook
outwb = Workbook()
outsheet = outwb.create_sheet(title='Results')
outsheet.cell(row=1,column=1).value = 'Filename'
outsheet.cell(row=1,column=2).value = 'Km'
outsheet.cell(row=1,column=3).value = 'Vm'
outsheet.cell(row=1,column=4).value = 'k2'

zfiles = ['zconcentration1.dat','zconcentration2.dat','zconcentration3.dat','zconcentration4.dat']
extinction = 18800.0

ns = 2

for i in range(len(zfiles)):
    thisfile = zfiles[i]
    directfit(thisfile,extinction,ns)  
    ns = ns + len(zfiles)

std = outwb['Sheet']
outwb.remove(std)
outwb.save('directfitresults.xlsx')

xlsxfile = 'directfitresults.xlsx'
import pandas as pd
import pdfkit
df = pd.read_excel(xlsxfile)
df.to_html("junk.html")
pdfkit.from_file("junk.html", "directfitresults.pdf")

@

\end{comment}

<<directfitSfixed.py>>=
<<requiredlibraries>>
<<readnonblanklines>>
<<readdata>>
<<readdataX>>
<<readlistfromfile>>
<<sintegrated>>
<<corrcoeff>>
<<sintegrated>> 
<<directfit>>
<<setupdirectfit>>

@

\begin{pycode}
from directfitSfixed import *
\end{pycode}

%\includepdf[pages=-,pagecommand={},width=\textwidth]{directfitresults.pdf}

\section{Results from Direcfitting}

\begin{figure}
\makebox[\textwidth]{
\includegraphics[scale=0.75]{directfitresults.pdf}
}
\caption{Km, Vm from fitting Integrated MM equation}
\end{figure}


%\py{directfitting}

\section{The Enzyme Mechanism, set of differential equations}
In a batch reactor, we can write expressions for the rate
of change for the different species involved in the enzymatic reactions
If we ignore the competitive binding
of phosphate to the enzyme, we get a set of differential equations shown in
~\ref{diffeqset} (we can also get this simpler set by 
setting $k_3$ and $k_{-3}$ to zero).  

\begin{center}
\begin{subequations}\label{diffeqset}
\label{diffeqs}
\begin{align}
\frac{d[S]}{dt} & = & -k_1[E][S] + k_{-1}[ES] \label{diffeqset:S} \\
\frac{d[E]}{dt} & = & -k_1[E][S] + k_{-1}[ES] + k_2[ES] \label{diffeqset:E} \\
\frac{d[ES]}{dt} & = & k_1[E][S]- k_{-1}[ES] - k_2[ES] \label{diffeqset:ES} \\
\frac{d[P]}{dt} & = & k_2[ES] \label{diffeqset:P} 
\end{align}
\end{subequations}
\end{center}

This system of differential equations shown as
~\ref{diffeqset} can be integrated if we know the rate constants
and initial values of the species.  The python code to do this is shown
as a function called {\em diffeqset} (and we will see how to use this
function later).  We can also do the reverse - use data on how the 
species changes with time and estimate the rate constants.

\section{Integrating the Differential Equations}

\subsection{Integration, forward}

\begin{comment}

<<diffeqset>>=

def diffeqset(parameters):

    k1, km1, k2, S0, E0, ES0, P0, start_time, end_time, intervals = parameters
    rateconstants = (k1, km1, k2)
    initial_cond = [S0, E0, ES0, P0]
# define the differential equation    
    def eq(par,initial_cond,start_t,end_t,incr):
#-time-grid-----------------------------------
      t  = np.linspace(start_t, end_t,incr)
#differential-eq-system----------------------
      def funct(y,t):
        S=y[0]
        E=y[1]
        ES=y[2]
        P=y[3]
        k1,km1,k2=par
        # the model equations (see Munz et al. 2009)
        f0 = -k1*E*S + km1*ES 
        f1 = -k1*E*S + km1*ES + k2*ES
        f2 = k1*E*S - km1*ES - k2*ES
        f3 = k2*ES
        return [f0, f1, f2, f3]
#integrate------------------------------------
      ds = integrate.odeint(funct,initial_cond,t)
      return (ds[:,0],ds[:,1],ds[:,2],ds[:,3],t)

# initial conditions for the calculations
    y0 = [S0, E0, ES0, P0]
# model steps
#---------------------------------------------------

# F0 = S, F1 =E, F2 = ES, F3 = P
    F0,F1,F2,F3,T=eq(rateconstants,y0,start_time,end_time,intervals)
# calculate Vm using the k2 and E0 
    Vm = k2*E0
# calculate the Km using k1, k2 and km1    
    Km = (km1 + k2)/k1
# you can calculate the equilibrium constant at all the time points    
    Keq = []
    for i in range(len(T)):
        Keq.append(F2[i]/(F0[i]*F1[i]))
    return F0, F1, F2, F3, T, Keq

@

\end{comment}

\subsection{Setting the variables}

\begin{comment}

<<setvariables>>=

# set the values for rate constants
k1 = 2.912e+09
km1 = 4.275e+05
k2 = 300.0
k3 = 1.835e+08
km3 = 600.0
# set initial conditions
S0 = 0.0003
E0 = 15.36e-09
ES0 = 0.0
P0 = 0.0
Vm = k2*E0
Km = (km1 + k2)/k1 
# set conditions for integration, time in seconds
start_time = 0.0
end_time = 160.0
intervals = 1000

parameters1 = (k1, km1, k2, S0, E0, ES0, P0, start_time, end_time, intervals)

@

\end{comment}

\subsection{Fit the diffeq set}

\begin{comment}

<<fitdiffeqset>>=

def fitdiffeqset(infile, parameters):
    
    Td, Zd = abs2conc(infile)
    k1, km1, k2, S0, E0, ES0, P0, start_time, end_time, intervals = parameters
    rates = (k1, km1, k2)
# define the differential equation    
    def eq(par,initial_cond,start_t,end_t,incr):
#-time-grid-----------------------------------
        t  = np.linspace(start_t, end_t,incr)
#differential-eq-system----------------------
        def funct(y,t):
            S=y[0]
            E=y[1]
            ES=y[2]
            P=y[3]
            k1,km1,k2=par
        # the model equations f0 is dS/dt, f1 is dE/dt, f2 is dES/dt, F3 is dP/dt
            f0 = -k1*E*S + km1*ES 
            f1 = -k1*E*S + km1*ES + k2*ES
            f2 = k1*E*S - km1*ES - k2*ES
            f3 = k2*ES
            return [f0, f1, f2, f3]
#integrate - solution returned in order for S, E, ES and P 
        ds = integrate.odeint(funct,initial_cond,t)
        return (ds[:,0],ds[:,1],ds[:,2],ds[:,3],t)
# initial conditions for the calculations
    y0 = [S0, E0, ES0, P0]
# model steps
#---------------------------------------------------
    mt=np.linspace(start_time,end_time,intervals)
 
# model index to compare to data
#----------------------------------------------------
    findindex=lambda x:np.where(mt>=x)[0][0]
    mindex=list(map(findindex,Td))
#=======================================================
 
#Score Fit of System
#=========================================================
    def score(parms):
#a.Get Solution to system
     S, E, ES, P, T=eq(parms,y0,start_time,end_time,intervals)
#b.Pick of Model Points to Compare - Note we pick the product P
     Zm=P[mindex]
#c.Score Difference between model and data points
     ss=lambda data,model:((data-model)**2).sum()
     return ss(Zd,Zm)
#========================================================
 
 
#Optimize Fit
#=======================================================
    fit_score=score(rates)
    answ=fmin(score,(rates),full_output=1,maxiter=900000,maxfun=100000,xtol=0.001)


    bestrates=answ[0]
    bestscore=answ[1]
    nk1, nkm1, nk2 =answ[0]
    newrates=(nk1, nkm1, nk2)
#=======================================================
 
#Generate optimized Solution to System
#=======================================================
    S, E, ES, P, T=eq(newrates,y0,start_time,end_time,intervals)
    Zm=P[mindex]
    Tm=T[mindex]

    Vm = nk2*E0
    Km = (nkm1 + nk2)/nk1
    return T,P,Tm,Zm,nk1,nkm1,nk2 

@

\end{comment}

\subsection{Setting up the diffeq set}

\begin{comment}

<<setupdiffeqset>>=

from openpyxl import Workbook
from openpyxl import load_workbook
outwb = Workbook()
outsheet = outwb.create_sheet(title='Results')
outsheet.cell(row=1,column=1).value = 'Filename'
outsheet.cell(row=1,column=2).value = 'Km'
outsheet.cell(row=1,column=3).value = 'Vm'
outsheet.cell(row=1,column=4).value = 'k2'


extinction = 18800.0
ns = 2
zfiles = ['zconcentration1.dat','zconcentration2.dat','zconcentration3.dat','zconcentration4.dat']
#zfiles = ['zconcentration2.dat']
for i in range(len(zfiles)):
    from textwrap import wrap
    thislist = zfiles[i]
    myfiles, myS, myE = readlistfromfile(thislist)
    for j in range(len(myfiles)):
        thisfile = myfiles[j]
        ES0 = 0.0
        P0 = 0.0
        X = readdataX(thisfile,extinction)[0]
        Y = readdataX(thisfile,extinction)[1]
        start_time = X[0]
        end_time = X[-1]
        intervals = 100
        k1 = 2.912e+09
        km1 = 4.275e+05
        k2 = 30.0
#        fig = plt.figure()
#        ax = fig.add_subplot(111)
        parameters = (k1, km1, k2, myS[j], myE[j], ES0, P0, start_time, end_time, intervals)
        (Tf,Pf,Tmf,Zmf,nk1,nkm1,nk2) = fitdiffeqset(thisfile,parameters)
        thelabel='S0 = '+str("{:.3e}".format(myS[j]))+' E0 = '+str("{:.3e}".format(myE[j]))
        plt.plot(Tf,Pf,label=thelabel)
        parameters1 = (nk1, nkm1, nk2, myS[j], myE[j], ES0, P0, start_time, end_time, intervals)
        (mySf, myEf, myESf, myproductf, mytimef, myKeq) = diffeqset(parameters1)


        Vmig = k2*E0
        Kmig = (km1 + k2)/k1

        nVmi = nk2*myE[j]
        nKmi = (nkm1 + nk2)/nk1 
#        plt.plot(mytimef,myproductf,'ro',markevery=10,label='forward')
        plt.plot(X,Y,label=str(thisfile))
        plt.xlabel('Time in Seconds')
        plt.ylabel('Concentration moles/liter')
        plt.legend(loc='best')

#        title = ax.set_title("\n".join(wrap('Km = '+str("{:.4e}".format(nKmi))+ ' Vm = ' + str("{:.4e}".format(nVmi)) +'\n'+ 'Km = '+str("{:.4e}".format(nKmi))+ ' Vm = ' + str("{:.4e}".format(nVmi)),60)))

        thetitle = 'Km = '+str("{:.4e}".format(nKmi))+ ' Vm = ' + str("{:.4e}".format(nVmi)) +'\n'+ 'k1 = '+str("{:.4e}".format(nk1))+ ' km1 = ' + str("{:.4e}".format(nkm1)) + ' k2 = ' + str("{:.4e}".format(nk2))      
        
        plt.title(thetitle,wrap=True)
        plt.savefig('diffeqfit'+thisfile+'.png')
        plt.clf()
#        plt.show()
        outsheet.cell(row=ns,column=1).value = thisfile
        outsheet.cell(row=ns,column=2).value = nKmi
        outsheet.cell(row=ns,column=3).value = nVmi
        outsheet.cell(row=ns,column=4).value = nk2
        ns = ns + 1


        plt.clf()

std = outwb['Sheet']
outwb.remove(std)
outwb.save('diffeqresults.xlsx')

xlsxfile = 'diffeqresults.xlsx'
import pandas as pd
import pdfkit
df = pd.read_excel(xlsxfile)
df.to_html("junk.html")
pdfkit.from_file("junk.html", "diffeqresults.pdf")

@

\end{comment}

<<diffeqmodel.py>>=
<<requiredlibraries>>
<<readnonblanklines>>
<<absorbance2concentration>>
<<diffeqset>>
<<setvariables>>
<<fitdiffeqset>>
<<readdataX>>
<<readlistfromfile>>
<<setupdiffeqset>>

@


\begin{pycode}
from diffeqmodel import *
\end{pycode}

%\includepdf[pages=-,pagecommand={},width=\textwidth]{diffeqresults.pdf}

\begin{figure}
\includegraphics[scale=1.0]{diffeqresults.pdf}
\caption{Km, Vm from fitting differential equations}
\end{figure}


\section*{Creating a video file}

<<createmp4.py>>= 

def createmp4(prefix,fps):
    import cv2
    import numpy as np
    import glob
    img_array = []
    for filename in glob.glob(prefix+'*.png'):
        img = cv2.imread(filename)
        height, width, layers = img.shape
        size = (width,height)
        img_array.append(img)

    outname = prefix+'.mp4'
    out = cv2.VideoWriter(outname,cv2.VideoWriter_fourcc(*'MP4V'), fps, size)

    for i in range(len(img_array)):
        out.write(img_array[i])
    out.release()


createmp4('diffeq',0.5)
createmp4('directfit',0.5)

@

\section*{Video Files}
%\addtocS{Video Files}
I have not quite figured out how to embed an mp4 file in a pdf.
Instead of adding multiple figures (png files) I assembled them all into one
video file (yes, code for that is also part of this document)

\href{directfit.mp4}{Video of results from direct fitting of all data files}
\href{diffeq.mp4}{Video of results from differential equations fit to all data files}

\section{Conclusions, what we have learned}
%\addtocS{Conclusions}
Here are some of what we have learned through many years of working with
undergraduate students in chemical engineering.

\begin{enumerate}
\item Students were given stock solutions of both the substrate and the enzyme -
and were asked to design their own experiments.  They had to find out the
published values of Km, Vm and the rate at which they had to collect the data
(a data point every second?  every minute?)
\item Defining time zero when the product concentration was zero was not trivial - because
the substrate starts degrading into product without the enzyme at a small rate but
accelerates as soon as the enzyme is added - the first data point while indicating a time
zero, is clearly not time zero.  How can this be addressed?
\item Calculations - the absorbance is converted to concentration using the
extinction coefficient and students had to decide how to analyze the data.
Calculation of an initial rate was not trivial - we have provided a few additional
approaches for the calculations.
\end{enumerate}


%\newpage
%\includemovie{directfit.mp4}
%\newpage
%\includemovie{diffeq.mp4}
%\newpage

\section{Some data files}
\subsection{Data files used in these calculations} Sample files are here
%\addtocS{Data files}

\begin{comment}
<<zs1e1.dat>>=
0       0.008
20      0.124
40      0.255
60      0.372
80      0.475
100     0.57
120     0.655
140     0.742
160     0.835

@

<<zs1e2.dat>>=
0       0.007
20      0.065
40      0.124
60      0.182
80      0.242
100     0.304
120     0.365
140     0.424
160     0.476
180     0.526
200     0.58
220     0.636
240     0.691
260     0.745
280     0.796
300     0.845

@

<<zs1e3.dat>>=
0       0.007
20      0.038
60      0.099
80      0.13
100     0.159
120     0.192
140     0.222
160     0.25
180     0.278
200     0.308
220     0.338
240     0.365
260     0.392
280     0.42
300     0.45

@

<<zs1e4.dat>>=
0       0.007
20      0.02
40      0.033
60      0.048
80      0.065
100     0.082
120     0.099
140     0.118
160     0.136
180     0.151
200     0.167
220     0.179
240     0.189
260     0.203
280     0.219
300     0.238

@

<<zs2e1.dat>>=
0       0.004
20      0.123
40      0.241
60      0.35
80      0.451
100     0.552
120     0.64
140     0.734
160     0.825

@

<<zs2e2.dat>>=
0       0.004
20      0.069
40      0.131
60      0.19
80      0.247
100     0.301
120     0.385
140     0.418
160     0.476
180     0.53
200     0.582
220     0.631
240     0.678
260     0.723
280     0.792
300     0.815

@

<<zs2e3.dat>>=
0       0.003
20      0.032
40      0.045
60      0.09
80      0.122
100     0.153
120     0.185
140     0.212
160     0.24
180     0.27
200     0.302
220     0.334
240     0.366
260     0.396
280     0.426
300     0.454

@

<<zs2e4.dat>>=
0       0.003
20      0.021
40      0.037
60      0.052
80      0.067
100     0.081
120     0.098
140     0.115
160     0.131
180     0.147
200     0.163
220     0.179
240     0.195
260     0.211
280     0.227
300     0.244

@

<<zs3e1.dat>>=
0       0.001
20      0.12
40      0.232
60      0.327
80      0.414
100     0.492
120     0.563
140     0.628
160     0.69
180     0.742
200     0.787
220     0.83
240     0.865

@

<<zs3e2.dat>>=
0       0.002
20      0.066
40      0.126
60      0.18
80      0.23
100     0.278
120     0.327
140     0.38
160     0.424
180     0.466
200     0.506
220     0.54
240     0.574
260     0.608
300     0.674

@

<<zs3e3.dat>>=
0       0.002
20      0.032
40      0.06
60      0.089
80      0.119
100     0.149
120     0.177
140     0.204
160     0.23
180     0.255
200     0.28
220     0.307
240     0.333
260     0.357
280     0.38
300     0.402

@

<<zs3e4.dat>>=
0       0.001
20      0.016
40      0.032
60      0.047
80      0.062
100     0.076
120     0.09
140     0.104
160     0.118
180     0.132
200     0.147
220     0.162
240     0.176
260     0.19
280     0.203
300     0.216

@

<<zs4e1.dat>>=
0       0.003
20      0.11
40      0.194
60      0.262
80      0.314
100     0.358
120     0.392
140     0.418
160     0.44
180     0.458
200     0.472
220     0.486
240     0.494
260     0.502
280     0.508
300     0.51

@

<<zs4e2.dat>>=
0       0.002
20      0.05
40      0.096
60      0.138
80      0.176
100     0.211
120     0.243
140     0.27
160     0.295
180     0.317
200     0.339
220     0.358
240     0.375
260     0.39
280     0.404
300     0.416

@

<<zs4e3.dat>>=
0       0.003
20      0.03
40      0.059
60      0.086
80      0.112
100     0.137
120     0.16
140     0.182
160     0.202
180     0.22
200     0.239
220     0.255
240     0.271
260     0.285
280     0.299
300     0.313

@

<<zs4e4.dat>>=
0       0.001
20      0.016
40      0.029
60      0.042
80      0.056
100     0.07
120     0.085
140     0.098
160     0.11
180     0.123
200     0.135
220     0.146
240     0.156
260     0.165
280     0.175
300     0.186

@

<<zs5e1.dat>>=
0       0.001
20      0.085
40      0.144
60      0.183
80      0.21
100     0.228
120     0.241
140     0.25
160     0.254
180     0.261
200     0.264
220     0.266
240     0.267
260     0.268
280     0.268
300     0.269

@

<<zs5e2.dat>>=
0       0.001
40      0.09
60      0.123
80      0.148
100     0.169
120     0.188
140     0.203
160     0.216
180     0.226
200     0.234
220     0.24
240     0.246
260     0.251
280     0.254
300     0.257

@

<<zs5e3.dat>>=
0       0.001
20      0.029
40      0.054
60      0.074
80      0.093
100     0.11
120     0.126
140     0.143
180     0.17
200     0.18
220     0.189
240     0.197
260     0.204
280     0.211
300     0.217

@

<<zs5e4.dat>>=
0       0
20      0.014
40      0.029
60      0.042
80      0.053
100     0.064
120     0.075
140     0.088
160     0.099
180     0.109
200     0.118
220     0.125
240     0.132
260     0.14
280     0.147
300     0.154

@

<<zs6e1.dat>>=
0       0.001
20      0.071
40      0.104
60      0.12
80      0.128
100     0.132
120     0.134
140     0.136
160     0.136
180     0.136

@

<<zs6e2.dat>>=
0       0.002
20      0.045
40      0.074
60      0.094
80      0.107
100     0.116
120     0.122
140     0.126
160     0.129
180     0.13
200     0.132
220     0.132
240     0.133
260     0.133
280     0.133
300     0.134

<<zs6e3.dat>>=
0       0.001
20      0.023
40      0.041
60      0.055
80      0.068
100     0.078
120     0.087
140     0.096
160     0.103
180     0.108
200     0.112
220     0.115
240     0.118
260     0.12
280     0.123
300     0.125

<<zs6e4.dat>>=
0       0.001
20      0.011
40      0.023
60      0.033
80      0.041
100     0.049
120     0.056
140     0.061
160     0.064
180     0.069
200     0.075
220     0.081
240     0.083
260     0.087
280     0.089
300     0.092

@

<<zconcentration1.dat>>=
zs1e1.dat 0.0003 15.36e-9
zs2e1.dat 0.00015 15.36e-9
zs3e1.dat 0.000075 15.36e-9
zs4e1.dat 0.00003 15.36e-9
zs5e1.dat 0.000015 15.36e-9
zs6e1.dat 0.0000075 15.36e-9

@

<<zconcentration2.dat>>=
zs1e2.dat 0.0003 7.68e-9
zs2e2.dat 0.00015 7.68e-9
zs3e2.dat 0.000075 7.68e-9
zs4e2.dat 0.00003 7.68e-9
zs5e2.dat 0.000015 7.68e-9
zs6e2.dat 0.0000075 7.68e-9

@

<<zconcentration3.dat>>=
zs1e3.dat 0.0003 3.84e-9
zs2e3.dat 0.00015 3.84e-9
zs3e3.dat 0.000075 3.84e-9
zs4e3.dat 0.00003 3.84e-9
zs5e3.dat 0.000015 3.84e-9
zs6e3.dat 0.0000075 3.84e-9

@

<<zconcentration4.dat>>=
zs1e4.dat 0.0003 1.92e-9
zs2e4.dat 0.00015 1.92e-9
zs3e4.dat 0.000075 1.92e-9
zs4e4.dat 0.00003 1.92e-9
zs5e4.dat 0.000015 1.92e-9
zs6e4.dat 0.0000075 1.92e-9

@

<<alldatasets>>=
zs1e1.dat 0.0003 15.36e-9
zs2e1.dat 0.00015 15.36e-9
zs3e1.dat 0.000075 15.36e-9
zs4e1.dat 0.00003 15.36e-9
zs5e1.dat 0.000015 15.36e-9
zs6e1.dat 0.0000075 15.36e-9
zs1e2.dat 0.0003 7.68e-9
zs2e2.dat 0.00015 7.68e-9
zs3e2.dat 0.000075 7.68e-9
zs4e2.dat 0.00003 7.68e-9
zs5e2.dat 0.000015 7.68e-9
zs6e2.dat 0.0000075 7.68e-9
zs1e3.dat 0.0003 3.84e-9
zs2e3.dat 0.00015 3.84e-9
zs3e3.dat 0.000075 3.84e-9
zs4e3.dat 0.00003 3.84e-9
zs5e3.dat 0.000015 3.84e-9
zs6e3.dat 0.0000075 3.84e-9
zs1e4.dat 0.0003 1.92e-9
zs2e4.dat 0.00015 1.92e-9
zs3e4.dat 0.000075 1.92e-9
zs4e4.dat 0.00003 1.92e-9
zs5e4.dat 0.000015 1.92e-9
zs6e4.dat 0.0000075 1.92e-9

@

\end{comment}

\section{References}
This is incomplete

\begin{comment}
<<myreferences.bib>>=

@book{Shuler2006Bioprocess,
  added-at = {2018-12-02T16:09:07.000+0100},
  author = {Shuler, Michael L. and Kargi, Fikret},
  edition = {2nd},
  howpublished = {Paperback},
  publisher = {Prentice Hall},
  title = {Bioprocess Engineering: Basic Concepts},
  url = {http://www.amazon.com/exec/obidos/redirect?tag=citeulike07-20\&path=ASIN/0134782151},
  year = 2006
}


@article{apple2011,
Abstract = {We describe the implementation of "APPLE for the Teacher," an alternative education outreach program that augments teacher efforts in presenting specific AP Biology laboratory exercises and at the same time involves the community in the educational process. The program is 5 years old and is staffed primarily by volunteers. We discuss the experiences of participants and lessons learned during the program's implementation and growth. [ABSTRACT FROM AUTHOR]},
Author = {TWIGG, PAMELA and LAMB, NEIL and DU BREUIL, RUSLA and ZAHORCHAK, BOB},
ISSN = {00027685},
Journal = {American Biology Teacher (University of California Press)},
Keywords = {ACTIVITY programs in biology education, ALTERNATIVE education, BIOTECHNOLOGY study & teaching, ADVANCED placement programs (Education), BIOLOGY education, LIFE science education, BIOLOGICAL laboratories, SCIENCE education (Secondary), ACTIVITY programs in science education, AP Biology, Community outreach, education enhancement},
Number = {8},
Pages = {444 - 448},
Title = {APPLE for the Teacher -- Scientists in the Classroom: From Grassroots to Productive Orchard.},
Volume = {73},
URL = {https://elib.uah.edu/login?url=https://search.ebscohost.com/login.aspx?direct=true&db=a9h&AN=66705244&site=ehost-live&scope=site},
Year = {2011},
}


@article{alkphos2019,
author = {Miquet, Johanna G. and González, Lorena and Sotelo, Ana I. and González Lebrero, Rodolfo M.},
title = {A laboratory work to introduce biochemistry undergraduate students to basic enzyme kinetics-alkaline phosphatase as a model},
journal = {Biochemistry and Molecular Biology Education},
volume = {47},
number = {1},
pages = {93-99},
keywords = {Enzyme kinetics, alkaline phosphatase, experimental design, hands-on learning, laboratory experiment},
doi = {https://doi.org/10.1002/bmb.21195},
url = {https://iubmb.onlinelibrary.wiley.com/doi/abs/10.1002/bmb.21195},
eprint = {https://iubmb.onlinelibrary.wiley.com/doi/pdf/10.1002/bmb.21195},
abstract = {Abstract Enzyme kinetics is an essential topic in undergraduate Biochemistry courses. A laboratory work that covers the principal basic concepts of enzyme kinetics in steady state is presented. The alkaline phosphatase catalyzed reaction of phenyl-phosphate hydrolysis was studied as a model. The laboratory experience was designed to reinforce the concepts of initial velocity dependence on substrate and enzyme concentration, and to highlight the importance of the accurate determination of initial reaction rate. The laboratory work consists in two parts, in which students first determine the enzyme concentration and the time to be used in the following session to obtain the kinetic parameters (KM and Vmax) by non-lineal fitting of the Michaelis–Menten equation to the initial velocity dependence with substrate concentration results. The experimental methodology is robust, the cost per student is low and the equipment and reagents used are of easy access. © 2018 International Union of Biochemistry and Molecular Biology, 47(1):93–99, 2018.},
year = {2019}
}

@

\end{comment}

\bibliography{myreferences}
\printindex
\end{document}


