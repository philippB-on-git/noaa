noaa_data <- eq_clean_data(eq_noaa_example())
noaa_data <- noaa_data[!is.na(noaa_data$DATE) & !is.na(noaa_data$COUNTRY) &
                           !is.na(noaa_data$LOCATION_NAME) & !is.na(noaa_data$MAG) &
                           !is.na(noaa_data$TOTAL_DEATHS), ]

test_that("plot_eq_timeline works with noaa data", {
    expect_s3_class(plot_eq_timeline(noaa_data), "ggplot")
    expect_s3_class(plot_eq_timeline(noaa_data, label = DATE), "ggplot")
    expect_s3_class(plot_eq_timeline(noaa_data, label = NULL), "ggplot")

    expect_error(print(plot_eq_timeline(noaa_data)), NA)
    expect_error(print(plot_eq_timeline(noaa_data[, names(noaa_data) != "LOCATION_NAME"])),
                 info =  "required column not in dataframe")
})
