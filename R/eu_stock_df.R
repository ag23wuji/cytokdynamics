#' eu_stock_df: European Stock Market Prices
#'
#' This dataset is a sample built from the `EuStockMarkets` dataset, containing yearly stock prices
#' of major European indices: DAX (Germany), SMI (Switzerland), CAC (France), and FTSE (United Kingdom).
#'
#' @format A data frame with 4 columns:
#' \describe{
#'   \item{year}{\code{numeric}. The year of the recorded stock prices.}
#'   \item{stock}{\code{character}. The name of the stock market index (e.g., "DAX", "SMI", "CAC", "FTSE").}
#'   \item{price}{\code{numeric}. The stock price recorded for the corresponding index.}
#' }
#'
#' @details
#' The data includes annual stock prices for each of the listed stock market indices. It can be used
#' for demonstrating data analysis, visualization, and modeling techniques.
#'
#' @source Built from the \code{\link{EuStockMarkets}} dataset in base R.
#'
#' @examples
#' # Load the dataset
#' data(eu_stock_df)
#'
#' # View the first few rows
#' head(eu_stock_df)
#'
#' # Example 1: Plotting stock prices over time, grouped by stock
#' meansd_ot(
#'   eu_stock_df,
#'   x_axis = "year",
#'   y_axis = "price",
#'   color = "stock",
#'   ggplot_objects = list(
#'     ggplot2::geom_line(),
#'     ggplot2::labs(title = "Stock Prices Over Time", x = "Year", y = "Price")
#'   )
#' )
"eu_stock_df"
