# ---------------------- #
### --- add rivers --- ### 
### ---  1 ----------- ### 
# ---------------------- #

# date: 15.12.20 

# outsource add rivers from fix_flow_direction scripts so it does not have to be run every time.


# SETUP -------------------------------------------------------------------
pacman::p_load(sf, stringr, data.table)

DIR = list()
DIR$da = "01_data/"
DIR$rs = "02_r_scripts/"

# LOAD --------------------------------------------------------------------
dt_rivers = readRDS(file.path(DIR$da, "rivers.RDS"))

dt_rivers[, ecoserv_number := as.numeric(str_extract(string=ecoserv_id, pattern="[0-9].*"))]

source(file.path(DIR$rs, "f_02_add_river.R"))

# add rivers  -------------------------------------------------------------

dt_rivers = add_river(from_line = "rlp_148", to_line = "rlp_10105",
                      from_point = "P42", to_point = "P44"
)
dt_rivers = add_river(from_line = "rlp_54", to_line = "swd_68189",
                      from_point = "P26", to_point = "P104120"
)
dt_rivers = add_river(from_line = "rlp_188", to_line = "rlp_9913",
                      from_point = "P52", to_point = "P2183"
)
dt_rivers = add_river(from_line = "rlp_10145", to_line = "rlp_201",
                      from_point = "P2648", to_point = "P61"
)
dt_rivers = add_river(from_line = "rlp_201", to_line = "rlp_202",
                      from_point = "P62", to_point = "P54"
)
dt_rivers = add_river(from_line = "rlp_202", to_line = "swd_68185",
                      from_point = "P64", to_point = "P104112"
)
dt_rivers = add_river(from_line = "rlp_192", to_line = "rlp_191",
                      from_point = "p_add_01", to_point = "P55"
)
dt_rivers = add_river(from_line = "rlp_10403", to_line = "swd_68158",
                      from_point = "P3160", to_point = "P104058"
)
dt_rivers = add_river(from_line = "rlp_373", to_line = "swd_68162",
                      from_point = "P128", to_point = "P104066"
)
dt_rivers = add_river(from_line = "rlp_10594", to_line = "swd_68142",
                      from_point = "P3546", to_point = "P103151"
)
dt_rivers = add_river(from_line = "rlp_727", to_line = "rlp_728",
                      from_point = "P226", to_point = "P228"
)
dt_rivers = add_river(from_line = "rlp_11219", to_line = "rlp_11220",
                      from_point = "P4796", to_point = "P4782"
)
dt_rivers = add_river(from_line = "rlp_3128", to_line = "rlp_12726",
                      from_point = "P746", to_point = "P4678"
)
dt_rivers = add_river(from_line = "rlp_14384", to_line = "rlp_14385",
                      from_point = "P11126", to_point = "P10962"
)
dt_rivers = add_river(from_line = "rlp_6696", to_line = "rlp_15803",
                      from_point = "P1724", to_point = "P8940"
)
dt_rivers = add_river(from_line = "rlp_782", to_line = "swd_68123",
                      from_point = "P244", to_point = "P103988"
)
dt_rivers = add_river(from_line = "swd_68100", to_line = "rlp_10994",
                      from_point = "P244", to_point = "P4344"
)
dt_rivers = add_river(from_line = "rlp_16917", to_line = "swd_68110",
                      from_point = "P16192", to_point = "P103962"
)
dt_rivers = add_river(from_line = "rlp_936", to_line = "swd_68108",
                      from_point = "P293", to_point = "P42163"
)
dt_rivers = add_river(from_line = "vdn_8246", to_line = "sar_4880",
                      from_point = "P30382", to_point = "P120878"
)
dt_rivers = add_river(from_line = "sar_1918", to_line = "sar_4880",
                      from_point = "P116043", to_point = "P120878"
)
dt_rivers = add_river(from_line = "sar_4873", to_line = "rlp_3787",
                      from_point = "P120863", to_point = "P961"
)
dt_rivers = add_river(from_line = "vdn_7769", to_line = "sar_5556",
                      from_point = "P18244", to_point = "P122230"
)
dt_rivers = add_river(from_line = "sar_5482", to_line = "rlp_7990",
                      from_point = "P122081", to_point = "P2163"
)
dt_rivers = add_river(from_line = "rlp_5003", to_line = "rlp_14273",
                      from_point = "P1352", to_point = "P10050"
)
dt_rivers = add_river(from_line = "rlp_11198", to_line = "rlp_11199",
                      from_point = "P4754", to_point = "P404"
)
dt_rivers = add_river(from_line = "rlp_14942", to_line = "rlp_14943",
                      from_point = "P12242", to_point = "P11990"
)
dt_rivers = add_river(from_line = "vdn_8099", to_line = "swd_68224",
                      from_point = "P27234", to_point = "P104190"
)
dt_rivers = add_river(from_line = "vdn_7437", to_line = "swd_68204",
                      from_point = "P27204", to_point = "P96301"
)
dt_rivers = add_river(from_line = "vdn_6192", to_line = "swd_68221",
                      from_point = "P25166", to_point = "P55667"
)
dt_rivers = add_river(from_line = "vdn_5689", to_line = "swd_68227",
                      from_point = "P25268", to_point = "P91393"
)
dt_rivers = add_river(from_line = "vdn_7412", to_line = "swd_68196",
                      from_point = "P27208", to_point = "P35769"
)
dt_rivers = add_river(from_line = "rlp_3809", to_line = "rlp_13310",
                      from_point = "P970", to_point = "P8976"
)
dt_rivers = add_river(from_line = "rlp_3812", to_line = "rlp_13312",
                      from_point = "P972", to_point = "P8980"
)
dt_rivers = add_river(from_line = "rlp_3814", to_line = "rlp_13313",
                      from_point = "P974", to_point = "P8982"
)
dt_rivers = add_river(from_line = "rlp_3826", to_line = "rlp_13321",
                      from_point = "P982", to_point = "P8998"
)
dt_rivers = add_river(from_line = "rlp_13316", to_line = "rlp_13317",
                      from_point = "P8990", to_point = "P8984"
)
dt_rivers = add_river(from_line = "rlp_13327", to_line = "rlp_13328",
                      from_point = "P9012", to_point = "P9006"
)
dt_rivers = add_river(from_line = "rlp_13651", to_line = "rlp_13652",
                      from_point = "P9660", to_point = "P9650"
)
dt_rivers = add_river(from_line = "rlp_13656", to_line = "rlp_13657",
                      from_point = "P9670", to_point = "P9664"
)
dt_rivers = add_river(from_line = "rlp_13706", to_line = "rlp_13707",
                      from_point = "P1181", to_point = "P9684"
)
dt_rivers = add_river(from_line = "rlp_13807", to_line = "rlp_13808",
                      from_point = "P9972", to_point = "P9780"
)
dt_rivers = add_river(from_line = "rlp_13811", to_line = "rlp_13812",
                      from_point = "P9980", to_point = "P9974"
)
dt_rivers = add_river(from_line = "rlp_13822", to_line = "rlp_13823",
                      from_point = "P10002", to_point = "P9996"
)
dt_rivers = add_river(from_line = "rlp_13834", to_line = "rlp_13835",
                      from_point = "P10026", to_point = "P10012"
)
dt_rivers = add_river(from_line = "rlp_3786", to_line = "rlp_16953",
                      from_point = "P960", to_point = "P962"
)
dt_rivers = add_river(from_line = "rlp_3796", to_line = "rlp_16954",
                      from_point = "P964", to_point = "P8958"
)
dt_rivers = add_river(from_line = "rlp_3820", to_line = "rlp_13318",
                      from_point = "P976", to_point = "P8992"
)
dt_rivers = add_river(from_line = "rlp_3822", to_line = "rlp_13319",
                      from_point = "P978", to_point = "P8994"
)
dt_rivers = add_river(from_line = "rlp_3824", to_line = "rlp_13320",
                      from_point = "P980", to_point = "P8996"
)
dt_rivers = add_river(from_line = "rlp_3829", to_line = "rlp_13323",
                      from_point = "P984", to_point = "P9002"
)
dt_rivers = add_river(from_line = "rlp_3831", to_line = "rlp_13324",
                      from_point = "P986", to_point = "P9004"
)
dt_rivers = add_river(from_line = "rlp_3837", to_line = "rlp_13329",
                      from_point = "P988", to_point = "P9014"
)
dt_rivers = add_river(from_line = "rlp_3839", to_line = "rlp_13330",
                      from_point = "P990", to_point = "P9016"
)
dt_rivers = add_river(from_line = "rlp_3841", to_line = "rlp_13331",
                      from_point = "P992", to_point = "P9018"
)
dt_rivers = add_river(from_line = "rlp_3843", to_line = "rlp_13332",
                      from_point = "P994", to_point = "P9020"
)
dt_rivers = add_river(from_line = "rlp_4103", to_line = "rlp_13520",
                      from_point = "P1148", to_point = "P9396"
)
dt_rivers = add_river(from_line = "rlp_4224", to_line = "rlp_13640",
                      from_point = "P1154", to_point = "P9636"
)
dt_rivers = add_river(from_line = "rlp_4226", to_line = "rlp_13641",
                      from_point = "P1156", to_point = "P9638"
)
dt_rivers = add_river(from_line = "rlp_4228", to_line = "rlp_13642",
                      from_point = "P1158", to_point = "P9640"
)
dt_rivers = add_river(from_line = "rlp_4231", to_line = "rlp_13644",
                      from_point = "P1160", to_point = "P9644"
)
dt_rivers = add_river(from_line = "rlp_4234", to_line = "rlp_13646",
                      from_point = "P1162", to_point = "P9648"
)
dt_rivers = add_river(from_line = "rlp_4247", to_line = "rlp_13658",
                      from_point = "P1164", to_point = "P9672"
)
dt_rivers = add_river(from_line = "rlp_4249", to_line = "rlp_13659",
                      from_point = "P1166", to_point = "P9674"
)
dt_rivers = add_river(from_line = "rlp_4251", to_line = "rlp_13660",
                      from_point = "P1168", to_point = "P9676"
)
dt_rivers = add_river(from_line = "rlp_4253", to_line = "rlp_13661",
                      from_point = "P1170", to_point = "P9678"
)
dt_rivers = add_river(from_line = "rlp_4255", to_line = "rlp_13662",
                      from_point = "P1172", to_point = "P9680"
)
dt_rivers = add_river(from_line = "rlp_4257", to_line = "rlp_13663",
                      from_point = "P1174", to_point = "P9682"
)
dt_rivers = add_river(from_line = "rlp_4277", to_line = "rlp_13681",
                      from_point = "P1180", to_point = "P1178"
)
dt_rivers = add_river(from_line = "rlp_4305", to_line = "rlp_13708",
                      from_point = "P1184", to_point = "P9772"
)
dt_rivers = add_river(from_line = "rlp_4307", to_line = "rlp_13709",
                      from_point = "P1186", to_point = "P9774"
)
dt_rivers = add_river(from_line = "rlp_4310", to_line = "rlp_13711",
                      from_point = "P1188", to_point = "P9778"
)
dt_rivers = add_river(from_line = "rlp_4333", to_line = "rlp_13732",
                      from_point = "P1192", to_point = "P9820"
)
dt_rivers = add_river(from_line = "rlp_4335", to_line = "rlp_13733",
                      from_point = "P1194", to_point = "P9822"
)
dt_rivers = add_river(from_line = "rlp_4355", to_line = "rlp_13753",
                      from_point = "P1196", to_point = "P9862"
)
dt_rivers = add_river(from_line = "rlp_4416", to_line = "rlp_4417",
                      from_point = "P1198", to_point = "P1199"
)
dt_rivers = add_river(from_line = "rlp_4417", to_line = "rlp_13813",
                      from_point = "P1200", to_point = "P9398"
)
dt_rivers = add_river(from_line = "rlp_4419", to_line = "rlp_13814",
                      from_point = "P1202", to_point = "P9984"
)
dt_rivers = add_river(from_line = "rlp_4422", to_line = "rlp_13816",
                      from_point = "P1204", to_point = "P9988"
)
dt_rivers = add_river(from_line = "rlp_4424", to_line = "rlp_13817",
                      from_point = "P1206", to_point = "P9990"
)
dt_rivers = add_river(from_line = "rlp_4433", to_line = "rlp_13824",
                      from_point = "P1210", to_point = "P10004"
)
dt_rivers = add_river(from_line = "rlp_4436", to_line = "rlp_13826",
                      from_point = "P1212", to_point = "P10008"
)
dt_rivers = add_river(from_line = "rlp_4438", to_line = "rlp_13827",
                      from_point = "P1214", to_point = "P10010"
)
dt_rivers = add_river(from_line = "rlp_4448", to_line = "rlp_4449",
                      from_point = "P1216", to_point = "P1217"
)
dt_rivers = add_river(from_line = "rlp_4449", to_line = "rlp_13836",
                      from_point = "P1218", to_point = "P9022"
)
dt_rivers = add_river(from_line = "swd_70880", to_line = "swd_522",
                      from_point = "P31297", to_point = "P30589"
)
dt_rivers = add_river(from_line = "swd_71595", to_line = "swd_71594",
                      from_point = "P80972", to_point = "P110930"
)
dt_rivers = add_river(from_line = "swd_522", to_line = "swd_70879",
                      from_point = "P30589", to_point = "P31295"
)
dt_rivers = add_river(from_line = "swd_70741", to_line = "swd_55150",
                      from_point = "P31293", to_point = "P78045"
)
dt_rivers = add_river(from_line = "swd_55150", to_line = "swd_70740",
                      from_point = "P78045", to_point = "P31291"
)
dt_rivers = add_river(from_line = "swd_70731", to_line = "swd_5402",
                      from_point = "P31289", to_point = "P30751"
)
dt_rivers = add_river(from_line = "swd_5402", to_line = "swd_5770",
                      from_point = "P30751", to_point = "P30765"
)
dt_rivers = add_river(from_line = "swd_5770", to_line = "swd_2109",
                      from_point = "P30765", to_point = "P30647"
)
dt_rivers = add_river(from_line = "swd_2109", to_line = "swd_9535",
                      from_point = "P30647", to_point = "P30901"
)
dt_rivers = add_river(from_line = "swd_9535", to_line = "swd_3827",
                      from_point = "P30901", to_point = "P30699"
)
dt_rivers = add_river(from_line = "swd_3827", to_line = "swd_5981",
                      from_point = "P30699", to_point = "P30774"
)
#dt_rivers = add_river(from_line = "swd_5981", to_line = "swd_5981",
#                      from_point = "P30774", to_point = "P30773"
#)
dt_rivers = add_river(from_line = "swd_5981", to_line = "swd_58907",
                      from_point = "P30773", to_point = "P85559"
)
dt_rivers = add_river(from_line = "swd_58907", to_line = "swd_62012",
                      from_point = "P85559", to_point = "P91769"
)
dt_rivers = add_river(from_line = "swd_62012", to_line = "swd_11015",
                      from_point = "P91769", to_point = "P30955"
)
dt_rivers = add_river(from_line = "swd_11015", to_line = "swd_17689",
                      from_point = "P30955", to_point = "P31205"
)
dt_rivers = add_river(from_line = "swd_17689", to_line = "swd_70730",
                      from_point = "P31205", to_point = "P31287"
)

# save to file ------------------------------------------------------------
saveRDS(dt_rivers, file.path(DIR$da, "rivers_w_added.RDS"))
