#' Downloading the dataframe of Nearest Important Locations relatively User's Current Location as csv, geojson or kml format
#'
#' @param category {"accommodation.hotel", "commercial.supermarket", "catering.restaurant", "catering.cafe", "healthcare.pharmacy", "healthcare.hospital", "education.library", "entertainment.cinema"}
#' @param output_format {"csv", "geojson", "kml"}
#'
#' @return csv, geojson or kml file with details of Nearest Important Locations
#' @export
#'
#' @examples
#' category <- "healthcare.pharmacy"
#' output_format <- "kml"
#' download_list(category,output_format)
#' @importFrom utils write.csv
download_list <- function(category, output_format) {

  # Lon, Lat, Accuracy from Google Location API
  api_key <- "PLEASE INSERT YOUR Google Location API"
  url <- "https://www.googleapis.com/geolocation/v1/geolocate?key="
  api_url <- paste0(url, api_key)
  response <- httr::POST(api_url)

  if (httr::status_code(response)==200) {
    parsed_data <- jsonlite::fromJSON(httr::content(response, "text"))
    data_vector <- unlist(parsed_data)

    latitude <- parsed_data$location[[1]]
    longitude <- parsed_data$location[[2]]
    accuracy <- parsed_data$accuracy

  } else {
    cat("Error:", httr::http_status(response)$reason, "\n")
  }

  # GeoAPIfy
  api_url2 <- paste0("https://api.geoapify.com/v2/places?categories=",
                     category,
                     "&filter=circle:",
                     longitude,",",
                     latitude,
                     ",5000&bias=proximity:",
                     longitude,",",
                     latitude,
                     "&lang=en&limit=50&apiKey=PLEASE INSERT YOUR geoapify API"
  )
  response2 <- httr::GET(api_url2)

  if (httr::status_code(response2)==200) {
    parsed_data2 <- jsonlite::fromJSON(httr::content(response2, "text"))
    data_vector2 <- unlist(parsed_data2)

    loc_name <- parsed_data2$features[[2]][["name"]]
    loc_lon <- parsed_data2$features[[2]][["lon"]]
    loc_lat <- parsed_data2$features[[2]][["lat"]]
    loc_house_number <- parsed_data2$features[[2]][["housenumber"]]
    loc_street <- parsed_data2$features[[2]][["street"]]
    loc_postal_code <- parsed_data2$features[[2]][["postcode"]]
    loc_website <- parsed_data2$features[[2]][["datasource"]][["raw"]][["website"]]
    loc_phone <- parsed_data2$features[[2]][["datasource"]][["raw"]][["contact:phone"]]
    loc_opening_hours <- parsed_data2$features[[2]][["datasource"]][["raw"]][["opening_hours"]]
    loc_distance <- parsed_data2$features[[2]][["distance"]]
  } else {
    cat("Error:", httr::http_status(response2)$reason, "\n")
  }

  # create dataframe
  nearest_locations_dataframe <- data.frame(loc_name, loc_lon, loc_lat, loc_distance, loc_street, loc_house_number, loc_postal_code, loc_opening_hours, loc_phone, loc_website)

  # download the files
  if (output_format=="csv") {
    write.csv(nearest_locations_dataframe, "nearest_locations.csv", row.names = FALSE)
  } else if (output_format=="geojson") {
    spatial_dataframe <- sf::st_as_sf(nearest_locations_dataframe, coords = c("loc_lon", "loc_lat"), crs = 4326)
    sf::st_write(spatial_dataframe, "nearest_locations.geojson")
  } else if (output_format=="kml") {
    spatial_dataframe <- sf::st_as_sf(nearest_locations_dataframe, coords = c("loc_lon", "loc_lat"))
    sf::st_write(spatial_dataframe, "nearest_locations.kml", driver = "KML")
  }else {
    write.csv(nearest_locations_dataframe, "nearest_locations.csv", row.names = FALSE)
  }

}
