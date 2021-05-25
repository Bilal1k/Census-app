library(sf)

geom <- st_read("Cal_CT_geom.shp")

minor_df <- readRDS("minor_df_Cal.rds")
minor_nm <- readRDS("minor_nm_Cal.rds")

POB_df <- readRDS("POB_df_Cal.rds")
con_nm <- readRDS("con_nm_Cal.rds")

POB_df_rec <- readRDS("POB_df_Cal_rec.rds")
con_nm_rec <- readRDS("con_nm_Cal_rec.rds")

lang_df <- readRDS("lang_df_Cal.rds")
lang_nm <- readRDS("lang_nm_Cal.rds")

ethn_df <- readRDS("ethn_df_Cal.rds")
ethn_nm <- readRDS("ethn_nm_Cal.rds")

