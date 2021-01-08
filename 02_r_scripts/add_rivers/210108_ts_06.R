# ---------------------- #
### --- add rivers --- ### 
### ---  6 ----------- ### 
# ---------------------- #

# date: 8.1.21 

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

dt_rivers = add_river(from_line = "vdn_5692", to_line = "swd_68241",
                      from_point = "P25274", to_point = "P45659"
)
dt_rivers = add_river(from_line = "rlp_5465", to_line = "rlp_14668",
                      from_point = "P1490", to_point = "P11128"
)
dt_rivers = add_river(from_line = "rlp_5464", to_line = "rlp_5465",
                      from_point = "P1488", to_point = "P1489"
)
dt_rivers = add_river(from_line = "rlp_5462", to_line = "rlp_14667",
                      from_point = "P1486", to_point = "P11690"
)
dt_rivers = add_river(from_line = "rlp_5460", to_line = "rlp_14666",
                      from_point = "P1484", to_point = "P11688"
)
dt_rivers = add_river(from_line = "rlp_14664", to_line = "rlp_14665",
                      from_point = "P1481", to_point = "P11680"
)
dt_rivers = add_river(from_line = "rlp_5453", to_line = "rlp_14661",
                      from_point = "P1480", to_point = "P11678"
)
dt_rivers = add_river(from_line = "rlp_5449", to_line = "rlp_14659",
                      from_point = "P1476", to_point = "P11674"
)
dt_rivers = add_river(from_line = "rlp_14657", to_line = "rlp_14658",
                      from_point = "P11672", to_point = "P11650"
)
dt_rivers = add_river(from_line = "rlp_5434", to_line = "rlp_14646",
                      from_point = "P1472", to_point = "P11648"
)
dt_rivers = add_river(from_line = "rlp_5432", to_line = "rlp_14645",
                      from_point = "P1470", to_point = "P11646"
)
dt_rivers = add_river(from_line = "rlp_14643", to_line = "rlp_14644",
                      from_point = "P11644", to_point = "P11638"
)
dt_rivers = add_river(from_line = "rlp_5426", to_line = "rlp_14640",
                      from_point = "P1468", to_point = "P11636"
)
dt_rivers = add_river(from_line = "rlp_5424", to_line = "rlp_14639",
                      from_point = "P1466", to_point = "P11634"
)
dt_rivers = add_river(from_line = "rlp_14637", to_line = "rlp_14638",
                      from_point = "P11632", to_point = "P11626"
)
dt_rivers = add_river(from_line = "rlp_14633", to_line = "rlp_14634",
                      from_point = "P11624", to_point = "P11606"
)
dt_rivers = add_river(from_line = "rlp_5408", to_line = "rlp_14624",
                      from_point = "P1464", to_point = "P11604"
)
dt_rivers = add_river(from_line = "rlp_5406", to_line = "rlp_14623",
                      from_point = "P1462", to_point = "P11602"
)
dt_rivers = add_river(from_line = "rlp_5379", to_line = "rlp_14597",
                      from_point = "P1460", to_point = "P1458"
)
dt_rivers = add_river(from_line = "rlp_14621", to_line = "rlp_14622",
                      from_point = "P11600", to_point = "P11550"
)
dt_rivers = add_river(from_line = "rlp_5376", to_line = "rlp_14596",
                      from_point = "P1456", to_point = "P11548"
)
dt_rivers = add_river(from_line = "rlp_5374", to_line = "rlp_14595",
                      from_point = "P1454", to_point = "P11546"
)
dt_rivers = add_river(from_line = "rlp_5372", to_line = "rlp_14594",
                      from_point = "P1452", to_point = "P11544"
)
dt_rivers = add_river(from_line = "rlp_5370", to_line = "rlp_14593",
                      from_point = "P1450", to_point = "P11542"
)
dt_rivers = add_river(from_line = "rlp_5367", to_line = "rlp_14591",
                      from_point = "P1448", to_point = "P11538"
)
dt_rivers = add_river(from_line = "rlp_5365", to_line = "rlp_14590",
                      from_point = "P1446", to_point = "P11536"
)
dt_rivers = add_river(from_line = "rlp_5363", to_line = "rlp_14589",
                      from_point = "P1444", to_point = "P11534"
)
dt_rivers = add_river(from_line = "rlp_5361", to_line = "rlp_14588",
                      from_point = "P1442", to_point = "P11532"
)
dt_rivers = add_river(from_line = "rlp_5359", to_line = "rlp_14587",
                      from_point = "P1440", to_point = "P11530"
)
dt_rivers = add_river(from_line = "rlp_5357", to_line = "rlp_14586",
                      from_point = "P1438", to_point = "P11528"
)
dt_rivers = add_river(from_line = "rlp_14584", to_line = "rlp_14585",
                      from_point = "P11526", to_point = "P11520"
)
dt_rivers = add_river(from_line = "rlp_14580", to_line = "rlp_14581",
                      from_point = "P11518", to_point = "P11512"
)
dt_rivers = add_river(from_line = "rlp_5347", to_line = "rlp_14577",
                      from_point = "P1436", to_point = "P11510"
)
dt_rivers = add_river(from_line = "rlp_14575", to_line = "rlp_14576",
                      from_point = "P11508", to_point = "P11502"
)
dt_rivers = add_river(from_line = "rlp_5341", to_line = "rlp_14572",
                      from_point = "P1434", to_point = "P11500"
)
dt_rivers = add_river(from_line = "rlp_14570", to_line = "rlp_14571",
                      from_point = "P11498", to_point = "P11488"
)
dt_rivers = add_river(from_line = "rlp_14564", to_line = "rlp_14565",
                      from_point = "P11486", to_point = "P11480"
)
dt_rivers = add_river(from_line = "rlp_5329", to_line = "rlp_14561",
                      from_point = "P1432", to_point = "P11478"
)
dt_rivers = add_river(from_line = "rlp_5327", to_line = "rlp_14560",
                      from_point = "P1430", to_point = "P11476"
)
dt_rivers = add_river(from_line = "rlp_14557", to_line = "rlp_14558",
                      from_point = "P11472", to_point = "P11466"
)
dt_rivers = add_river(from_line = "rlp_5320", to_line = "rlp_14554",
                      from_point = "P1428", to_point = "P11464"
)
dt_rivers = add_river(from_line = "rlp_14552", to_line = "rlp_14553",
                      from_point = "P11462", to_point = "P11444"
)
dt_rivers = add_river(from_line = "rlp_5308", to_line = "rlp_14543",
                      from_point = "P1426", to_point = "P11442"
)
dt_rivers = add_river(from_line = "rlp_14541", to_line = "rlp_14542",
                      from_point = "P11440", to_point = "P11434"
)
dt_rivers = add_river(from_line = "rlp_5302", to_line = "rlp_14538",
                      from_point = "P1424", to_point = "P11432"
)
dt_rivers = add_river(from_line = "rlp_5300", to_line = "rlp_14537",
                      from_point = "P1422", to_point = "P11430"
)
dt_rivers = add_river(from_line = "rlp_14535", to_line = "rlp_14536",
                      from_point = "P11428", to_point = "P11422"
)
dt_rivers = add_river(from_line = "rlp_14531", to_line = "rlp_14532",
                      from_point = "P11420", to_point = "P11362"
)
dt_rivers = add_river(from_line = "rlp_5285", to_line = "rlp_14523",
                      from_point = "P1420", to_point = "P11402"
)
dt_rivers = add_river(from_line = "rlp_5261", to_line = "rlp_14502",
                      from_point = "P1414", to_point = "P11360"
)
dt_rivers = add_river(from_line = "rlp_14499", to_line = "rlp_14500",
                      from_point = "P11356", to_point = "P11342"
)
dt_rivers = add_river(from_line = "rlp_14491", to_line = "rlp_14492",
                      from_point = "P11340", to_point = "P11334"
)
dt_rivers = add_river(from_line = "rlp_14487", to_line = "rlp_14488",
                      from_point = "P11332", to_point = "P11318"
)
dt_rivers = add_river(from_line = "rlp_14479", to_line = "rlp_14480",
                      from_point = "P11316", to_point = "P11310"
)
dt_rivers = add_river(from_line = "rlp_5234", to_line = "rlp_14476",
                      from_point = "P1412", to_point = "P11308"
)
dt_rivers = add_river(from_line = "rlp_5232", to_line = "rlp_14475",
                      from_point = "P1410", to_point = "P11306"
)
dt_rivers = add_river(from_line = "rlp_14472", to_line = "rlp_14473",
                      from_point = "P11302", to_point = "P11296"
)
dt_rivers = add_river(from_line = "rlp_14468", to_line = "rlp_14469",
                      from_point = "P11294", to_point = "P11284"
)
dt_rivers = add_river(from_line = "rlp_5196", to_line = "rlp_14440",
                      from_point = "P1408", to_point = "P11236"
)
dt_rivers = add_river(from_line = "rlp_5195", to_line = "rlp_5196",
                      from_point = "P1406", to_point = "P1404"
)
dt_rivers = add_river(from_line = "rlp_14438", to_line = "rlp_14439",
                      from_point = "P11234", to_point = "P11220"
)
dt_rivers = add_river(from_line = "rlp_14430", to_line = "rlp_14431",
                      from_point = "P11218", to_point = "P11212"
)
dt_rivers = add_river(from_line = "rlp_14425", to_line = "rlp_14426",
                      from_point = "P11208", to_point = "P11166"
)
dt_rivers = add_river(from_line = "rlp_5171", to_line = "rlp_14416",
                      from_point = "P1402", to_point = "P11188"
)
dt_rivers = add_river(from_line = "rlp_5157", to_line = "rlp_14403",
                      from_point = "P1400", to_point = "P11162"
)
dt_rivers = add_river(from_line = "rlp_5155", to_line = "rlp_14402",
                      from_point = "P1398", to_point = "P11160"
)
dt_rivers = add_river(from_line = "rlp_14684", to_line = "rlp_14685",
                      from_point = "P11726", to_point = "P11964"
)
dt_rivers = add_river(from_line = "rlp_5484", to_line = "rlp_14686",
                      from_point = "P1492", to_point = "P11728"
)
dt_rivers = add_river(from_line = "rlp_5494", to_line = "rlp_14694",
                      from_point = "P1496", to_point = "P11730"
)
dt_rivers = add_river(from_line = "rlp_5493", to_line = "rlp_5494",
                      from_point = "P1494", to_point = "P1495"
)
dt_rivers = add_river(from_line = "rlp_5497", to_line = "rlp_5498",
                      from_point = "P1500", to_point = "P1498"
)
dt_rivers = add_river(from_line = "rlp_5498", to_line = "rlp_14695",
                      from_point = "P1502", to_point = "P11746"
)
dt_rivers = add_river(from_line = "rlp_5500", to_line = "rlp_14696",
                      from_point = "P1504", to_point = "P11748"
)
dt_rivers = add_river(from_line = "rlp_5502", to_line = "rlp_14697",
                      from_point = "P1506", to_point = "P11750"
)
dt_rivers = add_river(from_line = "rlp_5509", to_line = "rlp_14703",
                      from_point = "P1508", to_point = "P11762"
)
dt_rivers = add_river(from_line = "rlp_14709", to_line = "rlp_14710",
                      from_point = "P11776", to_point = "P11752"
)
dt_rivers = add_river(from_line = "rlp_5518", to_line = "rlp_14711",
                      from_point = "P1510", to_point = "P11778"
)
dt_rivers = add_river(from_line = "rlp_5520", to_line = "rlp_14712",
                      from_point = "P1512", to_point = "P11780"
)
dt_rivers = add_river(from_line = "rlp_5522", to_line = "rlp_14713",
                      from_point = "P1514", to_point = "P11782"
)
dt_rivers = add_river(from_line = "rlp_5525", to_line = "rlp_14715",
                      from_point = "P1516", to_point = "P11786"
)
dt_rivers = add_river(from_line = "rlp_14718", to_line = "rlp_14719",
                      from_point = "P11794", to_point = "P11788"
)
dt_rivers = add_river(from_line = "rlp_5531", to_line = "rlp_14720",
                      from_point = "P1518", to_point = "P11796"
)
dt_rivers = add_river(from_line = "rlp_14813", to_line = "rlp_14814",
                      from_point = "P11984", to_point = "P11798"
)
dt_rivers = add_river(from_line = "rlp_5624", to_line = "rlp_14807",
                      from_point = "P1530", to_point = "P1528"
)
dt_rivers = add_river(from_line = "rlp_5617", to_line = "rlp_14802",
                      from_point = "P1526", to_point = "P1524"
)
dt_rivers = add_river(from_line = "rlp_5633", to_line = "rlp_14815",
                      from_point = "P1532", to_point = "P11986"
)
dt_rivers = add_river(from_line = "rlp_5635", to_line = "rlp_14816",
                      from_point = "P1534", to_point = "P11988"
)
dt_rivers = add_river(from_line = "rlp_5730", to_line = "rlp_14908",
                      from_point = "P1542", to_point = "P1540"
)
dt_rivers = add_river(from_line = "rlp_5658", to_line = "rlp_14837",
                      from_point = "P1538", to_point = "P12030"
)
dt_rivers = add_river(from_line = "rlp_5650", to_line = "rlp_14830",
                      from_point = "P1536", to_point = "P12016"
)
dt_rivers = add_river(from_line = "rlp_5769", to_line = "rlp_14944",
                      from_point = "P1548", to_point = "P12244"
)
dt_rivers = add_river(from_line = "rlp_5772", to_line = "rlp_14946",
                      from_point = "P1550", to_point = "P12248"
)
dt_rivers = add_river(from_line = "rlp_5792", to_line = "rlp_14964",
                      from_point = "P1554", to_point = "P12250"
)
dt_rivers = add_river(from_line = "rlp_5791", to_line = "rlp_5792",
                      from_point = "P1552", to_point = "P1553"
)
dt_rivers = add_river(from_line = "rlp_14970", to_line = "rlp_14971",
                      from_point = "P12298", to_point = "P12286"
)
dt_rivers = add_river(from_line = "rlp_5797", to_line = "rlp_14966",
                      from_point = "P1560", to_point = "P12288"
)
dt_rivers = add_river(from_line = "rlp_5795", to_line = "rlp_14965",
                      from_point = "P1558", to_point = "P1556"
)
dt_rivers = add_river(from_line = "rlp_15132", to_line = "rlp_15133",
                      from_point = "P12622", to_point = "P12300"
)
dt_rivers = add_river(from_line = "rlp_5817", to_line = "rlp_14985",
                      from_point = "P1564", to_point = "P12326"
)
dt_rivers = add_river(from_line = "rlp_5959", to_line = "rlp_15134",
                      from_point = "P1570", to_point = "P12624"
)
dt_rivers = add_river(from_line = "rlp_5961", to_line = "rlp_15135",
                      from_point = "P1572", to_point = "P12626"
)
dt_rivers = add_river(from_line = "rlp_15138", to_line = "rlp_15139",
                      from_point = "P12634", to_point = "P12628"
)
dt_rivers = add_river(from_line = "rlp_5968", to_line = "rlp_15141",
                      from_point = "P1574", to_point = "P12638"
)
dt_rivers = add_river(from_line = "rlp_5970", to_line = "rlp_15142",
                      from_point = "P1576", to_point = "P12640"
)
dt_rivers = add_river(from_line = "rlp_5972", to_line = "rlp_15143",
                      from_point = "P1578", to_point = "P12642"
)
dt_rivers = add_river(from_line = "rlp_15165", to_line = "rlp_15166",
                      from_point = "P12688", to_point = "P12644"
)
dt_rivers = add_river(from_line = "rlp_15186", to_line = "rlp_15187",
                      from_point = "P12730", to_point = "P12694"
)
dt_rivers = add_river(from_line = "rlp_6020", to_line = "rlp_15188",
                      from_point = "P1584", to_point = "P12732"
)
dt_rivers = add_river(from_line = "rlp_6022", to_line = "rlp_15189",
                      from_point = "P1586", to_point = "P12734"
)
dt_rivers = add_river(from_line = "rlp_6024", to_line = "rlp_15190",
                      from_point = "P1588", to_point = "P12736"
)
dt_rivers = add_river(from_line = "rlp_6027", to_line = "rlp_15192",
                      from_point = "P1590", to_point = "P12740"
)
dt_rivers = add_river(from_line = "rlp_15214", to_line = "rlp_15215",
                      from_point = "P12786", to_point = "P12742"
)
dt_rivers = add_river(from_line = "rlp_6052", to_line = "rlp_15216",
                      from_point = "P1592", to_point = "P12788"
)
dt_rivers = add_river(from_line = "rlp_15222", to_line = "rlp_15223",
                      from_point = "P12802", to_point = "P12792"
)

# SAVE --------------------------------------------------------------------

saveRDS(dt_rivers, file.path(DIR$da, "fixed_w_added.RDS"))
drive_upload(media = file.path(DIR$da, "fixed_w_added.RDS"), 
             path = "Projekt Uwi Passierbarkeit/rivers_w_added.RDS", 
             overwrite = TRUE)
