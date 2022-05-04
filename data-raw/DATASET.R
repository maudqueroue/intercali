## code to prepare `DATASET` dataset goes here

library(dssd)
library(dsims)
library(intercali)

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

usethis::use_data(dataset_map, overwrite = TRUE)
usethis::use_r("dataset_map")
