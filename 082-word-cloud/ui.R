fluidPage(
  # Application title
  titlePanel("Interative Word Cloud Machine"),

  sidebarLayout(
    # Sidebar with a slider and selection inputs
    sidebarPanel(
      selectInput("selection", "Choose a data set:",
                  choices = books),
      actionButton("update", "Change"),
      hr(),
      sliderInput("freq",
                  "Minimum Frequency:",
                  min = 1,  max = 50, value = 15),
      sliderInput("max",
                  "Maximum Number of Words:",
                  min = 1,  max = 300,  value = 100)
    ),

    # Show Word Cloud
    mainPanel(
      plotOutput("plot")
    )
  )
)
