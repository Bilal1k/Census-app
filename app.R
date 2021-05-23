library(shiny)
library(maps)
library(mapproj)
library(leaflet)
library(rgdal)
library(stringr)
library(sf)
library(shinyalert)
library(wrapr)

source("leaflet.R")

minor_geom <- st_read("min_geom.shp")
minor_df <- readRDS("minor_df.rds")
minor_geom <- st_set_geometry(minor_df, value = minor_geom$geometry)
minor_nm <- readRDS("minor_nm.rds")


POB_geom <- st_read("POB_geom.shp")
POB_df <- readRDS("POB_df.rds")
POB_geom <- st_set_geometry(POB_df, value = POB_geom$geometry)
con_nm <- readRDS("con_nm.rds")

POB_geom_rec <- st_read("POB_geom_rec.shp")
POB_df_rec <- readRDS("POB_df_rec.rds")
POB_geom_rec <- st_set_geometry(POB_df_rec, value = POB_geom_rec$geometry)
con_nm_rec <- readRDS("con_nm_rec.rds")


ui <- fluidPage(

    titlePanel("Chloropleth of Census Data for the GTA Population"),
  
        sidebarPanel(width = 12,
        actionButton("i", "info"),
                     
                     
          selectInput("var",
                      label = "Choose a variable",
                      choices = c("Visible minority",
                                  "Immigrants places of birth",
                                  "Recent immigrants places of birth"),
                      selected = "Visible minority"),
          
          conditionalPanel(condition = "input.var == 'Visible minority'",
            selectInput("minor", 
                        label = "Choose a minority",
                        choices = minor_nm,
                       )),
            
          conditionalPanel(condition = "input.var == 'Immigrants places of birth'",
             selectInput("pob", 
                         label = "Choose a place",
                         choices = con_nm,
                         )),
        
        conditionalPanel(condition = "input.var == 'Recent immigrants places of birth'",
                         selectInput("pob_rec",
                                     label = "Choose a place",
                                     choices = con_nm_rec,
                         )),
        ),
        
        mainPanel(leafletOutput("map"), width = 12)
)
    


server <- function(input, output){
        observeEvent(input$i, {
          showNotification("Based on the 2016 census. 
                   Recent immigrant refers to a person who obtained a
                   landed immigrant or permanent resident status up to five
                     years prior to a given census year" , type = "message")}
        )
            
    
        output$map <- renderLeaflet({
       
          
        dat <-  switch(input$var,
                   "Visible minority" = minor_df,
                   "Immigrants places of birth" = POB_df,
                   "Recent immigrants places of birth" = POB_df_rec)
          
        geom <- switch(input$var,
                        "Visible minority" = minor_geom,
                        "Immigrants places of birth" = POB_geom,
                       "Recent immigrants places of birth" = POB_geom_rec
                       )
        
        sub <-  switch(input$var,
                       "Visible minority" = input$minor,
                       "Immigrants places of birth" = input$pob,
                       "Recent immigrants places of birth" = input$pob_rec)
        

        mymap(dat,sub,geom)
    
        })}

# Run app 
shinyApp(ui, server)


