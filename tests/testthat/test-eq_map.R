noaa_clean <- eq_clean_data(eq_noaa_example())
noaa_clean_na_rm <- noaa_clean[!is.na(noaa_clean$DATE) & !is.na(noaa_clean$COUNTRY) &
                                   !is.na(noaa_clean$LOCATION_NAME) & !is.na(noaa_clean$MAG) &
                                   !is.na(noaa_clean$TOTAL_DEATHS), ]

test_that("eq_map works with cleaned noaa data", {
    expect_s3_class(eq_map(noaa_clean_na_rm,
                           annot_col = "DATE"),
                    "leaflet")

    expect_s3_class(eq_map(noaa_clean_na_rm,
                           annot_col = "YEAR"),
                    "leaflet")


    expect_warning(eq_map(noaa_clean, annot_col = "DATE")) # warning due to missing values
    expect_error(eq_map(noaa_clean_na_rm))
})
