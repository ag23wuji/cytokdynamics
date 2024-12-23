% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/pca_prep.R
\name{pca_prep}
\alias{pca_prep}
\title{PCA Preprocessing}
\usage{
pca_prep(
  data,
  dummy_specify = list(),
  cols.remove = list(),
  dummys = TRUE,
  pca_call = TRUE
)
}
\arguments{
\item{data}{A data frame.}

\item{dummy_specify}{A list of column names to create dummy variables for. If left empty, the function will create dummy variables for all factor columns.}

\item{cols.remove}{A list of column names to remove from the data frame.}

\item{dummys}{A logical value indicating whether to create dummy variables.}

\item{pca_call}{A logical value indicating whether to perform PCA.}
}
\value{
A PCA object if pca_call is TRUE, otherwise a data frame.
}
\description{
This function preprocesses data for PCA analysis. It cleans column names, converts character columns to factors, removes specified columns, creates dummy variables, and standardizes numeric columns. It then performs PCA on the standardized numeric columns.
}
\examples{
pca_prep(iris)
pca_prep(iris, dummy_specify = c("Species"))
pca_prep(iris, cols.remove = c("Species"))
pca_prep(starwars_data)
}
