load("measures.RData")
load("years.RData")
load("countries.RData")

library(shiny)
library(shinythemes)

# Define UI for application that draws a histogram
shinyUI(

  fluidPage(theme = shinytheme("paper"),

  # Application title
  titlePanel("World Gender Statistics"),

  sidebarLayout(
    sidebarPanel(

      tags$h4("Select to display in map:"),

      uiOutput("choose_measure"),

      uiOutput("choose_years"),

      radioButtons("sex", "Gender:",
                   choices = list("Male" = "M",
                                  "Female" = "F",
                                  "Ratio" = "ratio"),
                   selected = "ratio"),

      br(),

      tags$h4("Select to display in timeline:"),

      selectInput("country", "Country",
                  choices = countries)
  ),


      mainPanel(

        fluidRow(
          p("The data was downloaded from", a("The World Bank's Open Data project", href = "http://data.worldbank.org/"), "via", a("Kaggle.", href = "https://www.kaggle.com/theworldbank/world-gender-statistic"), "For more info on how I built this app check out", a("my blog.", href = "https://shiring.github.io/2017/02/05/WGS_final")),

          p("Explore the tabs below to see information about male vs female measures of 160 statistics from 56 years. 'World map' shows female, male or male/female values for individual years. 'Latest ratios' shows the most recent male/ female ratio of the chosen statistic. 'Timelines' shows the change of male and female values over time. 'Country information' gives an overview over the co-variates used for statistic analysis in 'Analysis - Plots' and '- Tests'.")
          ),

      tabsetPanel(
        tabPanel("World map", fluidRow(
                                  tags$h3("World map of gender statistic"),

                                  p("Select a statistic and year on sidebar panel."),

                                  plotOutput("map",
                                             click = "plot_click", height = "auto"),

                                  p("Click on any country on the map to find out more about it:"),

                                  tableOutput("info"))),

        tabPanel("Latest ratios", fluidRow(
                                  plotOutput("last_vals", height = "auto"))),

        tabPanel("Timelines", fluidRow(
                                  tags$h3("Timeline of gender statistic"),

                                  p("Select a country on sidebar panel."),

                                  plotOutput("timeline", height = "auto"),

                                  plotOutput("timeline2", height = "auto"))),

        tabPanel("Country information", fluidRow(
                                  plotOutput("income", height = "auto"),

                                  plotOutput("economy", height = "auto"),

                                  plotOutput("population", height = "auto"),

                                  plotOutput("gdp", height = "auto"))),

        tabPanel("Analysis - Plots", fluidRow(
                                  plotOutput("density"),

                                  br(),

                                  plotOutput("distribution1"),

                                  br(),

                                  plotOutput("distribution2"),

                                  br(),

                                  plotOutput("cor1"),

                                  br(),

                                  plotOutput("cor2"))),

        tabPanel("Analysis - Tests", fluidRow(

                                  tags$h3("Wilcoxon Signed-Rank Test"),
                                  tableOutput("wilcox"),

                                  br(),

                                  tags$h3("Kruskal-Wallis Test"),
                                  tableOutput("kruskal"),

                                  br(),

                                  tags$h3('ANOVA Table'),
                                  tableOutput('aovSummary')

        ))
    ))
  )
))
