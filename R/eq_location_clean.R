#' @title Clean location names
#'
#' @description Reformats location names of noaa raw data and extracts country names into new collumn.
#'
#' @param data (\emph{\link[dplyr]{tbl_df}}) raw noaa data imported with \code{\link{eq_read_data}}
#' @param col (\emph{tidy eval syntax}) column containing location name
#' @param country (\emph{tidy eval syntax}) column where country names are written to
#'
#' @return noaa dataframe with cleaned loaction and country names as tibble (see \code{\link[dplyr]{tbl_df}})
#'
#' @seealso \code{\link{eq_clean_data}}, \code{\link{eq_read_data}}
#'
#' @examples
#' \dontrun{
#' path <- system.file("extdata", "noaa_earthquakes.tsv", package = "noaa")
#' eq_read_data(path) %>%
#'   eq_location_clean
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
