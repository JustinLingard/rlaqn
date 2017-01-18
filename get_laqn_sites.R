#' 
#' @author JJNL : 11/12/2016
#'
#' @description  
#' Gets laqn site meta data from the   
#' London Air website air quality API
#' 

  get_laqn_sites <- function (theGroup = "London",  metric = "Information",
                              data_type = "MonitoringSites", api_type = "Json")
  
  {
    
  # Create the API
  base_api <- "http://api.erg.kcl.ac.uk/AirQuality/"
    
  the_apis <- paste0(base_api, metric, "/", data_type, "/GroupName=", theGroup, 
                     "/", api_type)
  
    # Get the data
    theData <- plyr::ldply(lapply(the_apis, get_laqn_data), data.frame)
  
    # Make sensible column names
    names(theData) <- gsub("Sites.Site\\.{2}", "", names(theData))
  
  return(theData)
  
}

  # Not run
  # laqn_sites <- get_laqn_sites()
  # write.table(laqn_sites, file = "laqn_sites.txt", row.names = FALSE, quote = FALSE, sep = ";")
  # End
  
