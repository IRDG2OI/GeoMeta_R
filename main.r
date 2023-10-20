library(tools)
library(utils)

#-*- coding: UTF-8 -*-
#-------------------------[ Define project variable ]--------------------------
project_name <-"my-project"

#Clean prefix on data name
generic_sub_str <- list("sey_msp_", "seymsp_")  # If your file have a radical you wants to remove

# Name of geoserver storage vector / raster
datastore <- "myDataStore_vector" 

# Metadata information
data_owner <- "put data owner email adress"
publisher <-"put data publisher email adress"
originator <-"put data originator email adress"
point_of_contact <-"put point of contact email adress"
metadata_author <- "put metadata author email adress"

# Thumbnail (logo)
thumbnails <- list("Put logo organisation")
theme_area <- "SWIO, Indian Ocean, océan Indien,"

# Put data location
data_dir <- "/home/namik/workspace/geoflow_sey_env/SHAPEFILES" 


#-------------------------[ Process]--------------------------
# Create a dictionnary with all files name and path
files <- list.files(data_dir, full.names = TRUE, recursive = TRUE)

zip_files_with_occurence <- function(file_paths) {
  file_dict <- list()
  zipped_files <- list()

  # Add file to dictionnary if occurence in name
  for (file_path in file_paths) {
    # Extract file name 
    file_name <- sub("\\-[^-]*$", "", tools::file_path_sans_ext(basename(file_path)))

    # Add file to dictionnary
    if (file_name %in% names(file_dict)) {
      file_dict[[file_name]] <- c(file_dict[[file_name]], file_path)
    } else {
      file_dict[[file_name]] <- file_path
    }
  }

  # Zip file having the same name 
  for (file_name in names(file_dict)) {
    # Shapefile have at least 3 files (shp, dbf and shx)
    if (length(file_dict[[file_name]]) >= 3) {
            # Add the name of the zipped file to the list
     zipped_files[[file_name]] <- file_name
     zip_file_name <- paste0(file_name, ".zip")
     zip::zip(file.path(dirname(file_dict[[file_name]][1]), zip_file_name), files = file_dict[[file_name]], mode = "cherry-pick")

    }
  }
  return(zipped_files)
}

# Set metadata file name
metadata_file_name <- paste0("metadata_", project_name, ".csv")



create_metadata_csv <- function(files, zipped_files, csv_file_name, df, datastore,thumbnails, theme_area) {
  # Empty Frame for metadata table
    metadata_frame <- data.frame(Identifier = character(),
                               Title = character(),
                               Description = character(),
                               Subject = character(),
                               Creator = character(),
                               Date = character(),
                               Type = character(),
                               Language = character(),
                               SpatialCoverage = character(),
                               TemporalCoverage = character(),
                               Format = character(),
                               Relation = character(),
                               Rights = character(),
                               Provenance = character(),
                               Data = character(),
                               stringsAsFactors = FALSE)
                               
    previous_file <- ""
    data <- ""
    thumbnails_format <- ""

    # get thumbnails in Geoflow format
    for (thumbnail in thumbnails){
       thumbnails_format <- paste0("thumbnail:thumbnail data@", thumbnail, collapse = "\n")
    } 

    # format contact 

    # for every file in dir or subdir add a line in df      
    for (file in files ){
      file_name <- sub("\\-[^-]*$", "", tools::file_path_sans_ext(basename(file)))
      if(file_name != previous_file) {      
        previous_file <- file_name
     # if file is in list of previous zipped file list 
          if(file_name %in% zipped_files){
              print(paste(file_name," is a zipped file"))
              data <- paste0("access:default_\nsource:", file_name, ".zip@",tools::file_path_sans_ext(file),".zip","_\nsourceType:shp_\nuploadType:shp_\nuploadSource:",file_name ,".zip_\nstore:",datastore,"_\nupload:true_\nlayername:",file_name,"_\nstyle:generic")

          }else if(!(file_name %in% zipped_files)){
            print(paste(file_name," is not a zipped file"))
            data <- paste0("access:default_\nsource:", basename(file),"@",file,"_\nsourceType:shp_\nuploadType:shp_\nuploadSource:",file_name ,".zip_\nstore:",datastore,"_\nupload:true_\nlayername:",file_name,"_\nstyle:generic")
          }
          file_name_with_space <-gsub("_"," ",file_name)
          new_metadata_line <- data.frame(Identifier = paste0("id:", file_name), 
                                          Title = file_name_with_space,
                                          Description = paste0("abstract:",file_name_with_space), 
                                          Subject = paste0("theme[General]:",file_name_with_space,"_\ntheme[Area]:",theme_area),
                                          Creator= paste0("owner:",data_owner,"_\npublisher:",publisher,"_\noriginator:",originator,"_\npointOfContact:",point_of_contact,"_\nmetadata:",metadata_author),
                                          Date= "Creation: _\nPublication: _\nlastRevision:",
                                          Type= "dataset",
                                          Language= "eng", 
                                          SpatialCoverage= "",
                                          TemporalCoverage= "",
                                          Format= "",
                                          Relation= thumbnails_format,
                                          Rights= 'use:NA',
                                          Provenance= 'statement:the data is distributed in shapefiles format. It is an extraction from a GBD database',
                                          Data= data)

       metadata_frame <- rbind(metadata_frame, new_metadata_line)
       write.csv(metadata_frame, csv_file_name, row.names = FALSE)
    }
    }
}

# zip files having occurences 
zipped_files <- zip_files_with_occurence(files)
create_metadata_csv(files, zipped_files, metadata_file_name, metada_frame, datastore, thumbnails,theme_area)
