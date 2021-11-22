#' @title Visualize earthquake locations on map
#'
#' @description  Draw earthquake locations from noaa dataset on leaflet map.
#'
#' @param data (\emph{\link[dplyr]{tbl_df}}) noaa dataset cleaned with \code{\link{eq_clean_data}}
#' @param annot_col (\emph{character}) column to be used as labels
#'
#'
#' @seealso \code{\link{eq_create_label}}
#'
#' @examples
#' \dontrun{
#' system.file("extdata", "noaa_earthquakes.tsv", package = "noaa") %>%
#'   eq_read_data %>%
#'   eq_clean_data %>%
#'   eq_map(annot_col = "DATE")
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
