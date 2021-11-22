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
#' @importFrom readr read_delim cols col_skip col_double col_character
#' @export
eq_read_data <- function(path) {
    read_delim(file = path,
               delim = "\t",
               skip_empty_rows = T,
               guess_max = 5000,
               col_types = cols(
                   `Search Parameters` = col_skip(),
                   Missing = col_double(),
                   `Damage ($Mil)` = col_double(),
                   `Total Missing` = col_double(),
                   `Total Missing Description` = col_character(),
                   `Total Damage ($Mil)` = col_double()
               ))
}
