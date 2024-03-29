# Generated by fusen: do not edit by hand


#' Get the area of the monitored region
#'
#' @param transect_obj sf dataframe. Transect/segment data. 
#' @param map_obj sf dataframe or Region object from dssd. Study region.
#' @param truncation_m Numeric. A single numeric value (in m) describing the longest distance at which an object may be observed.
#' @param crs Numeric. Projection system. Default : NA.
#'
#' @importFrom sf st_sf st_buffer st_union st_intersection st_area
#'
#' @return numeric. The area of the monitored surface in m.
#' @export


#' @examples
#' data("dataset_map")
#' data("dataset_segs")
#' 
#' get_monitored_area(transect_obj = dataset_segs,
#'                    map_obj = dataset_map,
#'                    truncation_m = 400)
get_monitored_area <- function(transect_obj, map_obj, truncation_m, crs = NA) {
  
    # function check
  
  assert_that(inherits(transect_obj, "sf"))
  assert_that(is.numeric(truncation_m))
  assert_that(inherits(map_obj, c("sf", "Region")))
  
  # function
  
  if(inherits(map_obj, "sf")){
    contour_obj <- map_obj %>%
      st_union()
  }
  
  if(inherits(map_obj, "Region")){
    assert_that(is.numeric(crs))
    contour_obj <- st_sf(map_obj@region,
                         crs = crs)
  }
  
  out <- transect_obj %>%
    st_buffer(dist = truncation_m, endCapStyle = 'FLAT') %>%
    st_union %>%
    st_intersection(contour_obj) %>%
    st_area()
  
  return(out)
  
}
