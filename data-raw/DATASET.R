## code to prepare `DATASET` dataset goes here

rm(list=ls())


library(dssd)
library(dsims)
library(sf)
library(intercali)

set.seed(2022)
# Create the region object with the make.region function of the dsims package
shapefile.name <- system.file("extdata", "StAndrew.shp", package = "dssd")


region <- make.region(region.name = "St Andrews bay",
                      shape = shapefile.name,
                      units = "m")

density <- make.density(region = region,
                        x.space = 2000,
                        y.space = 2000,
                        constant = 5)

density <- add.hotspot(object = density,
                       centre = c(-163000, 6245000),
                       sigma = 10000,
                       amplitude = 6)

density <- add.hotspot(object = density,
                       centre = c(-145000, 6275000),
                       sigma = 10000,
                       amplitude = -3)

plot(density)

dataset_density <- density

#usethis::use_data(dataset_density, overwrite = TRUE)
#usethis::use_r("dataset_density")

dataset_map <- extract_map(density_obj = density,
                           N = 500,
                           crs = 2154)

# usethis::use_data(dataset_map, overwrite = TRUE)
# usethis::use_r("dataset_map")

dataset_transects <- create_transect(region_obj = region,
                             crs = 2154,
                             design = "eszigzag",
                             line.length = 400000,
                             design.angle = 30,
                             truncation = 400)

# usethis::use_data(dataset_transects, overwrite = TRUE)
# usethis::use_r("dataset_transects")

# Crop_transects
transects <- crop_transect(transect_obj = dataset_transects,
                           map_obj = dataset_map)

# Segmentize transects
dataset_segs <- segmentize_transect(transect_obj = transects,
                                         length_m = 2000,
                                         to = "LINESTRING")

# usethis::use_data(dataset_segs, overwrite = TRUE)
# usethis::use_r("dataset_segs")


# Simulate individuals
dataset_obs <- simulate_ind(map_obj = dataset_map,
                            crs = 2154)

# usethis::use_data(dataset_obs, overwrite = TRUE)
# usethis::use_r("dataset_obs")

# Calculate distance
dataset_dist <- calculate_distance(obs_obj = dataset_obs,
                                   transect_obj = dataset_segs,
                                   crs = 2154)

# usethis::use_data(dataset_dist, overwrite = TRUE)
# usethis::use_r("dataset_dist")

dataset_detected <- detection(dist_obj = dataset_dist,
                              key = "hn",
                              esw_km = 0.16,
                              g_zero = 1,
                              truncation_m = 400)

# usethis::use_data(dataset_detected, overwrite = TRUE)
# usethis::use_r("dataset_detected")
