# berechnung des DCI in einem netzwerk


# setup ---------------------------------------------------------------------------------------------------------------------------------------------------
pacman::p_load(igraph,
               data.table,
               dplyr,
               here,
               magrittr,
               shp2graph,
               sf,
               sp,
               tmap)

DIR = list(data = here("01_data/"))

## OPTIONS
OPTIONS = list(save = T)

# read files --------------------------------------------------------------
li_nodes  = readRDS(file.path(DIR$data, "list_pre_network.RDS"))
nw_rivers = readRDS(file.path(DIR$data, "igraph_river.RDS"))
dt_rivers = readRDS(file.path(DIR$data, "fixed_w_barrier.RDS"))
sf_sites  = readRDS(file.path(DIR$data, "sites_original.RDS"))
sf_sites2 = readRDS(file.path(DIR$data, "new_sites1.RDS"))
sf_sites3 = readRDS(file.path(DIR$data, "new_sites2.RDS"))
sf_sites4 = readRDS(file.path(DIR$data, "new_sites3.RDS"))
sf_sites5 = readRDS(file.path(DIR$data, "new_sites4.RDS"))

# drop "bow" variable
sf_sites %<>% select(!"bow")
names(sf_sites) = c("layer", "geom")
st_geometry(sf_sites) = "geom"
# transform projection. Both data sets need to have the same projection.
sf_sites %<>% st_transform(crs = st_crs(sf_sites2))


# drop "raster" variable
sf_sites2 %<>% select(!raster)
sf_sites3 %<>% select(!raster)
sf_sites4 %<>% select(!raster)
sf_sites5 %<>% select(!raster)

#combine data sets
sf_sites_w2 = rbind(sf_sites, sf_sites2, sf_sites3 ,sf_sites4, sf_sites5)

sf_sites_w2 <- sf_sites_w2[a,]

sf_sites_w2 = readRDS("01_data/reduced_random_sites.RDS")


# carpet ------------------------------------------------------------------

# convert to spatial
sf_rivers = st_as_sf(dt_rivers)
# transform sites to same CRS
sf_sites_w2 %<>% st_transform (crs = st_crs(sf_rivers))

# Create table: Edge x goes from Node y to Node z
tb_edge = tibble(EdgeID = li_nodes[[3]][, 1],
                 Node1 = li_nodes[[3]][, 2],
                 Node2 = li_nodes[[3]][, 3])
# add network data to site infos
tb_edge = left_join(x = tb_edge,
                    y = li_nodes[[5]],
                    by = "EdgeID")
# to data.table
dt_edge = setDT(tb_edge)
rm(tb_edge)
gc()

# update with current river network
dt_edge = dt_edge[ecoserv_id %in% dt_rivers$ecoserv_id]
dt_edge[, c("FROM", "TO") := NULL]
dt_rivers_join = dt_rivers[, c("ecoserv_id", "FROM", "TO")]
dt_edge = dt_rivers_join[dt_edge, on = "ecoserv_id"]
rm(dt_rivers_join)
gc()
# vector of site names
vc_sites = unique(sf_sites_w2$layer)
li_sp = list()


n_sites = nrow(sf_sites_w2)
#n_sites = 10

#identify nearest stream segment for each point
close_segment = c()
for (i in 1:n_sites){
        close_segment[i] = st_nearest_feature(x = sf_sites_w2[i,],
                                              y = sf_rivers)
        print(i)
}
saveRDS(close_segment, "01_data/ts_close_segment_75.RDS")
close_segment = readRDS("01_data/ts_close_segment_75.RDS")

