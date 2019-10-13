path_app <- system.file("app", package = "bddwc.app")
shiny::runApp(path_app, launch.browser = TRUE, port = 875)