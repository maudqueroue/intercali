# Generated by fusen: do not edit by hand

library(testthat)
library(dplyr)
library(dssd)


test_that("plot_transect works", {
  
  # Use of the St Andrews bay map from the dssd package
  shapefile.name <- system.file("extdata", "StAndrew.shp", package = "dssd")
  
  # Creation of the object with the make.region function of the dsims package
  region <- make.region(region.name = "St Andrews bay",
                        shape = shapefile.name,
                        units = "m")
  
  data(dataset_transects)
  data(dataset_map)
  
  expect_true(inherits(plot_transects(transect_obj = dataset_transects, 
                                      map_obj = dataset_map, 
                                      crs = 2154), "ggplot"))
  
  expect_true(inherits(plot_transects(transect_obj = dataset_transects, 
                                      map_obj = region, 
                                      crs = 2154), "ggplot"))
  
  expect_true(inherits(plot_transects, "function")) 
})


test_that("test erreur plot_transects", {
  
  data(iris)
  data("dataset_map")
  data("dataset_transects")
  
  expect_error(object = plot_transects(transect_obj = iris, 
                                       map_obj = dataset_map, 
                                       crs = 2154))
  
  expect_error(object = plot_transects(transect_obj = dataset_transects, 
                                       map_obj = iris, 
                                       crs = 2154))
  
}) 
