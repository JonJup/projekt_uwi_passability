# ------------------------------ #
### --- Fix flow direction --- ### 
# ------------------------------ #

# date written: 21.10.20
# date changed: 28.10.20 

# Used to be part of 005_create_map.R. Exacted because it is also useful for other parts of the project. 

# overview # 

## OPTIONS 
OPTIONS = list(workshop= F, 
               remove= F,
               save = T)

# setup -------------------------------------------------------------------
pacman::p_load(data.table,
               dplyr,
               here,
               lwgeom,
               magrittr,
               sf,
               stringr,
               tmap)

# load reverse function 
source(file.path(DIR$rs, "f_01_reverse.R"))
source(file.path(DIR$rs, "f_02_add_river.R"))
source(file.path(DIR$rs,  "f_03_split_rivers.R"))

# load data ---------------------------------------------------------------
dt_rivers = readRDS(file.path(DIR$da, "rivers.RDS"))
st_sites  = readRDS(file.path(DIR$da, "sites_original.RDS"))
st_barrier = st_read(file.path(DIR$da, "2020-08-22_all_barriers.gpkg"), quiet = T)
# carpeting ---------------------------------------------------------------
dt_rivers[, ecoserv_number := as.numeric(str_extract(string=ecoserv_id, pattern="[0-9].*"))]
if (st_crs(st_barrier) != st_crs(st_as_sf(dt_rivers))) {
        st_barrier %<>% st_transform(crs = st_crs(st_as_sf(dt_rivers)))
}

# delete segments ---------------------------------------------------------
print("### --- DELETING SEGMENTS --- ###")
dt_rivers  <-
        dt_rivers[!ecoserv_id %in% c(
                "rlp_55",
                "rlp_56",
                "rlp_203",
                "rlp_212",
                "rlp_214",
                "rlp_374",
                "rlp_248",
                "rlp_740",
                "rlp_1370",
                "rlp_10137",
                "rlp_10152",
                "rlp_10174",
                "rlp_10420",
                "rlp_10595",
                "rlp_10596",
                "rlp_10597",
                "rlp_10598",
                "rlp_10599",
                "rlp_10604",
                "rlp_10605",
                "rlp_10606",
                "rlp_10610",
                "rlp_10648",
                "rlp_10649",
                "rlp_10650",
                "rlp_10651",
                "rlp_10652",
                "rlp_10653",
                "rlp_10654",
                "rlp_10736",
                "rlp_10737",
                "rlp_10782",
                "rlp_10783",
                "rlp_10820",
                "rlp_10821",
                "rlp_10902",
                "rlp_10918",
                "rlp_10919",
                "rlp_10930",
                "rlp_10931",
                "rlp_10932",
                "rlp_10933",
                "rlp_10941",
                "rlp_10942",
                "rlp_10943",
                "rlp_10944",
                "rlp_10945",
                "rlp_10947",
                "rlp_10948",
                "rlp_10950",
                "rlp_10951",
                "rlp_10965",
                "rlp_10966",
                "rlp_10967",
                "rlp_10968",
                "rlp_10969",
                "rlp_10979",
                "rlp_10981",
                "rlp_10982",
                "rlp_10983",
                "rlp_10988",
                "rlp_10989",
                "rlp_10990",
                "rlp_10991",
                "rlp_10992",
                "rlp_10993",
                "rlp_16929",
                "rlp_16930",
                
                "swd_19631",
                "swd_32360",
                "swd_32406",
                "swd_33118",
                "swd_34009",
                "swd_35010",
                "swd_35910",
                "swd_37142",
                "swd_37206",
                "swd_37658",
                "swd_37712",
                "swd_38051",
                "swd_38065",
                "swd_38904",
                "swd_39272",
                "swd_39350",
                "swd_39976",
                "swd_40177",
                "swd_40413",
                "swd_40824",
                "swd_40833",
                "swd_40883",
                "swd_41717",
                "swd_42326",
                "swd_43506",
                "swd_43799",
                "swd_43910",
                "swd_43986",
                "swd_44248",
                "swd_44665",
                "swd_44793",
                "swd_44849",
                "swd_44885",
                "swd_45416",
                "swd_48147",
                "swd_58143",
                "swd_59794",
                "swd_60407",
                "swd_62290",
                "swd_62438",
                "swd_67705",
                "swd_63726",
                "swd_64279",
                "swd_64280",
                "swd_67704",
                "swd_69582",
                "swd_71702",
                "swd_71703",
                "swd_71961",
                "swd_72365",
                "swd_72366",
                "swd_72911",
                
                "vdn_2342",
                "vdn_5868",
                "vdn_5685",
                "vdn_5869",
                "vdn_6655",
                "vdn_6656",
                "vdn_6657",
                "vdn_6658",
                "vdn_6661",
                "vdn_6671",
                "vdn_6672",
                "vdn_6673",
                "vdn_7770",
                "vdn_7861",
                "vdn_6659",
                "vdn_6660",
                "vdn_678"
        )]


