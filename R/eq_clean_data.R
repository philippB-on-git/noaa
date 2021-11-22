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
#' @importFrom magrittr `%>%`
#' @importFrom dplyr select mutate relocate
#' @importFrom lubridate ymd
#' @export
eq_clean_data <- function(data_raw, do_clean_location = T, do_clean_headers = T) {
    data_raw %>%
        select(-grep("^Search Parameter", names(.), value = T)) %>%
        mutate(date = ymd(paste(Year, Mo, Dy, sep = "-"), quiet = T)) %>%
        relocate(date, .before = Year) %>%
        mutate(Latitude = as.numeric(Latitude),
               Longitude = as.numeric(Longitude)) %>%
        { if (do_clean_location) eq_location_clean(.) else . } %>%
        { if (do_clean_headers) clean_headers(.) else . }
}

#' helper function for eq_clean_data
#'
#' @seealso \code{\link{eq_clean_data}}
#'
#' @importFrom dplyr rename_all mutate
#' @importFrom stringr str_replace_all
clean_headers <- function(data) {
    data %>%
        rename_all(toupper) %>%
        rename_all(str_replace_all, pattern = " ", replacement = "_") %>%
        mutate(EQ_PRIMARY = MAG)
}
