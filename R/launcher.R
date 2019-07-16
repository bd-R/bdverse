#' Launch bdverse App Suite Launcher
#'
#' @import bdDwC bdchecks bdclean bdvis
#' @importFrom shiny runApp
#' @importFrom rstudioapi jobRunScript
#' 
#' @examples
#' 
#' if(interactive()){
#' 
#' # Requires rstudio 1.2
#' bd_launcher()
#' 
#' } 
#'
#' @export
bd_launcher <- function(){
    app_path <- system.file("shiny", package = "bdverse")
    return(shiny::runApp(app_path, launch.browser = TRUE))
}
