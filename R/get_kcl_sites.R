#' 
#' @author JJNL : 07/07/2017
#' 
#' @description 
#' Get the KCL site meta data, not
#' all sites are necessarily in London


  get_kcl_sites <- function ()
  
  { 
    theData <- openair::importMeta(source = "kcl", all = TRUE) 
    
    return(theData)
    
  }
  
  # Not run
  # kcl_sites <- get_kcl_sites()
  # Save to file
  # write.table(kcl_sites, file = "kcl_sites.txt",
  #             row.names = FALSE, quote = FALSE, sep = ";")
  # End (Not run)