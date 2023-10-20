## Geometa_R : Package Description

This package provides functionalities to generate a metadata Template in CSV format wich can be edited to add Description or other fields in order to feed an [Geoflow](https://github.com/r-geoflow/geoflow) worklflow.

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

### Funding
This Code was developed as part of the INTERREG V - G2OI project, cofinanced by the European union, the Reunion region, and the French Republic.

<div  style="float:left;">
	<img height=100  width=178  src="https://upload.wikimedia.org/wikipedia/commons/b/b7/Flag_of_Europe.svg">
	<img height=100  width=120 src="https://upload.wikimedia.org/wikipedia/fr/thumb/2/22/Republique-francaise-logo.svg/512px-Republique-francaise-logo.svg.png?20201008150502"   >
	<img height=100  width=240  src="https://upload.wikimedia.org/wikipedia/fr/3/3b/Logolareunion.png">
	<img height=50  width=180  src="https://regionreunion.com/IMG/jpg/interreg_vi_fr.jpg">
</div>
<br>
