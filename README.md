## Geometa_R : Package Description

This package provides functionalities to generate a metadata Template in CSV format wich can be edited to add Description or other fields in order to feed an [Geoflow](https://github.com/r-geoflow/geoflow) worklflow.

This code was produced as part of the G2OI project Co-financed by the European Union, the French State and the Réunion Region.

<div  style="float:center;">
	<img height=120  width=198 src="https://upload.wikimedia.org/wikipedia/commons/b/b7/Flag_of_Europe.svg" hspace=10>
	<img height=120  width=140 src="https://upload.wikimedia.org/wikipedia/fr/thumb/2/22/Republique-francaise-logo.svg/512px-Republique-francaise-logo.svg.png?20201008150502" hspace=10 >
	<img height=120  width=260 src="https://upload.wikimedia.org/wikipedia/fr/3/3b/Logolareunion.png" hspace=10 >
</div>
<br>

## Variable Configuration

Before running the code, please ensure that you have correctly configured the following variables:

### Project Variable

-   `project_name`: Specify the name of your project.

### Data Cleaning

-   `generic_sub_str`: This is a list of strings that you want to clean data names. 

### Geoserver Information

-   `datastore`: Specify the name of your Geoserver data store for vector or raster data (if you want to make a deposit on geoserver).

### Metadata Information

-   `data_owner`: Provide the email address of the data owner.
-   `publisher`: Provide the email address of the data publisher.
-   `originator`: Provide the email address of the data originator.
-   `point_of_contact`: Provide the email address of the point of contact.
-   `metadata_author`: Provide the email address of the metadata author.

### Thumbnails and Theme Area

-   `thumbnails`: This is a list of logos or thumbnails related to the organization. Customize it by adding the appropriate logo paths.
-   `theme_area`: Specify the theme area for the data, such as "SWIO, Indian Ocean, océan Indien"

### Data Location

-   `data_dir`: Set the directory path where your shapefiles are located. Update it according to your system.
