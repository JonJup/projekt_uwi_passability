# ---------------------- #
### --- add rivers --- ### 
### ---  7 ----------- ### 
# ---------------------- #

# date: 15.1.21 

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

dt_rivers = add_river(from_line = "rlp_6232", to_line = "rlp_15390",
                      from_point = "P1614", to_point = "P12804"
)
dt_rivers = add_river(from_line = "rlp_6106", to_line = "rlp_15265",
                      from_point = "P1606", to_point = "P12886"
)
dt_rivers = add_river(from_line = "rlp_6083", to_line = "rlp_15244",
                      from_point = "P1600", to_point = "P1598"
)
dt_rivers = add_river(from_line = "rlp_6080", to_line = "rlp_15243",
                      from_point = "P1596", to_point = "P12842"
)
dt_rivers = add_river(from_line = "rlp_6224", to_line = "rlp_15383",
                      from_point = "P1612", to_point = "P13122"
)
dt_rivers = add_river(from_line = "rlp_6234", to_line = "rlp_15391",
                      from_point = "P1616", to_point = "P13138"
)
dt_rivers = add_river(from_line = "rlp_15394", to_line = "rlp_15395",
                      from_point = "P13146", to_point = "P13140"
)
dt_rivers = add_river(from_line = "rlp_6242", to_line = "rlp_15398",
                      from_point = "P1618", to_point = "P13152"
)
dt_rivers = add_river(from_line = "rlp_15418", to_line = "rlp_15419",
                      from_point = "P13194", to_point = "P13154"
)
dt_rivers = add_river(from_line = "rlp_6265", to_line = "rlp_15421",
                      from_point = "P1620", to_point = "P13198"
)
dt_rivers = add_river(from_line = "rlp_6268", to_line = "rlp_15423",
                      from_point = "P1622", to_point = "P13202"
)
dt_rivers = add_river(from_line = "rlp_6270", to_line = "rlp_15424",
                      from_point = "P1624", to_point = "P13204"
)
dt_rivers = add_river(from_line = "rlp_6272", to_line = "rlp_15425",
                      from_point = "P1626", to_point = "P13206"
)
dt_rivers = add_river(from_line = "rlp_15428", to_line = "rlp_15429",
                      from_point = "P13214", to_point = "P13208"
)
dt_rivers = add_river(from_line = "rlp_6279", to_line = "rlp_15431",
                      from_point = "P1628", to_point = "P13218"
)
dt_rivers = add_river(from_line = "rlp_6282", to_line = "rlp_15433",
                      from_point = "P1630", to_point = "P13222"
)
dt_rivers = add_river(from_line = "rlp_6284", to_line = "rlp_15434",
                      from_point = "P1632", to_point = "P13224"
)
dt_rivers = add_river(from_line = "rlp_6287", to_line = "rlp_15436",
                      from_point = "P1634", to_point = "P13228"
)
dt_rivers = add_river(from_line = "rlp_6320", to_line = "rlp_15464",
                      from_point = "P1644", to_point = "P13230"
)
dt_rivers = add_river(from_line = "rlp_6319", to_line = "rlp_6320",
                      from_point = "P1642", to_point = "P1643"
)
dt_rivers = add_river(from_line = "rlp_6312", to_line = "rlp_15458",
                      from_point = "P1640", to_point = "P13272"
)
dt_rivers = add_river(from_line = "rlp_6302", to_line = "rlp_15449",
                      from_point = "P1638", to_point = "P13254"
)
dt_rivers = add_river(from_line = "rlp_15447", to_line = "rlp_15448",
                      from_point = "P13252", to_point = "P13246"
)
dt_rivers = add_river(from_line = "rlp_6296", to_line = "rlp_15444",
                      from_point = "P1636", to_point = "P13244"
)
dt_rivers = add_river(from_line = "rlp_15469", to_line = "rlp_15470",
                      from_point = "P13296", to_point = "P13286"
)
dt_rivers = add_river(from_line = "rlp_6328", to_line = "rlp_15471",
                      from_point = "P1646", to_point = "P13298"
)
dt_rivers = add_river(from_line = "rlp_6330", to_line = "rlp_15472",
                      from_point = "P1648", to_point = "P13300"
)
dt_rivers = add_river(from_line = "rlp_6332", to_line = "rlp_15473",
                      from_point = "P1650", to_point = "P13302"
)
dt_rivers = add_river(from_line = "rlp_6334", to_line = "rlp_15474",
                      from_point = "P1652", to_point = "P13304"
)
dt_rivers = add_river(from_line = "rlp_6336", to_line = "rlp_15475",
                      from_point = "P1654", to_point = "P13306"
)
dt_rivers = add_river(from_line = "rlp_6338", to_line = "rlp_15476",
                      from_point = "P1656", to_point = "P13308"
)
dt_rivers = add_river(from_line = "rlp_6340", to_line = "rlp_15477",
                      from_point = "P1658", to_point = "P13310"
)
dt_rivers = add_river(from_line = "rlp_6342", to_line = "rlp_15490",
                      from_point = "P1660", to_point = "P13312"
)
dt_rivers = add_river(from_line = "rlp_6348", to_line = "rlp_15483",
                      from_point = "P1662", to_point = "P13322"
)
dt_rivers = add_river(from_line = "rlp_15489", to_line = "rlp_15490",
                      from_point = "P13336", to_point = "P13312"
)
dt_rivers = add_river(from_line = "rlp_15560", to_line = "rlp_15561",
                      from_point = "P13478", to_point = "P13338"
)
dt_rivers = add_river(from_line = "rlp_15554", to_line = "rlp_15555",
                      from_point = "P13466", to_point = "P13426"
)
dt_rivers = add_river(from_line = "rlp_6410", to_line = "rlp_15537",
                      from_point = "P1680", to_point = "P13430"
)
dt_rivers = add_river(from_line = "rlp_6408", to_line = "rlp_15536",
                      from_point = "P1678", to_point = "P13428"
)
dt_rivers = add_river(from_line = "rlp_6406", to_line = "rlp_15535",
                      from_point = "P1676", to_point = "P1674"
)
dt_rivers = add_river(from_line = "rlp_6403", to_line = "rlp_15534",
                      from_point = "P1672", to_point = "P13424"
)
dt_rivers = add_river(from_line = "rlp_15531", to_line = "rlp_15532",
                      from_point = "P13420", to_point = "P13378"
)
dt_rivers = add_river(from_line = "rlp_15507", to_line = "rlp_15508",
                      from_point = "P13372", to_point = "P13366"
)
dt_rivers = add_river(from_line = "rlp_6372", to_line = "rlp_15504",
                      from_point = "P1670", to_point = "P13364"
)
dt_rivers = add_river(from_line = "rlp_6370", to_line = "rlp_15503",
                      from_point = "P1668", to_point = "P13362"
)
dt_rivers = add_river(from_line = "rlp_6368", to_line = "rlp_15502",
                      from_point = "P1666", to_point = "P13360"
)
dt_rivers = add_river(from_line = "rlp_6366", to_line = "rlp_15501",
                      from_point = "P1664", to_point = "P13358"
)
dt_rivers = add_river(from_line = "rlp_15570", to_line = "rlp_15571",
                      from_point = "P13498", to_point = "P13480"
)
dt_rivers = add_river(from_line = "rlp_6446", to_line = "rlp_15572",
                      from_point = "P1684", to_point = "P13500"
)
dt_rivers = add_river(from_line = "rlp_15579", to_line = "rlp_15580",
                      from_point = "P13516", to_point = "P13504"
)
dt_rivers = add_river(from_line = "rlp_6454", to_line = "rlp_15577",
                      from_point = "P1690", to_point = "P13510"
)
dt_rivers = add_river(from_line = "rlp_6450", to_line = "rlp_15574",
                      from_point = "P1688", to_point = "P1686"
)
dt_rivers = add_river(from_line = "rlp_15651", to_line = "rlp_15652",
                      from_point = "P13660", to_point = "P13518"
)
dt_rivers = add_river(from_line = "rlp_6527", to_line = "rlp_15649",
                      from_point = "P1692", to_point = "P13654"
)
dt_rivers = add_river(from_line = "rlp_6582", to_line = "rlp_15703",
                      from_point = "P1694", to_point = "P13662"
)
dt_rivers = add_river(from_line = "rlp_6584", to_line = "rlp_15704",
                      from_point = "P1696", to_point = "P13764"
)
dt_rivers = add_river(from_line = "rlp_15707", to_line = "rlp_15708",
                      from_point = "P13772", to_point = "P13766"
)
dt_rivers = add_river(from_line = "rlp_6617", to_line = "rlp_15735",
                      from_point = "P1702", to_point = "P13776"
)
dt_rivers = add_river(from_line = "rlp_6616", to_line = "rlp_6617",
                      from_point = "P1700", to_point = "P1701"
)
dt_rivers = add_river(from_line = "rlp_15728", to_line = "rlp_15729",
                      from_point = "P13814", to_point = "P1698"
)
dt_rivers = add_river(from_line = "rlp_15744", to_line = "rlp_15745",
                      from_point = "P13846", to_point = "P13828"
)
dt_rivers = add_river(from_line = "rlp_15748", to_line = "rlp_15749",
                      from_point = "P13854", to_point = "P13848"
)
dt_rivers = add_river(from_line = "rlp_6634", to_line = "rlp_15750",
                      from_point = "P1706", to_point = "P13856"
)
dt_rivers = add_river(from_line = "rlp_6633", to_line = "rlp_15750",
                      from_point = "P1704", to_point = "P13856"
)
dt_rivers = add_river(from_line = "rlp_15774", to_line = "rlp_15775",
                      from_point = "P13906", to_point = "P13860"
)
dt_rivers = add_river(from_line = "rlp_6643", to_line = "rlp_15757",
                      from_point = "P1710", to_point = "P1708"
)
dt_rivers = add_river(from_line = "rlp_15780", to_line = "rlp_15781",
                      from_point = "P13918", to_point = "P13908"
)
dt_rivers = add_river(from_line = "rlp_6669", to_line = "rlp_15782",
                      from_point = "P1712", to_point = "P13920"
)
dt_rivers = add_river(from_line = "rlp_6671", to_line = "rlp_15783",
                      from_point = "P1714", to_point = "P13922"
)
dt_rivers = add_river(from_line = "rlp_6673", to_line = "rlp_15784",
                      from_point = "P1716", to_point = "P13924"
)
dt_rivers = add_river(from_line = "rlp_15795", to_line = "rlp_15796",
                      from_point = "P13948", to_point = "P13928"
)
dt_rivers = add_river(from_line = "rlp_6689", to_line = "rlp_15798",
                      from_point = "P1720", to_point = "P13952"
)
dt_rivers = add_river(from_line = "rlp_6693", to_line = "rlp_15801",
                      from_point = "P1722", to_point = "P13958"
)

# SAVE --------------------------------------------------------------------

saveRDS(dt_rivers, file.path(DIR$da, "fixed_w_added.RDS"))
drive_upload(media = file.path(DIR$da, "fixed_w_added.RDS"), 
             path = "Projekt Uwi Passierbarkeit/rivers_w_added.RDS", 
             overwrite = TRUE)
