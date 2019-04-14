#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)
library(grDevices)

# Define UI for application that draws a histogram
ui <- fluidPage(
   
   # Application title
   titlePanel("Savings / Investment Scenario Simulator"),
   
   # Sidebar with a slider input for number of bins 
   sidebarLayout(
      #sidebarPanel(
      #   width = 0
      #),
      NULL,
      
      # Show a plot of the generated distribution
      mainPanel(
        fluidRow(
          column(4, 
                 sliderInput("init_amt",
                             "Initial Amount",
                             min = 1,
                             max = 100000,
                             value = 1000,
                             pre = "$",
                             step = 500)
                 ),
          column(4, 
                 sliderInput("ret_rate",
                             "Return Rate (in %)",
                             min = 0,
                             max = 20,
                             value = 5,
                             step = 0.1)
          ),
          column(4, 
                 sliderInput("years",
                             "Years",
                             min = 0,
                             max = 50,
                             value = 10,
                             step = 1)
          )
        ),
        fluidRow(
          column(4, 
                 sliderInput("ann_contrib",
                             "Annual Contribution",
                             min = 0,
                             max = 50000,
                             value = 2000,
                             pre = "$",
                             step = 500)
          ),
          column(4, 
                 sliderInput("growth_rate",
                             "Growth Rate (in %)",
                             min = 0,
                             max = 20,
                             value = 2,
                             step = 0.1)
          ),
          column(4, 
                 selectInput("facet",
                             "Facet?",
                             choices = c("No", "Yes"),
                             selected = "No",
                             multiple = FALSE)
          )
        ),
        
        hr(),
        
        h3("Timeline Graphs"),
        
        plotOutput("timePlot"),
        
        hr(),
        
        h3("Balance Table"),
        
        tableOutput("balanceTable")
      )
   )
)

