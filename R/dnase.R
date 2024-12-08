#' Sample Dataset: DNase Concentration and Density Measurements
#'
#' This dataset is a sample inspired by the `DNase` dataset, containing measurements of DNase
#' concentration and the resulting density values for various runs.
#'
#' @format A data frame with 3 columns:
#' \describe{
#'   \item{Run}{\code{integer}. The identifier for each experimental run.}
#'   \item{conc}{\code{numeric}. The concentration of DNase in arbitrary units.}
#'   \item{density}{\code{numeric}. The measured density corresponding to the DNase concentration.}
#' }
#'
#' @details
#' The dataset contains measurements of DNase activity across 11 experimental runs. For each run,
#' DNase concentration values are recorded along with the corresponding density measurements.
#' The dataset can be used for demonstrating curve-fitting and analysis of enzyme activity.
#'
#' @source Adapted from the \code{\link{DNase}} dataset in base R.
#'
#' @examples
#' # Load the dataset
#' data(dnase)
#'
#' # View the first few rows
#' head(dnase)
#'
#' # Plot density vs. concentration for different runs
#' library(ggplot2)
#' ggplot(dnase, aes(x = conc, y = density, color = factor(Run))) +
#'   geom_line() +
#'   labs(title = "DNase Concentration vs. Density",
#'        x = "Concentration",
#'        y = "Density",
#'        color = "Run")
"dnase"
