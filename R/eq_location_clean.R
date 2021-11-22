#' <title>
#'
#' <description> \cr
#' \code{<function name>}.
#'
#' @param <x> (\emph{character}) <description>.
#'
#' @details
#' <details> \code{\link{<other function name>}}
#'
#' @return FIBS data is returned as tibble (see \code{\link[dplyr]{tbl_df}})
#'
#' @references US National Highway Traffic Safety Administration \cr
#' (\href{https://www.nhtsa.gov/research-data/fatality-analysis-reporting-system-fars}{https://www.nhtsa.gov/research-data/fatality-analysis-reporting-system-fars})
#'
#' @seealso \code{\link{<other function name>}}
#'
#' @examples
#' \dontrun{
#' ...
#' }
#'
#' @importFrom rlang enquo quo_name
#' @importFrom stringr str_extract
#' @importFrom dplyr mutate relocate
#' @export
eq_location_clean <- function(data, col = `Location Name`, country = COUNTRY) {
    col     <- enquo(col)
    country <- enquo(country)

    col_name    <- quo_name(col)
    country_name <- quo_name(country)

    data %>%
        mutate(!!country_name := str_extract(!!col, "^[A-z ]+")) %>%
        mutate(!!col_name := gsub("^[A-z ]+:[ ]+", "", !!col)) %>%
        relocate(!!country, .before = !!col) %>%
        mutate(!!country := replace(!!country, !!country %in% toupper(datasets::state.name), "USA"))
}
