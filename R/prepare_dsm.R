# Generated by fusen: do not edit by hand


#' Recuperer des estimations de variance
#'
#' @param grid_obj dataframe. La grille de prÃ©diction du modele
#' @param dsm_obj dsm objet. Le modele dsm crÃ©Ã©
#'
#' @importFrom dsm dsm.var.gam 
#' @importFrom stats qnorm
#'
#' @return List. Une liste avec le cv, le se et l'intervalle de confiance Ã  95% 
#' @export


#' @examples
#' # TO DO
get_var_dsm <- function(grid_obj, dsm_obj) {
  
  
  # RÃ©cupÃ©ration variance
  pred_dsm_var <- split(grid_obj, 1:nrow(grid_obj))
  
  dsm_var <- dsm.var.gam(dsm.obj = dsm_obj, 
                         pred.data = grid_obj,
                         off.set = grid_obj$area)
  
  sum_data <- summary(dsm_var)
  
  unconditional.cv.square <- sum_data$cv^2
  
  asymp.ci.c.term <- exp(qnorm(1-sum_data$alpha/2) * sqrt(log(1+unconditional.cv.square)))
  
  asymp.tot <- c(sum_data$pred.est / asymp.ci.c.term,
                sum_data$pred.est,
                sum_data$pred.est * asymp.ci.c.term)
  
  out <- list(CI = asymp.tot,
              cv = sum_data$cv,
              se = sum_data$se)
  
  return(out)

}



#' Obtenir dans le bon format les fichiers nÃ©cessaires aux analyses de distance sampling
#'
#' @param map_obj dataframe. La carte avec la densitÃ© associÃ©e
#' @param dist_obj dataframe. Les distances entre individus et transects
#' @param segs_obj dataframe. Les diffÃ©rents transects utilisÃ©s et leur coordonnÃ©es
#'
#' @importFrom dplyr select left_join filter mutate
#' @importFrom units drop_units
#' @importFrom sf st_centroid st_coordinates st_drop_geometry
#'
#' @return List. Les diffÃ©rents objects nÃ©cessaire pour faire du distance sampling.
#' @export

#' @examples
#' # TO DO
prepare_dsm <- function(map_obj, dist_obj, segs_obj) {
  
  obs_dsm <-   left_join(dist_obj, segs_obj, by='Sample.Label')  %>%
    select(object, Sample.Label, size, distance_m, detected) %>%
    drop_units() %>% 
    rename(distance = distance_m) %>%
    filter(detected == 1)
  
  dist_dsm <-  obs_dsm %>%
    select(object, distance) %>%
    drop_units()
  
  # segments
  segs_dsm <- segs_obj %>%
    st_centroid() %>%
    mutate(X = st_coordinates(.)[,1]) %>%
    mutate(Y = st_coordinates(.)[,2]) %>%
    select(Effort, Sample.Label, X, Y) %>%
    st_drop_geometry() %>%
    drop_units()
  
  grid_dsm <- map_obj %>%
    st_centroid() %>%
    mutate(X = st_coordinates(.)[,1],
           Y = st_coordinates(.)[,2]) %>%
    drop_units() %>%
    as.data.frame() %>%
    select("X","Y","area")
  
  out <- list(dist_dsm = dist_dsm,
              obs_dsm = obs_dsm,
              segs_dsm = segs_dsm,
              grid_dsm = grid_dsm)
  
  return(out)
  
}
