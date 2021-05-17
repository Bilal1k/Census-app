library(shiny)
library(maps)
library(mapproj)
library(leaflet)
library(rgdal)
library(stringr)
library(sf)

data <- st_read("minority.shp")

minority <- c("South Asian", "Chinese", "Black", "Filipino", "Latin American",
              "Arab","Southeast Asian", "West Asian","Korean","Japanese")

Google_template <- 
    "http://mt0.google.com/vt/lyrs=m&hl=en&x={x}&y={y}&z={z}&s=Ga"



# User interface ----
ui <- fluidPage(
    titlePanel("Chloropleth of Visible Minorities in the GTA"),
    
    sidebarLayout(
        sidebarPanel(
            helpText("Based on the 2016 census."), width = 4,
            helpText( "Due to the large amount of data, it will take about 10 seconds to load each map", size),
            
            selectInput("var", 
                        label = "Choose a variable to display",
                        choices = minority,
                        selected = "South Asian")
            
        ),
        
        mainPanel(leafletOutput("map"), width = 12
)
    )
)

# Server logic ----
server <- function(input, output){

      output$map <- renderLeaflet({
          
         mino <- switch(input$var, 
                 "South Asian" = data$SthsA,
                 "Chinese"= data$Chins,
                 "Black" = data$Black_1,
                 "Filipino" = data$Filpn,
                 "Latin American" = data$LtnAm,
                 "Arab" = data$Arab,
                 "Southeast Asian" = data$SthsA,
                 "West Asian" = data$WstAs,
                 "Korean" = data$Koren,
                 "Japanese" = data$Japns)
         
          
          pal <- colorNumeric(
              palette = "Reds",
              domain = mino)
          
          withProgress(message = 'Making plot', value = 1, {
          
          leaflet(data = data, options = leafletOptions(minZoom = 9, maxZoom = 18)) %>%
              # sets map center view and zoom level;
              setView(-79.3832, 43.6532,12) %>%
              
              # Choose map type
              addTiles(urlTemplate = Google_template, attribution = 'Google') %>%
              
             # add polygons and legend
             addPolygons(opacity = 0.3, weight = 0.3, fillOpacity = 0.6, color = "Gray", fillColor = ~pal(mino),
             popup = str_c(as.character(mino), data$GeUID, sep = "% - DA: ")
      ) %>%
          addLegend("bottomright", pal = pal, values = ~mino,
                    title = paste("Percentage of residents"),
                    opacity = 0.6)
                     
          
        })
      })
    
}
# Run app ----
shinyApp(ui, server)
