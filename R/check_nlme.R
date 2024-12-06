#' Checks a non-linear mixed-effects model (nlme) for various assumptions
#'
#' @param model The nlme model to check
#' @param autocorrelation Whether to check for autocorrelation (default is TRUE)
#' @param collinearity Whether to check for collinearity (default is TRUE)
#' @param heteroscedasticity Whether to check for heteroscedasticity (default is TRUE)
#' @param normality Whether to check for normality of residuals (default is TRUE)
#' @param varCorr Whether to compute the variance-covariance matrix of random effects (default is TRUE)
#' @param ranef Whether to extract the random effects (default is TRUE)
#'
#' @return A list with the results of the checks
#' @export
#'
#' @examples
#' # Load the Orthodont data
#' data("Orthodont", package = "nlme")
#' as.data.frame(Orthodont)
#' # Fit a non-linear mixed-effects model
#' model <- nlme::lme(distance ~ sin(age), data = Orthodont, random = ~ 1 | Subject)
#' # Check the model
#' check_nlme(model)
check_nlme <- function(model = NULL, autocorrelation = TRUE, collinearity = TRUE,
                       heteroscedasticity = TRUE, normality = TRUE,
                       varCorr = TRUE, ranef = TRUE) {
  if (is.null(model)) {
    stop("Specify a model to check.")
  }
  # Check autocorrelation
  if (autocorrelation) {
    autocorrelation <- tryCatch(
      nlme::ACF(model, form = ~ time),
      error = function(e) NULL
    )
  } else {
    autocorrelation <- NULL
  }

  # Check collinearity of fixed effects predictors
  if (collinearity) {
    collinearity <- tryCatch(
      performance::check_collinearity(model),
      error = function(e) NULL
    )
  } else {
    collinearity <- NULL
  }

  # Check heteroscedasticity
  if (heteroscedasticity) {
    heteroscedasticity <- tryCatch(
      {
        residuals <- residuals(model)
        fitted <- fitted(model)
        plot <- plot(fitted, residuals, main = "Heteroscedasticity Check")
        list(residuals = residuals, fitted = fitted, plot = plot)
      },
      error = function(e) NULL
    )
  } else {
    heteroscedasticity <- NULL
  }

  # Check normality of residuals
  if (normality) {
    normality <- tryCatch(
      shapiro.test(residuals(model)),
      error = function(e) NULL
    )
  } else {
    normality <- NULL
  }

  # Extract variance-covariance matrix of random effects
  if (varCorr) {
    varCorr <- tryCatch(
      nlme::VarCorr(model),
      error = function(e) NULL
    )
  } else {
    varCorr <- NULL
  }

  # Extract random effects
  if (ranef) {
    ranef <- tryCatch(
      nlme::ranef(model),
      error = function(e) NULL
    )
  } else {
    ranef <- NULL
  }

  # Return a list of results
  return(list(
    autocorrelation = autocorrelation,
    collinearity = collinearity,
    heteroscedasticity = heteroscedasticity,
    normality = normality,
    varCorr = varCorr,
    ranef = ranef
  ))
}
