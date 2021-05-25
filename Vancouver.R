library(sf)

geom <- st_read("Van_CT_geom.shp")

minor_df <- readRDS("minor_df_Van.rds")
minor_nm <- readRDS("minor_nm_Van.rds")

POB_df <- readRDS("POB_df_Van.rds")
con_nm <- readRDS("con_nm_Van.rds")

POB_df_rec <- readRDS("POB_df_Van_rec.rds")
con_nm_rec <- readRDS("con_nm_Van_rec.rds")

lang_df <- readRDS("lang_df_Van.rds")
lang_nm <- readRDS("lang_nm_Van.rds")

ethn_df <- readRDS("ethn_df_Van.rds")
ethn_nm <- readRDS("ethn_nm_Van.rds")
