#### --- ECOSERV/ PROJEKT UWI 
#### --- FUNCTION: SPLITTING LINES AT INTERSECTIONS 
#### --- DATE: 23.11.20

split_lines = function(data, split, by){
        
        if (!require(lwgeom)) print("loading lwgeom package")
        
        data = st_as_sf(data)
        
        st_tobe_split = filter(data, ecoserv_id == split)
        st_by = filter(data, ecoserv_id == by)
        
        # st_by %>% 
        #         st_cast("POINT") -> st_by_pt
        # st_by_pt_dist  = st_distance(x = st_by_pt, y = st_tobe_split)
        # st_by_pt_dist2 = st_by_pt_dist[c(1,length(st_by_pt_dist)), ]
        # int_dis_id1    = which(st_by_pt_dist2 == min(st_by_pt_dist2))
        # int_dis_id     = ifelse(int_dis_id1 == 1, 1, length(st_by_pt_dist))
        # tm_shape(st_tobe_split) + tm_lines() +
        #         tm_shape(st_by_pt) +
        #         tm_dots() +
        #         tm_shape(st_by_pt[int_dis_id,]) +
        #         tm_dots(col = "red")
        st_split_river = lwgeom::st_split(x = st_tobe_split, 
                         y = st_by)
        st_split_river %<>% st_collection_extract(type = "LINESTRING")   
        if (any(str_detect(data$ecoserv_id, "^split_"))){
                data %>% 
                        filter(str_detect(data$ecoserv_id, "^split_")) %>% 
                        pull(ecoserv_id) %>% 
                        str_split("_") %>% 
                        unlist %>% 
                        str_remove_all("split") %>% 
                        as.integer() %>% 
                        max(na.rm = T) %>% 
                        + 1 -> 
                        new_id 
                st_split_river$ecoserv_id[2] = paste0("split_", new_id)
        } else {
                st_split_river$ecoserv_id[2] = "split_1"   
        }
        st_split_river$FROM = ""
        st_split_river$TO = ""

        st_split_river$ecoserv_number[2] = data %>% 
                pull(ecoserv_number) %>% 
                max %>% 
                +1
        
        st_barrier_subset = st_intersection(x = st_buffer(st_split_river, 25), 
                        y = st_barrier)
        # tm_shape(st_split_river) + tm_lines(col="ecoserv_id") + 
        #         tm_shape(st_barrier_subset) + tm_dots()
        
        ## -- Check that barriers are in total equal to the previous score
        num_score_down = prod(st_barrier_subset$score_down.1)
        num_score_up = prod(st_barrier_subset$score_up.1)
        if (st_split_river$score_up[1] != num_score_up) stop("upstream passabilities differ")
        if (st_split_river$score_down[1] != num_score_down) stop("downstream passabilities differ")
        rm(num_score_down, num_score_up)
        
        st_split_river$score_up = 1
        st_split_river$score_down = 1
        
        ## -- assign barriers to new stream segents -- ## 
        barrier_distances = st_distance(st_barrier_subset,
                                        st_split_river)
        for (i in 1:nrow(barrier_distances)) {
                st_barrier_subset$subset[i] = which(barrier_distances[1,] == min(barrier_distances[1,]))
        }
        for (i in 1:nrow(st_split_river)){
                loop_barriers = filter(st_barrier_subset, subset == i)
                if (nrow(loop_barriers) == 0) next()
                st_split_river$score_down[i] = prod(loop_barriers$score_down.1)
                st_split_river$score_up[i] = prod(loop_barriers$score_up.1)
        }
        st_split_river = st_cast(x = st_split_river, "MULTILINESTRING")
        data = filter(data, ecoserv_id != split)
        data = rbind(data, st_split_river)
        # setDT(data)
        return(data)
        
}
