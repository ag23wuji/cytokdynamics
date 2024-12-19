#' Find starting values for the parameters of a sinusoidal model
#'
#' This function calculates starting values for the parameters of a sinusoidal model
#' based on the data provided. The starting values are calculated as follows:
#'
#' - The amplitude (\code{A}) is set to the mean of the range of the relative quantity values.
#' - The angular frequency (\code{omega}) is set to \code{2 * pi} divided by the range of the time values.
#' - The phase (\code{phase}) is set to 0.
#' - The decay (\code{decay}) is set to 0.01.
#'
#' @param data A data frame containing the data.
#' @param relative_quantity The name of the column containing the relative quantity values.
#' @param time The name of the column containing the time values.
#' @return A numeric vector containing the starting values for the parameters of the sinusoidal model.
#' @importFrom base names
#' @importFrom base all
#' @importFrom base c
#' @importFrom base pi
#' @importFrom base seq
#' @importFrom base sin
#' @examples
#' data <- data.frame(
#'  time = seq(0, 10, by = 0.1),
#'  relative_quantity_ratio = sin(seq(0, 10, by = 0.1))
#'  )
#'  find_starts(data)
#' @export find_starts
find_starts <- function(data, relative_quantity = "relative_quantity_ratio", time = "time") {
  # Validate inputs
  if (!all(c(relative_quantity, time) %in% names(data))) {
    stop("The specified columns do not exist in the dataset.")
  }

  # Convert column names to symbols for tidy evaluation
  relative_quantity <- rlang::sym(relative_quantity)
  time <- rlang::sym(time)

  # Extract relevant columns using tidy evaluation
  relative_quantity_values <- data |> dplyr::pull(!!relative_quantity)
  time_values <- data |> dplyr::pull(!!time)

  # Calculate start parameters
  A_start <- mean(range(relative_quantity_values, na.rm = TRUE))
  omega_start <- 2 * pi / diff(range(time_values, na.rm = TRUE))
  phase_start <- 0
  decay_start <- 0.01

  # Return the starting values
  return(c(A_start, omega_start, phase_start, decay_start))
}