loop_out = matrix(data = NA, nrow=n_sites, ncol=n_sites)
diag(loop_out) = 0
# check if two point are connected
for (site1 in 1:n_sites) {
        for (site2 in 1:n_sites) {
                if (site1 == site2) next()
                # Print start message
                print(paste("START from", vc_sites[site1], "to", vc_sites[site2]))

                int_start = close_segment[site1]
                int_end   = close_segment[site2]

                int_start = sf_rivers[int_start, ]$ecoserv_id
                int_end   = sf_rivers[int_end,   ]$ecoserv_id
                from      = dt_edge[ecoserv_id ==  int_start, Node2]
                to        = dt_edge[ecoserv_id ==  int_end,   Node1]

                li_sp = shortest_paths(graph = nw_rivers,
                                       from  = from,
                                       to    = to)
                v_path = unlist(li_sp[[1]])
                loop_out[site1, site2] = length(v_path)
        }
        print(site1)
}

saveRDS(loop_out, "01_data/ts_loop_out_75.RDS")
loop_out = readRDS("01_data/ts_loop_out_75.RDS")

# corrplot::corrplot(
#         loop_out,
#         is.corr = FALSE,
#         diag = FALSE,
#         type = "lower",
#         addgrid.col = NA,
#         tl.pos = 'n'
# )
# How many are connected?
# The total number is n_sites^2.
n_sites ^ 2 == length(loop_out)
# How many are connected ?
sum(loop_out > 1)
# In percent:
sum(loop_out > 1) / length(loop_out) * 100
# 61.7 %

# create symmetric matrices for spatial and barrier distance
ma_distance = matrix(data = NA, nrow = n_sites, ncol = n_sites)
ma_spatial = ma_spatial_p_cg = ma_distance
diag(ma_distance) = 1
diag(ma_spatial_p_cg) = 1
diag(ma_spatial) = 0


#start_sites = sample(1:nrow(sf_sites_w2), 15)
#end_sites = sample(1:nrow(sf_sites_w2), 15)

start_sites = (1:nrow(sf_sites_w2))
end_sites = (1:nrow(sf_sites_w2))


