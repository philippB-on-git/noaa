
# takes the dataset as an argument and creates an HTML label that can be used as the annotation text
# in the leaflet map. This function should put together a character string for each earthquake that
# will show the cleaned location (as cleaned by the eq_location_clean() function created in
#                                 Module 1), the magnitude (EQ_PRIMARY), and the total number of
# deaths (TOTAL_DEATHS), with boldface labels for each ("Location", "Total deaths", and "Magnitude").
# If an earthquake is missing values for any of these, both the label and the value should be skipped
# for that element of the tag. Your code should be able to be used in the following way:
# readr::read_delim("earthquakes.tsv.gz", delim = "\t") %>%
#     eq_clean_data() %>%
#     dplyr::filter(COUNTRY == "MEXICO" & lubridate::year(DATE) >= 2000) %>%
#     dplyr::mutate(popup_text = eq_create_label(.)) %>%
#     eq_map(annot_col = "popup_text")
eq_create_label <- function() {

}
