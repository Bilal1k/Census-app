library(shiny)
library(maps)
library(mapproj)
library(leaflet)
library(rgdal)
library(stringr)
library(sf)

source("leaflet.R")

tags$style(type="text/css",
           ".shiny-output-error { visibility: hidden; }",
           ".shiny-output-error:before { visibility: hidden; }"
)

ui <- fluidPage(
  
        sidebarPanel(width = 3,
        actionButton("i", "info"),
                     
        selectInput("CMA",
                    label = "Choose a censes metro area",
                    choices = c("Toronto",
                                "Montréal")),
       
        
          selectInput("var",
                      label = "Choose a variable",
                      choices = c("Visible minority",
                                  "Immigrants places of birth",
                                  "Recent immigrants places of birth",
                                  "Mother tongue",
                                  "Ethnic origin")),
          
          conditionalPanel(condition = "input.var == 'Visible minority'",
            selectInput("minor", 
                        label = "Choose a minority",
                        choices = NULL
                       )),
            
          conditionalPanel(condition = "input.var == 'Immigrants places of birth'",
             selectInput("pob", 
                         label = "Choose a place",
                         choices = NULL
                         )),
        
        conditionalPanel(condition = "input.var == 'Recent immigrants places of birth'",
                         selectInput("pob_rec",
                                     label = "Choose a place",
                                     choices = NULL
                         )),
                                     
         conditionalPanel(condition = "input.var == 'Mother tongue'",
                          selectInput("lang",
                                      label = "Choose a language",
                                      choices = NULL                                 
                         )),
        conditionalPanel(condition = "input.var == 'Ethnic origin'",
                         selectInput("ethn",
                                     label = "Choose an ethnic origin",
                                     choices = NULL                                    
                         ))
        ),
        
        tags$style(type="text/css",
                   ".shiny-output-error { visibility: hidden; }",
                   ".shiny-output-error:before { visibility: hidden; }"
        ),
        
        mainPanel(leafletOutput("map"), width = 9),
    
)
    


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
    
    
        })}

# Run app 
shinyApp(ui, server)


