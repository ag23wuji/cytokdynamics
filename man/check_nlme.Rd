% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/check_nlme.R
\name{check_nlme}
\alias{check_nlme}
\title{Checks a non-linear mixed-effects model (nlme) for various assumptions}
\usage{
check_nlme(
  model = NULL,
  autocorrelation = TRUE,
  collinearity = TRUE,
  heteroscedasticity = TRUE,
  normality = TRUE,
  varCorr = TRUE,
  ranef = TRUE
)
}
\arguments{
\item{model}{The nlme model to check}

\item{autocorrelation}{Whether to check for autocorrelation (default is TRUE)}

\item{collinearity}{Whether to check for collinearity (default is TRUE)}

\item{heteroscedasticity}{Whether to check for heteroscedasticity (default is TRUE)}

\item{normality}{Whether to check for normality of residuals (default is TRUE)}

\item{varCorr}{Whether to compute the variance-covariance matrix of random effects (default is TRUE)}

\item{ranef}{Whether to extract the random effects (default is TRUE)}
}
\value{
A list with the results of the checks
}
\description{
Checks a non-linear mixed-effects model (nlme) for various assumptions
}
\examples{
# Load the Orthodont data
data("Orthodont", package = "nlme")
as.data.frame(Orthodont)
# Fit a non-linear mixed-effects model
model <- nlme::lme(distance ~ sin(age), data = Orthodont, random = ~ 1 | Subject)
# Check the model
check_nlme(model)
}
