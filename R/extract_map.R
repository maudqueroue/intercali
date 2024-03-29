# Generated by fusen: do not edit by hand


#' Extract map with the desired density
#'
#' This function allows, from a density map density_obj (density object of the dsims packages), to provide a map of class sf (data.frame).It allows to recalculate the correct density ratios of the provided map according to the desired number of individuals in the area N. 
#' @param density_obj Density object from dsims package. The map containing information density ratio on the study area.
#' @param N Numeric. The number of individuals desired in the area.
#' @param crs Numeric. Projection system.
#'
#' @importFrom sf st_sf st_area
#' @importFrom dplyr mutate pull
#' @importFrom units drop_units
#' @importFrom assertthat assert_that
#'
#' @return sf object. The map with the densities corresponding to the number of individuals desired in the study area. 
#' @export


#' @examples
#' 
#' data(dataset_density)
#' 
#' map <- extract_map(density_obj = dataset_density,
#'                    N = 500,
#'                    crs = 2154)
#' 
#' 
#' head(map)
#' 
extract_map <- function(density_obj, N, crs) {
  
  
  # Function checks
  
  
  assert_that(inherits(density_obj, "Density"))
  
  # Function
  
  map_obj <- density_obj@density.surface %>%
    as.data.frame() %>%
    st_sf(crs = crs) %>%
    mutate(area = st_area(.)) %>%
    mutate(area_grid = density_obj@x.space * density_obj@y.space) %>%
    drop_units() %>%
    filter(area == area_grid)
  
  area <- sum(map_obj$area)
  
  average_density_m <- N / area
  
  map_obj <- map_obj %>%
    mutate(density_m = average_density_m * density / mean(density, na.rm = TRUE)) %>%
    mutate(density_km = (average_density_m * density / mean(density, na.rm = TRUE)) * 1000000) %>%
    
    
    return(map_obj)
  
}

