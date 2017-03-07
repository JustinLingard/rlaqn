#' 
#' @ JJNL : 13/12/2016
#' 
#' This function gets the KCL/LAQN site meta data for all sites,
#' not necessarily all are in London

kcl_sites <- openair::importMeta(source = "kcl", all = TRUE)