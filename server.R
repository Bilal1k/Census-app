library(shiny)
library(leaflet)
library(rgdal)
library(stringr)
library(sf)

source("leaflet.R")

server <- function(input, output){
  observeEvent(input$i, {
    showNotification("Chloropleth of Demographic Data for Major CMAs based on the 2016 census. 
                   Recent immigrant refers to a person who obtained a
                   landed immigrant or permanent resident status up to five
                     years prior to a given census year. Click on map to get 
                    percentage and Census Tract (CT) Geocode" ,
                     type = "message")}
  )
  
  dat <- reactive({switch(input$CMA,
                          "Toronto" = source("GTA.R"),
                          "Montréal" = source("Montreal.R"))
  })
  

observeEvent(dat(),{
  switch(input$var,
                "Visible minority" =
                   updateSelectInput(inputId = "minor", choices = minor_nm),

                "Immigrants places of birth" = 
                    updateSelectInput(inputId = "pob", choices = pob_nm),

                "Recent immigrants places of birth" = 
                  updateSelectInput(inputId = "pob_rec", choices = pob_nm_rec),

                "Mother tongue" = 
                  updateSelectInput(inputId = "lang", choices = lang_nm_rec),
                
                "Ethnic origin" =  
                  updateSelectInput(inputId = "ethn", choices = ethn_nm_rec))
})
  
  observeEvent(dat(),{
  output$map <- renderLeaflet({
    
    df <-   switch(input$var,
                   "Visible minority" = minor_df,
                   "Immigrants places of birth" = POB_df,
                   "Recent immigrants places of birth" = POB_df_rec,
                   "Mother tongue" = lang_df,
                   "Ethnic origin" = ethn_df)
    
    
    sub <-  switch(input$var,
                   "Visible minority" = input$minor,
                   "Immigrants places of birth" = input$pob,
                   "Recent immigrants places of birth" = input$pob_rec,
                   "Mother tongue" = input$lang,
                   "Ethnic origin" = input$ethn)
    
    
    mymap(df,sub,geom)
    
  })
    
  })}