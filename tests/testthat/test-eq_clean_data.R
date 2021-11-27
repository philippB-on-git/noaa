noaa_clean <- eq_noaa_example() %>%
    eq_clean_data()

test_that("all column names are upper case", {
    expect_equal(all(grepl("^[0-9A-Z_\\(\\)\\$]+$", names(noaa_clean))), T)
})

test_that("data frame dimensions are as expected", {
    expect_equal(ncol(noaa_clean), 41)
    expect_equal(nrow(noaa_clean), 6236)
})

test_that("data frame class is tbl_df", {
    expect_s3_class(noaa_clean, "tbl_df")
})

test_that("clean data is as expected", {
    expect_snapshot_value(head(noaa_clean, 5), style = "serialize")
})

test_that("clean_headers returns correct strings", {
    dt <- data.frame(`var one` = 1,
                      `VAR$Two($)_` = 2,
                      mAg = 3,
                      check.names = F)

    expect_equal(names(clean_headers(dt)), c("VAR_ONE", "VAR$TWO($)_", "MAG", "EQ_PRIMARY"))
})