for (site1 in start_sites) {
        # Loop site1
        for (site2 in end_sites) {
                # loop site2
                # skip if same site or not reached
                if (site1 == site2 |
                    loop_out[site1, site2] == 1)
                        next()
                # TEMP - REMOVE ME
                # if (site1 < 21) next()
                # if (site1 == 22 & site2 < 41) next()
                
                # Print start message
                print(paste("START from", vc_sites[site1], "to", vc_sites[site2]))
                
                # select start and end edges
                int_start = close_segment[site1]
                int_end   = close_segment[site2]
                int_start = sf_rivers[int_start,]$ecoserv_id
                int_end   = sf_rivers[int_end,]$ecoserv_id
                from      = dt_edge[ecoserv_id ==  int_start, Node2]
                to        = dt_edge[ecoserv_id ==  int_end,   Node1]
                
                # compute path and extract shortest path
                v_path = unlist(shortest_paths(
                        graph = nw_rivers,
                        from  = from,
                        to    = to
                )[[1]])
                
                # prepare edge id subset - only with edges on the shortest path
                tb_edge_id_sub = dt_edge[(Node2 %in% v_path &
                                                  Node1 %in% v_path) | ecoserv_id == int_start | ecoserv_id == int_end]
                # add two new variables: flow direction and segment number. The first determined whether upstream or
                # downstream score is used. The latter gives the number in the flow sequence, i.e. 4 means that it is
                # fourth in line from the start point
                tb_edge_id_sub[, flow_direction := factor(levels = c("up", "down"))]
                tb_edge_id_sub[, segment_number := numeric()]
                # Assign values to the start segment. Will always flow down.
                tb_edge_id_sub[ecoserv_id == int_start, c("flow_direction", "segment_number") := .("down", 1)]
                # add segment length to edge subset
                st_loop_length = filter(sf_rivers,
                                        ecoserv_id %in% tb_edge_id_sub$ecoserv_id)
                st_loop_length$segment_length = st_length(st_loop_length)
                st_loop_length %<>% select(ecoserv_id, segment_length) %>%
                        st_drop_geometry() %>%
                        setDT
                st_loop_length[, segment_length := as.numeric(segment_length)]
                tb_edge_id_sub = st_loop_length[tb_edge_id_sub, on = "ecoserv_id"]
                
                # MANAUAL EDIT JJ
                # if (site1 == 1 & site2 == 3)
                #         v_path = v_path[-116]
                # if (site1 == 2 & site2 == 3)
                #         v_path = v_path[-76]
                # if (site1 == 3)
                #         v_path = v_path[-4]
                # if (site1 == 4 & site2 == 3)
                #         v_path = v_path[-20]
                # if (site1 == 5 & site2 == 3)
                #         v_path = v_path[-48]
                
                # now loop over path and determine sequence and flow direction
                for (i in seq_along(v_path)) {
                #for (i in 1:151) {
                        if (i == 1)
                                loop_bool = 1
                        if (loop_bool == 0)
                                next()
                        
                        loop_var = tb_edge_id_sub[is.na(flow_direction) &
                                                          (Node1 == v_path[i] |
                                                                   Node2 == v_path[i])]
                        
                        if (nrow(loop_var) == 1) {
                                # assign segment number i + 1
                                tb_edge_id_sub[is.na(flow_direction) &
                                                       (Node1 == v_path[i] |
                                                                Node2 == v_path[i]),
                                               segment_number := i + 1]
                                
                                # flowing up or down?
                                loop_bool = ifelse(
                                        any(loop_var$FROM == tb_edge_id_sub[segment_number == (i), TO]),1,
                                        ifelse(any(loop_var$TO == tb_edge_id_sub[segment_number == (i), TO]),2,
                                               ifelse(any(loop_var$TO == tb_edge_id_sub[segment_number == (i), FROM]),3,
                                                      ifelse(any(loop_var$FROM == tb_edge_id_sub[segment_number == (i), FROM]),4,0)))
                                )
                                # informative failure
                                if (loop_bool == 0) {
                                        print("bool = 0, can't decide if up or down")
                                        ma_distance[site1, site2] = 666
                                        ma_spatial[site1, site2] = 666
                                        ma_spatial_p_cg[site1, site2] = 666
                                }
                                
                                if (loop_bool == 0)
                                        break()
                                
                                if (loop_bool == 1) {
                                        # check for length
                                        tb_edge_id_sub[ecoserv_id == loop_var$ecoserv_id, flow_direction := "down"]
                                } else if (loop_bool == 2) {
                                        # check for length
                                        tb_edge_id_sub[ecoserv_id == loop_var$ecoserv_id, flow_direction := "up"]
                                } else if (loop_bool == 3) {
                                        # check for length
                                        tb_edge_id_sub[ecoserv_id == loop_var$ecoserv_id, flow_direction := "up"]
                                } else if (loop_bool == 4) {
                                        tb_edge_id_sub[ecoserv_id == loop_var$ecoserv_id, flow_direction := "down"]
                                }
                                
                                
                        } else if (nrow(loop_var) > 1) {
                                # we have more than one stream that flows from our endpoint
                                # loop over them
                                # note to self: the loop could be the norm!
                                for (j in 1:nrow(loop_var)) {
                                        loop_segment = loop_var[j,]
                                        tb_edge_id_sub[ecoserv_id == loop_segment$ecoserv_id, segment_number := i + 1]
                                        loop_bool = vector(mode = "numeric", length = 2L)
                                        # flowing up or down?
                                        loop_bool[j] = ifelse( any(loop_segment$FROM == tb_edge_id_sub[segment_number == (i), TO]),
                                                1,
                                                ifelse(any(loop_segment$TO == tb_edge_id_sub[segment_number == (i), TO]),
                                                        2,
                                                        ifelse(any(loop_segment$TO == tb_edge_id_sub[segment_number == (i), FROM]),
                                                                3,
                                                                ifelse(any(loop_segment$FROM == tb_edge_id_sub[segment_number == (i), FROM]),
                                                                        4, 0 ))))
                                }        
                                # informative failure
                                if (all(loop_bool == 0)) {
                                                print("bool = 0, can't decide if up or down")
                                                ma_distance[site1, site2] = 666
                                                ma_spatial[site1, site2] = 666
                                                ma_spatial_p_cg[site1, site2] = 666
                                } 
                                if (loop_bool == 0)  break()
                                if (any(loop_bool == 0)){
                                                zero_id = which(loop_bool == 0)
                                                loop_bool = loop_bool[-zero_id]
                                                loop_var = loop_var[-zero_id,]
                                }
                                for (j in 1:nrow(loop_var)){
                                        loop_segment = loop_var[j, ]
                                        if (loop_bool[j] == 1) {
                                                # check for length
                                                tb_edge_id_sub[ecoserv_id == loop_segment$ecoserv_id, flow_direction := "down"]
                                        } else if (loop_bool[j] == 2) {
                                                # check for length
                                                tb_edge_id_sub[ecoserv_id == loop_segment$ecoserv_id, flow_direction := "up"]
                                        } else if (loop_bool[j] == 3) {
                                                # check for length
                                                tb_edge_id_sub[ecoserv_id == loop_segment$ecoserv_id, flow_direction := "up"]
                                        } else if (loop_bool[j] == 4) {
                                                tb_edge_id_sub[ecoserv_id == loop_segment$ecoserv_id, flow_direction := "down"]
                                        } 
                                }
                        } else if (nrow(loop_var) == 0) {
                                #print(paste("no sites at iteration", i))
                                break()
                        }
                        # any segments with this node at all?
                        if (tb_edge_id_sub[is.na(flow_direction) &
                                           (Node1 == v_path[i] |
                                            Node2 == v_path[i]), .N] == 0) {
                                # print(paste(
                                #         "No segments with Node",
                                #         i,
                                #         "left"
                                # ))
                                next()
                        }
                        
                } # END loop of path
                if (loop_bool != 0 & !all(tb_edge_id_sub$segment_number %in% c(NA,1))) {
                        # CALCULATE PROBABILITES
                        p_down  = prod(dt_rivers[ecoserv_id %in% tb_edge_id_sub[flow_direction ==
                                                                                        "down", ecoserv_id], score_down])
                        p_up    = prod(dt_rivers[ecoserv_id %in% tb_edge_id_sub[flow_direction ==
                                                                                        "up", ecoserv_id], score_up])
                        p_total = p_up * p_down
                        
                        in_most_segments = tb_edge_id_sub[segment_number != min(segment_number) &
                                                                  segment_number != max(segment_number),
                                                          sum(segment_length)]
                        
                        
                        # which is the second stream?
                        if (nrow(tb_edge_id_sub) > 1) {
                                in_d1 = st_distance(x = sf_sites_w2[site1,],
                                                    y = filter(sf_rivers,
                                                               ecoserv_id == tb_edge_id_sub[segment_number == 2, ecoserv_id])) %>%
                                        as.numeric()
                                in_d2 = st_distance(x = sf_sites_w2[site2, ],
                                                    y = filter(sf_rivers,
                                                               ecoserv_id == tb_edge_id_sub[segment_number == max(segment_number) -
                                                                                                    1, ecoserv_id])) %>%
                                        as.numeric()
                        } else {
                                in_d1 = 0
                                in_d2 = 0
                        }
                        
                        # FILL OUTPUT MATRICES
                        ma_distance[site1, site2] = p_total
                        ma_spatial[site1, site2] = in_most_segments + in_d2 + in_d1
                        ma_spatial_p_cg[site1, site2] = dnorm(x = ma_spatial[site1, site2],
                                                              mean = 51,
                                                              sd = 9.2) # data: Knaepkens et al (2005) Table 1
                        ## PRINT LOOP END
                        # print(paste(
                        #         "FINISHED from",
                        #         vc_sites[site1],
                        #         "to",
                        #         vc_sites[site2]
                        # ))
                        # REMOVE LOOP OBJECTS
                } else {
                        ma_distance[site1, site2] = ma_spatial[site1, site2] = ma_spatial_p_cg[site1, site2] = 666
                }
                rm(
                        int_start,
                        int_end,
                        from,
                        to,
                        v_path,
                        tb_edge_id_sub,
                        p_down,
                        p_up,
                        p_total,
                        in_most_segments,
                        in_d2,
                        in_d1,
                        st_loop_length
                )
                gc()
        } # end loop site2
} # end Loop site1

