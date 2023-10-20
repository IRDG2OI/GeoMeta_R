## Geometa_R : Package Description

This package provides functionalities to generate a metadata Template in CSV format wich can be edited to add Description or other fields in order to feed an [Geoflow](https://github.com/r-geoflow/geoflow) worklflow.

This code was produced as part of the G2OI project Co-financed by the European Union, the French State and the Réunion Region.

<img height=120  width=198  src="https://upload.wikimedia.org/wikipedia/commons/b/b7/Flag_of_Europe.svg">
<img  src="https://upload.wikimedia.org/wikipedia/fr/thumb/2/22/Republique-francaise-logo.svg/512px-Republique-francaise-logo.svg.png?20201008150502"  height=120  width=140/>
<img  height=120  width=260  src="https://upload.wikimedia.org/wikipedia/fr/3/3b/Logolareunion.png">


## Variable Configuration

Before running the code, please ensure that you have correctly configured the following variables:

### Project Variable

-   `project_name`: Specify the name of your project.

### Data Cleaning

-   `generic_sub_str`: This is a list of strings that you want to remove from the data names. Customize it as per your requirements.

### Geoserver Information

-   `datastore`: Specify the name of your Geoserver data store for vector or raster data.

### Metadata Information

-   `data_owner`: Provide the email address of the data owner.
-   `publisher`: Provide the email address of the data publisher.
-   `originator`: Provide the email address of the data originator.
-   `point_of_contact`: Provide the email address of the point of contact.
-   `metadata_author`: Provide the email address of the metadata author.

### Thumbnails and Theme Area

-   `thumbnails`: This is a list of logos or thumbnails related to the organization. Customize it by adding the appropriate logo paths.
-   `theme_area`: Specify the theme area for the data, such as "SWIO, Indian Ocean, océan Indien."

### Data Location

-   `data_dir`: Set the directory path where your shapefiles are located. Update it according to your system.

## Process

The code provided performs the following tasks:

1.  It creates a dictionary of all file names and paths located in the specified `data_dir`.
2.  It zips files that have the same name by using the `zip_files_with_occurence` function.
3.  It creates a metadata CSV file by using the `create_metadata_csv` function. This function takes the file dictionary, zipped file names, metadata file name, metadata frame, datastore information, thumbnails, and theme area as input.
