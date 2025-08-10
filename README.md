# nearPointR-An R Package for Real-Time Location based services using Geoapify API with Leaflet

## Repository Overview

This repository contains the complete development and documentation of the R package **nearPointR**. It leverages real-time geospatial and non-spatial data from the Geoapify REST API to deliver dynamic, location-based services tailored to the user’s current location. Installation instructions and usage guides are also included.

## **Technologies Used**
![R](https://img.shields.io/badge/R-276DC3?style=for-the-badge&logo=r&logoColor=white)
![Leaflet for R](https://img.shields.io/badge/Leaflet-R-4CAF50?style=for-the-badge&logo=leaflet&logoColor=white)
![REST API](https://img.shields.io/badge/REST_API-FF6C40?style=for-the-badge&logo=postman&logoColor=white) 
![Geoapify](https://img.shields.io/badge/Geoapify-FF6C00?style=for-the-badge&logo=geoapify&logoColor=white)
![Google Location API](https://img.shields.io/badge/Google_Location_API-F4B400?style=for-the-badge&logo=googlemaps&logoColor=white)
![Google Maps](https://img.shields.io/badge/Google_Maps-F4B400?style=for-the-badge&logo=googlemaps&logoColor=white)
![RStudio](https://img.shields.io/badge/RStudio-75AADB?style=for-the-badge&logo=rstudio&logoColor=white) 
![R Markdown](https://img.shields.io/badge/R_Markdown-2D69C7?style=for-the-badge&logo=r&logoColor=white)
![VS Code](https://img.shields.io/badge/VS%20Code-007ACC?style=for-the-badge&logo=visual-studio-code&logoColor=white) 
![Git](https://img.shields.io/badge/Git-F05032?style=for-the-badge&logo=git&logoColor=white) 
![GitHub](https://img.shields.io/badge/GitHub-181717?style=for-the-badge&logo=github&logoColor=white)

## Table of Content

- [Introduction and Motivation](#introduction-and-motivation)
- [Package Overview](#package-overview)
- [Installation Instructions and Usage Guides](#installation-instructions-and-usage-guides)
- [Methodology](#methodology)
  - [Data Description and Exploration](#data-description-and-exploration)
  - [R Package Development](#r-package-development)
- [Results](#results)
- [Discussion](#discussion) 

## Introduction and Motivation

In the modern world, advancing technology has gained immense significance for location-based services. The ability to quickly find nearby essential locations such as **pharmacies, hotels, supermarkets, restaurants, hospitals**, and more has become an integral part of daily life. The concept of location-based services has revolutionized the way individuals navigate and interact with their environment. With the development of smartphones and web applications, users now expect quick and accurate information about nearby services. Traditional maps and navigation tools have evolved into interactive platforms that provide real-time data visualization, transforming location awareness into a more engaging and informed experience.

The motivation behind the development of this R package lies in the need to empower users with a comprehensive tool to easily explore their surroundings and make informed decisions. Existing applications offer high levels of customizability and advanced data visualization but often lack options for downloading data. Developers typically rely on cleaned datasets and visualizations for their applications, which requires direct use of APIs. This package bridges that gap by providing data download options, using cleaned data that removes unwanted or unclean entries, and eliminating the need for API keys.

### Package Overview

This R package designed to enhance location-based decision-making through interactive visualization. The package use **[Leaflet](https://leafletjs.com/)**, a powerful open-source R package for interactive maps, **httr, jsonlite, utils, sf** and three external geographic APIs to provide current location of user’s with valuable information about their surroundings. The package’s flexible to allow users to customize basemaps according to their preferences. With options such as **[OpenStreeMap](https://www.openstreetmap.org/#map=5/51.33/10.45), [EsriWorldImagery](https://www.arcgis.com/home/item.html?id=10df2279f9684e4a9f6a7f08febac2a9)** and **[OpenTopoMap](https://opentopomap.org/#map=5/49.023/10.020)**, users can tailor the visualization experience to suit their needs.

### Installation instructions and Usage guides

- basemap { **OpenStreeMap , EsriWorldImagery , OpenTopoMap** }
- category { **accommodation.hotel , commercial.supermarket , catering.restaurant , catering.cafe , healthcare.pharmacy , healthcare.hospital , education.library , entertainment.cinema** }
- output_format { **csv , geojson , kml** }

**The developed R package introduces a set of functions to enhance the location-based experience for users as follows**

- **current_location:** Visualizes the user's current location on an interactive map
- **show_list:** Users can select specific types of locations, such as pharmacies, hotels, restaurants, etc. and visualize the nearest 50 locations of the selected type within a 10km 
  range. This help users in identifying the availability and proximity of essential services.
- **download_list:** Users can download the detailed information of the nearest locations as CSV, GeoJSON, or KML formats. This functionality is particularly useful for users who wish to 
  analyze the data in external tools or share it with others.
- **navigate_to_closest:** Facilitates navigation to the closest important location using Google Maps, enhancing the usability of the package in practical scenarios.
- **nearest_locations**: Provides an interactive map visualization with Leaflet library for the 50 nearest important locations relative to the user's current location.
  
**The developed package has a wide range of potential applications, including:**

- **Tourism and Travel Planning:** Travelers can quickly locate services and points of interest in a new city, enabling them to make efficient plans.
- **Emergency Situations:** During emergencies, individuals can easily identify the nearest hospitals and pharmacies. 
- **Business Decision-Making:** Entrepreneurs can analyze the distribution of competitors and potential customers to make informed business decisions.

## Methodology 

### Data Description and Exploration

This package uses Google Location API and ipinfo API for obtaining the user’s current location and details of current location. This package also uses data extracted from an **[GeoAPIfy](https://www.geoapify.com/#:~:text=Geoapify%20is%20a%20feature%2Drich,%2C%20geodata%20access%2C%20and%20more.)**, which provides information about various important locations in a given geographical area. The data includes attributes such as location name, geographical coordinates, street name, and many more. The URL of the API can be customized according to the customer requirements. For this package URL was customized to 50 numbers of point’s lies within the 10km range. 

```{r}
category <- "accommodation.hotel"
longitude <- 7.6009394 # When executing computer obtain this from Google location API
latitude <- 51.956711 # When executing computer obtain this from Google location API
api_url <- paste0("https://api.geoapify.com/v2/places?categories=",
                     category,
                     "&filter=circle:",
                     longitude,",",
                     latitude,
                     ",5000&bias=proximity:",
                     longitude,",",
                     latitude,
                     "&lang=en&limit=50&apiKey=YOUR API KEY"
  )
print(api_url)
#> [1] "https://api.geoapify.com/v2/places?categories=accommodation.hotel&filter=circle:7.6009394,51.956711,5000&bias=proximity:7.6009394,51.956711&lang=en&limit=50&apiKey=YOUR API KEY"
```

Understanding the structure and content of the data is essential for maximizing the utility of the Interactive Nearest Location Visualization R package. The data exploration process provides available data attributes, their distributions, and potential patterns. Here are some key aspects of data exploration:

#### 1.	Data Attributes:

On map view, following data attributes can be seen in popups. And also these data attributes can be seen in downloaded formats (csv, geojson, kml)

- Location Name: The name of the important location, such as a specific restaurant or pharmacy.
- Latitude and Longitude: The geographic coordinates that pinpoint the location on a map.
- Distance: distance to specific location from user’s current location
- Street- Street number
- House number – House number of the location
- Postal code – Postal code for specific location
- Opening hours – Opening hours for service
- Phone number – Contact number
- Web site – Web site relevant to service

#### 2. Spatial Distribution:

Analyzing the distribution of location data on a map helps identify clusters and trends. Visualizing the spatial distribution of various location types can reveal the geographic availability of different services.

**3. Proximity Analysis and Navigation:**

By calculating the distances between the user’s current location and the nearest important locations of different types, it’s possible to understand the accessibility of various services. This analysis can highlight areas that may lack specific services within a certain radius

### R Package Development 

The development and implementation of the "nearPointR" package involves several key steps, ranging from package creation to visualization and deployment. Below is a detailed overview of the entire process.

#### 1. Initializing the Package with `create_package()`

**a. Initialize the Package:**

- Start by calling the `create_package()` function to set up a new package in a specified directory on computer. If the directory doesn't exist yet, `create_package()` will create it.

   ```r
   create_package("~/path/to/nearPointR")
   ```

**b. Leverage the `devtools` Package:**

- The `devtools` package is commonly used by R developers for creating, testing, and managing R packages. It provides a comprehensive suite of functions that simplify the package development process.

- When create a new R package using the `create_package()` function from the `devtools` package, it sets up a directory structure that includes several critical files and subdirectories. These components are vital for the organization, building, and distribution of R package.

#### 2. Key Files and Subdirectories Created by `create_package()`

- **`.Rbuildignore` and `.gitignore`:** These files help control what gets included in the final package and what is tracked by version control. `.Rbuildignore` ensures that unnecessary files are excluded during the build process, while `.gitignore` prevents certain files from being tracked by Git.

- **`DESCRIPTION`:** This file is crucial for defining the package's identity, including its name, version, author information, and dependencies. It is essential for the package's distribution and installation, as it provides the metadata that R and package management tools use to handle the package.

- **`NAMESPACE`:** The `NAMESPACE` file manages the package's interface, controlling which functions and objects are exported for use by others. It also ensures that dependencies are correctly imported and that there is no conflict with other packages.

- **`R/ Directory`:** This is where the core code of your package resides, making it the most important part of your package. All your functions, classes, and other R code will be stored here.

- **`.Rproj File and .Rproj.user Directory`:** The `.Rproj` file and `.Rproj.user` directory enhance the development experience in RStudio by managing your project-specific settings and environment. This includes configurations for your workspace, build tools, and other session-specific settings.

These files and directories are fundamental to the structure and functionality of your R package, ensuring that it is well-organized, easy to develop, and ready for distribution.

![create_package](https://github.com/Prasadmadhusanka/Development-of-comprehensive-R-Package-for-visualization-interactive-nearest-location-using-Leaflet/blob/main/images/create%20package.PNG)

#### 3. Initialize Git with `use_git()`

Next, use the `use_git()` function to initialize a Git repository in current project directory. This function is often used alongside `devtools` during R package development.

![use_git](https://github.com/Prasadmadhusanka/Development-of-comprehensive-R-Package-for-visualization-interactive-nearest-location-using-Leaflet/blob/main/images/use_git.PNG)

#### 4. Deveploing Functions

There are five functions developed for R package as follows;

- `current_location` :	Visualizing the User's Current Location on a map using the Leaflet library
- `download_list` : 	Downloading the dataframe of Nearest Important Locations relatively User's Current Location as csv, geojson or kml format
- `navigate_to_closest` :	Navigate to the Closest Important Location relatively User's Current Location using Google map in your Web browser
- `nearest_locations` :	Visualizing the Nearest Important Locations relatively User's Current Location on a map using the Leaflet library
- `show_list` :	Showing the details of Nearest Important Locations relatively User's Current Location as dataframe

#### 5. Create R Script Files with use_r()

Next, use the use_r() function to create new R script files within your R package project. These files are stored in the R/ directory, which is the central location for all the R functions and code that form the core functionality of your package.

![use_r](https://github.com/Prasadmadhusanka/Development-of-comprehensive-R-Package-for-visualization-interactive-nearest-location-using-Leaflet/blob/main/images/use_r.png)

#### 6. Load Package with `load_all()`

The `load_all()` function from the `devtools` package is an essential tool for R package development. It simplifies the process of loading and testing  package’s functions as it work. When call `load_all()`, it loads all the functions and objects from  package’s `R/` directory directly into your R session. This allows you to test and interact with  package as if it were installed, but without the need to go through the full build and installation process.

Instead of installing the package `load_all()` lets quickly load the package code for immediate use. This is particularly useful for rapid development and testing. Each time make changes to  package code, running `load_all()` ensures that the most recent version is loaded into  R session, allowing to instantly test updates without reinstalling the package.

#### 7. Validate R Package with `check()`

Next, use the `check()` function from the `devtools` package to ensure the quality and integrity of  R package. Running `check()` helps confirm that  package meets CRAN standards and follows best practices for R package development. 

The `check()` function performs automated checks on various aspects of the package, including its structure, documentation, and code quality. It runs the same checks as `R CMD check`, the standard for package validation in R.

- **Documentation:** It verifies that all functions and datasets are properly documented, ensuring that comments are correctly converted into `.Rd` files and that all documentation fields are complete.
- **Code Quality:** It checks that code follows standard R coding practices, such as naming conventions and formatting, to maintain consistency and readability.
- **Dependencies:** It ensures that all package dependencies are correctly specified and that the package can be built and installed without any missing dependencies.

The function provides a detailed report of any errors, warnings, or notes, helping you identify and resolve issues before distributing your package.

![check](https://github.com/Prasadmadhusanka/Development-of-comprehensive-R-Package-for-visualization-interactive-nearest-location-using-Leaflet/blob/main/images/check.PNG)

#### 8. Edit the `DESCRIPTION` File

Next, edit the `DESCRIPTION` file, which is a crucial part of any R package. This file contains important metadata about package, such as its name, version, and dependencies. This information helps others understand the package’s purpose and requirements.

Properly editing the `DESCRIPTION` file is key to ensuring that your package is correctly configured, meets standards, and works as expected.

- **Dependencies:** Lists the R packages  package relies on, ensuring that all necessary dependencies are installed when package is used.
- **License:** Specifies the license under which package is distributed, informing users of their rights and obligations.
- **Additional Info:** Includes details like the package’s URL, where to report bugs, and the names of collaborators.

Accurate and complete information in the `DESCRIPTION` file is essential for package’s distribution and use.

![edit_desc](https://github.com/Prasadmadhusanka/Development-of-comprehensive-R-Package-for-visualization-interactive-nearest-location-using-Leaflet/blob/main/images/edit_description.PNG)

#### 9. Add an MIT License with `use_mit_license()`

Use the `use_mit_license()` function to add an MIT License to  R package. The MIT License is a widely-used, simple, and permissive open-source license. It allows others to use, modify, and distribute code freely, as long as they include the original copyright notice and license text.

When call `use_mit_license()`, it creates a `LICENSE` file in the root directory of  package. This file contains the text of the MIT License and includes placeholders for the author’s name and the year, which should update to reflect details.

Including this license file in  package clearly communicates the terms under which others can use, modify, and distribute  code. The MIT License is permissive and widely understood, which can encourage other developers to use and contribute to package while protecting  rights as the author.

![mit_lic](https://github.com/Prasadmadhusanka/Development-of-comprehensive-R-Package-for-visualization-interactive-nearest-location-using-Leaflet/blob/main/images/mit_license.png)

#### 10. Document R Package with `document()`

Call the `document()` function from the `devtools` package to generate documentation for  R package based on comments and annotations in  R script files. This function converts Roxygen2 comments into `.Rd` files, which are the standard format for R package documentation.

Following shows what `document()` does:

- **Creates `.Rd` Files:** It generates documentation files in the `man/` directory, which are used to create help pages for  functions, datasets, and other objects.
- **Updates Documentation:** It ensures that the documentation matches the latest comments in R scripts.
- **Updates `NAMESPACE`:** It adjusts the `NAMESPACE` file to include any new functions or datasets that documented and updates the exports as needed.

Using `document()` keeps  package’s documentation up-to-date and aligned with  code.

![document](https://github.com/Prasadmadhusanka/Development-of-comprehensive-R-Package-for-visualization-interactive-nearest-location-using-Leaflet/blob/main/images/document.png)

#### 11. Run `check()` Again

After using the `document()` function to update the package documentation, it’s important to run `check()` once more. This step verifies that everything in R package is working correctly and follows best practices. Ideally, `check()` should now pass `R CMD check` with 0 errors, 0 warnings, and 0 notes, ensuring the R package is in good shape.

![check_again](https://github.com/Prasadmadhusanka/Development-of-comprehensive-R-Package-for-visualization-interactive-nearest-location-using-Leaflet/blob/main/images/check_again.PNG)

#### 12. Install Package with `install()`

The `install()` function from the `devtools` package installs  R package locally in machine. This is a key step in development, as it allow to test and use the package just like any other installed package from CRAN or another repository. 

Follows shows what `install()` does:

- **Builds and Installs:** It builds the package from source, including compiling any C/C++ code if needed, and installs it into local R library.
- **Loads for Testing:** After installation, can load the package using `library(packageName)` and test it in R environment.
- **Applies Changes:** Each time make changes to R package, use `install()` to apply those changes locally and ensure everything works correctly before finalizing or distributing the package.

This function is crucial for the development workflow, allowing  to iteratively build, install, and test R package.

![install](https://github.com/Prasadmadhusanka/Development-of-comprehensive-R-Package-for-visualization-interactive-nearest-location-using-Leaflet/blob/main/images/install.PNG)

#### 13. Set Up Testing with `use_testthat()`

The `use_testthat()` function from the `usethis` package sets up the `testthat` framework for testing  R package. `testthat` is a popular tool for unit testing in R, helping to ensure R package functions correctly.

Following shows what `use_testthat()` does:

- **Creates a Testing Directory:** It creates a `tests/testthat/` directory in  package structure, where  organize and run  tests.
- **Adds Dependency:** It adds `testthat` as a dependency in package’s `DESCRIPTION` file, making sure it’s installed when the package is used.
- **Generates Sample Tests:** It creates a sample test file (`tests/testthat/testthat.R`) with basic content to help get started with writing tests and sets up the necessary configuration for running tests with `testthat`.

This function helps to get started with testing your package efficiently.

![test](https://github.com/Prasadmadhusanka/Development-of-comprehensive-R-Package-for-visualization-interactive-nearest-location-using-Leaflet/blob/main/images/test.png)

#### 14. Add Dependencies with `use_package()`

The `use_package()` function from the `usethis` package makes it easy to add package dependencies to R package. This function helps to declare which other packages that R package depends on, ensuring they are installed and available when  package is used.

Following shows what `use_package()` does:

- **Updates `DESCRIPTION`:** It adds the specified package to the `Imports`, `Depends`, or `Suggests` field in package’s `DESCRIPTION` file, based on the arguments provided.
- **Updates `NAMESPACE`:** It modifies the `NAMESPACE` file to import functions from the specified package, making them available for use in package.

By properly declaring dependencies, ensure that anyone using or developing  package will have the required packages installed, which helps prevent issues related to missing dependencies.

#### 15. Create a README with `use_readme_rmd()`

The `use_readme_rmd()` function from the `usethis` package sets up a README file forR package using R Markdown. R Markdown lets create a README that can include both code and narrative text.

Following shows what `use_readme_rmd()` does:

- **Creates a README File:** It generates a `README.Rmd` file with a basic template to help to get started.
- **Includes a Template:** The template has placeholders for key sections like package description, installation instructions, and usage examples.

This function helps to create a well-structured README that provides clear and comprehensive information about R package.

![rmd](https://github.com/Prasadmadhusanka/Development-of-comprehensive-R-Package-for-visualization-interactive-nearest-location-using-Leaflet/blob/main/images/rmd.PNG)

#### 16. Final Checks and Installation

After setting up  R package with functions, documentation, and tests,  need to ensure everything is working correctly. This is where the `check()` and `install()` functions come in:

- **`check()`:** Verifies that R package is well-structured and meets all necessary standards.
- **`install()`:** Installs the package locally so can test it as if it were a finished product.

![check_final](https://github.com/Prasadmadhusanka/Development-of-comprehensive-R-Package-for-visualization-interactive-nearest-location-using-Leaflet/blob/main/images/check_final.PNG)

![install_final](https://github.com/Prasadmadhusanka/Development-of-comprehensive-R-Package-for-visualization-interactive-nearest-location-using-Leaflet/blob/main/images/install_final.PNG)

#### 17. Creating Vignettes

Creating vignettes for R package is a key step in providing detailed documentation and usage examples. Vignettes are comprehensive guides or tutorials that show how to use R package in a more detailed and narrative way than standard documentation.

![vigneetee](https://github.com/Prasadmadhusanka/Development-of-comprehensive-R-Package-for-visualization-interactive-nearest-location-using-Leaflet/blob/main/images/vigneete.png)

Following shows simple step-by-step guide to creating vignettes:

**a. Set Up knitr and rmarkdown**

Vignettes are written in R Markdown (.Rmd files). Install the knitr and rmarkdown packages to create and render them.

```{r}
install.packages(c("knitr", "rmarkdown"))
```
**b. Add the Vignettes Directory**

Create a vignettes directory in  package structure if it doesn’t exist. This is where store all vignette files.

```{r}
usethis::use_vignette("vignette-name")
```
This command creates a new R Markdown file and updates the DESCRIPTION file.

**c. Edit the Vignette**

Open the new R Markdown file in the vignettes directory and edit it to include:

- Title and Metadata: Add a title and other details at the top using YAML syntax.
- Narrative Text: Write detailed explanations of package’s features and uses.
- Code Chunks: Include R code examples wrapped in {r} to show how to use  package.

**d. Build and Test**

Use devtools::build_vignettes() and devtools::check() to make sure  vignette is included and works correctly.

#### 18. Building and Installing the Package

To compile your R package into a .tar.gz file that can be shared or uploaded to repositories like CRAN or GitHub, use

```{r}
devtools::build()
```
## Results 

The results provide a deeper understanding of the spatial distribution of important locations, their accessibility, and their characteristics. Here, discuss obtained results and their significance

```{r}
library(nearPointR)
```

### 1. Visualizes the user’s current location on an interactive map

```{r}
basemap <- "OpenStreetMap"
current_location(basemap)
```
![currentloc1](https://github.com/Prasadmadhusanka/Development-of-comprehensive-R-Package-for-visualization-interactive-nearest-location-using-Leaflet/blob/main/images/currentloc%201.PNG)

```{r}
basemap <- "EsriWorldImagery"
current_location(basemap)
```
![currentloc2](https://github.com/Prasadmadhusanka/Development-of-comprehensive-R-Package-for-visualization-interactive-nearest-location-using-Leaflet/blob/main/images/currentloc%202.PNG)

### 2. Spatial Distribution and Accessibility

The spatial distribution of different types of important locations offers a clear overview of areas with high concentrations of services. This information help users in identifying commercial zones, popular residential areas, and potential gaps in service coverage. For instance, a dense cluster of restaurants in a particular area might indicate a vibrant dining scene, while a sparse distribution of pharmacies could highlight a need for improved accessibility to healthcare services.

```{r}
category <- "healthcare.pharmacy"
basemap <- "EsriWorldImagery"
nearest_locations(category,basemap)
```
![phamacy](https://github.com/Prasadmadhusanka/Development-of-comprehensive-R-Package-for-visualization-interactive-nearest-location-using-Leaflet/blob/main/images/pharmacy.png)

```{r}
category <- "healthcare.hospital"
basemap <- "OpenStreetMap"
nearest_locations(category,basemap)
```
![phamacy2](https://github.com/Prasadmadhusanka/Development-of-comprehensive-R-Package-for-visualization-interactive-nearest-location-using-Leaflet/blob/main/images/phamcy2.png)

### 3. Proximity Analysis and Navigation Route Planning

The average distances to nearest important locations provide users with essential information for planning their routes and optimizing their travel time. The package’s functionality assists users in finding the closest services, reducing travel distances, and making more efficient choices.

```{r}
category <- "healthcare.hospital"
navigate_to_closest(category)
```
![google](https://github.com/Prasadmadhusanka/Development-of-comprehensive-R-Package-for-visualization-interactive-nearest-location-using-Leaflet/blob/main/images/navigate.png)

After executing Google map will open on your default web browser with best navigation route to closest category marker. **Screenshot of Output** 

### 4. Showing nearest locations data as dataframe

![dataframe](https://github.com/Prasadmadhusanka/Development-of-comprehensive-R-Package-for-visualization-interactive-nearest-location-using-Leaflet/blob/main/images/sc1.png)

### Download the dataframe as csv or geojson or kml format

```{r}
category <- "healthcare.pharmacy"
output_format <- "kml"
download_list(category,output_format)
#> writing: substituting ENGCRS["Undefined Cartesian SRS with unknown unit"] for missing CRS
#> Writing layer `nearest_locations' to data source 
#>   `nearest_locations.kml' using driver `KML'
#> Warning in CPL_write_ogr(obj, dsn, layer, driver,
#> as.character(dataset_options), : GDAL Error 6: Cannot find coordinate
#> operations from `ENGCRS["Undefined Cartesian SRS with unknown
#> unit",EDATUM["Unknown engineering
#> datum"],CS[Cartesian,2],AXIS["x",unspecified,ORDER[1],LENGTHUNIT["unknown",0]],AXIS["y",unspecified,ORDER[2],LENGTHUNIT["unknown",0]]]'
#> to `EPSG:4326'
#> Warning in CPL_write_ogr(obj, dsn, layer, driver, as.character(dataset_options), : GDAL Message 1: Failed to create coordinate transformation between the input coordinate system and WGS84.  This may be because they are not transformable.  KML geometries may not render correctly.  This message will not be issued any more.
#> Source:
#> LOCAL_CS["Undefined Cartesian SRS with unknown unit",
#>     UNIT["unknown",0],
#>     AXIS["X",OTHER],
#>     AXIS["Y",OTHER]]
#> Writing 50 features with 8 fields and geometry type Point.
#> Warning in CPL_write_ogr(obj, dsn, layer, driver,
#> as.character(dataset_options), : GDAL Message 1: Value 'A3' of field
#> nearest_locations.loc_distance parsed incompletely to integer 0.
#> Warning in CPL_write_ogr(obj, dsn, layer, driver,
#> as.character(dataset_options), : GDAL Message 1: Value '22-23' of field
#> nearest_locations.loc_distance parsed incompletely to integer 22.
#> Warning in CPL_write_ogr(obj, dsn, layer, driver,
#> as.character(dataset_options), : GDAL Message 1: Value '2b' of field
#> nearest_locations.loc_distance parsed incompletely to integer 2.
#> Warning in CPL_write_ogr(obj, dsn, layer, driver,
#> as.character(dataset_options), : GDAL Message 1: Value '97-101' of field
#> nearest_locations.loc_distance parsed incompletely to integer 97.
```

## Discussion

The analysis of the data set using the Interactive Nearest Location Visualization R package demonstrates its capabilities in providing valuable insights to users. The visualization reveals the concentration of different services, aiding users in identifying popular areas. Proximity analysis indicates the accessibility of various services, with an average distance that can assist users in planning their routes. A deep understanding of the data attributes, patterns, and distributions enables users to make informed decisions when utilizing the package’s functionalists. By combining the power of interactive maps, geographic APIs, and exploratory data analysis, the package provides users with a comprehensive tool for effectively navigating their surroundings and accessing essential services.

## THANK YOU FOR READING THIS DOCUMENTAION

## ENJOY WITH ‘nearPointR’ FOR YOUR DAY TODAY ACTIVITIES
