#' @title Plot noaa timeline
#'
#' @description  Wrapper for \code{\link{geom_timeline}} and  \code{link{geom_timeline_label}}.
#' Data is grouped by COUNTRY.
#'
#' @param data noaa dataset prepared by \code{\link{eq_clean_data}}.
#' @param label (\emph{tidy eval syntax}) Column used for labeling.
#'
#' @seealso \code{\link{geom_timeline}}, \code{\link{geom_timeline_label}}
#'
#' @examples
#' \dontrun{
#' noaa_data <- system.file("extdata", "noaa_earthquakes.tsv", package = "noaa") %>%
#'   eq_read_data %>%
#'   eq_clean_data %>%
#'   filter(COUNTRY %in% c("USA", "CHINA") & YEAR > 2000)
#'
#' timeline <- noaa_data %>%
#'   plot_eq_timeline(label = DATE)
#' }
#'
#' @importFrom ggplot2 ggplot aes theme element_blank element_line guides guide_legend guide_colorbar element_text margin
#' @importFrom magrittr `%>%`
#' @importFrom dplyr mutate
#' @importFrom rlang enquo quo_is_null `!!`
#' @export
plot_eq_timeline <- function(data, label = LOCATION_NAME) {
    label <- enquo(label)

    data %>%
        ggplot(aes(x = DATE, y = COUNTRY, color = TOTAL_DEATHS, size = MAG)) +
        theme(legend.position = "bottom",
              panel.background = element_blank(),
              axis.line.x.bottom = element_line(colour = "black", size = 1)) +
        geom_timeline() +
        guides(size = guide_legend(title = "Richter scale value",
                                   nrow = 1, title.vjust = 1,
                                   order = 1,
                                   title.theme = element_text(margin = margin(t = 3))),
               colour = guide_colorbar(title = "#deaths",
                                       nrow = 1, title.vjust = 1,
                                       title.theme = element_text(margin = margin(t = 3)),
                                       label.theme = element_text(size = 8,
                                                                  angle = 60,
                                                                  hjust = 1))) +
        {
            if (!rlang::quo_is_null(label))
                geom_timeline_label(data, mapping = ggplot2::aes(y = COUNTRY, label = !!label))
        }
}
