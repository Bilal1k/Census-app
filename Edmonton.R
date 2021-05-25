library(sf)

geom <- st_read("Edm_CT_geom.shp")

minor_df <- readRDS("minor_df_Edm.rds")
minor_nm <- readRDS("minor_nm_Edm.rds")

POB_df <- readRDS("POB_df_Edm.rds")
con_nm <- readRDS("con_nm_Edm.rds")

POB_df_rec <- readRDS("POB_df_Edm_rec.rds")
con_nm_rec <- readRDS("con_nm_Edm_rec.rds")

lang_df <- readRDS("lang_df_Edm.rds")
lang_nm <- readRDS("lang_nm_Edm.rds")

ethn_df <- readRDS("ethn_df_Edm.rds")
ethn_nm <- readRDS("ethn_nm_Edm.rds")