# saveRDS(ma_distance, "01_data/ts_ma_distance_75.RDS")
# saveRDS(ma_spatial, "01_data/ts_ma_spatial_75.RDS")

# ma_distance %>% corrplot::corrplot(method = "square",
#                                    is.corr = FALSE,
#                                    addgrid.col = NA,
#                                    tl.pos = 'n')
# ma_spatial %>% corrplot::corrplot(
#         is.corr = FALSE,
#         diag = FALSE,
#         type = "lower",
#         method = "square",
#         addgrid.col = NA,
#         tl.pos = 'n'
# )
# 

# Evaluate loop -----------------------------------------------------------

ma_distance2 = ma_distance %>% round(2)
diag(ma_distance2) = 666
id = which(apply(ma_distance2,2,function(x)!(all(x %in% c(NA,666)))))
id = c(id, start_sites, end_sites) %>% unique %>% sort()
ma_distance2 = ma_distance2[id,id]
ma_distance2.v = as.vector(ma_distance2)
cs = which(ma_distance2.v == 666)
ma_distance2.v[cs] = NA
ma_distance2 = matrix(ma_distance2.v, ncol = length(id))

ma_spatial2 = ma_spatial %>% round(2)
diag(ma_spatial2) = 666
id = which(apply(ma_spatial2,2,function(x)!(all(x %in% c(NA,666)))))
id = c(id, start_sites, end_sites) %>% unique %>% sort()
ma_spatial2 = ma_spatial2[id,id]
ma_spatial2.v = as.vector(ma_spatial2)
cs = which(ma_spatial2.v == 666)
ma_spatial2.v[cs] = NA
ma_spatial2 = matrix(ma_spatial2.v, ncol = length(id))

