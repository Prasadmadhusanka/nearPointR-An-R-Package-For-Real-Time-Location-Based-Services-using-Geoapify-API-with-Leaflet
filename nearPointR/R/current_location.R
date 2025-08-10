#' Visualizing the User's Current Location on a map using the Leaflet library
#'
#' @param basemap {"OpenStreetMap", "EsriWorldImagery", "OpenTopoMap"}
#'
#' @return User's Current Location marker on selected basemap
#' @export
#'
#' @examples
#' basemap <- "OpenStreetMap"
#' current_location(basemap)
current_location <- function(basemap) {

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

  # Location details from  IPinfo API
  api_url1 <- "http://ipinfo.io/json"
  response1 <- httr::GET(api_url1)

  if (httr::status_code(response1)==200) {
    parsed_data1 <- jsonlite::fromJSON(httr::content(response1, "text"))
    data_vector1 <- unlist(parsed_data)

    city <- parsed_data1$city
    region <- parsed_data1$region
    postalCode <- parsed_data1$postal
    country <- parsed_data1$country
    timeZone <- parsed_data1$timezone
  } else {
    cat("Error:", httr::http_status(response1)$reason, "\n")
  }

  # Adding Leaflet Map
  map <- leaflet::leaflet()

  # Add a tile layer (basemap)
  if (basemap =="OpenStreetMap") {
    map <- leaflet::addTiles(map)
  } else if (basemap =="EsriWorldImagery") {
    map <- leaflet::addTiles(map, urlTemplate = "https://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}", attribution= "Tiles &copy; Esri &mdash; Source: Esri, i-cubed, USDA, USGS, AEX, GeoEye, Getmapping, Aerogrid, IGN, IGP, UPR-EGP, and the GIS User Community")
  } else if (basemap =="OpenTopoMap") {
    map <- leaflet::addTiles(map, urlTemplate = "https://{s}.tile.opentopomap.org/{z}/{x}/{y}.png",attribution = "&copy; OpenTopoMap contributors")
  }else {
    map <- leaflet::addTiles(map)
  }

  # set map center and zoom level
  map <- leaflet::setView(map, lng = longitude, lat = latitude, zoom = 12)

  # Define the content for the popup with multiple lines
  popup_content_current <- paste(
    "<strong>My Location</strong>",
    "<br>",
    "Longitude: ",longitude,
    "<br>",
    "Latitude: ", latitude,
    "<br>",
    "Postal Code: ", postalCode,
    "<br>",
    "City/ State: ", city, "/ ", region,
    "<br>",
    "Country: ", country,
    "<br>",
    "Time Zone: ", timeZone,
    "<br>",
    "Location Accuracy", accuracy, "m"
  )

  # Add markers for current location
  map <- leaflet::addMarkers(map, lng = longitude, lat = latitude, popup = popup_content_current)

  # Display the map
  map
}
