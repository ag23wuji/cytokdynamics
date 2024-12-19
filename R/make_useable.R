#' @title make_useable
#' @description You have big datasets and want to make them directly more usable? This function helps you with this issue. It will read in your data from a path (either as .xlsx or .csv) or take a given data, turn it into a nice format, and, if you want, give you back how it is structured!
#' @param data A dataframe
#' @param path A path to a csv or xlsx file
#' @param type The type of object to return. Either 'tibble' or 'dataframe'
#' @param clean_names Whether to clean the column names using janitor::clean_names (logical)
#' @param to_fct Whether to convert character columns to factors (logical)
#' @param check_struct Whether to check the structure of the data using dplyr::glimpse (logical)
#' @param file_args A list of arguments to pass to either read.csv or openxlsx::read.xlsx
#' @param tibble_args A list of arguments to pass to tibble::as_tibble
#' @param clean_args A list of arguments to pass to janitor::clean_names
#' @return A dataframe or tibble
#' @examples
#' # make_useable(path = "example.csv", type = "dataframe",
#' # clean_names = TRUE, file_args = list(sep = ","))
#' # make_useable(path = "example.xlsx", type = "tibble",
#' # clean_names = TRUE, file_args = list(sheet = 1))
#' make_useable(data = mtcars, type = "dataframe", to_fct = TRUE, check_struct = TRUE)
#' make_useable(data = iris, type = "tibble", clean_names = FALSE)
#' make_useable(data = iris, type = "tibble", clean_names = TRUE)
#' @export
#' @importFrom janitor clean_names
#' @importFrom tibble as_tibble
#' @importFrom dplyr mutate across where glimpse
#' @importFrom utils read.csv
#' @importFrom openxlsx read.xlsx
#' @importFrom stringr str_detect
make_useable <- function(
    data = NULL,
    path = NULL,
    type = c("tibble", "dataframe"),
    clean_names = TRUE,
    to_fct = FALSE,
    check_struct = FALSE,
    file_args = list(),
    tibble_args = list(),
    clean_args = list()
) {
  # Ensure type is valid
  type <- match.arg(type)

  # Validate input
  if (!is.null(data) && !is.null(path)) {
    stop("Provide either 'data' or 'path', not both")
  }
  if (is.null(data) && is.null(path)) {
    stop("You must provide either 'data' or a valid 'path'")
  }

  # Read data if path is provided
  if (!is.null(path)) {
    if (!file.exists(path)) {
      stop("File does not exist")
    } else if (stringr::str_detect(tolower(path), "\\.csv$")) {
      data <- do.call(utils::read.csv, c(list(file = path), file_args))
    } else if (stringr::str_detect(tolower(path), "\\.xlsx$")) {
      data <- do.call(openxlsx::read.xlsx, c(list(xlsxFile = path), file_args))
    } else {
      stop("Unsupported file type. Only .csv and .xlsx are supported.")
    }
  }

  # Ensure data is a dataframe
  if (!is.data.frame(data)) {
    stop("The input 'data' must be a valid dataframe")
  }

  # Convert to tibble if requested
  if (type == "tibble") {
    data <- do.call(tibble::as_tibble, c(list(data), tibble_args))
  }

  # Clean column names if requested
  if (clean_names) {
    data <- do.call(janitor::clean_names, c(list(dat = data), clean_args))
  }

  # Convert character columns to factors if requested
  if (to_fct) {
    data <- data |> dplyr::mutate(dplyr::across(dplyr::where(is.character), as.factor))
  }

  # Check the structure of the data if requested
  if (check_struct) {
    dplyr::glimpse(data)
  }

  return(data)
}

# Helper functions could be added if further modularization is required in the future.
