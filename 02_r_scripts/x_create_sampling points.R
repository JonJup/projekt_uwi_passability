# ---------------------------------- #
### --- Create Sampling points --- ### 
# ---------------------------------- #

# date_ 09.11 
# projekt uwi 

# setup -------------------------------------------------------------------
if(!require(pacman)){install.packages("pacman");library(pacman)}
pacman::p_load(beepr,
               data.table,
               dplyr,
               here,
               magrittr,
               purrr,
               raster,
               sf,
               stringr,
               tmap)
# dirs
dir_da  = here("01_data/")
dir_fun = here("02_r_scripts/")

tmap_mode("view")

# OPTIONS 
save = FALSE

# load data ---------------------------------------------------------------
dt_rivers = readRDS(file.path(dir_da, "rivers.RDS"))
st_sites  = readRDS(file.path(dir_da, "sites_original.RDS"))

# rivers to spaial object
st_rivers = st_as_sf(dt_rivers)
# extract bounding box of rivers 
st_rivers_bbox = st_bbox(st_rivers)

# proj4string of river data
crs_object = raster::crs(st_rivers)

ra_bbox = raster(
        nrows = 50,
        ncols = 50,
        xmn = st_rivers_bbox[1],
        xmx = st_rivers_bbox[3],
        ymn = st_rivers_bbox[2],
        ymx = st_rivers_bbox[4],
        crs = crs_object
)

values(ra_bbox) <- 1:ncell(ra_bbox)

tm_shape(ra_bbox) + tm_raster()

# extract cell centroids as points 
df_points = as.data.frame(rasterToPoints(ra_bbox))
sf_point = st_as_sf(df_points, coords=c("x","y"))
sf_point = st_set_crs(sf_point, st_crs(st_rivers))

sf_point %>%  
        tm_shape() + tm_dots()

# for each point find the closest river segment
nn = st_nearest_feature(x = sf_point,
                        y = st_rivers)
# take rows from rivers in the order that they are the closest segments
st_rivers_resorted = st_rivers[nn,]

# The function map is similar to apply. It is from the purrr package (part of
# the tidyverse). It has an argument .x which provides arguments to a function
# called (and in this case also defined) in .f. A function that is not named is
# called anonymous. In this step we calculate the distance between each point
# and it's closeted river segment.
distance_list <-
        map(.x = 1:nrow(sf_point),
            .f = ~ as.numeric(st_distance(x = sf_point[.x, ],
                                          y = st_rivers_resorted[.x, ]))); beep()
distance_list %<>% unlist()
distance_table = data.table("point_id" = sf_point$layer,
                             "nn_distance" = distance_list,
                             "ecoserv_id"    = st_rivers_resorted$ecoserv_id)

# drop all points that are more than 1000 meters away from the next river 
distance_table = distance_table[nn_distance <= 1000]


# save to file  -----------------------------------------------------------
if (save) {
sf_point %>%  
        filter(layer %in% distance_table$point_id) %>%
        st_write(dsn = file.path(dir_da, "some_points.gpkg"))
}