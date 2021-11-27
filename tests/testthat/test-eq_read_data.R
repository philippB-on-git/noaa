test_raw <- eq_read_data(system.file("extdata", "noaa_earthquakes.tsv", package = "noaa"))

test_that("column names are as expected", {
    expect_snapshot_value(names(test_raw), style = "serialize")
})

test_that("dimensions are correct", {
    expect_equal(dim(test_raw), c(6236, 38))
})

test_that("values are correct", {
    expect_snapshot_value(rbind(head(test_raw, 5), tail(test_raw, 5)), style = "serialize")
})

test_that("example data loading works", {
    expect_snapshot_value(rbind(head(eq_noaa_example(), 5),
                                tail(eq_noaa_example(), 5)),
                          style = "serialize")
})
