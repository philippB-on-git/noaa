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
#' @importFrom stringr str_to_title
#' @export
eq_create_label <- function(data) {
    loc <- empty_if_na(str_to_title(data$LOCATION_NAME),
                       FUN = make_label,
                       label_name ="Location")
    mag <- empty_if_na(data$MAG,
                       FUN = make_label,
                       label_name = "Magnitude")
    dth <- empty_if_na(data$TOTAL_DEATHS,
                       FUN = make_label,
                       label_name = "Total deaths")

    paste0(loc, mag, dth)
}


#' helper function for eq_create_label
#'
#' @seealso \code{\link{eq_create_label}}
#' @importFrom dplyr if_else
empty_if_na <- function(x, FUN, ...) {
    if_else(is.na(x), "", FUN(as.character(x), ...))
}


#' helper function for eq_create_label
#'
#' @seealso \code{\link{eq_create_label}}
make_label <- function(x, label_name) {
    paste0("<b>", label_name, ":</b> ", x, "<br />")
}
