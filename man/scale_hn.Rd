% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/scale_hn.R
\name{scale_hn}
\alias{scale_hn}
\title{Scale hn}
\usage{
scale_hn(esw, lower = 0.001, upper = 5)
}
\arguments{
\item{esw}{numeric. Effective strip width.}

\item{lower}{numeric. Lower range of search.}

\item{upper}{numeric. Upper range of search.}
}
\value{
numeric. The sigma parmater of a half normal function associated with a esw value.
}
\description{
Scale hn
}
\examples{

scale_hn(esw = 0.16)
# sigma = 0.128

}
