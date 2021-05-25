library(sf)

geom <- st_read("GTA_CT_geom.shp")

minor_df <- readRDS("minor_df.rds")
minor_nm <- readRDS("minor_nm.rds")

POB_df <- readRDS("POB_df.rds")
con_nm <- readRDS("con_nm.rds")

POB_df_rec <- readRDS("POB_df_rec.rds")
con_nm_rec <- readRDS("con_nm_rec.rds")

lang_df <- readRDS("lang_df.rds")
lang_nm <- readRDS("lang_nm.rds")

ethn_df <- readRDS("ethn_df.rds")
ethn_nm <- readRDS("ethn_nm.rds")