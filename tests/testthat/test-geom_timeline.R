test_that("s3 class 'Layer' is returned", {
    expect_s3_class(geom_timeline(), "Layer")
})

test_that("noaa data can be used", {
    noaa_data <- eq_clean_data(eq_noaa_example())

    expect_s3_class({
        ggplot2::ggplot(data = noaa_data,
                        mapping = ggplot2::aes(x = DATE, y = COUNTRY,
                                               color = TOTAL_DEATHS, size = MAG)) +
            geom_timeline()
    }, "ggplot")
})

test_that("ggproto_timeline has is class 'ggproto'", {
    expect_s3_class(ggproto_timeline, "ggproto")
})
