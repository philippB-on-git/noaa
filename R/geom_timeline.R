#' @title Earthquake timeline
#'
#' @description Adds an earthquake timeline geom to a ggplot2 object expecting noaa dataset cleaned with \code{\link{eq_clean_data}}.
#'
#'
#' @inheritParams ggplot2::layer
#'
#' @details
#' ### Aesthetics
#' geom_timeline uses the following aesthetics (bold is required):
#' \itemize{
#'   \item{\bold{x}}{DATE}
#'   \item{y}{Grouping variable by which visualization is split (usually \emph{COUNTRY})}
#'   \item{colour}{Colour of earthquake marker (e.g. \emph{TOTAL_DEATHS})}
#'   \item{size}{Size of earthquake marker (e.g. \emph{MAG}, \emph{EQ_PRIMARY})}
#' }
#'
#'
#' @seealso \code{\link{geom_timeline_label}}
#'
#' @examples
#' \dontrun{
#' system.file("extdata", "noaa_earthquakes.tsv", package = "noaa") %>%
#'   eq_read_data %>%
#'   eq_clean_data %>%
#'   filter(COUNTRY %in% c("USA", "CHINA") & YEAR > 2000) %>%
#'   ggplot(aes(x = DATE, y = COUNTRY, color = TOTAL_DEATHS, size = MAG)) +
#'   geom_timeline()
#' }
#'
#' @importFrom ggplot2 layer
#' @export
geom_timeline <- function(mapping = NULL,
                          data = NULL,
                          stat = "identity",
                          position = "identity",
                          na.rm = FALSE,
                          show.legend = NA,
                          inherit.aes = TRUE,
                          ...) {
    ggplot2::layer(
        geom = ggproto_timeline,
        mapping = mapping,
        data = data,
        stat = stat,
        position = position,
        show.legend = show.legend,
        inherit.aes = inherit.aes,
        params = list(na.rm = na.rm, ...)
    )
}


#' helper function for ggproto_timeline
#'
#' @seealso \code{\link{ggproto_timeline}}
#' @importFrom ggplot2 alpha
#' @importFrom grid pointsGrob segmentsGrob gList gpar
draw_group_timeline <- function(data, panel_params, coord) {
    coords <- coord$transform(data, panel_params)

    pts <- grid::pointsGrob(coords$x,
                            coords$y,
                            pch = coords$shape,
                            size = grid::unit(coords$size / 5, "lines"),
                            gp = gpar(col = alpha(coords$colour, coords$alpha)))

    ln  <- grid::segmentsGrob(x0 = 0,
                              x1 = 1,
                              y0 = coords$y,
                              y1 = coords$y)

    grid::gList(pts, ln)
}


#' ggproto function for geom_timeline
#'
#' @seealso \code{\link{geom_timeline}}
#' @importFrom ggplot2 ggproto Geom aes draw_key_point
ggproto_timeline <- ggproto("ggproto_timeline",
                            Geom,
                            required_aes = "x",
                            default_aes = aes(y = 1, alpha = 0.3,
                                              colour = "black",
                                              size = 1, shape = 16, stroke = 1),
                            draw_key = draw_key_point,
                            draw_group = draw_group_timeline)






