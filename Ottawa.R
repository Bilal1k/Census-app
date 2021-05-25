library(sf)

geom <- st_read("Ott_CT_geom.shp")

minor_df <- readRDS("minor_df_Ott.rds")
minor_nm <- readRDS("minor_nm_Ott.rds")

POB_df <- readRDS("POB_df_Ott.rds")
con_nm <- readRDS("con_nm_Ott.rds")

POB_df_rec <- readRDS("POB_df_Ott_rec.rds")
con_nm_rec <- readRDS("con_nm_Ott_rec.rds")

lang_df <- readRDS("lang_df_Ott.rds")
lang_nm <- readRDS("lang_nm_Ott.rds")

ethn_df <- readRDS("ethn_df_Ott.rds")
ethn_nm <- readRDS("ethn_nm_Ott.rds")

