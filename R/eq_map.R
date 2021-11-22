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
#' @importFrom leaflet leaflet addTiles addCircleMarkers
#' @importFrom magrittr `%>%`
#' @export
eq_map <- function(data, annot_col) {
    data %>%
        leaflet() %>%
        addTiles() %>%
        addCircleMarkers(lng = data$LONGITUDE,
                         lat = data$LATITUDE,
                         radius = data$MAG,
                         popup = data[[annot_col]],
                         color = "blue",
                         weight = 1,
                         opacity = 0.5)
}