# MANUAL -----------------------------------------------------
print("### --- MANUAL IMPROVEMENTS --- ###")
dt_rivers[ecoserv_id == "rlp_54"   , FROM := "P52"]
dt_rivers[ecoserv_id == "rlp_192"  , FROM := "P2184"]
dt_rivers[ecoserv_id == "rlp_192"  , TO := "p_add_01"]
dt_rivers[ecoserv_id == "rlp_10118", FROM := "P2590"]
dt_rivers[ecoserv_id == "rlp_10143", FROM := "P2634"]
dt_rivers[ecoserv_id == "rlp_10143", TO   := "P2638"]
dt_rivers[ecoserv_id == "rlp_10280", FROM := "P3136"]
dt_rivers[ecoserv_id == "rlp_10389", TO := "Px3136"]
dt_rivers[ecoserv_id == "rlp_10390", FROM := "Px3136"]
dt_rivers[ecoserv_id == "rlp_10390", TO := "P3136"]
dt_rivers[ecoserv_id == "rlp_10391", FROM := "P3136"]
dt_rivers[ecoserv_id == "rlp_10394", FROM := "P2917"]
dt_rivers[ecoserv_id == "rlp_10398", FROM := "P3150"]
dt_rivers[ecoserv_id == "rlp_10398", TO   := "P3160"]
dt_rivers[ecoserv_id == "rlp_10399", FROM := "P3150"]
dt_rivers[ecoserv_id == "rlp_10509", FROM := "P3374"]
dt_rivers[ecoserv_id == "rlp_10560", FROM := "P3474"]
dt_rivers[ecoserv_id == "rlp_10580", FROM := "P3474"]
dt_rivers[ecoserv_id == "rlp_10581", FROM := "P3480"]
dt_rivers[ecoserv_id == "rlp_10589", FROM := "P3512"]
dt_rivers[ecoserv_id == "rlp_10611", FROM := "P3414"]
dt_rivers[ecoserv_id == "rlp_10627", FROM := "P3598"]
dt_rivers[ecoserv_id == "rlp_10627", TO   := "P3612"]
dt_rivers[ecoserv_id == "rlp_10634", FROM := "P3422"]
dt_rivers[ecoserv_id == "rlp_10770", FROM := "P288"]

dt_rivers[ecoserv_id == "rlp_14111", FROM := "P29614"]
dt_rivers[ecoserv_id == "rlp_16937", FROM   := "P2917"]

dt_rivers[ecoserv_id == "vdn_2342" , TO   := "P28346"]
dt_rivers[ecoserv_id == "vdn_3872" , TO := "P21634_add"]
dt_rivers[ecoserv_id == "vdn_4415" , FROM := "P21634_add"]
dt_rivers[ecoserv_id == "vdn_2342" , FROM := "P22684"]
dt_rivers[ecoserv_id == "vdn_4399" , FROM := "P22684"]
dt_rivers[ecoserv_id == "vdn_7362" , FROM := "P20200"]
dt_rivers[ecoserv_id == "vdn_7362" , TO   := "P22508"]
dt_rivers[ecoserv_id == "vdn_8001" , FROM   := "P21820"]
dt_rivers[ecoserv_id == "vdn_8001" , TO   := "P29426"]

