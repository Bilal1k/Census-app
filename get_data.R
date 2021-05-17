library(sf)
library(cancensus)
library(tidyverse)
library(geojsonsf)
library(shinyjs)
library(readr)


options(cancensus.api_key = "your API here")

# List regions
regions <- list_census_regions('CA16')

# Filter major metro areas
CMAs <- regions$name[regions$level == "CMA" &
                    regions$pop > 900000]

# get geocodes for CMAs
CMA_codes <- regions$region[regions$name %in% CMAs &
                            regions$level == "CMA"]

# get GTA code
GTA <- regions$region[regions$name == "Toronto"  &
                        regions$level == "CMA"]
                           

# List census vector "col names"
vec <- list_census_vectors("CA16")

# Choose relevant vector names
vec_mother_tongue <- 
  vec$vector[str_detect(vec$details,
            pattern =  "Mother tongue for the total population excluding institutional residents -
            100% data; Single responses; Non-official languages; Non-Aboriginal") & 
        vec$type == "Total" & !is.na(vec$vector)]

vec_POB <- vec$vector[str_detect(vec$details,
                                                pattern =  "Selected places of birth") & 
                                    vec$type == "Total" & !is.na(vec$vector)]

vec_vis_minor <- vec$vector[str_detect(vec$details,
                                        pattern =  "Visible minority") & 
                               vec$type == "Total" & !is.na(vec$vector)]

vec_ethnic <- vec$vector[str_detect(vec$details,
                                              pattern =  "Ethnic origin") & 
                                     vec$type == "Total" & !is.na(vec$vector)]


# pull data from census "for now, only pull visible minority data in the GTA"
vis_minor_data <- get_census(dataset='CA16', regions=list(CMA=GTA),
                          vectors = c(vec_vis_minor),
                          level="DA", use_cache = TRUE, geo_format = "sf")


# list of minority names
minority <- c("South Asian", "Chinese", "Black", "Filipino", "Latin American",
          "Arab","Southeast Asian", "West Asian","Korean","Japanese") 

# Loop to calculate percentage of minority per DA and remove NA
for (i in minority){
    new <- round(st_drop_geometry(vis_minor_data[,str_detect(names(vis_minor_data), pattern = i)])
                 /vis_minor_data$Population * 100, digits = 2)                                    
    vis_minor_data[ , ncol(vis_minor_data) + 1] <- new                
    colnames(vis_minor_data)[ncol(vis_minor_data)] <- paste0(i)
    vis_minor_data[,i][is.na(vis_minor_data[,i])] <- 0
}

# Get all relavent data from census "doesn't work due to API daily and monthly limits"
# data <- get_census(dataset='CA16', regions=list(CMA=CMA_codes),
                             #vectors = c(vec_vis_minor,vec_POB,vec_ethnic,vec_mother_tongue),
                            # level="DA", use_cache = TRUE, geo_format = "sf")

# Google maps template
Google_template <- "http://mt0.google.com/vt/lyrs=m&hl=en&x={x}&y={y}&z={z}&s=Ga"

# color pallete
pal <- colorNumeric(
  palette = "Blues",
  domain = data$subset)

# save spatial features to H.D.D as shape file, avoid pulling data multiple times, col names will change due to shape file name length and capitalization rules
st_write(vis_minor_data, "minority.shp")



