# With much gratitude for tidyverse folks. 
# This script is derived from https://github.com/tidyverse/tidyverse and altered for bdverse.

core <- c("bdutilities", "bdutilities.app", "bdDwC", "bddwc.app", "bdchecks", "bdchecks.app", "bdclean")

.onAttach <- function(...) {
  
    needed <- core[!is_attached(core)]
    
    if (length(needed) == 0)
        return()
    
    crayon::num_colors(TRUE)
    
    to_load <- core_unloaded()
    
    if (length(to_load) == 0)
        return(invisible())
    
    msg(
        cli::rule(
            left = crayon::magenta(crayon::bold("Attaching packages")),
            right = paste0("bdverse ", package_version("bdverse"))
        ),
        startup = TRUE
    )
    
    versions <- vapply(to_load, package_version, character(1))
    packages <- paste0(
        crayon::green(cli::symbol$tick), " ", crayon::blue(format(to_load)), " ",
        crayon::col_align(versions, max(crayon::col_nchar(versions)))
    )
    
    if (length(packages) %% 2 == 1) {
        packages <- append(packages, "")
    }
    col1 <- seq_len(length(packages) / 2)
    info <- paste0(packages[col1], "     ", packages[-col1])
    
    msg(paste(info, collapse = "\n"), startup = TRUE)
    
    suppressWarnings(suppressPackageStartupMessages(
        k <- lapply(to_load, same_library)
    )) 
    
    msg(
        cli::rule(
            left = crayon::yellow(("With love for biodiversity and R open source: www.bdverse.org"))
        ),
        startup = TRUE
    )
    
}

core_unloaded <- function() {
    search <- paste0("package:", core)
    core[!search %in% search()]
}

package_version <- function(x) {
    version <- as.character(unclass(utils::packageVersion(x))[[1]])
    
    if (length(version) > 3) {
        version[4:length(version)] <- crayon::red(as.character(version[4:length(version)]))
    }
    paste0(version, collapse = ".")
}

same_library <- function(pkg) {
    loc <- if (pkg %in% loadedNamespaces()) dirname(getNamespaceInfo(pkg, "path"))
    do.call(
        "library",
        list(pkg, lib.loc = loc, character.only = TRUE, warn.conflicts = FALSE)
    )
}

is_attached <- function(x) {
    paste0("package:", x) %in% search()
}

msg <- function(..., startup = FALSE) {
  if (startup) {
    if (!isTRUE(getOption("tidyverse.quiet"))) {
      packageStartupMessage(text_col(...))
    }
  } else {
    message(text_col(...))
  }
}
