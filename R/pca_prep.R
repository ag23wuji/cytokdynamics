#' PCA Preprocessing
#'
#' This function preprocesses data for PCA analysis. It cleans column names, converts character columns to factors, removes specified columns, creates dummy variables, and standardizes numeric columns. It then performs PCA on the standardized numeric columns.
#'
#' @param data A data frame.
#' @param dummy_specify A list of column names to create dummy variables for. If left empty, the function will create dummy variables for all factor columns.
#' @param cols.remove A list of column names to remove from the data frame.
#' @param dummys A logical value indicating whether to create dummy variables.
#' @param pca_call A logical value indicating whether to perform PCA.
#' @return A PCA object if pca_call is TRUE, otherwise a data frame.
#' @export pca_prep
#' @examples
#' pca_prep(iris)
#' pca_prep(iris, dummy_specify = c("Species"))
#' pca_prep(iris, cols.remove = c("Species"))
#' pca_prep(starwars_data)
pca_prep <- function(data, dummy_specify = list(), cols.remove = list(), dummys = TRUE, pca_call = TRUE) {
  data <- data |>
    janitor::clean_names() |>
    dplyr::mutate_if(is.character, factor) |>
    na.omit() |>
    dplyr::select(-dplyr::any_of(janitor::make_clean_names(unlist(cols.remove))))  # Clean column names in cols.remove

  dummy_specify <- janitor::make_clean_names(unlist(dummy_specify))

  if (dummys) {
    if (length(dummy_specify) > 0) {
      data <- data |> fastDummies::dummy_cols(dummy_specify)
    } else {
      factor_cols <- names(data)[sapply(data, is.factor)]
      if (length(factor_cols) > 0) {
        data <- data |> fastDummies::dummy_cols(factor_cols)
      }
    }
  }

  if(pca_call) {
    pca <- data |>
      dplyr::select_if(is.numeric) |>
      dplyr::mutate_if(is.numeric, datawizard::standardize) |>
      prcomp(center = TRUE, scale = FALSE)

    return(pca)
  } else {
    return(data)
  }
}
