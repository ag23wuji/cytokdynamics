#' @title is_negative_feedback Feedback identification
#' @description This function uses a specified nlme to detect whether a system exhibits negative feedback behavior. The specified nlme follows an oscillatory curve, starting with a peak (A), followed by an oscillatoric behavior. The formula is as follows: relative_quantity ~ A * sin(omega * time + phase).
#' Take in mind: if the output is an error, this most likely indicates that we dont have a negative feedback dynamic. Check out cytokdynamics vignette to see how to define if there are other dynamic behaviors.
#'
#' @param data A data frame containing the data.
#' @param relative_quantity The name of the column containing the relative quantity data.
#' @param time The name of the column containing the time data.
#' @param group The name of the column containing the group data.
#' @param max_time The maximum time to consider in the analysis. If NULL, all data is used. By default it is set to <= 120 min.
#' @param filter_args A list of additional arguments to filter the data. You could for example filter out specific groups or time points. Take in mind, that if group is not specified or group column has less than 2 values, nls will be used instead of nlme.
#' @return An nlme object representing the fitted model.
#' @importFrom stats as.formula
#' @export is_negative_feedback
#' @examples
#' # use the package intern datasets cytokinin expression:
#' data(cytokinin_expression)
#' is_negative_feedback(cytokinin_expression)
#' is_negative_feedback(cytokinin_expression, filter_args = list('group == "500_direct_ARR5"'))
is_negative_feedback <- function(
    data,
    relative_quantity = "relative_quantity_ratio",
    time = "time",
    group = "group",
    max_time = 120,
    filter_args = list()
) {
  result <- tryCatch({
    # Validate inputs
    if (!all(c(relative_quantity, time, group) %in% names(data))) {
      stop("The specified columns do not exist in the dataset.")
    }

    # Convert column names to symbols for tidy evaluation
    relative_quantity <- rlang::sym(relative_quantity)
    time <- rlang::sym(time)
    group <- rlang::sym(group)

    # Filter data based on max_time
    if (!is.null(max_time)) {
      data <- data |> dplyr::filter(!!time <= max_time)
    }

    # Apply additional filters programmatically
    if (length(filter_args) > 0) {
      # Apply each filter condition
      for (filter_arg in filter_args) {
        data <- data |> dplyr::filter(rlang::eval_tidy(rlang::quo(!!rlang::parse_expr(filter_arg))))
      }
    }

    # Get starting values for the model
    starts <- find_starts(data, as.character(relative_quantity), as.character(time))
    names(starts) <- c("A", "omega", "phase")

    # Dynamically create the model formula
    model_formula <- as.formula(
      paste(as.character(relative_quantity), "~ A * sin(omega *", as.character(time), "+ phase)")
    )

    if (length(unique(data[[as.character(group)]])) > 1) {
      # Specify the grouping variable for random effects
      random_effects <- A + omega + phase ~ 1 | group

      # Fit the nlme model
      model <- nlme::nlme(
        model_formula,
        fixed = A + omega + phase ~ 1,
        random = random_effects,
        data = data,
        start = starts[1:3]
      )

      # Extract the model parameters
      params <- nlme::fixef(model)

      message(
        "Your gene expression probably follows a negative feedback curve. This is a great finding!",
        "The peak occurs at relative quantity = ", params["A"],
        ", the trough at relative quantity = ", params["omega"],
        ", and the phase is reached at relative quantity = ", params["phase"], "."
      )
    } else {
      warning("The group column has less than 2 values. Using nls instead of nlme.")
      model <- nls(
        model_formula,
        data = data,
        start = starts[1:3]
      )

      # Extract the model parameters
      params <- summary(model)$parameters

      message(
        "Your gene expression probably follows a negative feedback curve. ",
        "The peak occurs at relative quantity = ", round(params["A", "Estimate"], 4),
        ", the trough at relative quantity = ", round(params["omega", "Estimate"], 4),
        ", and the phase is reached at relative quantity = ", params["phase", "Estimate"], "."
      )
    }

    return(model)
  }, error = function(e) {
    warning("Your data probably does not follow a negative feedback curve. Is this unexpected? Check if you specified all arguments and parameters correctly. Some possible questions you should consider before keeping on: >>Are there possible missing values? Did you choose an appropriate time range? Have you split into different groups if you have multiple target genes or treatments?<< If it is expected, you could keep on with fitting other possible behaviors, check out cytokdynamics vignette to find the other is_...feedback functions.")
    return(NULL)
  })

  return(result)
}
