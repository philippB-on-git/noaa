
# Please cite as:
# National Geophysical Data Center / World Data Service (NGDC/WDS): NCEI/WDS Global Significant
# Earthquake Database. NOAA National Centers for Environmental Information. doi:10.7289/V5TD9V7K

library(readr)
library(dplyr)
path <- "C:/Users/Philipp/iCloudDrive/Dokumente/Statistics_DataScience/Courses/Coursera_Mastering_R__capstone/earthquakes-2021-06-05_16-41-49_+0200.tsv"

eq_read_data <- function(path) {
    read_delim(file = path,
               delim = "\t",
               skip_empty_rows = T,
               guess_max = 5000,
               col_types = cols(
                   `Search Parameters` = col_skip(),
                   Missing = col_double(),
                   `Damage ($Mil)` = col_double(),
                   `Total Missing` = col_double(),
                   `Total Missing Description` = col_character(),
                   `Total Damage ($Mil)` = col_double()
               ))
}
