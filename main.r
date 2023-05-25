library(tools)
library(utils)
#execute script for each project

#set workspace
wd <- "/home/namik/workspace/testScript_R/"


metadata_author <- "namik.scherzl@ird.fr"
datastore <- "sey_msp_vector"
# Ask data location
data_dir <- "/home/namik/Bureau/sey_msp_atlas_base_map_layers" 

# Define project name 
project_name <-"Base map"
generic_sub_str <- c("sey_msp_", "seymsp_")  # If your file have a radical you wants to remove


# create a dictionnary with all files name and path
files <- list.files(data_dir, full.names = TRUE, recursive = TRUE)






zip_files_with_occurence <- function(file_paths) {
  file_dict <- list()
  zipped_files <- list()
  
  # add file to dictionnary if occurence in name
  for (file_path in file_paths) {
    # extract file name 
    file_name <- sub("\\-[^-]*$", "", tools::file_path_sans_ext(basename(file_path)))
    
    # add file to dic
    if (file_name %in% names(file_dict)) {
      file_dict[[file_name]] <- c(file_dict[[file_name]], file_path)
    } else {
      file_dict[[file_name]] <- file_path
    }
  }
  
  # zip file having the same name 
  for (file_name in names(file_dict)) {
    # shapefile have at least 3 files (shp, dbf and shx)
    if (length(file_dict[[file_name]]) > 3) {
      # add the name of the zipped file to the list
      zipped_files[[file_name]] <- file_name
      zip_file_name <- paste0(file_name, ".zip")
      zip::zip(file.path(dirname(file_dict[[file_name]][1]), zip_file_name), files = file_dict[[file_name]], mode = "cherry-pick")
      
    }
  }
  return(zipped_files)
}

# set metadata file name
metadata_file_name <- paste0("metadata_", project_name, ".csv")

create_metadata_csv <- function(files, zipped_files, csv_file_name, df, datastore) {
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
  # for every file in dir or subdir add a line in df      
  for (file in files ){
    file_name <- sub("\\-[^-]*$", "", tools::file_path_sans_ext(basename(file)))
    if(file_name != previous_file) {      
      previous_file <- file_name
      # if file is in list of previous zipped file list
      if(file_name %in% zipped_files){
        print(paste(file_name," is a zipped file"))
        data <- paste0("access:default_\nsource:", file_name, ".zip@",file,"_\nsourceType:shp_\nuploadType:shp_\nuploadSource:",file_name ,".zip_\nstore:",datastore,"_\nupload:true_\nlayername:",file_name,"_\nstyle:generic")
        
      }else if(!(file_name %in% zipped_files)){
        print(paste(file_name," is not a zipped file"))
        data <- paste0("access:default_\nsource:", basename(file),"@",file,"_\nsourceType:shp_\nuploadType:shp_\nuploadSource:",file_name ,".zip_\nstore:",datastore,"_\nupload:true_\nlayername:",file_name,"_\nstyle:generic")
      }
      file_name_with_space <-gsub("_"," ",file_name)
      new_metadata_line <- data.frame(Identifier = paste0("id:", file_name), 
                                      Title = file_name_with_space,
                                      Description = file_name_with_space, 
                                      Subject = paste0("theme[General]:",file_name_with_space,"_\ntheme[Area]:SWIO, Indian Ocean, océan Indien, Seychelles"),
                                      Creator= paste0("owner:j.prosper@env.gov.sc_\npublisher:j.prosper@env.gov.sc_\noriginator:j.prosper@env.gov.sc_\npointOfContact:j.prosper@env.gov.sc_\nmetadata:",metadata_author),
                                      Date= "",
                                      Type= "dataset",
                                      Language= "eng", 
                                      SpatialCoverage= "",
                                      TemporalCoverage= "",
                                      Format= "",
                                      Relation= "thumbnail:thumbnail data@https://drive.ird.fr/apps/files_sharing/publicpreview/7FNMG5TP4reW9xW?x=1920&y=618&a=true&file=seychelles.png&scalingup=0_\nthumbnail:thumbnail data@https://drive.ird.fr/apps/files_sharing/publicpreview/ooDzWPi9DR2nYFd?x=1920&y=618&a=true&file=Seychelles2.png&scalingup=0",
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

create_metadata_csv(files, zipped_files, metadata_file_name, metada_frame, datastore)
