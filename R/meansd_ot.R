#' Plot Mean and Standard Deviation over Time
#'
#' This function creates a plot of the mean and standard deviation of a numeric variable
#' over a specified x-axis, optionally grouped by a color variable and additional grouping variables. Perfect for plotting time series with discrete groups.
#' Custom ggplot2 objects can be added to enhance the plot.
#'
#' @param data A data frame containing the variables to be plotted. If group factors, structure should be as follows: "x_axis" (e.g. time), "y_axis" (e.g. expression), "color" (e.g. target).
#' @param x_axis A character string specifying the column name to use for the x-axis (mandatory). E.g. time
#' @param y_axis A character string specifying the column name to use for the y-axis (mandatory). E.g. expression or relative quantity
#' @param color An optional character string specifying the column name to use for grouping and coloring lines.
#' If NULL, no grouping is applied. Default is NULL.
#' @param ggplot_objects A list of ggplot2 objects (e.g., themes, labels, layers) to be added to the plot.
#' Default is a single layer with ggplot2::geom_line().
#' @param group_args A list of additional column names to use for grouping data (e.g., for calculating means
#' and standard deviations). Default is an empty list.
#'
#' @return A ggplot2 object showing the mean and standard deviation of the numeric variable over the x-axis.
#'
#' @examples
#' # Example 1: Plotting stock prices over time, grouped by stock
#' \dontrun{
#' meansd_ot(
#'   eu_stock_df,
#'   x_axis = "year",
#'   y_axis = "price",
#'   color = "stock",
#'   ggplot_objects = list(
#'     ggplot2::geom_line(),
#'     hrbrthemes::theme_ipsum(),
#'     ggplot2::labs(title = "Stock Prices Over Time", x = "Year", y = "Price"),
#'     hrbrthemes::scale_color_ipsum()
#'   )
#' )
#' }
#' # Example 2: Plotting stock prices over time without grouping
#' meansd_ot(
#'   eu_stock_df,
#'   x_axis = "year",
#'   y_axis = "price",
#'   ggplot_objects = list(
#'     ggplot2::geom_line(),
#'     ggplot2::theme_minimal(),
#'     ggplot2::labs(title = "Stock Prices Over Time", x = "Year", y = "Price")
#'   )
#' )
#'
#' # Example 3: Plotting results of dnase test, with density over runs
#' meansd_ot(
#'     dnase |> dplyr::mutate(Run = as.numeric(Run)),
#'     x_axis = "Run",
#'     y_axis = "density"
#'    )
#'
#' # Example 4:
#' meansd_ot(
#'     dnase |> dplyr::mutate(Run = as.numeric(Run)),
#'     x_axis = "Run",
#'     y_axis = "density",
#'     ggplot_objects = list(ggplot2::geom_line(),
#'        ggplot2::theme_minimal(),
#'        ggplot2::labs(title = "Density for each Run", x = "Run", y = "Density")
#'  )
#')
#' @export
meansd_ot <- function(data, x_axis = NULL, y_axis = NULL, color = NULL, ggplot_objects = list(ggplot2::geom_line()), group_args = list()) {
  if (is.null(x_axis) | is.null(y_axis)) {
    stop("Specify x and y axis")
  }

  if (is.null(color)) {
    data <- data |>
      dplyr::group_by(dplyr::across(dplyr::all_of(c(x_axis, purrr::flatten_chr(group_args))))) |>
      dplyr::summarise(dplyr::across(dplyr::where(is.numeric), list(mean = mean, sd = sd), .names = "{col}_{fn}"), .groups = 'drop')

    p <- ggplot2::ggplot(data, ggplot2::aes(x = !!rlang::sym(x_axis), y = !!rlang::sym(paste0(y_axis, "_mean")))) +
      ggplot2::geom_point() +
      ggplot2::geom_errorbar(ggplot2::aes(
        ymin = !!rlang::sym(paste0(y_axis, "_mean")) - !!rlang::sym(paste0(y_axis, "_sd")),
        ymax = !!rlang::sym(paste0(y_axis, "_mean")) + !!rlang::sym(paste0(y_axis, "_sd"))
      ))

  } else {
    data <- data |>
      dplyr::group_by(dplyr::across(dplyr::all_of(c(x_axis, color, purrr::flatten_chr(group_args))))) |>
      dplyr::summarise(dplyr::across(dplyr::where(is.numeric), list(mean = mean, sd = sd), .names = "{col}_{fn}"), .groups = 'drop')

    p <- ggplot2::ggplot(data, ggplot2::aes(x = !!rlang::sym(x_axis), y = !!rlang::sym(paste0(y_axis, "_mean")), color = !!rlang::sym(color))) +
      ggplot2::geom_point() +
      ggplot2::geom_errorbar(ggplot2::aes(
        ymin = !!rlang::sym(paste0(y_axis, "_mean")) - !!rlang::sym(paste0(y_axis, "_sd")),
        ymax = !!rlang::sym(paste0(y_axis, "_mean")) + !!rlang::sym(paste0(y_axis, "_sd"))
      )) +
      ggplot2::scale_color_viridis_d()
  }

  if (length(ggplot_objects) > 0) {
    p <- purrr::reduce(ggplot_objects, `+`, .init = p)
  }

  p
}
