library(shiny)
library(maps)
library(mapproj)
library(leaflet)
library(rgdal)
library(stringr)
library(sf)

minor_geom <- st_read("minor_geom.shp")
minor_df <- readRDS("minor_df.rds")
minor_df <- st_set_geometry(minor_df, value = minor_geom$geometry)
minor_nm <- readRDS("minor_nm.rds")


POB_geom <- st_read("POB_geom.shp")
POB_df <- readRDS("POB_df.rds")
POB_df <-  st_set_geometry(POB_df, value = POB_geom$geometry)
con_nm <-readRDS("con_nm.rds")

Google_template <- 
    "http://mt0.google.com/vt/lyrs=m&hl=en&x={x}&y={y}&z={z}&s=Ga"



ui <- fluidPage(
    titlePanel("Chloropleth of Visible Minorities and Places of Birth for the GTA Population"),
    
    sidebarLayout(
        sidebarPanel(
            helpText("Based on the 2016 census."), width = 4,
            helpText( "Due to the large amount of data, it will take about 10 seconds to load each map"),
          
          selectInput("var",
                      label = "Choose a Variable",
                      choices = c("Visible minority",
                                  "Place of birth"),
                      selected = "Visible minority"),
          
          conditionalPanel(condition = "input.var == 'Visible minority'",
            selectInput("subset", 
                        label = "Choose a minority",
                        choices = minor_nm,
                        selected = "South Asian")),
            
            conditionalPanel(condition = "input.var == 'Place of birth for immigrant population'",
                             selectInput("subset", 
                                         label = "Choose a country",
                                         choices = con_nm,
                                         selected = "United States")),
            helpText( "Click on dissimination area to get percentage and geocode")

        ),
        
        mainPanel(leafletOutput("map"), width = 12
)
    )
)


server <- function(input, output){

      output$map <- renderLeaflet({
      
        
        data < switch(input$var,
                      "Visible minority" = minor_df,
                      "Place of birth" = POB_df)
          
         mino <- input$data$sub 
                        
                 # "South Asian" = data$SthsA,
                 # "Chinese"= data$Chins,
                 # "Black" = data$Black_1,
                 # "Filipino" = data$Filpn,
                 # "Latin American" = data$LtnAm,
                 # "Arab" = data$Arab,
                 # "Southeast Asian" = data$SthsA,
                 # "West Asian" = data$WstAs,
                 # "Korean" = data$Koren,
                 # "Japanese" = data$Japns)
         
         name <- switch(input$var, 
                        "South Asian" = "South Asians",
                        "Chinese" = "Chinese",
                        "Black" = "Blacks",
                        "Filipino" = "Filipinos",
                        "Latin American" = "Latin Americans",
                        "Arab" = "Arabs",
                        "Southeast Asian" = "Southeast Asians",
                        "West Asian" = "West Asians",
                        "Korean" = "Koreans",
                        "Japanese" = "Japanese")
          
          pal <- colorNumeric(
              palette = "Reds",
              domain = mino)
          
          withProgress(message = 'Making plot', value = 1, {
          
        mymap(data, sub)
                     
          
        })
      })
    
}
# Run app ----
shinyApp(ui, server)