# Define server logic required to draw the necessary graphs
server <- function(input, output) {
  
   output$balanceTable <- renderTable({
     initial_invest <- input$init_amt
     invest_per <- input$years
     contrib <- input$ann_contrib
     
     annuity_gr <- input$growth_rate / 100
     ret_rate <- input$ret_rate / 100
     
     facet <- input$facet
     
     no_contrib_colors <- c()
     fixed_contrib_colors <- c()
     growing_contrib_colors <- c()
     for (i in 0:invest_per) {
       no_contrib_colors <- append(no_contrib_colors, "red")
       fixed_contrib_colors <- append(fixed_contrib_colors, "blue")
       growing_contrib_colors <- append(growing_contrib_colors, "green")
     }
     modalities <- gen_modalities(initial_invest, ret_rate, contrib, contrib, annuity_gr, invest_per)
     return(modalities)
   })
   
   output$timePlot <- renderPlot({
     initial_invest <- input$init_amt
     invest_per <- input$years
     contrib <- input$ann_contrib
     
     annuity_gr <- input$growth_rate / 100
     ret_rate <- input$ret_rate / 100
     
     facet <- input$facet
     
     no_contrib_colors <- c()
     fixed_contrib_colors <- c()
     growing_contrib_colors <- c()
     for (i in 0:invest_per) {
       no_contrib_colors <- append(no_contrib_colors, "red")
       fixed_contrib_colors <- append(fixed_contrib_colors, "blue")
       growing_contrib_colors <- append(growing_contrib_colors, "green")
     }
     modalities <- gen_modalities(initial_invest, ret_rate, contrib, contrib, annuity_gr, invest_per)
     modality_lst <- c("No Contribution", "Fixed Contribution", "Growing Contribution")
     
     if (facet == "Yes") {
         new_modalities = data.frame(year = rep(modalities$year, 3), 
                                   contrib = c(modalities$no_contrib, modalities$fixed_contrib, modalities$growing_contrib),
                                   type = c(rep("No Contribution", length(modalities$year)), rep("Fixed Contribution", length(modalities$year)), rep("Growing Contribution", length(modalities$year))),
                                   colors = c(rep("red", length(modalities$year)), rep("blue", length(modalities$year)), rep("green", length(modalities$year))))
         color_vals <- c("red", "blue", "green")
         names(color_vals) <- c("No Contribution", "Fixed Contribution", "Growing Contribution")
         alpha_color_vals <- c(adjustcolor("red", alpha.f = 0.2), 
                               adjustcolor("blue", alpha.f = 0.2), 
                               adjustcolor("green", alpha.f = 0.2))
         names(alpha_color_vals) <- c("No Contribution", "Fixed Contribution", "Growing Contribution")
         ggplot(data = new_modalities) + 
           geom_line(aes(x = year, y = contrib, color = type)) +
           geom_point(aes(x = year, y = contrib, color = type)) +
           geom_area(aes(x = year, y = contrib, fill = type)) +
           theme_minimal() +
           scale_color_manual(name = "variable", breaks = c("No Contribution", "Fixed Contribution", "Growing Contribution"), values = color_vals) +
           scale_fill_manual(name = "variable", breaks = c("No Contribution", "Fixed Contribution", "Growing Contribution"), values = alpha_color_vals) +
           labs(title = "Timeline Graph of Investment Growth over 10 Years by Savings Modality\n", x = "Time (years)", y = "Investment Value ($)", color = "Savings Modality\n") +
           facet_wrap(~type)
     } else {
       color_vals <- c("red", "blue", "green")
       names(color_vals) <- c("No Contribution", "Fixed Contribution", "Growing Contribution")
       ggplot(modalities) + 
         geom_line(aes(x = year, y = no_contrib, color = "No Contribution")) + 
         geom_point(aes(x = year, y = no_contrib, color = "No Contribution")) + 
         geom_line(aes(x = year, y = fixed_contrib, color = "Fixed Contribution")) +
         geom_point(aes(x = year, y = fixed_contrib, color = "Fixed Contribution")) +
         geom_line(aes(x = year, y = growing_contrib, color = "Growing Contribution")) +
         geom_point(aes(x = year, y = growing_contrib, color = "Growing Contribution")) +
         theme_minimal() +
         scale_color_manual(breaks = c("No Contribution", "Fixed Contribution", "Growing Contribution"), values = color_vals) +
         scale_fill_manual(breaks = c("No Contribution", "Fixed Contribution", "Growing Contribution"), values = color_vals) +
         labs(title = "Timeline Graph of Investment Growth over 10 Years by Savings Modality\n", x = "Time (years)", y = "Investment Value ($)", color = "Savings Modality\n")
     }
   })
   
   #' @title: future_value() with 3 params: amount, rate, years
   #' @description: calculates the future value of an investment (amount) after a certain number of years, returning at a certain rate
   #' @param amount: initial invested amount
   #' @param rate: annual rate of return
   #' @param years: number of years
   #' @return: future value of investment amount
   future_value <- function(amount, rate, years) {
     return(amount * (1 + rate)^years)
   }
   
   #' @title: annuity() with 3 params: contrib, rate, years
   #' @description: calculates the future value of an annuity (contrib) after a certain number of years, returning at a certain rate
   #' @param contrib: contributed amount
   #' @param rate: annual rate of return
   #' @param years: number of years
   #' @return: future value of annuity contribution amount
   annuity <- function(contrib, rate, years) {
     return(contrib * ((1 + rate)^years - 1) / rate)
   }
   
   #' @title: growing_annuity() with 4 params: contrib, rate, growth, years
   #' @description: calculates the future value of a growing annuity (contrib) after a certain number of years with a certain growth and return rate
   #' @param contrib: contributed amount
   #' @param rate: annual rate of return
   #' @param growth: annual growth rate
   #' @param years: number of years
   #' @return: the future value of growing annuity
   growing_annuity <- function(contrib, rate, growth, years) {
     return(contrib * ((1 + rate)^years - (1 + growth)^years) / (rate - growth))
   }
   
   gen_modalities <- function(mode1_start, mode1_rate, mode2_ann, mode3_ann, mode3_ann_rate, years) {
     year <- 0:years
     no_contrib <- c()
     fixed_contrib <- c()
     growing_contrib <- c()
     for (i in year) {
       no_contrib <- append(no_contrib, future_value(amount = mode1_start, rate = mode1_rate, years = i))
       fixed_contrib <- append(fixed_contrib, no_contrib[length(no_contrib)] + annuity(contrib = mode2_ann, rate = mode1_rate, years = i))
       growing_contrib <- append(growing_contrib, no_contrib[length(no_contrib)] + growing_annuity(contrib = mode2_ann, rate = mode1_rate, growth = mode3_ann_rate, years = i))
     }
     modalities <- data.frame(year, no_contrib, fixed_contrib, growing_contrib)
     return(modalities)
   }
   
}

# Run the application 
shinyApp(ui = ui, server = server)