dt_rivers[ecoserv_id == "sar_4600",  FROM := "P10674"]
dt_rivers[ecoserv_id == "sar_8158",  FROM := "P117261"]
dt_rivers[ecoserv_id == "sar_8158",  TO   := "P114079"]
dt_rivers[ecoserv_id == "sar_8400",  FROM := "P122813"]
dt_rivers[ecoserv_id == "sar_8400",  TO   := "P403"]
dt_rivers[ecoserv_id == "vdn_16960", FROM := "P10564"]

# out ---------------------------------------------------------------------
# Not sure anymore what this does ... 
#dt_rivers[ecoserv_id %in% c("vdn_6657", "vdn_6658", "vdn_6660"), c("FROM", "TO") := c(1,2,3)]

# REVERSE -----------------------------------------------------------------
print("### --- REVERSE SEGMENTS --- ###")
dt_rivers = reverse(x= c(
        "rlp_197", 
        "rlp_537",
        "rlp_5003",
        "rlp_7990",
        "rlp_10080",
        "rlp_10081",
        "rlp_10107",
        "rlp_10108",
        "rlp_10109",
        "rlp_10116",
        "rlp_10117",
        "rlp_10138",
        "rlp_10139",
        "rlp_10141",
        "rlp_10145",
        "rlp_10146",
        "rlp_10279",
        "rlp_10283",
        "rlp_10284",
        "rlp_10285",
        "rlp_10333", 
        "rlp_10334",
        "rlp_10338",
        "rlp_10400",
        "rlp_10406", 
        "rlp_10407",
        "rlp_10418",
        "rlp_10470",
        "rlp_10478",
        "rlp_10506",
        "rlp_10557",
        "rlp_10558",
        "rlp_10559",
        "rlp_10562",
        "rlp_10584",
        "rlp_10585",
        "rlp_10592",
        "rlp_10593",
        "rlp_10632",
        "rlp_10639",
        "rlp_10640",
        "rlp_10642",
        "rlp_10645",
        "rlp_10673",
        "rlp_10725",
        "rlp_10726",
        "rlp_10727",
        "rlp_10768",
        "rlp_10770",
        "rlp_10771",
        "rlp_10774",
        "rlp_11002",
        "rlp_11005",
        "rlp_11007",
        "rlp_11011",
        "rlp_11015",
        "rlp_11019",
        "rlp_11021",
        "rlp_11132",
        "rlp_11140",
        "rlp_11158",
        "rlp_11159",
        "rlp_11160",
        "rlp_11177",
        "rlp_11199",
        "rlp_11220",
        "rlp_11221",
        "rlp_11273",
        "rlp_11298",
        "rlp_11309",
        "rlp_11315",
        "rlp_11331",
        "rlp_11401",
        "rlp_11448",
        
        "rlp_11718",
        "rlp_11758",
        "rlp_12282",
        "rlp_12283",
        "rlp_12737",
        "rlp_12748",
        "rlp_12784",
        "rlp_12788",
        "rlp_12800",
        "rlp_12822",
        "rlp_12836",
        "rlp_12862",
        "rlp_12872",
        "rlp_12874",
        "rlp_12875",
        "rlp_12876",
        "rlp_12908",
        "rlp_12917",
        "rlp_13302",
        "rlp_13310",
        "rlp_13313",
        "rlp_13321",
        "rlp_13889",
        "rlp_13909",
        "rlp_13912",
        "rlp_13916",
        "rlp_13927",
        "rlp_13961",
        "rlp_13974",
        "rlp_13977",
        "rlp_14037",
        "rlp_14045",
        "rlp_14100",
        "rlp_14146",
        "rlp_14156",
        "rlp_14258",
        "rlp_14291",
        "rlp_14301",
        "rlp_14302",
        "rlp_14696",
        "rlp_14697",
        "rlp_14718",
        "rlp_14719",
        "rlp_14923",
        "rlp_14932",
        "rlp_14934",
        
        "rlp_15187",
        "rlp_15191",
        "rlp_15434",
        "rlp_15703",
        "rlp_15804",
        "rlp_15808",
        "rlp_15831",
        "rlp_15905",
        "rlp_16348",
        "rlp_16613",
        "rlp_16614",
        "rlp_16615",
        "rlp_16623",
        "rlp_16626",
        "rlp_16954",
        
        #"vdn_247",
        "vdn_297",
        "vdn_425",
        "vdn_758",
        "vdn_900",
        "vdn_1011",
        "vdn_1328",
        "vdn_1760",
        "vdn_2088",
        "vdn_3502",
        "vdn_3505",
        "vdn_3507",
        "vdn_3508",
        "vdn_3522",
        "vdn_3652",
        "vdn_3697",
        "vdn_3804",
        "vdn_3871",
        "vdn_3961",
        "vdn_4102",
        "vdn_4265",
        "vdn_4321",
        "vdn_4391",
        "vdn_4394",
        "vdn_4430",
        "vdn_4605",
        "vdn_4633",
        "vdn_4863",
        "vdn_4878",
        "vdn_4974",
        "vdn_4976",
        "vdn_5051",
        "vdn_5420",
        "vdn_5421",
        "vdn_5427",
        "vdn_5440",
        "vdn_5448",
        "vdn_5887",
        "vdn_5890",
        "vdn_6051",
        "vdn_6120",
        "vdn_6121",
        "vdn_6128",
        "vdn_6192",
        "vdn_6365",
        "vdn_6369",
        "vdn_6384",
        "vdn_6387",
        "vdn_6388",
        "vdn_6393",
        "vdn_6395",
        "vdn_6397",
        "vdn_6400",
        "vdn_6401",
        "vdn_6402",
        "vdn_6407",
        "vdn_6410",
        "vdn_6413",
        "vdn_6415",
        "vdn_6417",
        "vdn_6422",
        "vdn_6423",
        "vdn_6426",
        "vdn_6431",
        "vdn_6439",
        "vdn_6442",
        "vdn_6445",
        "vdn_6450",
        "vdn_6452",
        "vdn_6455",
        "vdn_6457",
        "vdn_6461",
        "vdn_6463",
        "vdn_6465",
        "vdn_6468",
        "vdn_6471",
        "vdn_6473",
        "vdn_6476",
        "vdn_6477",
        "vdn_6479",
        "vdn_6482",
        "vdn_6483",
        "vdn_6485",
        "vdn_6486",
        "vdn_6492",
        "vdn_6497",
        "vdn_6499",
        "vdn_6502",
        "vdn_6504",
        "vdn_6505",
        "vdn_6507",
        "vdn_6508",
        "vdn_6509",
        "vdn_6510",
        "vdn_6512",
        "vdn_6515",
        "vdn_6517",
        "vdn_6520",
        "vdn_6522",
        "vdn_6523",
        "vdn_6525",
        "vdn_6526",
        "vdn_6528",
        "vdn_6530",
        "vdn_6531",
        "vdn_6534",
        "vdn_6536",
        "vdn_6537",
        "vdn_6538",
        "vdn_6541",
        "vdn_6544",
        "vdn_6545",
        "vdn_6674",
        "vdn_6761",
        "vdn_6770",
        "vdn_6832",
        "vdn_6833",
        "vdn_6834",
        "vdn_7107",
        "vdn_7113",
        "vdn_7119",
        "vdn_7120",
        "vdn_7126",
        "vdn_7131",
        "vdn_7134",
        "vdn_7371",
        "vdn_7384",
        "vdn_7386",
        "vdn_7391",
        "vdn_7396",
        "vdn_7406",
        "vdn_7410",
        "vdn_7411",
        
        "vdn_7413",
        "vdn_7424",
        "vdn_7434",
        "vdn_7468",
        "vdn_7469",
        "vdn_7470",
        "vdn_7683",
        
        "vdn_7687",
        "vdn_7696",
        "vdn_7698",
        "vdn_7704",
        "vdn_7705",
        "vdn_7708",
        "vdn_7767",
        "vdn_7768",
        "vdn_7772",
        "vdn_7959",
        #"vdn_7963",
        #"vdn_7964",
        "vdn_7965",
        "vdn_7966",
        "vdn_7967",
        "vdn_7974",
        "vdn_7978",
        "vdn_7980",
        "vdn_7994",
        "vdn_7998",
        "vdn_8045",
        "vdn_8047",
        "vdn_8065",
        "vdn_8067",
        "vdn_8101",
        "vdn_8102",
        "vdn_8144",
        "vdn_8153",
        "vdn_8155",
        "vdn_8156",
        "vdn_8158",
        "vdn_8165",
        "vdn_8169",
        "vdn_8176",
        "vdn_8181",
        "vdn_8182",
        "vdn_8185",
        "vdn_8202",
        "vdn_8232",
        "vdn_8233",
        "vdn_8239",
        "vdn_8244",
        "vdn_8301",
        "vdn_8315",
        "vdn_8317",
        "vdn_8319",
        
        
        "swd_32047",
        "swd_32579",
        "swd_32594",
        "swd_37737",
        "swd_40692",
        "swd_41929",
        "swd_44656",
        "swd_45701",
        "swd_45704",
        "swd_46097",
        "swd_46113",
        "swd_46116",
        "swd_46166",
        "swd_46167",
        "swd_46169",
        "swd_46172",
        "swd_46175",
        "swd_46180",
        "swd_46182",
        "swd_46184",
        "swd_46187",
        "swd_46192",
        "swd_46285",
        "swd_46440",
        "swd_46441",
        "swd_47382",
        "swd_47394",
        "swd_47396",
        "swd_47401",
        "swd_47408",
        "swd_47416",
        "swd_47417",
        "swd_47419",
        "swd_47420",
        "swd_47422",
        "swd_47424",
        "swd_47433",
        "swd_47440",
        "swd_47446",
        "swd_47452",
        "swd_47461",
        "swd_47462",
        "swd_47464",
        "swd_47465",
        "swd_47469",
        "swd_47470",
        "swd_47472",
        "swd_47475",
        "swd_47479",
        "swd_47483",
        "swd_47487",
        "swd_47489",
        "swd_47493",
        "swd_47618",
        
        "swd_50566",
        "swd_51087",
        "swd_51088",
        "swd_51090",
        "swd_51994",
        "swd_53519",
        "swd_53521",
        "swd_53543",
        "swd_53544",
        "swd_53545",
        "swd_53546",
        "swd_53547",
        "swd_53548",
        "swd_53549",
        "swd_53550",
        "swd_53551",
        "swd_53552",
        "swd_53553",
        "swd_53873",
        "swd_55716",
        "swd_56389",
        "swd_56704",
        "swd_56708",
        "swd_56720",
        "swd_56728",
        "swd_59472",
        "swd_60398",
        "swd_60402",
        "swd_60405",
        "swd_62686",
        "swd_63164",
        "swd_63165",
        "swd_63166",
        "swd_65204",
        "swd_67409",
        "swd_67410",
        "swd_68114",
        "swd_68110",
        "swd_68105",
        "swd_68104",
        "swd_68107",
        "swd_68109",
        "swd_68143",
        "swd_68145",
        "swd_68146",
        "swd_68147",
        "swd_68155",
        "swd_68157", 
        "swd_68181",
        "swd_68203",
        "swd_68218",
        "swd_68216",
        "swd_69498",
        
        "sar_166",
        "sar_444",
        "sar_460",
        "sar_464",
        "sar_477",
        
        "sar_3319",
        
        "sar_4873",
        
        "sar_5482",
        "sar_5483",
        "sar_5487",
        "sar_5500",
        "sar_5507",
        "sar_5508",
        "sar_5510",
        "sar_5511",
        "sar_5513",
        "sar_5514",
        "sar_5516",
        "sar_5517",
        "sar_5521",
        "sar_5523",
        "sar_5527",
        "sar_5528",
        "sar_5529",
        "sar_5530",
        "sar_5531",
        "sar_5539",
        "sar_5541",
        "sar_5542",
        #"sar_5543",
        "sar_5545",
        "sar_5546",
        "sar_5555",
        "sar_5822",
        
        "sar_6536",
        "sar_6547",
        
        "sar_7129",
        "sar_7140",
        "sar_7285",
        "sar_7288",
        "sar_7289",
        "sar_7307",
        "sar_7318",
        
        "sar_8077",
        "sar_8079",
        "sar_8081",
        "sar_8083",
        "sar_8086",
        "sar_8087",
        "sar_8089",
        "sar_8090",
        "sar_8095",
        "sar_8098",
        "sar_8099",
        "sar_8100",
        "sar_8102",
        "sar_8104",
        "sar_8108",
        "sar_8112",
        "sar_8113",
        "sar_8115",
        "sar_8118",
        "sar_8120",
        "sar_8122",
        "sar_8124",
        "sar_8131",
        "sar_8132",
        "sar_8134",
        "sar_8135",
        "sar_8136",
        "sar_8137",
        "sar_8140",
        "sar_8141",
        "sar_8142",
        "sar_8147",
        "sar_8148",
        "sar_8149",
        "sar_8150",
        "sar_8152",
        "sar_8154",
        "sar_8156",
        "sar_8159",
        "sar_8160",
        "sar_8165",
        "sar_8167",
        "sar_8170",
        "sar_8171"
))

