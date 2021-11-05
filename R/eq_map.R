
# takes an argument data containing the filtered data frame with earthquakes to visualize.
# The function maps the epicenters (LATITUDE/LONGITUDE) and annotates each point with in pop up window
# containing annotation data stored in a column of the data frame. The user should be able to choose
# which column is used for the annotation in the pop-up with a function argument named annot_col.
# Each earthquake should be shown with a circle, and the radius of the circle should be proportional
# to the earthquake's magnitude (EQ_PRIMARY). Your code, assuming you have the earthquake data saved
# in your working directory as "earthquakes.tsv.gz", should be able to be used in the following way:
# readr::read_delim("earthquakes.tsv.gz", delim = "\t") %>%
#     eq_clean_data() %>%
#     dplyr::filter(COUNTRY == "MEXICO" & lubridate::year(DATE) >= 2000) %>%
#     eq_map(annot_col = "DATE")
eq_map <- function() {

}
