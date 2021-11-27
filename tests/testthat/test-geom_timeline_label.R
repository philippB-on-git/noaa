noaa_data <- eq_clean_data(eq_noaa_example())

test_that("s3 class 'Layer' is returned", {
    expect_s3_class(geom_timeline_label(data = noaa_data), "Layer")
})

test_that("noaa data can be used", {
    expect_s3_class({
        ggplot2::ggplot() +
            geom_timeline_label(data = noaa_data, mapping = ggplot2::aes(x = DATE, label = ))
    }, "ggplot")
})

test_that("ggproto_timeline_label has is class 'ggproto'", {
    expect_s3_class(ggproto_timeline_label, "ggproto")
})
