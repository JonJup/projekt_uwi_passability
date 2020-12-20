# ---------------------- #
### --- add rivers --- ### 
### ---  4 ----------- ### 
# ---------------------- #

# date: 18.12.20 

# outsource add rivers from fix_flow_direction scripts so it does not have to be run every time.


# SETUP -------------------------------------------------------------------
pacman::p_load(sf, stringr, data.table, googledrive, dplyr, magrittr)

DIR = list()
DIR$da = "01_data/"
DIR$rs = "02_r_scripts"

# LOAD --------------------------------------------------------------------
# drive_find(n_max = 30)
#drive_download(file = "Projekt Uwi Passierbarkeit/rivers_w_added.RDS", overwrite = TRUE, path = file.path(DIR$da, "rivers_w_added.RDS"))
# muss 7
dt_rivers = readRDS(file.path(DIR$da, "rivers_w_added.RDS"))

dt_rivers[, ecoserv_number := as.numeric(str_extract(string=ecoserv_id, pattern="[0-9].*"))]

source(file.path(DIR$rs, "f_02_add_river.R"))


# ADD ---------------------------------------------------------------------

dt_rivers = add_river(from_line = "rlp_10508", to_line = "rlp_10509",
                      from_point = "P3374", to_point = "P_add_3374"
)

# SAVE --------------------------------------------------------------------

saveRDS(dt_rivers, file.path(DIR$da, "fixed_w_added.RDS"))
# drive_upload(media = file.path(DIR$da, "fixed_w_added.RDS"), 
#             path = "Projekt Uwi Passierbarkeit/rivers_w_added.RDS", 
#             overwrite = TRUE)
