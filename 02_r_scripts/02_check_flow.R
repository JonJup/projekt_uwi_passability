# ---------------------- #
### --- check flow --- ### 
# ---------------------- #

#date written: 22.08.20 
#Jonathan Jupke 
# ecoserv 
# projekt uwi  

#-- what? -- # 
# improve passability data 

# setup -------------------------------------------------------------------
pacman::p_load(sf, 
               dplyr, 
               magrittr,
               here, 
               purrr, 
               data.table,
               tmap, 
               lwgeom, 
               stringr)

# here is the location of the .Rproj file 
setwd(here())

# directories 
dir_da = "01_data/"
dir_rs = "02_r_scripts/"

# load data ---------------------------------------------------------------
# Run script for fixed rivers  
source(file.path(dir_rs, "01_fix_flow_direction.R"))

# options 
save     = TRUE
tmap_mode("view")

## -- add your sampling sites here ! -- ## 
#st_sites = readRDS("01_data/new_sites1.RDS")

# carpeting ---------------------------------------------------------------
# change files in a way that we can use them further on. 

# create a spatial object for the rivers (st_river). The object has the class "sf" inherited from the package sf. 
st_rivers = st_as_sf(dt_rivers)
# in case the coordinates reference system (crs) of sites is not the same as that of the rivers ... 
if (st_crs(st_sites) != st_crs(st_rivers)) {
        # ... transform sites data to have the same crs. %<>% is a piping
        # operator from the magrittr package. More specifically it is the
        # assignment pipe that assigns the result of the operation to the
        # initial object. See https://magrittr.tidyverse.org/index.html for more
        # details.
        st_sites %<>% st_transform(crs = st_crs(st_rivers))
}

# copy is required for data.tables as copy-on modify does not work. 
dt_rivers_loop <- copy(dt_rivers)
# create new id going from 1 to the number of rows in dt_rivers_loop
dt_rivers_loop[, row_id := 1:nrow(dt_rivers_loop)]
# create the new variable "evaled" (short for evaluated) and assign a value of zero to each row. 
dt_rivers_loop[,evaled:=0]
# create a spatial object of class "sf" based on dt_rivers_loop
st_rivers_loop = st_as_sf(dt_rivers_loop)

# find number of sites when you know the id 
which(st_sites$site %in% c("ES001", "ES002", "ES003"))


# Figuratively speaking this loops lets the water flow through the rivers. It
# loops over the start positions.
for (j in c(1:4)) { # START LOOP 1 
    
        # find the river segment that is closest to the point (i.e. the start segment)
        start_segement <- st_nearest_feature(x = st_sites[j,], 
                                             y = st_rivers)
        # the last_id variable hold the segment from which "water is coming" 
        last_id = start_segement
        # assign the start segment its own scores for up and down and mark it as evaled 
        dt_rivers_loop[start_segement,
                       c("score_up_eval", "score_down_eval", "evaled") :=
                               .(score_up, score_down, evaled + 1)]
         
        # The counter variable ounts the rounds inside the while loop 
        counter = 1 
        # While loop with a trivial always true condition. 
        # Only stops through break() commands   
        while (1 != 2) {# START WHILE 1
                
                # Which Point did the last segment flow into   
                # This object can be read as: 
                # The object in row names(going_to)[i] ends in point going_to[[i]]
                last_id_ul <- unlist(last_id)
                pre_going_to <- dt_rivers_loop[last_id_ul, TO]
                going_to <- list()
                for (i in seq_along(pre_going_to)) {  
                        going_to[[i]] <- pre_going_to[i]     
                        names(going_to)[i] <- as.character(unlist(last_id))[i]
                }
                
                # What is the updated score of the last segment? 
                # This object can be read as: 
                # The object in row names(last_score_down)[i] has an updated score of last_score_down[[i]]
                pre_last_score_down <- dt_rivers_loop[last_id_ul, score_down_eval]
                last_score_down <- list()
                for (i in seq_along(pre_last_score_down)) {
                        last_score_down[[i]] <- pre_last_score_down[i]     
                        names(last_score_down)[i] <- as.character(unlist(last_id))[i]
                } 
                if (sum(duplicated(going_to)) != 0) {
                        dup_id <- which(duplicated(going_to))      
                        # note 27.08: I removed two brackets around dup_id and added the unlists
                        dup_id <- which(unlist(going_to) %in% unlist(going_to[dup_id]))
                        dup_score_down <- last_score_down[dup_id]
                        max_id <- which(dup_score_down == max(unlist(dup_score_down)))
                        last_score_down[dup_id] <-  last_score_down[max_id]
                } 
                
                
                
                # What rivers start from the last end point
                # The object pre_nxt_stop is a vector with object row numbers 
                # The object nxt_stop is a list with 
                (pre_nxt_stop <- which(dt_rivers_loop$FROM %in% going_to))
                nxt_stop <- list()
                for (i in seq_along(pre_nxt_stop)) {
                        # id of a row that is the next river segment 
                        nxt_stop[[i]] <-  pre_nxt_stop[i]
                        # Name = name of the point from which this one starts
                        # where does this one come from 
                        loop_from <- dt_rivers_loop[pre_nxt_stop[i], FROM]
                        loop_name <- dt_rivers_loop[row_id %in% as.character(unlist(last_id)) & TO == loop_from, row_id]
                        #if (length(loop_name) > 1) loop_name <- names(last_score_down)
                        names(nxt_stop)[i] <- loop_name
                }
                
                if (length(nxt_stop) == 0) break()
                for (i in seq_along(nxt_stop)) {
                        loop_var <- names(nxt_stop)[i]
                        dt_rivers_loop[nxt_stop[[i]], c("score_down_eval", "evaled") := .(score_down * unlist(last_score_down[loop_var]), evaled+1)]
                        # dt_rivers_loop[nxt_stop[[i]], c("score_down_eval", "evaled") := .(score_down * unlist(last_score_down[loop_var]), 1)]
                }
                #dt_rivers_loop[nxt_stop, c("score_down_eval", "evaled") := .(score_down * last_score_down,1)]
                last_id <- nxt_stop
                print(paste0("round ", counter,": ", names(going_to)))
                counter <- counter + 1
        } # END WHILE1
} # END LOOP1 

## -- look at map -- ## 

# after the loop finished every river segment that has been evaluated at some
# point in the loop now has a number different from zero. The number indicates
# the number of times it was evaluated. For some river segments this can be
# larger than 1, e.g. in reticulate networks. However when there are
# circularities in the network which lead to never ending loops this feature can
# be used to identify the culprits. 

# Here we only wish to plot those river segments that were evaluated. Plotting
# the whole network takes forever. We use the filter function from the dplyr
# package to reduce the data set to those lines that have values for "evaled"
# unequal zero.

# The argument col in the function tm_lines can be used to adjust the variable
# that is used to color the river segments.

dt_rivers_loop %>%
  filter(evaled != 0) %>%
  st_as_sf() %>%
  tm_shape() +
  tm_lines(col = "evaled",
           palette = "RdYlGn",
           scale = 4)

  
# This code chunk saves the file in a spatial data format. In case you want to open it in QGIS 
if (save) {
        old_temp = dir(
                path = dir_da,
                pattern = "_workshop",
                full.names = TRUE
        )
        file.remove(old_temp)
        dt_rivers_loop %>%
          st_as_sf() %>%
          st_write(dsn = file.path(
            dir_da,
            paste0(
              Sys.Date(),
              "_workshop_map.gpkg"
            )
          ))
}
