
# 1. date column by uniting year, month and day => convert to class data
# 2. LATITUDE and LONGITUDE columns converted to numeric class
library(tidyr)
library(dplyr)
library(lubridate)

eq_clean_data <- function(data_raw, do_clean_location = T, do_clean_headers = T) {
    data_raw %>%
        select(-grep("^Search Parameter", names(.), value = T)) %>%
        mutate(date = ymd(paste(Year, Mo, Dy, sep = "-"), quiet = T)) %>%
        relocate(date, .before = Year) %>%
        mutate(Latitude = as.numeric(Latitude),
               Longitude = as.numeric(Longitude)) %>%
        { if (do_clean_location) eq_location_clean(.) else . } %>%
        { if (do_clean_headers) clean_headers(.) else . }
}


clean_headers <- function(data) {
    data %>%
        rename_all(toupper) %>%
        rename_all(str_replace_all, pattern = " ", replacement = "_")
}
