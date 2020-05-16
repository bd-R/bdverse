library(shiny)
library(rstudioapi)
library(bdverse)


ui <- fluidPage(fluidRow(
    tags$head(
        tags$meta(name="viewport", content="width=device-width, initial-scale=1.0"),
        tags$link(rel = "stylesheet", type = "text/css", href = "style.css"),
        tags$link(rel= "shortcut icon", href= "bdverse_favicon_3.png")
    ),
    div(class = "logo", fluidRow(img(src="bdverse_logo_long_1.svg"))),
    column(
        width = 3,
        div(
            id = "pic01",
            class = "pane",
            
            p(class = "title", "bddwc:"),
            p(class = "decr", "Fix and standardize column names in biodiversity data."),
            actionButton("bddwc", label = "Launch bddwc", onclick ="window.open('https://bdverse.shinyapps.io/bddwc/', '_blank')"),
            img(src = '003.png', align = "center")
        )
    ),
    
    column(
        width = 3 ,
        div(
            id = "pic02",
            class = "pane",
            p(class = "title", "bdchecks:"),
            p(
                class = "decr",
                "Manage and execute data quality-checks on biodiversity data."
            ),
            actionButton("bdchecks", label = "Launch bdchecks", onclick ="window.open('https://bdverse.shinyapps.io/bdchecks/', '_blank')"),
            img(src = '004.png', align = "center")
        )
    ),
    
    column(
        width = 3 ,
        div(
            id = "pic03",
            class = "pane",
            p(class = "title", "bdclean:"),
            p(
                class = "decr",
                "Complete data cleaning pipeline for inexperienced R user."
            ),
            actionButton("bdclean", label = "Launch bdclean", onclick ="window.open('https://bdverse.shinyapps.io/bdclean/', '_blank')"),
            img(src = '002.png', align = "center")
        )
    ),
    
    column(
        width = 3 ,
        div(
            id = "pic04",
            class = "pane",
            p(class = "title", "bdvis:"),
            p(
                class = "decr",
                "Visualize and preview different aspects of biodiversity data."
            ),
            actionButton("action", label = "Launch bddashboard Demo", onclick ="window.open('https://bdverse.shinyapps.io/bddashboard/', '_blank')"),
            img(src = '001.png', align = "center")
        )
    )
))

server <- function(input, output) {
}

shinyApp(ui = ui, server = server)
