#' Star Wars Characters Dataset
#'
#' A dataset containing information about characters from the Star Wars universe.
#' This dataset is based on the `dplyr::starwars` dataset and includes details about
#' height, mass, appearance, homeworld, species, and associated films, vehicles,
#' and starships.
#'
#' @docType data
#'
#' @format A tibble with 87 rows and 14 variables:
#' \describe{
#'   \item{name}{Character name (character).}
#'   \item{height}{Height in centimeters (integer).}
#'   \item{mass}{Mass in kilograms (double).}
#'   \item{hair_color}{Hair color (character).}
#'   \item{skin_color}{Skin color (character).}
#'   \item{eye_color}{Eye color (character).}
#'   \item{birth_year}{Year of birth (BBY, Before the Battle of Yavin) (double).}
#'   \item{sex}{Biological sex (character).}
#'   \item{gender}{Gender presentation (character).}
#'   \item{homeworld}{Homeworld of the character (character).}
#'   \item{species}{Species of the character (character).}
#'   \item{films}{List of films the character appears in (list of character vectors).}
#'   \item{vehicles}{List of vehicles the character has used (list of character vectors).}
#'   \item{starships}{List of starships the character has piloted (list of character vectors).}
#' }
#'
#' @keywords datasets
#' @references \url{https://dplyr.tidyverse.org}
#' @source \url{https://dplyr.tidyverse.org}
#'
#' @examples
#' # Load the dataset
#' data(starwars_data)
#'
#' # View the first few rows
#' head(starwars_data)
#'
#' # Summary of starwars data
#' dplyr::glimpse(starwars_data)
#' @export
"starwars_data"
