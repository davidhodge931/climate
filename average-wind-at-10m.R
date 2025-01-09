library(tidyverse)
library(raster)
library(stars)
library(leaflet)

source("leaf-basemap.R")

wgtn_tif <- fs::path("data", 
         "Mean-Daily-Wind-Speed-At-10m_mean_1991-2020_Annual_Wellington",
         "Mean-Daily-Wind-Speed-At-10m_mean_1991-2020_Annual_Wellington", 
         ext = "tif")

wgtn <- raster(wgtn_tif) 

horizons_tif <- fs::path("data", 
                 "Mean-Daily-Wind-Speed-At-10m_mean_1991-2020_Annual_Manawatu-Whanganui",
                 "Mean-Daily-Wind-Speed-At-10m_mean_1991-2020_Annual_Manawatu-Whanganui", 
                 ext = "tif")


horizons <- raster(horizons_tif) 

# pal <- colorBin("Spectral", domain = c(1, 10), bins = seq(1, 10, 1), reverse = TRUE)
# pal <- colorBin("Spectral", domain = c(1, 10), bins = seq(1, 10, 0.5), reverse = TRUE)


bins <- c(seq(0, 5, 1), 10)
# bins <- c(0, 14, 29, 39, 62, 89, Inf) / 3.6

pal <- colorBin(viridis::turbo(9), domain = c(0, 10), bins = bins, 
                reverse = TRUE, 
                na.color = "transparent")

opacity <- 0.5

leaf_basemap() |> 
  addRasterImage(x = wgtn, colors = pal, opacity = opacity) |> 
  addRasterImage(x = horizons, colors = pal, opacity = opacity) |> 
  addLegend(
    title = "Average daily\nwind speed\nm/s", 
    pal = pal, 
    values = c(0, 1000),
    opacity = opacity,
  ) |> 
  leaflet.extras::addSearchOSM() |> 
  addScaleBar(position = "bottomright")
  

