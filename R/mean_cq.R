#' Mean Cq Dataset
#'
#' A dataset containing synthetic qPCR results for gene expression analysis over a time course.
#' This dataset represents changes in the mean Cq (Cycle Quantification) values for a reference gene
#' and two target genes across several time points. It can be used to test qPCR data analysis workflows.
#'
#' @docType data
#'
#' @format A tibble with 21 rows and 3 variables:
#' \describe{
#'   \item{Zeit}{Time points in hours (integer).}
#'   \item{Gen}{Gene name (character): "Reference_Gene", "Target_Gene_A", "Target_Gene_B".}
#'   \item{Mean_Cq}{Mean cycle quantification value (double).}
#'    \item{Relative_Quantitaet}{Relative quantity (double).}
#' }
#'
#' @keywords datasets
#' @references Synthetic dataset created for testing purposes.
#'
#' @examples
#' # Load the dataset
#' data(mean_cq)
#'
#' # View the first few rows
#' head(mean_cq)
#'
#' # Summary of the dataset
#' dplyr::glimpse(mean_cq)
#'
#' # Plot Mean Cq over time for each gene
#' library(ggplot2)
#' ggplot(mean_cq, aes(x = Zeit, y = Mean_Cq, color = Gen)) +
#'   geom_line() +
#'   geom_point() +
#'   labs(title = "Mean Cq Values Over Time",
#'        x = "Time (hours)", y = "Mean Cq") +
#'   theme_minimal()
#' @export
"mean_cq"
