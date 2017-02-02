#' 
#' @author JJNL 
#' @date 02/2/2016
#' 
#' @description 
#' Gets pre-calculated annual air quality objectives   
#' from the London Air website air quality API for 
#' psecific air quality monitoring stations
#' 

  get_site_aq_objectives <- function (theSite = "ZV1", metric = "Annual",
                                      data_type = "MonitoringObjective",
                                      dates = 1980, datee = as.numeric(format(Sys.Date(), "%Y")),
                                      api_type = "Json")
  {
  
  # Create the year range
  theYears <- seq(dates, datee, 1)
    if (length(theYears) == 1) { theYears <- unique(theYears) }
  
  # Create the API
  base_api <- "http://api.erg.kcl.ac.uk/AirQuality/"
      
  the_apis <- paste0(base_api, metric, "/", data_type, "/SiteCode=", theSite, 
                     "/Year=", theYears, "/", api_type)
      
      # Get the data
      theData <- lapply(the_apis, get_laqn_data)
      
      # Drop NAs (for years where there's no data)
      theData <- plyr::ldply(theData[!is.na(theData)], data.frame)
      
      # Make sensible column names
      names(theData) <- gsub("X.|@|Site.Objective\\.{2}|Site\\.{2}|SiteObjectives.", "", names(theData))
      
      # Remove factors
      theData <- data.frame(lapply(theData, as.character), 
                            stringsAsFactors = FALSE)
      
      # Convert columns to numeric
      theData[c("Latitude", "Longitude",
                "LatitudeWGS84", "LongitudeWGS84", 
                "Year", "Value")] <- as.numeric(unlist(theData[c("Latitude", "Longitude",
                                                                 "LatitudeWGS84", "LongitudeWGS84", 
                                                                 "Year", "Value")]))
  
  return(theData)
  
}

  # Not run  
  # site_aq_objectives <- get_site_aq_objectives()
  # Save to file
  # write.table(site_aq_objectives, file = "site_aq_objectives.txt", row.names = FALSE, quote = FALSE, sep = ";")
  # End (Not run)
