noaa_raw <- eq_noaa_example()

test_that("location string is cleaned properly", {
    expect_snapshot_value(eq_location_clean(noaa_raw[1:5, "Location Name"]),
                          style = "serialize")
})