# ADD LINES  ----------------------------------------------------------
print("### --- ADD SEGMENTS --- ###")
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


#  SPLIT LINES  -----------------------------------------------------------
print("### --- SPLIT SEGMENTS --- ###")
data = st_as_sf(dt_rivers)
data = split_lines(data  = data, 
                   split = "vdn_7815", 
                   by    = "sar_8075")
setDT(data)
dt_rivers = data

# modify added lines  -----------------------------------------------------
dt_rivers[ecoserv_id == "add_72929", FROM := "P103941"]
dt_rivers[ecoserv_id == "split_1", FROM := "P127267"]
dt_rivers[ecoserv_id == "split_1", TO := "P29431"]

## ---- add rows ----- ## 
new_number_rlp <- dt_rivers[str_detect(string=ecoserv_id,pattern="rlp"), max(ecoserv_number)]
dt_new_row <- data.table(ecoserv_id = paste0("rlp_", new_number_rlp + 1:2), 
                         FROM       = c("P42","P52"   ),
                         TO         = c("P44", "P2183"), 
                         score_up   = 1,
                         score_down = 1,
                         ecoserv_number = new_number_rlp + 1:2, 
                         geom       = c(dt_rivers[TO == "P42", geom], 
                                        dt_rivers[TO == "P52", geom])
)

