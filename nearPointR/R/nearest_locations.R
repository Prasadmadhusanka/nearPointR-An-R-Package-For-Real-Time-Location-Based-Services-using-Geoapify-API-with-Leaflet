#' Visualizing the Nearest Important Locations relatively User's Current Location on a map using the Leaflet library
#'
#' @param category {"accommodation.hotel", "commercial.supermarket", "catering.restaurant", "catering.cafe", "healthcare.pharmacy", "healthcare.hospital", "education.library", "entertainment.cinema"}
#' @param basemap {"OpenStreetMap", "EsriWorldImagery", "OpenTopoMap"}
#'
#' @return Nearest Important Location markers relatively User's Current Location on selected basemap
#' @export
#'
#' @examples
#' category <- "healthcare.pharmacy"
#' basemap <- "EsriWorldImagery"
#' nearest_locations(category,basemap)
nearest_locations <- function(category, basemap) {

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
    "Location Accuracy: ", accuracy, "m"
  )

  # Add markers for user's current location
  map <- leaflet::addMarkers(map, lng = longitude, lat = latitude, popup = popup_content_current)

  # Add markers for locations
  loc_name_length <- length(loc_name)
  popup_content_loc <- c()
  popup_content_loc <- c(popup_content_loc, loc_name_length)

  for (i in 1:loc_name_length) {
    popup_content_loc[i] <- paste(
      "<strong>",loc_name[i], "</strong>",
      "<br>",
      "Longitude: ",loc_lon[i],
      "<br>",
      "Latitude: ", loc_lat[i],
      "<br>",
      "Distance: ", loc_distance[i], " m",
      "<br>",
      "Street/ House Number: ", loc_street[i], "/ ", loc_house_number[i],
      "<br>",
      "Postal Code: ", loc_postal_code[i],
      "<br>",
      "Opening Hours: ", loc_opening_hours[i],
      "<br>",
      "Phone: ", loc_phone[i],
      "<br>",
      "Website: ", loc_website[i]
    )

    map <- leaflet::addMarkers(map, lng = loc_lon[i], lat = loc_lat[i], popup = popup_content_loc[i],icon = leaflet::makeIcon(iconUrl = "https://raw.githubusercontent.com/pointhi/leaflet-color-markers/master/img/marker-icon-red.png"))
  }

  # Display the map
  map
}
