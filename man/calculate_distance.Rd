% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/calculate_distance.R
\name{calculate_distance}
\alias{calculate_distance}
\title{Calculate distance between transects and points}
\usage{
calculate_distance(obs_obj, transect_obj, crs)
}
\arguments{
\item{obs_obj}{dataframe. Individuals simulated with their coordinates.}

\item{transect_obj}{sf dataframe. Transect/segments data.}

\item{crs}{numeric. projection system.}
}
\value{
sf dataframe. Distances between individuals and associated transect/segment.
}
\description{
This function calculates the nearest transect/segment transect_obj for each simulated individual obs_obj. It returns an array with the name of the closest transect/segment for each individual and the distance in m and in km between them.
}
\examples{

data(dataset_obs)
data(dataset_segs)

dist <- calculate_distance(obs_obj = dataset_obs, 
                           transect_obj = dataset_segs, 
                           crs = 2154)

head(dist)
}
