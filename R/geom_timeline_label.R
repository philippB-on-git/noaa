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
        group_by(COUNTRY) %>%
        slice_max(MAG, n = n_max, with_ties = F)


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
#' @seealso \code{\link{ggproto_timeline_label}}
#' @importFrom grid segmentsGrob textGrob gList
draw_group_timeline_label <- function(data, panel_params, coord) {
    coords <- coord$transform(data, panel_params)

    lns  <- grid::segmentsGrob(x0 = coords$x, y0 = coords$y,
                               x1 = coords$x, y1 = coords$y + 0.1 / length(panel_params$y$limits),
                               gp = grid::gpar(col = "gray60", alpha = 1, size = 1))

    txt  <- grid::textGrob(label = coords$label,
                           x = coords$x + 0.005,
                           y = coords$y + 0.1 / length(panel_params$y$limits) + 0.005,
                           rot = 45,
                           hjust = 0,
                           vjust = 0)

    grid::gList(lns, txt)
}


#' ggproto function for geom_timeline_label
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
