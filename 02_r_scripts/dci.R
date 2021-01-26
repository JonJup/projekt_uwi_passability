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
sf_sites2 = readRDS(file.path(DIR$data, "new_sites2.RDS"))

# drop "bow" variable 
sf_sites %<>% select(!"bow")
names(sf_sites) = c("layer", "geom")
st_geometry(sf_sites) = "geom"
# transform projection. Both data sets need to have the same projection. 
sf_sites %<>% st_transform(crs = st_crs(sf_sites2))


# drop "raster" variable 
sf_sites2 %<>% select(!raster)

#combine data sets 
sf_sites_w2 = rbind(sf_sites, sf_sites2)


# carpet ------------------------------------------------------------------
# convert to spatial 
sf_rivers = st_as_sf(dt_rivers)
# transform sites to same CRS
sf_sites %<>% st_transform (crs = st_crs(sf_rivers))

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
rm(tb_edge);gc()

# update with current river network 
dt_edge=dt_edge[ecoserv_id %in% dt_rivers$ecoserv_id]
dt_edge[,c("FROM", "TO") := NULL]
dt_rivers_join = dt_rivers[, c("ecoserv_id", "FROM", "TO")]
dt_edge=dt_rivers_join[dt_edge, on = "ecoserv_id"]
rm(dt_rivers_join);gc()
# vector of site names 
vc_sites = unique(sf_sites$site)
li_sp = list()


n_sites = nrow(sf_sites)
#n_sites = 10


# create symmetric matrices for spatial and barrier distance 
ma_distance = matrix(data = NA, nrow=n_sites, ncol=n_sites)
ma_spatial = ma_spatial_p_cg = ma_distance
diag(ma_distance) = 1
diag(ma_spatial_p_cg) = 1
diag(ma_spatial) = 0

#identify nearest stream segment for each point
# close_segment = c()
# for (i in 1:n_sites){
#         close_segment[i] = st_nearest_feature(x = sf_sites[i,],
#                                               y = sf_rivers)
# }
# saveRDS(close_segment, "01_data/jj_close_segment.RDS")
close_segment = readRDS("01_data/jj_close_segment.RDS")

# loop_out = matrix(data = NA, nrow=n_sites, ncol=n_sites)
# diag(loop_out) = 0
# # check if two point are connected 
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

#saveRDS(loop_out, "01_data/jj_loop_out.RDS")
loop_out = readRDS("01_data/jj_loop_out.RDS")

corrplot::corrplot(loop_out, is.corr = FALSE, diag = FALSE, type = "lower")

