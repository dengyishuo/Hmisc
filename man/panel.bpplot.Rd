\name{panel.bpplot}
\alias{panel.bpplot}
\alias{bpplotM}
\alias{bpplt}
\title{
Box-Percentile Panel Function for Trellis
}
\description{
For all their good points, box plots have a high ink/information ratio
in that they mainly display 3 quartiles.  Many practitioners have
found that the "outer values" are difficult to explain to
non-statisticians and many feel that the notion of "outliers" is too
dependent on (false) expectations that data distributions should be Gaussian.

\code{panel.bpplot} is a \code{panel} function for use with
\code{trellis}, especially for \code{bwplot}.  It draws box plots
(without the whiskers) with any number of user-specified "corners"
(corresponding to different quantiles), but it also draws box-percentile
plots similar to those drawn by Jeffrey Banfield's
(\email{umsfjban@bill.oscs.montana.edu}) \code{bpplot} function. 
To quote from Banfield, "box-percentile plots supply more
information about the univariate distributions.  At any height the
width of the irregular 'box' is proportional to the percentile of that
height, up to the 50th percentile, and above the 50th percentile the
width is proportional to 100 minus the percentile.  Thus, the width at
any given height is proportional to the percent of observations that
are more extreme in that direction.  As in boxplots, the median, 25th
and 75th percentiles are marked with line segments across the box."

\code{panel.bpplot} can also be used with base graphics to add extended
box plots to an existing plot, by specifying \code{nogrid=TRUE, height=...}.

\code{panel.bpplot} is a generalization of \code{bpplot} and
\code{\link[lattice]{panel.bwplot}} in 
that it works with \code{trellis} (making the plots horizontal so that
category labels are more visable), it allows the user to specify the
quantiles to connect and those for which to draw reference lines, 
and it displays means (by default using dots).

\code{bpplt} draws horizontal box-percentile plot much like those drawn
by \code{panel.bpplot} but taking as the starting point a matrix
containing quantiles summarizing the data.  \code{bpplt} is primarily
intended to be used internally by \code{plot.summary.formula.reverse}
but when used with no arguments has a general purpose: to draw an
annotated example box-percentile plot with the default quantiles used
and with the mean drawn with a solid dot.  This schematic plot is
rendered nicely in postscript with an image height of 3.5 inches.

\code{bpplotM} uses the \code{lattice} \code{bwplot} function to depict
multiple numeric continuous variables with varying scales in a single
\code{lattice} graph, after reshaping the dataset into a tall and thin
format.
}
\usage{
panel.bpplot(x, y, box.ratio=1, means=TRUE, qref=c(.5,.25,.75),
             probs=c(.05,.125,.25,.375), nout=0,
             nloc=c('right lower', 'right', 'left', 'none'), cex.n=.7,
             datadensity=FALSE, scat1d.opts=NULL,
             font=box.dot$font, pch=box.dot$pch, 
             cex.means =box.dot$cex,  col=box.dot$col,
             nogrid=NULL, height=NULL, \dots)

# E.g. bwplot(formula, panel=panel.bpplot, panel.bpplot.parameters)

bpplt(stats, xlim, xlab='', box.ratio = 1, means=TRUE,
      qref=c(.5,.25,.75), qomit=c(.025,.975),
      pch=16, cex.labels=par('cex'), cex.points=if(prototype)1 else 0.5,
      grid=FALSE)

bpplotM(vars, group=NULL, data, qlim=0.01, xlim=NULL,
        nloc=c('right lower','right','left','none'),
        vnames=c('labels', 'names'), cex.n=.7, \dots)
}
\arguments{
\item{x}{
continuous variable whose distribution is to be examined
}
\item{y}{
grouping variable
}
\item{box.ratio}{
see \code{\link[lattice]{panel.bwplot}}
}
\item{means}{
set to \code{FALSE} to suppress drawing a character at the mean value
}
\item{qref}{
vector of quantiles for which to draw reference lines.  These do not
need to be included in \code{probs}.
}
\item{probs}{
vector of quantiles to display in the box plot.  These should all be
less than 0.5; the mirror-image quantiles are added automatically.  By
default, \code{probs} is set to \code{c(.05,.125,.25,.375)} so that intervals
contain 0.9, 0.75, 0.5, and 0.25 of the data.
To draw all 99 percentiles, i.e., to draw a box-percentile plot,
set \code{probs=seq(.01,.49,by=.01)}.
To make a more traditional box plot, use \code{probs=.25}.
}
\item{nout}{
tells the function to use \code{scat1d} to draw tick marks showing the
\code{nout} smallest and \code{nout} largest values if \code{nout >= 1}, or to
show all values less than the \code{nout} quantile or greater than the
\code{1-nout} quantile if \code{0 < nout <= 0.5}.  If \code{nout} is a whole number,
only the first \code{n/2} observations are shown on either side of the
median, where \code{n} is the total number of observations. 
}
\item{nloc}{location to plot number of non-\code{NA}
	observations next to each box.  Specify \code{nloc='none'} to
        suppress.  For \code{panel.bpplot}, the default \code{nloc} is
        \code{'none'} if \code{nogrid=TRUE}.}
\item{cex.n}{character size for \code{nloc}}
\item{datadensity}{
set to \code{TRUE} to invoke \code{scat1d} to draw a data density
(one-dimensional scatter diagram or rug plot) inside each box plot.
}
\item{scat1d.opts}{
a list containing named arguments (without abbreviations) to pass to
\code{scat1d} when \code{datadensity=TRUE} or \code{nout > 0}
}
\item{cex.means}{character size for dots representing means}
\item{font,pch,col}{see \code{\link[lattice]{panel.bwplot}}}
\item{nogrid}{set to \code{TRUE} to use in base graphics}
\item{height}{if \code{nogrid=TRUE}, specifies the height of the box in
        user \code{y} units}
\item{\dots}{arguments passed to \code{points} or \code{panel.bpplot}}
\item{stats,xlim,xlab,qomit,cex.labels,cex.points,grid}{
  undocumented arguments to \code{bpplt}.  For \code{bpplotM},
        \code{xlim} is a list with elements named as the \code{x}-axis
        variables, 
        to override the \code{qlim} calculations with user-specified
        \code{x}-axis limits for selected variables.  Example:
        \code{xlim=list(age=c(20,60))}.
				}
\item{vars}{a character vector of names of variables to plot with
  \code{bpplotM}.  \code{vars} may also be a formula.  If it has a left
        hand side, that variable name is taken as the \code{group}
        variable and the \code{group} argument is ignored.}
\item{group}{a single character string specifying the name in
  \code{data} of a \code{y}-axis grouping variable, if any}
\item{data}{a data frame containing at least the \code{vars} variables}
\item{qlim}{the outer quantiles to use for scaling each panel in
  \code{bpplotM}}
\item{vnames}{default is to use variable \code{label} attributes when
        they exist, or use variable names otherwise.  Specify
        \code{vnames='names'} to always use variable names for panel
        labels in \code{bpplotM}}
}
\author{
Frank Harrell
\cr
Department of Biostatistics
\cr
Vanderbilt University School of Medicine
\cr
\email{f.harrell@vanderbilt.edu}
}
\references{
  Esty WW, Banfield J: The box-percentile plot.  J Statistical
Software 8 No. 17, 2003.
}
\seealso{
\code{\link{bpplot}}, \code{\link[lattice]{panel.bwplot}}, \code{\link{scat1d}}, \code{\link{quantile}}, \code{\link{Ecdf}}
}
\examples{
set.seed(13)
x <- rnorm(1000)
g <- sample(1:6, 1000, replace=TRUE)
x[g==1][1:20] <- rnorm(20)+3   # contaminate 20 x's for group 1


# default trellis box plot
require(lattice)
bwplot(g ~ x)


# box-percentile plot with data density (rug plot)
bwplot(g ~ x, panel=panel.bpplot, probs=seq(.01,.49,by=.01), datadensity=TRUE)
# add ,scat1d.opts=list(tfrac=1) to make all tick marks the same size
# when a group has > 125 observations


# small dot for means, show only .05,.125,.25,.375,.625,.75,.875,.95 quantiles
bwplot(g ~ x, panel=panel.bpplot, cex.means=.3)


# suppress means and reference lines for lower and upper quartiles
bwplot(g ~ x, panel=panel.bpplot, probs=c(.025,.1,.25), means=FALSE, qref=FALSE)


# continuous plot up until quartiles ("Tootsie Roll plot")
bwplot(g ~ x, panel=panel.bpplot, probs=seq(.01,.25,by=.01))


# start at quartiles then make it continuous ("coffin plot")
bwplot(g ~ x, panel=panel.bpplot, probs=seq(.25,.49,by=.01))


# same as previous but add a spike to give 0.95 interval
bwplot(g ~ x, panel=panel.bpplot, probs=c(.025,seq(.25,.49,by=.01)))


# decile plot with reference lines at outer quintiles and median
bwplot(g ~ x, panel=panel.bpplot, probs=c(.1,.2,.3,.4), qref=c(.5,.2,.8))


# default plot with tick marks showing all observations outside the outer
# box (.05 and .95 quantiles), with very small ticks
bwplot(g ~ x, panel=panel.bpplot, nout=.05, scat1d.opts=list(frac=.01))


# show 5 smallest and 5 largest observations
bwplot(g ~ x, panel=panel.bpplot, nout=5)


# Use a scat1d option (preserve=TRUE) to ensure that the right peak extends 
# to the same position as the extreme scat1d
bwplot(~x , panel=panel.bpplot, probs=seq(.00,.5,by=.001), 
       datadensity=TRUE, scat1d.opt=list(preserve=TRUE))

# Add an extended box plot to an existing base graphics plot
plot(x, 1:length(x))
panel.bpplot(x, 1070, nogrid=TRUE, pch=19, height=15, cex.means=.5)

# Draw a prototype showing how to interpret the plots
bpplt()

# Example for bpplotM
set.seed(1)
n <- 800
d <- data.frame(treatment=sample(c('a','b'), n, TRUE),
                age=rnorm(n, 40, 10),
                bp =rnorm(n, 120, 12),
                wt =rnorm(n, 190, 30))
label(d$bp) <- 'Systolic Blood Pressure'
units(d$bp) <- 'mmHg'
bpplotM(c('age', 'bp', 'wt'), group='treatment', data=d)
# Can use Hmisc Cs function, e.g. Cs(age, bp, wt)
bpplotM(treatment ~ age + bp + wt, data=d, nloc='left')
# Without treatment: bpplotM(~ age + bp + wt, data=d)

\dontrun{
# Example of finding all variables that appear to be continuous
getHdata(support)
s <- sapply(support, function(x) is.numeric(x) && length(unique(x)) > 5)
bpplotM(names(support)[s], group='dzgroup', data=support,
        par.strip.text=list(cex=.4), cex.means=.3, cex.n=.45)

# Separate displays for categorical vs. continuous baseline variables
getHdata(pbc)
pbc <- upData(pbc, moveUnits=TRUE)

s <- summaryM(stage + sex + spiders ~ drug, data=pbc)
plot(s)
Key(0, .5)
bpplotM(drug ~ bili + albumin + protime + age ~ drug, data=pbc)
}
}
\keyword{nonparametric}
\keyword{hplot}
\keyword{distribution}
\concept{trellis}
\concept{lattice}
