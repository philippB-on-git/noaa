
# cleans the LOCATION_NAME column by stripping out the country name (including the colon) and
# converts names to title case (as opposed to all caps). This will be needed later for annotating
# visualizations. This function should be applied to the raw data to produce a cleaned up version
# of the LOCATION_NAME column.
library(dplyr)
library(stringr)
eq_location_clean <- function(data, col = `Location Name`, country = COUNTRY) {
    col     <- enquo(col)
    country <- enquo(country)

    col_name    <- quo_name(col)
    country_name <- quo_name(country)

    data %>%
        mutate(!!country_name := str_extract(!!col, "^[A-z ]+")) %>%
        mutate(!!col_name := gsub("^[A-z ]+:[ ]+", "", !!col)) %>%
        relocate(!!country, .before = !!col)
}
