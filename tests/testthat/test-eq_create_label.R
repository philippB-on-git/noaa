test_df <- data.frame(LOCATION_NAME = c(NA, "name_1", "name_2"),
                      MAG = c(NA, 1, 2),
                      TOTAL_DEATHS = c(NA, NA, 3))

test_that("label string is correct", {
    test_str <- c("",
                  "<b>Location:</b> Name_1<br /><b>Magnitude:</b> 1<br />",
                  "<b>Location:</b> Name_2<br /><b>Magnitude:</b> 2<br /><b>Total deaths:</b> 3<br />")
    expect_equal(eq_create_label(test_df), test_str)
})

test_that("empty_if_na returns blank only for missing value", {
    expect_equal(empty_if_na(NA, paste0), "")
    expect_equal(empty_if_na("test", paste0), "test")
})

test_that("make_label creates correct string", {
    expect_equal(make_label(c("Name_2", 2, 3), "Location"),
                 c("<b>Location:</b> Name_2<br />",
                   "<b>Location:</b> 2<br />",
                   "<b>Location:</b> 3<br />"))
})
