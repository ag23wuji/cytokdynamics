% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/find_starts.R
\name{find_starts}
\alias{find_starts}
\title{Find starting values for the parameters of a sinusoidal model}
\usage{
find_starts(data, relative_quantity = "relative_quantity_ratio", time = "time")
}
\arguments{
\item{data}{A data frame containing the data.}

\item{relative_quantity}{The name of the column containing the relative quantity values.}

\item{time}{The name of the column containing the time values.}
}
\value{
A numeric vector containing the starting values for the parameters of the sinusoidal model.
}
\description{
This function calculates starting values for the parameters of a sinusoidal model
based on the data provided. The starting values are calculated as follows:
}
\details{
- The amplitude (\code{A}) is set to the mean of the range of the relative quantity values.
- The angular frequency (\code{omega}) is set to \code{2 * pi} divided by the range of the time values.
- The phase (\code{phase}) is set to 0.
- The decay (\code{decay}) is set to 0.01.
}
\examples{
data <- data.frame(
 time = seq(0, 10, by = 0.1),
 relative_quantity_ratio = sin(seq(0, 10, by = 0.1))
 )
 find_starts(data)
}
