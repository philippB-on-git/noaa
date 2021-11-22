#' @title Create label text for eq_map()
#'
#' @description  Create a label text that can be used with \code{\link{eq_map}} by combining \emph{LOCATION}, \emph{MAGNITUDE} and \emph{TOTAL_DEATHS} into a html-string.
#'
#' @param data (\emph{\link[dplyr]{tbl_df}}) noaa dataset cleaned with \code{\link{eq_clean_data}}
#'
#' @seealso \code{\link{eq_map}}
#'
#' @examples
#' \dontrun{
#' system.file("extdata", "noaa_earthquakes.tsv", package = "noaa") %>%
#'   eq_read_data %>%
#'   eq_clean_data %>%
#'   mutate(label_text = eq_create_label(.)) %>%
#'   eq_map(annot_col = "label_text")
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
