#' Checks a linear mixed-effects model for various assumptions
#'
#' @param model The model to check
#' @param autocorrelation Whether to check for autocorrelation (default is TRUE)
#' @param collinearity Whether to check for collinearity (default is TRUE)
#' @param heteroscedasticity Whether to check for heteroscedasticity (default is TRUE)
#' @param normality Whether to check for normality (default is TRUE)
#' @param rePCA Whether to perform a PCA on the random effects (default is TRUE)
#' @param varCorr Whether to compute the variance-covariance matrix of the random effects (default is TRUE)
#' @param singularity Whether to check for singularity (default is TRUE)
#' @param all_fit Whether to fit all possible models (default is TRUE)
#' @param ranef Whether to extract the random effects (default is TRUE)
#' @importFrom lme4 isSingular
#' @importFrom lme4 allFit
#' @importFrom lme4 ranef
#' @importFrom lme4 rePCA
#' @importFrom lme4 VarCorr
#' @importFrom performance check_autocorrelation
#' @importFrom performance check_collinearity
#' @importFrom performance check_heteroscedasticity
#' @importFrom performance check_normality
#' @examples
#' library(lme4)
#' library(performance)
#' model <- lmer(Reaction ~ Days + (Days | Subject), sleepstudy)
#' check_lmer(model)
#' @details This function checks a linear mixed-effects model for various assumptions. The assumptions checked are:
#' - Autocorrelation
#' - Collinearity
#' - Heteroscedasticity
#' - Normality
#' - Random effects PCA
#' - Variance-Covariance matrix of random effects
#' - Singularity
#' - All possible fits
#'
#' The function can be performed on a model object created with lme4::lmer. Alternatively the function accepts linear models for autocorrelation, collinearity, heteroscedasticity, and normality checks.
#' @return A list with the results of the checks
#' @export check_lmer
check_lmer <- function(model, autocorrelation = TRUE, collinearity = TRUE, heteroscedasticity = TRUE, normality = TRUE, rePCA = TRUE, varCorr = TRUE, singularity = TRUE, all_fit = TRUE, ranef = TRUE) {

  if (autocorrelation) {
    autocorrelation <- performance::check_autocorrelation(model)
  } else {
    autocorrelation <- NULL
  }

  if (collinearity) {
    collinearity <- performance::check_collinearity(model)
  } else {
    collinearity <- paste("Multicollinearity not checked")
  }

  if (heteroscedasticity) {
    heteroscedasticity <- performance::check_heteroscedasticity(model)
  } else {
    heteroscedasticity <- paste("No check for heteroscedascity")
  }

  if (normality) {
    normality <- performance::check_normality(model)
  } else {
    normality <- paste("Normality of residuals not checked")
  }

  if (rePCA) {
    rePCA <- lme4::rePCA(model)
  } else {
    rePCA <- paste("No PCA of random-effects covariance matrix performed")
  }

  if (varCorr) {
    varCorr <- lme4::VarCorr(model)
  } else {
    varCorr <- paste("Variance and Correlation Components not extracted")
  }

  if (singularity) {
    singularity <- lme4::isSingular(model)
  } else {
    singularity <- paste("No check for singularity")
  }

  if (all_fit) {
    all_fit <- lme4::allFit(model)
  } else {
    all_fit <- paste("Optimizer not fitted")
  }

  if (ranef) {
    ranef <- lme4::ranef(model)
  } else {
    ranef <- paste("Random effect modes not calculated")
  }

  # Return a list of results
  return(list(autocorrelation = autocorrelation,
              collinearity = collinearity,
              heteroscedasticity = heteroscedasticity,
              normality = normality,
              rePCA = rePCA,
              varCorr = varCorr,
              singularity = singularity,
              all_fit = all_fit,
              ranef = ranef))
}
