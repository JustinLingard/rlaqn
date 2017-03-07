#' 
#' @author JJNL 
#' @date 21/12/2016
#' 
#' Gets data from an API. If unsuccessful it
#' generates warnings and errors as necessary
#'

get_laqn_data <- function(x){ 
  
  out <- tryCatch(
      
      {

          { lapply(x, jsonlite::fromJSON, simplifyDataFrame = TRUE, flatten = TRUE) }

        },
        error = function(cond) {
          message(paste0("URL does not seem to exist:", x))
          message("Here's the error message:")
          message(cond)
          message("\n")
          # Choose a return value in case of error
          return(NA)

        },
        warning = function(cond) {
          message(paste0("URL caused a warning:", x))
          message("Here's the warning message:")
          message(cond)
          message("\n")
          # Choose a return value in case of warning
          return(NULL)

        },
        finally = { message(paste("Getting data from:", x)) }
    )    
      
return(out)
  
}
      

