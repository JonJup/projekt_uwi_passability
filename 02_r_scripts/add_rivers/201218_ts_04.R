# ---------------------- #
### --- add rivers --- ### 
### ---  4 ----------- ### 
# ---------------------- #

# date: 18.12.20 

# outsource add rivers from fix_flow_direction scripts so it does not have to be run every time.


# SETUP -------------------------------------------------------------------
pacman::p_load(sf, stringr, data.table, googledrive)

DIR = list()
DIR$da = "01_data/"
DIR$rs = "02_r_scripts/"

# LOAD --------------------------------------------------------------------
drive_find(n_max = 30)
#drive_download(file = "Projekt Uwi Passierbarkeit/rivers_w_added.RDS", overwrite = TRUE, path = file.path(DIR$da, "rivers_w_added.RDS"))
dt_rivers = readRDS(file.path(DIR$da, "rivers_w_added.RDS"))

dt_rivers[, ecoserv_number := as.numeric(str_extract(string=ecoserv_id, pattern="[0-9].*"))]

source(file.path(DIR$rs, "f_02_add_river.R"))


# ADD ---------------------------------------------------------------------

dt_rivers = add_river(from_line = "rlp_14272", to_line = "rlp_5003",
                      from_point = "P10902", to_point = "P1351"
)
dt_rivers = add_river(from_line = "rlp_14263", to_line = "rlp_14264",
                      from_point = "P10884", to_point = "P10878"
)
dt_rivers = add_river(from_line = "rlp_4990", to_line = "rlp_14260",
                      from_point = "P1350", to_point = "P10876"
)
dt_rivers = add_river(from_line = "rlp_4989", to_line = "rlp_4990",
                      from_point = "P1348", to_point = "P1346"
)
dt_rivers = add_river(from_line = "rlp_14241", to_line = "rlp_4988",
                      from_point = "P10840", to_point = "P1345"
)
dt_rivers = add_river(from_line = "rlp_4969", to_line = "rlp_14242",
                      from_point = "P1342", to_point = "P10840"
)
dt_rivers = add_river(from_line = "rlp_14257", to_line = "rlp_14258",
                      from_point = "P10872", to_point = "P10848"
)
dt_rivers = add_river(from_line = "rlp_4973", to_line = "rlp_14245",
                      from_point = "P1344", to_point = "P10846"
)
dt_rivers = add_river(from_line = "rlp_4966", to_line = "rlp_4967",
                      from_point = "P1338", to_point = "P1339"
)
dt_rivers = add_river(from_line = "rlp_4967", to_line = "rlp_14241",
                      from_point = "P1340", to_point = "P10828"
)
dt_rivers = add_river(from_line = "rlp_14234", to_line = "rlp_14235",
                      from_point = "P10826", to_point = "P10820"
)
dt_rivers = add_river(from_line = "rlp_4952", to_line = "rlp_14228",
                      from_point = "P1336", to_point = "P1334"
)
dt_rivers = add_river(from_line = "rlp_14229", to_line = "rlp_14231",
                      from_point = "P10816", to_point = "P10818"
)
dt_rivers = add_river(from_line = "sar_1692", to_line = "rlp_4938",
                      from_point = "P115741", to_point = "P1331"
)
dt_rivers = add_river(from_line = "rlp_4931", to_line = "rlp_14215",
                      from_point = "P1330", to_point = "P10786"
)
dt_rivers = add_river(from_line = "rlp_14213", to_line = "rlp_14214",
                      from_point = "P10784", to_point = "P10774"
)
dt_rivers = add_river(from_line = "rlp_4923", to_line = "rlp_14208",
                      from_point = "P1328", to_point = "P10772"
)
dt_rivers = add_river(from_line = "rlp_4920", to_line = "rlp_16959",
                      from_point = "P1326", to_point = "P10770"
)
dt_rivers = add_river(from_line = "rlp_4919", to_line = "rlp_4920",
                      from_point = "P1324", to_point = "P1325"
)
dt_rivers = add_river(from_line = "rlp_4917", to_line = "rlp_14205",
                      from_point = "P1322", to_point = "P1320"
)
dt_rivers = add_river(from_line = "sar_3652", to_line = "rlp_4916",
                      from_point = "P118427", to_point = "P1319"
)
dt_rivers = add_river(from_line = "rlp_4914", to_line = "rlp_14204",
                      from_point = "P1318", to_point = "P10764"
)
dt_rivers = add_river(from_line = "sar_7233", to_line = "rlp_14203",
                      from_point = "P125583", to_point = "P2164"
)
dt_rivers = add_river(from_line = "rlp_5005", to_line = "rlp_14274",
                      from_point = "P1354", to_point = "P10904"
)
dt_rivers = add_river(from_line = "rlp_5007", to_line = "rlp_14275",
                      from_point = "P1356", to_point = "P10906"
)
dt_rivers = add_river(from_line = "rlp_5009", to_line = "rlp_14276",
                      from_point = "P1358", to_point = "P10908"
)
dt_rivers = add_river(from_line = "rlp_5012", to_line = "rlp_14278",
                      from_point = "P1360", to_point = "P10912"
)
dt_rivers = add_river(from_line = "rlp_14285", to_line = "rlp_14286",
                      from_point = "P10928", to_point = "P10914"
)
dt_rivers = add_river(from_line = "rlp_14289", to_line = "rlp_14290",
                      from_point = "P10936", to_point = "P10930"
)
dt_rivers = add_river(from_line = "rlp_5026", to_line = "rlp_14291",
                      from_point = "P1362", to_point = "P10938"
)
dt_rivers = add_river(from_line = "rlp_14298", to_line = "rlp_14299",
                      from_point = "P10954", to_point = "P10940"
)
dt_rivers = add_river(from_line = "rlp_5036", to_line = "rlp_14300",
                      from_point = "P1364", to_point = "P10956"
)
dt_rivers = add_river(from_line = "rlp_5038", to_line = "rlp_14301",
                      from_point = "P1366", to_point = "P10958"
)

# SAVE --------------------------------------------------------------------

saveRDS(dt_rivers, file.path(DIR$da, "fixed_w_added.RDS"))
drive_upload(media = file.path(DIR$da, "fixed_w_added.RDS"), 
            path = "Projekt Uwi Passierbarkeit/rivers_w_added.RDS", 
            overwrite = TRUE)
