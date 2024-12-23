% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/meansd_ot.R
\name{meansd_ot}
\alias{meansd_ot}
\title{Plot Mean and Standard Deviation over Time}
\usage{
meansd_ot(
  data,
  x_axis = NULL,
  y_axis = NULL,
  color = NULL,
  ggplot_objects = list(ggplot2::geom_line()),
  group_args = list()
)
}
\arguments{
\item{data}{A data frame containing the variables to be plotted. If group factors, structure should be as follows: "x_axis" (e.g. time), "y_axis" (e.g. expression), "color" (e.g. target).}

\item{x_axis}{A character string specifying the column name to use for the x-axis (mandatory). E.g. time}

\item{y_axis}{A character string specifying the column name to use for the y-axis (mandatory). E.g. expression or relative quantity}

\item{color}{An optional character string specifying the column name to use for grouping and coloring lines.
If NULL, no grouping is applied. Default is NULL.}

\item{ggplot_objects}{A list of ggplot2 objects (e.g., themes, labels, layers) to be added to the plot.
Default is a single layer with ggplot2::geom_line().}

\item{group_args}{A list of additional column names to use for grouping data (e.g., for calculating means
and standard deviations). Default is an empty list.}
}
\value{
A ggplot2 object showing the mean and standard deviation of the numeric variable over the x-axis.
}
\description{
This function creates a plot of the mean and standard deviation of a numeric variable
over a specified x-axis, optionally grouped by a color variable and additional grouping variables. Perfect for plotting time series with discrete groups.
Custom ggplot2 objects can be added to enhance the plot.
}
\examples{
# Example 1: Plotting stock prices over time, grouped by stock
\dontrun{
meansd_ot(
  eu_stock_df,
  x_axis = "year",
  y_axis = "price",
  color = "stock",
  ggplot_objects = list(
    ggplot2::geom_line(),
    hrbrthemes::theme_ipsum(),
    ggplot2::labs(title = "Stock Prices Over Time", x = "Year", y = "Price"),
    hrbrthemes::scale_color_ipsum()
  )
)
}
# Example 2: Plotting stock prices over time without grouping
meansd_ot(
  eu_stock_df,
  x_axis = "year",
  y_axis = "price",
  ggplot_objects = list(
    ggplot2::geom_line(),
    ggplot2::theme_minimal(),
    ggplot2::labs(title = "Stock Prices Over Time", x = "Year", y = "Price")
  )
)

# Example 3: Plotting results of dnase test, with density over runs
meansd_ot(
    dnase |> dplyr::mutate(Run = as.numeric(Run)),
    x_axis = "Run",
    y_axis = "density"
   )

# Example 4:
meansd_ot(
    dnase |> dplyr::mutate(Run = as.numeric(Run)),
    x_axis = "Run",
    y_axis = "density",
    ggplot_objects = list(ggplot2::geom_line(),
       ggplot2::theme_minimal(),
       ggplot2::labs(title = "Density for each Run", x = "Run", y = "Density")
 )
)
}
