library(shiny)
library(leaflet)

ui <- fluidPage(
  titlePanel("Demographic Maps of Major Metro Area in Canada"),
  
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