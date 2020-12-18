# ---------------------- #
### --- add rivers --- ### 
### ---  3 ----------- ### 
# ---------------------- #

# date: 15.12.20 

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

dt_rivers = add_river(from_line = "rlp_4101", to_line = "rlp_13519",
                      from_point = "P1146", to_point = "P9394"
)
dt_rivers = add_river(from_line = "rlp_4099", to_line = "rlp_13518",
                      from_point = "P1144", to_point = "P9392"
)
dt_rivers = add_river(from_line = "rlp_4097", to_line = "rlp_13517",
                      from_point = "P1142", to_point = "P9390"
)
dt_rivers = add_river(from_line = "rlp_4092", to_line = "rlp_13516",
                      from_point = "P1134", to_point = "P9388"
)
dt_rivers = add_river(from_line = "rlp_4095", to_line = "rlp_13516",
                      from_point = "P1140", to_point = "P9388"
)
dt_rivers = add_river(from_line = "rlp_4094", to_line = "rlp_4095",
                      from_point = "P1138", to_point = "P1136"
)
dt_rivers = add_river(from_line = "rlp_13514", to_line = "rlp_13515",
                      from_point = "P9386", to_point = "P9380"
)
dt_rivers = add_river(from_line = "rlp_13510", to_line = "rlp_13511",
                      from_point = "P9378", to_point = "P9372"
)
dt_rivers = add_river(from_line = "rlp_4081", to_line = "rlp_13506",
                      from_point = "P1132", to_point = "P9368"
)
dt_rivers = add_river(from_line = "rlp_4079", to_line = "rlp_13505",
                      from_point = "P1130", to_point = "P9366"
)
dt_rivers = add_river(from_line = "rlp_4077", to_line = "rlp_13504",
                      from_point = "P1128", to_point = "P9364"
)
dt_rivers = add_river(from_line = "rlp_13502", to_line = "rlp_13503",
                      from_point = "P9362", to_point = "P9322"
)
dt_rivers = add_river(from_line = "rlp_4052", to_line = "rlp_13482",
                      from_point = "P1122", to_point = "P9320"
)
dt_rivers = add_river(from_line = "rlp_4050", to_line = "rlp_13481",
                      from_point = "P1120", to_point = "P9024"
)
dt_rivers = add_river(from_line = "rlp_4049", to_line = "rlp_4050",
                      from_point = "P1118", to_point = "P1119"
)
dt_rivers = add_river(from_line = "rlp_13479", to_line = "rlp_13480",
                      from_point = "P9316", to_point = "P9310"
)
dt_rivers = add_river(from_line = "rlp_4043", to_line = "rlp_13476",
                      from_point = "P1116", to_point = "P9308"
)
dt_rivers = add_river(from_line = "rlp_4041", to_line = "rlp_13475",
                      from_point = "P1114", to_point = "P9306"
)
dt_rivers = add_river(from_line = "rlp_4039", to_line = "rlp_13474",
                      from_point = "P1112", to_point = "P9304"
)
dt_rivers = add_river(from_line = "rlp_4037", to_line = "rlp_13473",
                      from_point = "P1110", to_point = "P9302"
)
dt_rivers = add_river(from_line = "rlp_4035", to_line = "rlp_13472",
                      from_point = "P1108", to_point = "P9300"
)
dt_rivers = add_river(from_line = "rlp_4032", to_line = "rlp_13470",
                      from_point = "P1106", to_point = "P9296"
)
dt_rivers = add_river(from_line = "rlp_4030", to_line = "rlp_13469",
                      from_point = "P1104", to_point = "P9294"
)
dt_rivers = add_river(from_line = "rlp_4028", to_line = "rlp_13468",
                      from_point = "P1102", to_point = "P9292"
)
dt_rivers = add_river(from_line = "rlp_4025", to_line = "rlp_13466",
                      from_point = "P1100", to_point = "P9288"
)
dt_rivers = add_river(from_line = "rlp_4024", to_line = "rlp_13466",
                      from_point = "P1098", to_point = "P9288"
)
dt_rivers = add_river(from_line = "rlp_4022", to_line = "rlp_13465",
                      from_point = "P1096", to_point = "P9286"
)
dt_rivers = add_river(from_line = "rlp_4020", to_line = "rlp_13464",
                      from_point = "P1094", to_point = "P9284"
)
dt_rivers = add_river(from_line = "rlp_4018", to_line = "rlp_13463",
                      from_point = "P1092", to_point = "P9282"
)
dt_rivers = add_river(from_line = "rlp_4016", to_line = "rlp_13462",
                      from_point = "P1090", to_point = "P9280"
)
dt_rivers = add_river(from_line = "rlp_4014", to_line = "rlp_13461",
                      from_point = "P1088", to_point = "P9278"
)
dt_rivers = add_river(from_line = "rlp_4013", to_line = "rlp_13461",
                      from_point = "P1086", to_point = "P9278"
)
dt_rivers = add_river(from_line = "rlp_4011", to_line = "rlp_13460",
                      from_point = "P1084", to_point = "P9276"
)
dt_rivers = add_river(from_line = "rlp_4009", to_line = "rlp_13459",
                      from_point = "P1082", to_point = "P9274"
)
dt_rivers = add_river(from_line = "rlp_13457", to_line = "rlp_13458",
                      from_point = "P9272", to_point = "P9266"
)
dt_rivers = add_river(from_line = "rlp_4002", to_line = "rlp_13453",
                      from_point = "P1080", to_point = "P9260"
)
dt_rivers = add_river(from_line = "rlp_4001", to_line = "rlp_4002",
                      from_point = "P1078", to_point = "P1079"
)
dt_rivers = add_river(from_line = "rlp_3999", to_line = "rlp_13452",
                      from_point = "P1076", to_point = "P1074"
)
dt_rivers = add_river(from_line = "rlp_3996", to_line = "rlp_13451",
                      from_point = "P1072", to_point = "P9184"
)
dt_rivers = add_river(from_line = "rlp_3953", to_line = "rlp_13410",
                      from_point = "P1068", to_point = "P1066"
)
dt_rivers = add_river(from_line = "rlp_13412", to_line = "rlp_3957",
                      from_point = "P2175", to_point = "P1064"
)
dt_rivers = add_river(from_line = "rlp_3957", to_line = "rlp_13413",
                      from_point = "P1070", to_point = "P9176"
)
dt_rivers = add_river(from_line = "rlp_3949", to_line = "rlp_13409",
                      from_point = "P1062", to_point = "P9174"
)
dt_rivers = add_river(from_line = "rlp_3947", to_line = "rlp_13408",
                      from_point = "P1060", to_point = "P9172"
)
dt_rivers = add_river(from_line = "rlp_3945", to_line = "rlp_13407",
                      from_point = "P1058", to_point = "P9170"
)
dt_rivers = add_river(from_line = "rlp_3943", to_line = "rlp_13406",
                      from_point = "P1056", to_point = "P9168"
)
dt_rivers = add_river(from_line = "rlp_3941", to_line = "rlp_13405",
                      from_point = "P1054", to_point = "P9166"
)
dt_rivers = add_river(from_line = "rlp_3939", to_line = "rlp_13404",
                      from_point = "P1052", to_point = "P9164"
)
dt_rivers = add_river(from_line = "rlp_3937", to_line = "rlp_13403",
                      from_point = "P1050", to_point = "P9162"
)
dt_rivers = add_river(from_line = "rlp_3935", to_line = "rlp_13402",
                      from_point = "P1048", to_point = "P9160"
)
dt_rivers = add_river(from_line = "rlp_3933", to_line = "rlp_13401",
                      from_point = "P1046", to_point = "P9158"
)
dt_rivers = add_river(from_line = "rlp_3931", to_line = "rlp_13400",
                      from_point = "P1044", to_point = "P9156"
)
dt_rivers = add_river(from_line = "rlp_3929", to_line = "rlp_13399",
                      from_point = "P1042", to_point = "P9154"
)
dt_rivers = add_river(from_line = "rlp_3926", to_line = "rlp_13397",
                      from_point = "P1040", to_point = "P9150"
)
dt_rivers = add_river(from_line = "rlp_3924", to_line = "rlp_13396",
                      from_point = "P1038", to_point = "P9148"
)
dt_rivers = add_river(from_line = "rlp_13393", to_line = "rlp_13394",
                      from_point = "P9144", to_point = "P9138"
)
dt_rivers = add_river(from_line = "rlp_3917", to_line = "rlp_13390",
                      from_point = "P1036", to_point = "P9136"
)
dt_rivers = add_river(from_line = "rlp_3916", to_line = "rlp_3917",
                      from_point = "P1034", to_point = "P1032"
)
dt_rivers = add_river(from_line = "rlp_3912", to_line = "rlp_13388",
                      from_point = "P1030", to_point = "P9130"
)
dt_rivers = add_river(from_line = "rlp_3911", to_line = "rlp_3912",
                      from_point = "P1028", to_point = "P1029"
)
dt_rivers = add_river(from_line = "rlp_3909", to_line = "rlp_13387",
                      from_point = "P1026", to_point = "P1024"
)
dt_rivers = add_river(from_line = "rlp_3905", to_line = "rlp_13385",
                      from_point = "P1022", to_point = "P9126"
)
dt_rivers = add_river(from_line = "rlp_13382", to_line = "rlp_13383",
                      from_point = "P9122", to_point = "P9108"
)
dt_rivers = add_river(from_line = "rlp_3892", to_line = "rlp_13371",
                      from_point = "P1018", to_point = "P9098"
)
dt_rivers = add_river(from_line = "rlp_3879", to_line = "rlp_13359",
                      from_point = "P1016", to_point = "P9074"
)
dt_rivers = add_river(from_line = "rlp_3877", to_line = "rlp_13358",
                      from_point = "P1014", to_point = "P9072"
)
dt_rivers = add_river(from_line = "rlp_3874", to_line = "rlp_13356",
                      from_point = "P1012", to_point = "P9068"
)
dt_rivers = add_river(from_line = "rlp_3872", to_line = "rlp_13355",
                      from_point = "P1010", to_point = "P9066"
)
dt_rivers = add_river(from_line = "rlp_3870", to_line = "rlp_13354",
                      from_point = "P1008", to_point = "P9064"
)
dt_rivers = add_river(from_line = "rlp_3867", to_line = "rlp_16955",
                      from_point = "P1006", to_point = "P9062"
)
dt_rivers = add_river(from_line = "rlp_3858", to_line = "rlp_13342",
                      from_point = "P1004", to_point = "P9040"
)
dt_rivers = add_river(from_line = "rlp_3850", to_line = "rlp_13335",
                      from_point = "P1002", to_point = "P1000"
)
dt_rivers = add_river(from_line = "rlp_4451", to_line = "rlp_13837",
                      from_point = "P1220", to_point = "P10030"
)
dt_rivers = add_river(from_line = "rlp_4453", to_line = "rlp_13838",
                      from_point = "P1222", to_point = "P10032"
)
dt_rivers = add_river(from_line = "rlp_4461", to_line = "rlp_13845",
                      from_point = "P1223", to_point = "P10034"
)
dt_rivers = add_river(from_line = "rlp_4463", to_line = "rlp_13846",
                      from_point = "P1226", to_point = "P10048"
)

# SAVE --------------------------------------------------------------------

saveRDS(dt_rivers, file.path(DIR$da, "fixed_w_added.RDS"))
#drive_upload(media = file.path(DIR$da, "fixed_w_added.RDS"), 
#            path = "Projekt Uwi Passierbarkeit/rivers_w_added.RDS", 
#           overwrite = TRUE)
