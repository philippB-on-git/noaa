
# plotting a time line of earthquakes ranging from xmin to xmaxdates with a point for each
# earthquake. Optional aesthetics include color, size, and alpha (for transparency).
# The xaesthetic is a date and an optional y aesthetic is a factor indicating some stratification
# in which case multiple time lines will be plotted for each level of the factor (e.g. country).
library(ggplot2)

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


draw_group_timeline <- function(data, panel_scales, coord) {
    coords <- coord$transform(data, panel_scales)

    dbg_data <<- data
    dbg_scales <<- panel_scales
    dbg_coord <<- coord
    dbg_coords_ <<- coords
    print(dbg_coords_)

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


ggproto_timeline <- ggplot2::ggproto("ggproto_timeline",
                                     ggplot2::Geom,
                                     required_aes = "x",
                                     default_aes = ggplot2::aes(y = 1, alpha = 0.5,
                                                                colour = "black",
                                                                size = 1, shape = 16, stroke = 1),
                                     draw_key = ggplot2::draw_key_point,
                                     draw_group = draw_group_timeline)



test_plot_timeline <- function(data) {
    data %>%
        ggplot(aes(x = DATE, y = COUNTRY, color = TOTAL_DEATHS, size = MAG)) +
        geom_timeline()
}

# test
dt %>% filter(COUNTRY %in% c("JAPAN", "RUSSIA")) %>% test_plot_timeline()


