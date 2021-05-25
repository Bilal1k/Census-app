library(sf)

geom <- st_read("Mont_CT_geom.shp")

minor_df <- readRDS("minor_df_mont.rds")
minor_nm <- readRDS("minor_nm_mont.rds")

POB_df <- readRDS("POB_df_mont.rds")
con_nm <- readRDS("con_nm.rds")

POB_df_rec <- readRDS("POB_df_mont_rec.rds")
con_nm_rec <- readRDS("con_nm_mont_rec.rds")

lang_df <- readRDS("lang_df_mont.rds")
lang_nm <- readRDS("lang_nm_mont.rds")

ethn_df <- readRDS("ethn_df_mont.rds")
ethn_nm <- readRDS("ethn_nm_mont.rds")
