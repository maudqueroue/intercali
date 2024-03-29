# Generated by fusen: do not edit by hand


library(testthat)
library(dsims)
library(dplyr)


test_that("random_density works", {
  expect_true(inherits(random_density, "function")) 
})



test_that("test conformite random_density", {
  
  set.seed(2022)
  
  shapefile.name <- system.file("extdata", "StAndrew.shp", package = "dssd")
  region <- make.region(region.name = "St Andrews bay",
                        shape = shapefile.name,
                        units = "m")
  
  density <- random_density(region_obj = region,
                            grid_m = 500,
                            density_base = 10,
                            crs = 2154,
                            amplitude = c(-5, 5),
                            sigma = c(2000, 6000),
                            nb_simu = 15) 
  
  test <- density@density.surface %>%
    as.data.frame %>%
    slice(1:5)
  
exp <- structure(list(strata = c("St Andrews bay", "St Andrews bay", 
"St Andrews bay", "St Andrews bay", "St Andrews bay"), density = c(9.91133425322749, 
9.92450046733582, 9.93877367100102, 9.95337420196009, 9.96768670101523
), x = c(-157640.409885506, -157140.409885506, -156640.409885506, 
-156140.409885506, -155640.409885506), y = c(6241293.1524534, 
6241293.1524534, 6241293.1524534, 6241293.1524534, 6241293.1524534
), geometry = structure(list(structure(list(structure(c(-157572.396626863, 
-157390.409885506, -157390.409885506, -157572.396626863, 6241543.1524534, 
6241543.1524534, 6241537.74048088, 6241543.1524534), .Dim = c(4L, 
2L))), class = c("XY", "POLYGON", "sfg")), structure(list(structure(c(-157390.409885506, 
-157390.409885506, -156890.409885506, -156890.409885506, -157390.409885506, 
6241537.74048088, 6241543.1524534, 6241543.1524534, 6241522.87134127, 
6241537.74048088), .Dim = c(5L, 2L))), class = c("XY", "POLYGON", 
"sfg")), structure(list(structure(c(-156890.409885506, -156890.409885506, 
-156390.409885506, -156390.409885506, -156890.409885506, 6241522.87134127, 
6241543.1524534, 6241543.1524534, 6241508.00220167, 6241522.87134127
), .Dim = c(5L, 2L))), class = c("XY", "POLYGON", "sfg")), structure(list(
    structure(c(-156390.409885506, -156390.409885506, -155890.409885506, 
    -155890.409885506, -156390.409885506, 6241508.00220167, 6241543.1524534, 
    6241543.1524534, 6241493.13306206, 6241508.00220167), .Dim = c(5L, 
    2L))), class = c("XY", "POLYGON", "sfg")), structure(list(
    structure(c(-155890.409885506, -155890.409885506, -155390.409885506, 
    -155390.409885506, -155890.409885506, 6241493.13306206, 6241543.1524534, 
    6241543.1524534, 6241478.26392246, 6241493.13306206), .Dim = c(5L, 
    2L))), class = c("XY", "POLYGON", "sfg"))), class = c("sfc_POLYGON", 
"sfc"), precision = 0, bbox = structure(c(xmin = -157572.396626863, 
ymin = 6241478.26392246, xmax = -155390.409885506, ymax = 6241543.1524534
), class = "bbox"), crs = structure(list(input = NA_character_, 
    wkt = NA_character_), class = "crs"), n_empty = 0L)), class = "data.frame", row.names = c(NA, 
-5L))

expect_equal(object = test,
             expected = exp)

expect_is(density, "Density")

}) 


test_that("test erreur random_map", {
  
  data(iris)
  
  expect_error(object = random_density(region_obj = iris,
                                       grid_m = 500,
                                       density_base = 10,
                                       crs = 2154,
                                       amplitude = c(-5, 5),
                                       sigma = c(2000, 6000),
                                       nb_simu = 15))
  
  expect_error(object = random_density(region_obj = region,
                                       grid_m = 500,
                                       density_base = 10,
                                       crs = 2154,
                                       amplitude = 5,
                                       sigma = c(2000, 6000),
                                       nb_simu = 15))
  
})
