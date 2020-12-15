# ------------------------------------ #
### --- Add barriers to flow map --- ### 
# ------------------------------------ #

#date written: 22.08.20 
#date changes: 14.12.20
#date used   : 22.08.20 + 26.
#Jonathan Jupke 
# Ecoserv 
# Passability Map/ Projekt Uwi

#-- what? -- # 
# Add barrier information to single stream segments 


# setup -------------------------------------------------------------------
pacman::p_load(sf, dplyr, magrittr,
               here, purrr, data.table,
               tmap)
setwd(here())

# load data ---------------------------------------------------------------
rivers   <- readRDS("01_data/fixed_rivers.RDS")
barrier  <- st_read("01_data/2020-08-22_all_barriers.gpkg")

# carpeting  -------------------------------------------------------------
rivers %<>% st_as_sf()

if (st_crs(barrier) != st_crs(rivers)) barrier %<>% st_transform(crs = st_crs(rivers))

## -- check with plot -- ## 
# tm_shape(rivers) + tm_lines() + 
#         tm_shape(barrier) + tm_dots(col = "red")
# tm_shape(barrier) + tm_dots()

# nearest neighbor analysis -------------------------------------------------------------
# nn = st_nearest_feature(barrier,
#                          rivers); beepr::beep()
#  
# rivers_resorted <- rivers[nn,]
# 
# distance_list <-
#         map(.x = 1:nrow(barrier),
#             .f = ~ as.numeric(st_distance(x = barrier[.x, ],
#                                           y = rivers_resorted[.x, ])));beepr::beep()
# 
# distance_list2 <- unlist(distance_list)
# distance_table <- data.table("barrier_ID"  = barrier$ecoserv_barrier_id,
#                              "nn_distance" = distance_list2,
#                              "river_ID"    = rivers_resorted$ecoserv_id)
# 
# saveRDS(distance_table, "01_data/distance_table.RDS")
distance_table = readRDS("~/01_Uni/01_Lehre/07_projekt_uwi/projekt_uwi_passability/01_data/distance_table.RDS")

accepted_distance = 50
distance_table2 <- distance_table[nn_distance <= accepted_distance]

# rm(nn, distance_list, distance_table, rivers_resorted);gc()
# hist(distance_table2$nn_distance)

# OK, so now we have i) only barriers that are close to a river and ii) the
# connection between each river and its barriers. I can use the latter to determine
# "passability" of a river segment as the product of its barrier passabilities.

# remove duplicates
if (!length(unique(rivers$ecoserv_id)) == nrow(rivers)) {
        dup_id <- which(duplicated(rivers$ecoserv_id))
        rivers <- rivers[-dup_id,]
        #rivers[dup_id,]
}

rivers2 <- rivers
setDT(rivers2)
setDT(barrier)
print_steps = c(1:10 * 10)
# # this loop gives the stream segments their scores 
for (i in 1:nrow(rivers2)) {
        loop_var  <- rivers2$ecoserv_id[i]
        loop_var2 <- distance_table2[river_ID == loop_var]
        if (nrow(loop_var2) == 0) next()
        loop_var3 <- barrier[ecoserv_barrier_id %in% loop_var2$barrier_ID]
        loop_score_up    <- prod(loop_var3$score_up  , na_rm = T)
        loop_score_down <-  prod(loop_var3$score_down, na_rm = T)
        rivers2[ecoserv_id == loop_var, c("score_up", "score_down") := .(loop_score_up, loop_score_down)]
        
        step = round(i / nrow(rivers2) * 100, 1)
        if (step %in% print_steps) {
                print(paste("Finished", step, "% @", Sys.time()))
                print_steps = print_steps[-which(print_steps == step)] 
        }
}
# 
rivers2[is.na(score_down), score_down := 1]
rivers2[is.na(score_up), score_up := 1]

# Save to file  -----------------------------------------------------------
saveRDS(rivers2, "01_data/fixed_w_barrier.RDS")
#st_write(st_as_sf(rivers2), paste0("001_data/map_passability/", Sys.Date(), "_rivers_w_flow_and_barriers.gpkg"))
