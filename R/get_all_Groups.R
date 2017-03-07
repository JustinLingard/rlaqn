#' get_all_Groups 
#' 
#' Returns the kcl GroupNames from the London Air website air quality API
#' 
#' @author JJNL : 07/02/2017
#'
#' @description Gets all kcl GroupNames from the London Air website air quality API
#' @param the_apis The source api
#' @return Groups within the London Air website air quality API
#' @export

  get_all_Groups <- function (metric = "Information", data_type = "Groups",
                                 api_type = "Json")
  
  {
    
  # Create the API
  base_api <- "http://api.erg.kcl.ac.uk/AirQuality/"
    
  the_apis <- paste0(base_api, metric, "/", data_type, "/", api_type)
  
    # Get the data
    theData <- plyr::ldply(lapply(the_apis, get_laqn_data), data.frame)
  
    # Make sensible column names
    names(theData) <- gsub("Groups.Group\\.{2}", "", names(theData))
  
  return(theData)
  
}

  # Not run
  #
  # Get all the GroupNames (networks) from the API
  # theGroups <- get_all_Groups()
  #
  # Generate the site meta data
  # kcl_sites <- get_laqn_sites(theGroup = theGroups$GroupName)
  #
  # write.table(kcl_sites, file = "kcl_sites.txt", row.names = FALSE, quote = FALSE, sep = ";")
  #
  # End (Not run)