dt_rivers <- rbindlist(list(dt_rivers, dt_new_row), 
                       use.names = TRUE)

## second delete step 
dt_rivers = dt_rivers[!ecoserv_id %in% c(
        "rlp_10404",
        "rlp_16932",
        "rlp_16934",
        "rlp_16961",
        "rlp_16962",
        # temp 
        "rlp_10138"
)
]

rm(add_river, dir_fun, dt_new_row, new_number_rlp, reverse);gc()


# SAVE  -----------------------------------------------------------
if (OPTIONS$save) {
        saveRDS(object=dt_rivers,
                file=file.path(DIR$da, "fixed_rivers.RDS"))
}
if (OPTIONS$remove) {
        rm(list=ls());gc()
}
# WORKSHOP ---------------------------------------------------------------
if (OPTIONS$workshop){
        
        tmap_mode("view")
        st_rivers = st_as_sf(dt_rivers)
        st_sites%<>%st_transform(crs=st_crs(st_rivers))
        
        # ## -- what? -- ## 
        sub=tb_edge_id_sub$ecoserv_id
        
        sub=c("PW_01", "PW02")
        
        rivers_sub=dt_rivers[ecoserv_id %in% sub]
        
        rivers_sub %>%
                mutate(fromto=paste(FROM, TO)) %>%
                st_as_sf() %>%
                tm_shape() + tm_lines(col="ecoserv_id", lwd=3) +
                tm_text(text="fromto")
        # 
        # ## -- bbox around sites -- ## 
        # ## -- + plot            -- ## 
        st_sites_sub = filter(st_sites, site %in% c("PW_01", "PW_02"))
        
        st_sites_sub %>%
                st_bbox() * c(.99,.99,1.11,1.11) ->
                cut_bbox
        # 
        st_cropped=sf::st_crop(
                x=st_rivers,
                y=cut_bbox
        )
        # 
        tm_shape(st_cropped) + tm_lines() +
                tm_shape(st_sites_sub) + tm_dots(col = "red")
        # 
        # ## ------------------- ## 
        # ## -- add lines eda -- ## 
        
        # extract lines between which a link is missing 
        st_rivers_sub =
                st_rivers %>%
                filter(ecoserv_id %in% c("rlp_188", "rlp_9913"))
        
        st_data = st_rivers
        st_data_sub = st_data %>%
                filter(ecoserv_id %in% c(from_line, to_line))
        
        st_data_sub_points =
                st_data_sub %>%
                st_cast(to = "POINT") %>%
                mutate(p_id = row_number())
        
        st_line_to = st_data_sub %>%
                filter(ecoserv_id == to_line)
        st_line_from = st_data_sub %>%
                filter(ecoserv_id == from_line)
        st_points_from = st_data_sub_points %>%
                filter(ecoserv_id == from_line)
        st_points_to = st_data_sub_points %>%
                filter(ecoserv_id == to_line)
        st_points_from = st_points_from[c(1, nrow(st_points_from)), ]
        st_points_to = st_points_to[c(1, nrow(st_points_to)), ]
        
        tm_shape(st_points_from) + tm_dots() +
                tm_shape(st_points_to) + tm_dots()
        
        p_id1 = st_nearest_feature(x = st_line_to,
                                   y = st_points_from)
        p_id2 = st_nearest_feature(x = st_line_from,
                                   y = st_points_to)
        p_id1 = st_points_from$p_id[p_id1]
        p_id2 = st_points_to$p_id[p_id2]
        
        # cast to points
        options(warn=-1);
        st_rivers_sub_point =
                st_rivers_sub %>%
                st_cast(to = "POINT");
        options(warn=1)
        
        st_rivers_sub_point %<>%
                mutate(p_id = 1:nrow(st_rivers_sub_point))
        point_id_2 <-
                unique(st_nearest_feature(
                        filter(st_rivers_sub_point, ecoserv_id == "rlp_188"),
                        filter(st_rivers_sub_point, ecoserv_id == "rlp_9913")
                ))
        point_id_1 <-
                unique(st_nearest_feature(
                        filter(st_rivers_sub_point, ecoserv_id == "rlp_9913"),
                        filter(st_rivers_sub_point, ecoserv_id == "rlp_188")
                ))
        point_id_1 = filter(st_rivers_sub_point, ecoserv_id == "rlp_9913") %>%
                st_drop_geometry() %>%
                select(p_id) %>%
                .[point_id_1,]
        
        point_id_2 = filter(st_rivers_sub_point, ecoserv_id == "rlp_188") %>%
                st_drop_geometry() %>%
                select(p_id) %>%
                .[point_id_2,]
        
        tm_shape(st_rivers_sub_point) +
                tm_dots()
        
        st_rivers_sub_point %>%
                filter(p_id %in% c(442, 446)) %>%
                st_coordinates(st_new_line) %>%
                .[, -3] %>%
                list() %>%
                st_multilinestring() %>%
                st_sfc() ->
                st_new_line
        
        st_crs(st_new_line)=st_crs(st_rivers_sub)
        
        tm_shape(st_rivers_sub) + tm_lines() +
                tm_shape(st_new_line) + tm_lines()
        
        df_attributes = data.frame(
                "ecoserv_id" = paste0("add_",
                                      max(dt_rivers$ecoserv_number) + 1),
                "FROM" = "P40",
                "TO"   = "P44",
                score_up=1,
                score_down=1,
                ecoserv_number=max(dt_rivers$ecoserv_number) + 1
        )
        
        st_new_line = st_sf(df_attributes, geom = st_new_line)
        st_crs(st_new_line)=st_crs(st_rivers)
        st_rivers %<>% rbind(st_new_line)
        
        
        #-----------------------#
        
        
        
        ## ------------------- ##
        
        
        to_split <- rivers[ecoserv_id == "vdn_7861"]
        to_split %<>% st_as_sf()
        to_split %<>% st_cast("POINT")
        
        st_nearest_feature(y = to_split,
                           x = st_as_sf(rivers[ecoserv_id == "rlp_16958"]))
}
