library(leaflet)
library(rgdal)
library(stringr)
library(sf)

mymap <- function(df, sub, geom){

  Google_template <-
    "http://mt0.google.com/vt/lyrs=m&hl=en&x={x}&y={y}&z={z}&s=Ga"
  
  pal <- colorNumeric(
    palette = "Reds",
    domain = df[,sub])

  c <- st_bbox(geom)
  
  
  leaflet(data = geom, options = leafletOptions(minZoom = 8, maxZoom = 18)) %>%
    
    setMaxBounds(c[[1]],c[[2]],c[[3]],c[[4]]) %>%

    # Choose map type
    addTiles(urlTemplate = Google_template, attribution = 'Google, Bilal') %>%
    
    # add polygons and legend
    addPolygons(opacity = 0.3, weight = 0.3, fillOpacity = 0.6, color = "Gray",
                fillColor = ~pal(df[,sub]),
                popup = str_c(as.character(df[,sub]),
                              df[,"GeoUID"],
                              sep = "% - CT: ")) %>%
    addLegend("bottomright", pal = pal, values = ~df[,sub],
              title = "Percentage", opacity = 0.3)
  
}

