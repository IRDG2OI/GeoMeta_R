library(tools)
library(utils)
#execute script for each project

#set workspace
wd <- "/home/namik/workspace/testScript_R/"


metadata_author <- "namik.scherzl@ird.fr"
datastore <- "sey_msp_vector"
# Ask data location
data_dir <- "/home/namik/Bureau/sey_msp_atlas_base_map_layers" #"/home/namik/workspace/geoflow_sey_env/SHAPEFILES/sey_msp_atlas_base_map_layers"


# Define project name 
project_name <-"Base map"
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


# set metadata file name
metadata_file_name <- paste0("metadata_", project_name, ".csv")


create_metadata_csv <- function(csv_file_name) {
        # list of DublinCore fields
        fields <-data.frame(Identifier = character(), 
                            Title = character(),
                            Description = character(), 
                            Subject = character(),
                            Creator= character(), 
                            Date= character(),
                            Type= character(),
                            Language= character(), 
                            SpatialCoverage= character(),
                            TemporalCoverage= character(),
                            Format= character(),
                            Relation= character(),
                            Rights= character(),
                            Provenance= character(),
                            Data= character(), 
                            stringsAsFactors = FALSE)

    write.csv(fields, csv_file_name, row.names = FALSE)
}

initialize_csv <- function(csv_file_name) {
  # create a data frame with three empty columns
  df <- data.frame(toto = character(),
                   tata = character(),
                   titi = character(),
                   stringsAsFactors = FALSE)
  
  # write the data frame to a CSV file
  write.csv(df, file = csv_file_name, row.names = FALSE)
}


# output
create_metadata_csv(metadata_file_name)
#initialize_csv("mon_fichier.csv")
# zip_files_by_name(data_dir)
# print(get_file_name(data_dir, FALSE))

