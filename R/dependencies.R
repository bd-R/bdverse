#' List all dependencies of bdverse
#'
#' 
#'
#' @export
bd_dependencies <- function(recursive = FALSE) {
    dep <- gtools::getDependencies("bdverse")
    dep <- rev(dep)
    dep_desc <- lapply(dep, utils::packageDescription)
    
    # Only first few packages
    if (!recursive) {
        dep_desc <- dep_desc[1:16]
    }
    
    return(
        tibble::tibble(
            Name = unlist(lapply(dep_desc, function(x) {
                return(x$Package)
            })),
            
            Title = unlist(lapply(dep_desc, function(x) {
                return(x$Title)
            })),
            
            Description = unlist(lapply(dep_desc, function(x) {
                return(x$Description)
            })),
            
            Version = unlist(lapply(dep_desc, function(x) {
                return(x$Version)
            })),
            
            Date = unlist(lapply(dep_desc, function(x) {
                return(x$Date)
            })),
            
            License = unlist(lapply(dep_desc, function(x) {
                return(x$License)
            }))
        )
    )
    
}


#' Create citations for all dependencies of bdverse
#'
#' 
#'
#' @export
bd_citation <- function(citation_level = 1,
                        type = "raw", bib_file = NA) {
    #--------- Get dependencies --------------
    dep <- gtools::getDependencies("bdclean")
    dep <- c(dep, "bdverse")
    dep <- rev(dep)
    
    if (citation_level == 3) {
        dep <- dep[1:16]
    } else if (citation_level == 2) {
        dep <- dep[1:5]
    } else if (citation_level == 1) {
        dep <- dep[1]
    }
    
    #--------------- Get Citations -----------
    ans <- list()
    
    if (type == "raw") {
        ans <- lapply(dep, citation)
    } else if (type == "text") {
        ans <- lapply(dep, function(cite) {
            return(format(utils::citation(cite), style = "text"))
        })
    } else if (type == "bibtex") {
        ans <- lapply(dep, function(cite) {
            return(format(utils::citation(cite), style = "Bibtex"))
        })
    } else if (type == "html") {
        ans <- lapply(dep, function(cite) {
            return(format(utils::citation(cite), style = "html"))
        })
    } else if (type == "latex") {
        ans <- lapply(dep, function(cite) {
            return(format(utils::citation(cite), style = "latex"))
        })
    } else {
        stop("Not supported Type")
    }
    
    if (!is.na(bib_file)){
        knitr::write_bib(x = dep, file = bib_file)
        message("File Written!")
    } else {
        return(ans)
    }
}


#' List all packages available in bdverse
#'
#' 
#'
#' @export
bd_packages <- function() {
    pkg_desc <-
        list(
            utils::packageDescription("bdDwC"),
            utils::packageDescription("bdchecks"),
            utils::packageDescription("bdvis"),
            utils::packageDescription("bdclean")
        )
    
    return(
        tibble::tibble(
            Name = unlist(lapply(pkg_desc, function(x) {
                return(x$Package)
            })),
            
            Title = unlist(lapply(pkg_desc, function(x) {
                return(x$Title)
            })),
            
            Description = unlist(lapply(pkg_desc, function(x) {
                return(x$Description)
            })),
            
            Version = unlist(lapply(pkg_desc, function(x) {
                return(x$Version)
            })),
            
            Date = unlist(lapply(pkg_desc, function(x) {
                return(x$Date)
            })),
            
            License = unlist(lapply(pkg_desc, function(x) {
                return(x$License)
            }))
        )
    )
}
