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
#' @importFrom grid pointsGrob segmentsGrob gList
draw_group_timeline <- function(data, panel_params, coord) {
    coords <- coord$transform(data, panel_params)

    # dbg_data[[length(dbg_data) + 1]] <<- data
    # dbg_scales <<- panel_params
    # dbg_coord <<- coord
    # dbg_coords_[[length(dbg_coords_) + 1]] <<- coords

    pts <- grid::pointsGrob(coords$x,
                            coords$y,
                            pch = coords$shape,
                            size = grid::unit(coords$size / 5, "lines"),
                            gp = grid::gpar(col = alpha(coords$colour, coords$alpha)))

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






