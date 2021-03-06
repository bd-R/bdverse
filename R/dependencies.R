#' List all dependencies of bdverse
#'
#' @param recursive Whether to return recursive rependencies as well.
#' 
#' @return tibble of dependency list
#' 
#'
#' @import tibble
#'
#' @export
bd_dependencies <- function(recursive = FALSE) {
    
    # Only direct packages
    if (recursive) {
        dep <- gtools::getDependencies("bdverse")
        dep <- rev(dep)
    } else {
        dep <-
            c(
                "DT",
                "assertive",
                "data.table",
                "finch",
                "golem",
                "gtools",
                "kableExtra",
                "knitr",
                "leaflet",
                "magrittr",
                "methods",
                "rgbif",
                "rmarkdown",
                "rstudioapi",
                "shiny",
                "shinydashboard",
                "shinyjs",
                "spocc",
                "tibble",
                "tools",
                "utils",
                "yaml"
            )
    }
    
    dep_desc <- lapply(dep, utils::packageDescription)
    
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
                return(ifelse(is.null(x$Date), "", x$Date))
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
#' @param citation_level Recursiveness of dependency to cite. 1 - just bdverse. 2 - all bdverse packages. 3 - all direct dependencies. 4 - all direct and indirect dependencies.
#' @param type Type of citation to generate. raw - Mixture of bib and text. text - Textual representation. bibtex - BibTex format. html - HTML Tags. latex - LATEX format.
#' @param bib_file If path of file provided, a bib file will be genrated and written to disk.
#' 
#' @return String with citations or a file with citations
#'
#' 
#' @import gtools utils knitr
#' 
#' @export
bd_citation <- function(citation_level = 1,
                        type = "raw",
                        bib_file = NA) {
    #--------- Get dependencies --------------
    if (citation_level == 1) {
        dep <- c("bdverse")
    } else if (citation_level == 2) {
        dep <-
            c(
                "bdverse",
                "bdDwC",
                "bdchecks",
                "bddwc.app",
                "bdchecks.app",
                "bdclean",
                "bdutilities",
                "bdutilities.app"
                )
    } else if (citation_level == 3) {
        dep <-
            c(
                "DT",
                "assertive",
                "data.table",
                "finch",
                "golem",
                "gtools",
                "kableExtra",
                "knitr",
                "leaflet",
                "magrittr",
                "methods",
                "rgbif",
                "rmarkdown",
                "rstudioapi",
                "shiny",
                "shinydashboard",
                "shinyjs",
                "spocc",
                "tibble",
                "tools",
                "utils",
                "yaml"
            )
    } else if (citation_level == 4) {
        dep <- gtools::getDependencies("bdverse")
        dep <- c(dep, "bdverse")
        dep <- rev(dep)
    }
    
    #--------------- Get Citations -----------
    ans <- list()
    
    if (type == "raw") {
        ans <- lapply(dep, utils::citation)
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
    
    if (!is.na(bib_file)) {
        knitr::write_bib(x = dep, file = bib_file)
        message("File Written!")
    } else {
        return(ans)
    }
}



#' List all packages available in bdverse
#'
#' 
#' @return tibble of packages list
#'
#' @import bdutilities bdutilities.app bdDwC bddwc.app bdchecks bdchecks.app bdclean utils tibble
#'
#' @export
bd_packages <- function() {
    pkg_desc <-
        list(
            utils::packageDescription("bdutilities"),
            utils::packageDescription("bdutilities.app"),
            utils::packageDescription("bdDwC"),
            utils::packageDescription("bddwc.app"),
            utils::packageDescription("bdchecks"),
            utils::packageDescription("bdchecks.app"),
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
