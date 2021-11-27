#' @title Add text labels
#'
#' @description  Add text labels to timeline visualization via \code{geom_timeline} of earthquakes.
#'
#' @inheritParams ggplot2::layer
#' @param n_max (\emph{integer}) Number of labels to be drawn per group.
#' @param na.rm If FALSE, the default, missing values are removed with a warning. If TRUE, missing values are silently removed.
#' @param ... Other arguments passed to ggplot2::layer
#'
#' @details Count of labels by group is controlled by \code{n_max} where top n_max earthquakes ordered by magnitude are used.
#' For label text \emph{mapping} of \code{label} is expected. \cr\cr
#' ### Aesthetics
#' geom_timeline_label requires the following aesthetics:
#' \itemize{
#'   \item{y}{Grouping variable by which visualization is split (usually \emph{COUNTRY})}
#'   \item{label}{Label text (e.g. \emph{LOCATION_NAME})}
#' }
#'
#' @seealso \code{\link{geom_timeline}}
#'
#' @examples
#' \dontrun{
#' noaa_data <- system.file("extdata", "noaa_earthquakes.tsv", package = "noaa") %>%
#'   eq_read_data %>%
#'   eq_clean_data %>%
#'   filter(COUNTRY %in% c("USA", "CHINA") & YEAR > 2000)
#'
#' timeline <- noaa_data %>%
#'   plot_eq_timeline(label = NULL)
#'
#' timeline +
#'   geom_timeline_label(data = noaa_data,
#'                       mapping = aes(y = COUNTRY, label = LOCATION_NAME), n_max = 6)
#' }
#'
#' @importFrom ggplot2 layer
#' @importFrom magrittr `%>%`
#' @importFrom dplyr group_by slice_max
#' @export
geom_timeline_label <- function(mapping = NULL,
                                data = NULL,
                                stat = "identity",
                                position = "identity",
                                na.rm = FALSE,
                                show.legend = NA,
                                inherit.aes = TRUE,
                                n_max = 5,
                                ...) {

    #wrangle data here

    data <- data %>%
        group_by(.$COUNTRY) %>%
        slice_max(.$MAG, n = n_max, with_ties = F)


    ggplot2::layer(
        geom = ggproto_timeline_label,
        mapping = mapping,
        data = data,
        stat = stat,
        position = position,
        show.legend = show.legend,
        inherit.aes = inherit.aes,
        params = list(na.rm = na.rm, ...)
    )
}


#' helper function for ggproto_timeline_label
#'
#' @keywords internal
#'
#' @seealso \code{\link{ggproto_timeline_label}}
#' @importFrom grid segmentsGrob textGrob gList gpar
draw_group_timeline_label <- function(data, panel_params, coord) {
    coords <- coord$transform(data, panel_params)

    lns  <- grid::segmentsGrob(x0 = coords$x, y0 = coords$y,
                               x1 = coords$x, y1 = coords$y + 0.1 / length(panel_params$y$limits),
                               gp = grid::gpar(col = "gray60", alpha = 1, size = 1))

    txt  <- grid::textGrob(label = coords$label,
                           x = coords$x + 0.005,
                           y = coords$y + 0.1 / length(panel_params$y$limits) + 0.005,
                           rot = 30,
                           hjust = 0,
                           vjust = 0,
                           gp = gpar(fontsize = 7))

    grid::gList(lns, txt)
}


#' ggproto function for geom_timeline_label
#'
#' @keywords internal
#'
#' @seealso \code{\link{geom_timeline_label}}
#' @importFrom ggplot2 ggproto Geom aes draw_key_label
ggproto_timeline_label <- ggproto("ggproto_timeline_label",
                                  Geom,
                                  required_aes = c("x", "label"),
                                  default_aes = aes(y = 1, alpha = 1,
                                                    colour = "black"),
                                  draw_key = draw_key_label,
                                  draw_group = draw_group_timeline_label)
