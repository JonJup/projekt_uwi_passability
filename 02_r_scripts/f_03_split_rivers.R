#### --- ECOSERV/ PROJEKT UWI 
#### --- FUNCTION: SPLITTING LINES AT INTERSECTIONS 
#### --- DATE: 23.11.20

split_lines = function(data, split, by){
        
        # load package 
        if (!require(lwgeom)) print("loading lwgeom package")
        
        # make sure data has class sf 
        data = st_as_sf(data)
        
        # select the two relevent stream segments
        st_tobe_split = filter(data, ecoserv_id == split)
        st_by = filter(data, ecoserv_id == by)
        
        # split river segment 
        st_split_river = st_split(x = st_tobe_split,
                                  y = st_by) %>%
                st_collection_extract(type = "LINESTRING") 
        
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
        
        # check visually 
        # tm_shape(st_split_river) + tm_lines(col="ecoserv_id") +
        #         tm_shape(st_barrier_subset) + tm_dots()
        
        if (nrow(st_barrier_subset) != 0) {
                ## -- Check that barriers are in total equal to the previous score
                num_score_down = prod(st_barrier_subset$score_down.1)
                num_score_up = prod(st_barrier_subset$score_up.1)
                if (st_split_river$score_up[1] != num_score_up) stop("upstream passabilities differ")
                if (st_split_river$score_down[1] != num_score_down) stop("downstream passabilities differ")
                rm(num_score_down, num_score_up)   
        }
        
        st_split_river$score_up = 1
        st_split_river$score_down = 1
        
        ## -- assign barriers to new stream segments -- ## 
        
        if (nrow(st_barrier_subset) != 0) {
                barrier_distances = st_distance(st_barrier_subset,
                                                st_split_river)
                for (i in 1:nrow(barrier_distances)) {
                        st_barrier_subset$subset[i] = which(barrier_distances[1, ] == min(barrier_distances[1, ]))
                }
                for (i in 1:nrow(st_split_river)) {
                        loop_barriers = filter(st_barrier_subset, subset == i)
                        if (nrow(loop_barriers) == 0)
                                next()
                        st_split_river$score_down[i] = prod(loop_barriers$score_down.1)
                        st_split_river$score_up[i] = prod(loop_barriers$score_up.1)
                }
        }
        
        st_split_river = st_cast(x = st_split_river, "MULTILINESTRING")
        data = filter(data, ecoserv_id != split)
        data = rbind(data, st_split_river)
        # setDT(data)
        return(data)
        
}
