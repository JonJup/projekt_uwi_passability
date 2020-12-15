# --------------------- #
### --- shp2graph --- ###
# --------------------- #

#date written:20.10.20

# SETUP -------------------------------------------------------------------
pacman::p_load(here,
               igraph,
               data.table,
               dplyr,
               magrittr,
               riverdist,
               shp2graph,
               sf,
               sp,
               tmap)

DIR = list(data = here("01_data/"))

# LOAD ---------------------------------------------------------------
dt_rivers = readRDS(
        file.path(DIR$data, "fixed_rivers.RDS")
)

st_sampling_sites = readRDS(
        file.path(DIR$data, "sites_original.RDS")
)

# CARPET ------------------------------------------------------------------
# to sf spatial object 
sf_rivers=st_as_sf(dt_rivers)
# extract segment length as edge length 
edge_length = st_length(sf_rivers) %>% 
        as.numeric()

# to sp spatial object, required format by shp2graph
sf_rivers %<>% as_Spatial()

# read network 
li_pre_net = readshpnw(ntdata = sf_rivers)

saveRDS(object = li_pre_net,
        file = file.path(DIR$data, "list_pre_network.RDS"))

igraph_river = nel2igraph(nodelist = li_pre_net[[2]],
                          edgelist = li_pre_net[[3]],
                          weight = edge_length)
saveRDS(object = igraph_river,
        file = file.path(DIR$data, "igraph_river.RDS"))

# rglplot(
#         igraph_river,
#         vertex.size = .5,
#         vertex.size2 = 2,
#         mark.col = "green",
#         main = "The converted igraph graph"
# )

