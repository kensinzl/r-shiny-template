# 1. I use shinydashboard as the layout framework, this package supports good layout stuff.
#    In this Demo, I have written comments for the key part, for the details, please refer http://rstudio.github.io/shinydashboard/index.html.
# 
# 2. If you want to see what is the exetution HTML, 
#    For example, tags$a(href = "https://niwa.co.nz", tags$img(src="www_NIWA_Rev_Hor_2.png", height = "80px")). Copy it in console and run.
#    Then you will get the execution response like the following HTML.
#    <a href="https://niwa.co.nz">
#       <img src="www_NIWA_Rev_Hor_2.png" height="80px"/>
#    </a>
#    Also can refer https://shiny.rstudio.com/articles/tag-glossary.html
dashboardPagePlus(
    dashboardHeaderPlus(
        # Use image in title
        # Use names(tags) to see what the tag you can  use.
        title = tags$span(id = "niwa", 
                          tags$a(href = "https://niwa.co.nz", tags$img(src="www_NIWA_Rev_Hor_2.png", height = "80px")), 
                          project_name),
        titleWidth = "100%"
    ),
    
    # If you do not need the side bar, you can use sidebar_fullCollapse = TRUE and collapse_sidebar = TRUE among dashboardPagePlus fun
    dashboardSidebar(
        # Hide the toggle button from header, if you need, do your change.
        tags$script(JS("document.getElementsByClassName('sidebar-toggle')[0].style.visibility = 'hidden';")),
        collapsed = TRUE,
        sidebarMenu(
            # Setting id makes input$tabs give the tabName of currently-selected tab
            id = "tabs",
            menuItem("Dashboard", tabName = "dashboard", badgeLabel = "new", icon = icon("dashboard")),
            menuItem("Charts", icon = icon("bar-chart-o"),
                     menuSubItem("Sub-item 1", tabName = "subitem1"),
                     menuSubItem("Sub-item 2", tabName = "subitem2")
            )
        )
    ),
    
    dashboardBody(
        # Here load your custom css file which is located on the www folder.
        tags$head(tags$link(rel = "stylesheet", type = "text/css", href = "styles.css")),
        
        # Show every tab stuff
        tabItems(
            # Here just show a NZ OverLeaf Map
            tabItem("dashboard", leafletOutput(outputId = "mymap", width="100%", height ="700px")
            ),
            tabItem("subitem1",
                    # Here just using fluidRow as example, you can choose other layout like splitLayout
                    fluidRow(
                        box(plotOutput(outputId = "plot1", height = 250)),
                        
                        box(
                            title = "Controls",
                            sliderInput(inputId = "slider", label= "Number of observations:", min = 1, max = 100, value= 50)
                        ),
                    )
            ),
            tabItem("subitem2",
                    "Sub-item 2 tab content"
            )
        )
    ),
    
    dashboardFooter(left_text = tags$ul(tags$li(paste0(paste(project_name, project_version), " Copyright, 2020 NIWA. All rights reserved.")),
                                        tags$li(tags$a(id = "policy", href="http://www.niwa.co.nz/privacy-policy", "Privacy Policy, 2016"))
                                        )
    ),
    
    title = "DashboardPage"
    
    # Like the above comment, if you do not need the silde bar, make these two lines un-comment.
     , sidebar_fullCollapse=TRUE,
    collapse_sidebar = TRUE
)