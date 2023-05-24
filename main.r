# library(tools)
library(utils)
#execute script for each project

#set workspace
wd <- "/home/namik/workspace/testScript_R/"


metadata_author <- "namik.scherzl@ird.fr"
datastore <- "sey_msp_vector"
# Ask data location
data_dir <- "/home/namik/Bureau/sey_msp_atlas_base_map_layers" #"/home/namik/workspace/geoflow_sey_env/SHAPEFILES/sey_msp_atlas_base_map_layers"


# Define project name 
project_name <- "Base map"
generic_sub_str <- c("sey_msp_", "seymsp_")  # If your file have a radical you wants to remove


# create a dictionnary with all files name and path
fichiers <- list.files(data_dir, full.names = TRUE, recursive = TRUE)
file_list <- list()
for (file in fichiers){
  file_name <- basename(file)
  file_dir <- dirname(file)
  file_list[[file_name]] <- file_dir
}

# create temp dir for zip
temp_zip_file <- paste0(wd, "temp_zip_file/")
if (!dir.exists(temp_zip_file)) {
    dir.create(temp_zip_file)
}


# for each element of dictionnary 
# - test if raster shapefile or gpkg
#   |==> if shp then zip the files 




print(file_list)


# get_file_name <- function(folder,isrecursive) {
#   file_list <- sort(dir(folder, full.names = TRUE, 
#   no.. = TRUE, recursive = isrecursive))

#   # list only files by name
#   file_groups <- c()
#   for (file in file_list) {
#     file_info <- file.info(file)
#     if (isFALSE(file_info$isdir)) { 
#       file_name <- tools::file_path_sans_ext(basename(file))
#       # ignore redundant value
#       if (!(file_name %in% file_groups) && !grepl("\\(1\\)$", file_name)) {
#         file_groups <- c(file_groups, file_name)
#       }
#     }
#   }
#   return(file_groups)
# }

create_metadata_csv <- function(project_name) {
        # set file name
        dc_file_name <- paste0("metadata_", project_name, ".csv")
        # list of DublinCore fields
        fields <-c("Identifier", 
        "Title", 
        "Description", 
        "Subject", 
        "Creator", 
        "Date",
        "Type",
        "Language", 
        "SpatialCoverage",
        "TemporalCoverage",
        "Format",
        "Relation",
        "Rights",
        "Provenance",
        "Data")

    write.csv(data.frame(t(fields)), file = dc_file_name, row.names = FALSE) 
}


# output

# zip_files_by_name(data_dir)
# print(get_file_name(data_dir, FALSE))
