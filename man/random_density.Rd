% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/random_density.R
\name{random_density}
\alias{random_density}
\title{Create a random density}
\usage{
random_density(
  region_obj,
  grid_m,
  density_base,
  crs,
  amplitude,
  sigma,
  nb_simu
)
}
\arguments{
\item{region_obj}{region object. Region create with the dsims package.}

\item{grid_m}{numeric. Length of the grid (side length of a square in m).}

\item{density_base}{numeric. Density in each cell.}

\item{crs}{numeric. Coordinate system.}

\item{amplitude}{numeric. Minimal and maximal height of the hotspot at its center.}

\item{sigma}{numeric. Minimal and maximal value giving the scale parameter for a gaussian decay.}

\item{nb_simu}{numeric. Number of hotspot to be created.}
}
\value{
density object. The map with the densities for each cell.
}
\description{
The function \code{random_density} creates a random density in the study area \code{region_obj}. The random density consists of the creation of a number of hotspots \code{nb_simu} randomly generated \code{amplitude}, size (\code{sigma}) and location. The function retruns a \code{density} object.
}
\details{
For the creation of the baseline density (homogeneous density on the study area) to which this function add randomly hotspot on the study area, the \code{make.density} function of the \code{dsims} package is used. Then, baseline density \code{density_base} as well as the desired grid size to use on the study area \code{grid_m} are requested.
}
\examples{

library(dsims)

# Create the region object with the make.region function of the dsims package
shapefile.name <- system.file("extdata", "StAndrew.shp", package = "dssd")
region <- make.region(region.name = "St Andrews bay",
                      shape = shapefile.name,
                      units = "m")

# Create a random density on the study area (with a 500m square grid) with a baseline density of 10.
# 15 hotspots added with random amplitudes chosen between -5 and 5 
# and different sizes (`sigma`) chosen between 2000 and 6000.  

density <- random_density(region_obj = region,
                          grid_m = 500,
                          density_base = 10,
                          crs = 2154,
                          amplitude = c(-5, 5),
                          sigma = c(2000, 6000),
                          nb_simu = 15)

# plot(density)

}
