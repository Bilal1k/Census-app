library(shiny)
library(leaflet)
library(rgdal)
library(stringr)
library(sf)

source("leaflet.R")
server <- function(input, output){
  observeEvent(input$i,{
    showNotification(ui = tags$div(
      tags$p("Choropleth of demographic data for major census 
              metropolitan areas in Canada (Population over 900,000) 
              based on the 2016 census at the census tract (CT) level."), 
      tags$p("Recent immigrant refers to a person who obtained a
                   landed immigrant or permanent resident status up 
                   to five years prior to a given census year."), 
      tags$p("Click on map to get percentage and Census Tract 
             (CT) Geocode."),
      tags$p("Part of the data is based on a 25% sample.")),
                     type = "message", duration = 15)}
  )
  
  dat <- reactive({switch(input$CMA,
                "Toronto" = source("GTA.R"),
                "Montréal" = source("Montreal.R"),
                "Vancouver" = source("Vancouver.R"),
                "Calgary" = source("Calgary.R"),
                "Ottawa - Gatineau" = source("Ottawa.R"),
                "Edmonton" = source("Edmonton.R"))
  })
  
  observeEvent(dat(),priority = 100,{
    choices <- minor_nm
    updateSelectInput(inputId = "minor", choices = choices)
  })
  
  observeEvent(dat(),{
    choices <- con_nm
    updateSelectInput(inputId = "pob", choices = choices)
  })
  
  observeEvent(dat(),{
    choices <- con_nm_rec
    updateSelectInput(inputId = "pob_rec", choices = choices)
  })
  
  observeEvent(dat(),{
    choices <- lang_nm
    updateSelectInput(inputId = "lang", choices = choices)
  })
  
  observeEvent(dat(),{
    choices <- ethn_nm
    updateSelectInput(inputId = "ethn", choices = choices)
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