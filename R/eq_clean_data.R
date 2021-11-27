#' @title Clean noaa data
#'
#' @description Clean raw noaa data that was imported with \code{\link{eq_read_data}}. \emph{DATE}, \emph{LONGITUDE} and \emph{LATITUDE} are reformatted.
#' By default \emph{LOCATION NAME} is cleaned via \code{\link{eq_location_clean}} and column names are reformatted to match naming convention (capitalize & replace space with "_").
#'
#' @param data_raw (\emph{\link[dplyr]{tbl_df}}) raw noaa data imported with \code{\link{eq_read_data}}
#' @param do_clean_location (\emph{logical}) if true, \code{\link{eq_location_clean}} is called
#' @param do_clean_headers (\emph{logical}) if true, columns are renamed properly
#'
#'
#' @return clean noaa data is returned as tibble (see \code{\link[dplyr]{tbl_df}})
#'
#' @seealso \code{\link{eq_location_clean}}, \code{\link{eq_read_data}}
#'
#' @examples
#' \dontrun{
#' path <- system.file("extdata", "noaa_earthquakes.tsv", package = "noaa")
#' eq_read_data(path) %>%
#'   eq_clean_data(do_clean_headers = F)
#' }
#'
#' @importFrom magrittr `%>%`
#' @importFrom dplyr select mutate relocate
#' @importFrom lubridate ymd
#' @importFrom rlang .data
#' @export
eq_clean_data <- function(data_raw, do_clean_location = T, do_clean_headers = T) {
    data_raw %>%
        select(-grep("^Search Parameter", names(.), value = T)) %>%
        mutate(date = ymd(paste(.$Year, .$Mo, .$Dy, sep = "-"), quiet = T)) %>%
        relocate(.data$date, .before = .data$Year) %>%
        mutate(Latitude = as.numeric(.$Latitude),
               Longitude = as.numeric(.$Longitude)) %>%
        { if (do_clean_location) eq_location_clean(.) else . } %>%
        { if (do_clean_headers) clean_headers(.) else . }
}


#' helper function for eq_clean_data
#'
#' @keywords internal
#'
#' @seealso \code{\link{eq_clean_data}}
#'
#' @importFrom dplyr rename_all mutate
#' @importFrom stringr str_replace_all
clean_headers <- function(data) {
    data %>%
        rename_all(toupper) %>%
        rename_all(str_replace_all, pattern = " ", replacement = "_") %>%
        mutate(EQ_PRIMARY = .$MAG)
}