for (site1 in 1:n_sites) { # Loop site1 
        for (site2 in 1:n_sites) { # loop site2 
                
                # skip if same site or not reached 
                if (site1 == site2 | loop_out[site1, site2] == 1) next()
                # Print start message 
                print(paste("START from", vc_sites[site1], "to", vc_sites[site2]))
                
                # check variable 
                check = c(site1, site2)
                
                # check out skips
                # if (site1 == 1) next()
                # if (1 %in% check & 5 %in% check) netx()
                # if (1 %in% check & 16 %in% check) next()
                # if (1 %in% check & 17 %in% check) next()
                # if (1 %in% check & 18 %in% check) next()
                # if (1 %in% check & 29 %in% check) next()
                # if (1 %in% check & 30 %in% check) next()
                # if (1 %in% check & 31 %in% check) next()
                # 
                # if (2 %in% check) next()
                # if (3 %in% check) next()
                # if (5 %in% check) next()
                
                # select start and end edges 
                int_start = close_segment[site1]
                int_end   = close_segment[site2]
                int_start = sf_rivers[int_start, ]$ecoserv_id
                int_end   = sf_rivers[int_end,   ]$ecoserv_id
                from      = dt_edge[ecoserv_id ==  int_start, Node2]
                to        = dt_edge[ecoserv_id ==  int_end,   Node1]
                
                # compute path and extract shortest path
                v_path = unlist(shortest_paths(graph = nw_rivers,
                                               from  = from,
                                               to    = to)[[1]])
                
                # prepare edge id subset - only with edges on the shortest path 
                tb_edge_id_sub = dt_edge[(Node2 %in% v_path & Node1 %in% v_path)|ecoserv_id==int_start|ecoserv_id==int_end]
                # add two new variables: flow direction and segment number. The first determined whether upstream or
                # downstream score is used. The latter gives the number in the flow sequence, i.e. 4 means that it is
                # fourth in line from the start point
                tb_edge_id_sub[, flow_direction := factor(levels=c("up","down"))]
                tb_edge_id_sub[, segment_number := numeric()]
                # Assign values to the start segment. Will always flow down. 
                tb_edge_id_sub[ecoserv_id==int_start, c("flow_direction", "segment_number") := .("down",1) ]
                # add segment length to edge subset 
                st_loop_length = filter(sf_rivers, ecoserv_id %in% tb_edge_id_sub$ecoserv_id)
                st_loop_length$segment_length = st_length(st_loop_length)
                st_loop_length %<>% select(ecoserv_id, segment_length) %>% 
                        st_drop_geometry() %>% 
                        setDT
                st_loop_length[, segment_length := as.numeric(segment_length)]
                tb_edge_id_sub = st_loop_length[tb_edge_id_sub, on = "ecoserv_id"]
                
                # MANAUAL EDIT JJ
                if (site1 == 1 & site2 == 3) v_path = v_path[-116]
                if (site1 == 2 & site2 == 3) v_path = v_path[-76]
                if (site1 == 3) v_path = v_path[-4]
                if (site1 == 4 & site2 == 3) v_path = v_path[-20]
                if (site1 == 5 & site2 == 3) v_path = v_path[-48]
                
                # now loop over path and determine sequence and flow direction 
                for (i in seq_along(v_path)) {
                #for (i in 1:114){
                        if (i == 1) loop_bool = 1
                        if(loop_bool == 0) next()
                        
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
                                loop_bool = ifelse(any(loop_var$FROM == tb_edge_id_sub[segment_number == (i), TO]),
                                                   1,
                                                   ifelse(
                                                           any(loop_var$TO == tb_edge_id_sub[segment_number == (i), TO]),
                                                           2,
                                                           ifelse(any(
                                                                   loop_var$TO == tb_edge_id_sub[segment_number == (i), FROM]
                                                           ),
                                                           3,
                                                           ifelse(any(
                                                                   loop_var$FROM == tb_edge_id_sub[segment_number == (i), FROM]
                                                           ),
                                                           4,
                                                           0 
                                                           ))
                                                          )
                                                   )
                                
                                # informative failure 
                                if (loop_bool == 0) {
                                        print("bool = 0, can't decide if up or down")
                                        ma_distance[site1, site2] = 666
                                        ma_spatial[site1, site2] = 666
                                        ma_spatial_p_cg[site1, site2] = 666
                                }
                                
                                if(loop_bool == 0) break()
                                
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
                                        loop_segment = loop_var[j, ]
                                        
                                        tb_edge_id_sub[ecoserv_id == loop_segment$ecoserv_id,
                                                       segment_number := i +
                                                               1]
                                        
                                        if (loop_segment$FROM == tb_edge_id_sub[segment_number == i, TO]) {
                                                tb_edge_id_sub[ecoserv_id == loop_segment$ecoserv_id, flow_direction := "down"]
                                        } else if (loop_segment$TO == tb_edge_id_sub[segment_number == i, TO]) {
                                                tb_edge_id_sub[ecoserv_id == loop_segment$ecoserv_id, flow_direction := "up"]
                                        } else if (loop_segment$TO == tb_edge_id_sub[segment_number == i, FROM]) {
                                                tb_edge_id_sub[ecoserv_id == loop_segment$ecoserv_id, flow_direction := "up"]
                                        }
                                        
                                }
                                
                        } else if (nrow(loop_var) == 0) {
                                print(paste("no sites at iteration", i))
                                #break()
                        }
                        # any segments with this node at all?
                        if (tb_edge_id_sub[is.na(flow_direction) &
                                           (Node1 == v_path[i] |
                                            Node2 == v_path[i]), .N] == 0) {
                                print(paste("No segments with Node", i, "left"))
                                next()
                        }
                        
                } # END loop of path
                if(loop_bool != 0){
                
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
                in_d1 = st_distance(x = sf_sites[site1,],
                                    y = filter(sf_rivers, ecoserv_id == tb_edge_id_sub[segment_number == 2, ecoserv_id])) %>%
                        as.numeric()
                in_d2 = st_distance(x = sf_sites[site2, ],
                                    y = filter(sf_rivers, ecoserv_id == tb_edge_id_sub[segment_number == max(segment_number) -
                                                                                               1, ecoserv_id])) %>%
                        as.numeric()
                # FILL OUTPUT MATRICES
                ma_distance[site1, site2] = p_total
                ma_spatial[site1, site2] = in_most_segments + in_d2 + in_d1
                ma_spatial_p_cg[site1, site2] = dnorm(x = ma_spatial[site1, site2], mean = 51, sd = 9.2) # data: Knaepkens et al (2005) Table 1
                ## PRINT LOOP END
                print(paste("FINISHED from", vc_sites[site1], "to", vc_sites[site2]))
                # REMOVE LOOP OBJECTS
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
# 
ma_distance %>% corrplot::corrplot(method = "square")
ma_spatial %>% corrplot::corrplot(is.corr = FALSE, diag =FALSE, type ="lower", method = "square")     


# weighting differs from original! 

L = sum(ma_spatial[1:5,1:5])     

vc_distance = as.vector(ma_distance[1:5,1:5])
vc_spatial = as.vector(ma_spatial[1:5,1:5])
vc_spatial_norm = vc_spatial/L
ifelse(sum(vc_spatial_norm) == 1, "Passed", "Failed")

DCI = sum(vc_distance * vc_spatial_norm)

# non zero example 
ma_distance_mod = matrix(data = runif(n = 25, 0, 1), ncol = 5)
vc_distance_mod = as.vector(ma_distance_mod)
(DCI = sum(vc_distance_mod * vc_spatial_norm))

     
### -- workshop 
if (1 == 2){
sf_sub = filter(sf_rivers, ecoserv_id %in% tb_edge_id_sub$ecoserv_id)
new = select(tb_edge_id_sub, c("ecoserv_id", "segment_number"))
sf_sub %<>% left_join(new)
tm_shape(sf_sub) + tm_lines(col = "segment_number")

View(tb_edge_id_sub)

v_path[i] %in% tb_edge_id_sub$Node1 |
        v_path[i] %in% tb_edge_id_sub$Node2
tb_edge_id_sub[Node1 == v_path[i]]
}