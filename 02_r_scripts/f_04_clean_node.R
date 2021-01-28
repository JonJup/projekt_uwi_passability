### --- CLEAN NODE FUNCTION --- ### 

# --------------- #
# date:  26.01.21
# ECOSERV
# Cleaning function for river network 
# --------------- #

clean_node = function(from_id, to_id){
        
        lp_from = filter(data, ecoserv_id == from_id)  
        lp_to   = filter(data, ecoserv_id == to_id)  
        
        lp_from_p = st_cast(lp_from, "POINT")
        lp_to_p = st_cast(lp_to, "POINT")
        
        lp_from_pp = lp_from_p[c(1,nrow(lp_from_p)), ]
        lp_to_pp = lp_to_p[c(1,nrow(lp_to_p)), ]
        
        dist = st_distance (lp_from_pp, lp_to_pp)
        id = which(dist == min(dist))
        if (id == 4){
                # remove last point 
                lp_from_p_id = lp_from_p[-(nrow(lp_from_p):nrow(lp_from_p)-5), ] 
                # extract new point 
                #lp_to_p_id = lp_to_p[nrow(lp_to_p), ]
                # add new row and assign values 
                #lp_bound = rbind(lp_from_p_id, lp_to_p_id)
                lp_bound = lp_from_p_id
                lp_bound$ecoserv_id = lp_bound$ecoserv_id[4]
                lp_bound$FROM = lp_bound$FROM[4]
                lp_bound$TO = lp_bound$TO[4]
                lp_bound$score_up = lp_bound$score_up[4]
                lp_bound$score_down = lp_bound$score_down[4]
                lp_bound$ecoserv_number = lp_bound$ecoserv_number[4]
        } else if (id != 4){
                stop("Other IDS than 4 not yet implemented!")
        }
        # exchange rows 
        new_line = st_cast(lp_bound, "LINESTRING") %>% 
                st_geometry() %>% 
                st_multilinestring() %>% 
                st_sfc()  
        new_line = st_sf(ecoserv_id = lp_from$ecoserv_id,
                         FROM = lp_from$FROM,
                         TO = lp_from$TO,
                         score_up = lp_from$score_up,
                         score_down = lp_from$score_down,
                         ecoserv_number = lp_from$ecoserv_number,
                         geom = new_line) %>% 
                st_set_crs(value = st_crs(data))
        
        lp_out   = filter(data, ecoserv_id != from_id) 
        lp_out   = rbind(lp_out, new_line)
        return(lp_out)
        
}