apply(ma_distance2,1, function(x) sum(!is.na(x)))

sum(!is.na(ma_distance2))
corrplot::corrplot(ma_distance2,  addgrid.col = NA)
sum(!is.na(ma_spatial2))
corrplot::corrplot(ma_spatial2,  addgrid.col = NA, is.corr = FALSE)



# DCI ---------------------------------------------------------------------



# weighting differs from original!
# without NAs
L = sum(ma_spatial2[1:n_sites, 1:n_sites])
# with NAs
L = sum(ma_spatial2, na.rm = T)

vc_distance = as.vector(ma_distance2)
vc_spatial = as.vector(ma_spatial2)
vc_spatial_norm = vc_spatial / L
ifelse(sum(vc_spatial_norm, na.rm = TRUE) == 1, "Passed", "Failed")

(DCI = sum(vc_distance * vc_spatial_norm, na.rm = TRUE))
(DCI = sum(vc_distance * (1-vc_spatial_norm), na.rm = TRUE))
(DCI = mean(vc_distance, na.rm = TRUE))

# non zero example
ma_distance_mod = matrix(data = runif(n = 25, 0, 1), ncol = 5)
vc_distance_mod = as.vector(ma_distance_mod)
(DCI = sum(vc_distance_mod * vc_spatial_norm))


### -- workshop
if (1 == 2) {
        sf_sub = filter(sf_rivers, ecoserv_id %in% tb_edge_id_sub$ecoserv_id)
        new = select(tb_edge_id_sub, c("ecoserv_id", "segment_number"))
        sf_sub %<>% left_join(new)
        tm_shape(sf_sub) + tm_lines(col = "segment_number")
        
        View(tb_edge_id_sub)
        
        v_path[i] %in% tb_edge_id_sub$Node1 |
                v_path[i] %in% tb_edge_id_sub$Node2
        tb_edge_id_sub[Node1 == v_path[i]]
}