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
#' data(sample_dataset)
#'
#' # View the first few rows
#' head(sample_dataset)
#'
#' # Plot stock prices over time
#' library(ggplot2)
#' ggplot(sample_dataset, aes(x = year, y = price, color = stock)) +
#'   geom_line() +
#'   labs(title = "European Stock Market Prices", x = "Year", y = "Price")
"eu_stock_df"
