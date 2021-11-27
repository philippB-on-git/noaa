#' @title read noaa dataset
#'
#' @description Read tab-delimited raw noaa dataset from U.S. National Oceanographic and Atmospheric Administration (NOAA): \cr
#' National Geophysical Data Center / World Data Service (NGDC/WDS): NCEI/WDS Global Significant \cr
#' Earthquake Database. NOAA National Centers for Environmental Information. doi:10.7289/V5TD9V7K
#'
#' @param path (\emph{file path}) file location of raw data
#'
#'
#' @return noaa data is returned as tibble (see \code{\link[dplyr]{tbl_df}})
#'
#' @references Earthquake Database. NOAA National Centers for Environmental Information. \cr
#' (\href{https://www.ncei.noaa.gov/access/metadata/landing-page/bin/iso?id=gov.noaa.ngdc.mgg.hazards:G012153}{doi:10.7289/V5TD9V7K})
#'
#' @seealso \code{\link{eq_clean_data}}
#'
#' @examples
#' \dontrun{
#' path <- system.file("extdata", "noaa_earthquakes.tsv", package = "noaa") %>%
#' eq_read_data(path)
#' }
#'
#' @importFrom readr read_delim cols col_skip col_double col_character
#' @export
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


#' @title load example noaa data
#'
#' @description Load raw noaa example dataset from U.S. National Oceanographic and Atmospheric Administration (NOAA): \cr
#' National Geophysical Data Center / World Data Service (NGDC/WDS): NCEI/WDS Global Significant \cr
#' Earthquake Database. NOAA National Centers for Environmental Information. doi:10.7289/V5TD9V7K
#'
#'
#' @return example noaa data, that comes with noaa package, is returned as tibble (see \code{\link[dplyr]{tbl_df}})
#'
#' @references Earthquake Database. NOAA National Centers for Environmental Information. \cr
#' (\href{https://www.ncei.noaa.gov/access/metadata/landing-page/bin/iso?id=gov.noaa.ngdc.mgg.hazards:G012153}{doi:10.7289/V5TD9V7K})
#'
#' @seealso \code{\link{eq_read_data}}
#'
#' @examples
#' \dontrun{
#' noaa_raw <- eq_noaa_example()
#' }
#'
#' @importFrom magrittr `%>%`
#' @export
eq_noaa_example <- function() {
    system.file("extdata", "noaa_earthquakes.tsv", package = "noaa") %>%
        eq_read_data
}

