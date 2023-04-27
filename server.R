#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    
    
    
    # Track the filter date in a reactive value so it can be
    # update independently of the chart
    filter_date <- reactiveVal(value = NULL)
    
    # Update the filter date on click on data point
    observeEvent(input$chart_clicked_data, {
        filter_date(input$chart_clicked_data$value[1])
    })
    
    # Reset the filter date
    observeEvent(input$reset_filter, {
        filter_date(NULL)
    })
    
    # Display the filter date
    output$filter_title <- renderText({
        if (is.null(filter_date())) return('Showing all flights')
        paste('Showing flights on', filter_date())
    })
    
    # Create an interactive chart
    output$chart <- renderEcharts4r({
        data %>% 
            e_charts(name) %>% 
            e_area(value, name = '1',symbolSize = 12) %>% 
            e_x_axis(boundaryGap = FALSE)%>% 
            e_line(proportion, name = '3',symbolSize = 12) %>%
            e_legend(
                orient = 'vertical', 
                left = 'right', 
                top = 0
              
            ) %>%e_tooltip(trigger = "axis")%>%
            e_theme(theme = themes[3])
           
    })
    
    # Create a table with detailed information
    output$dt <- renderDT({
        if (!is.null(filter_date())) {
            data <- data %>% filter(name == filter_date())
        }
        data <- data %>% select(name, value,value2, proportion) 
        datatable(
            data, 
            extensions = 'Scroller',
            options = list(
                deferRender = TRUE,
                scrollY = 200,
                scroller = TRUE
            )
            
        )%>% formatStyle(
            'name',
            target = 'row',
            backgroundColor = styleEqual(c(0, 1), c('gray', 'yellow'))
        )
    })
    
    #kpi
    
    output$kpi1 <- renderEcharts4r({
        
        
        # kpi %>%   
        #     e_charts() %>%
        #     e_liquid(val) %>% e_title(text = '排产率%') %>%
        #     e_theme(theme = themes[3])
        
        e_charts() %>% 
            e_gauge(95, "%") %>%
            e_title("排产率") %>%
        e_theme(theme = themes[3])
        
        
    })
    
    output$kpi2 <- renderEcharts4r({
        
        
        e_charts() %>% 
            e_gauge(95, "%") %>%
            e_title("排产率") %>%
            e_theme(theme = themes[3])
        
        
    })
    
    #radar
    output$radar <- renderEcharts4r({
        
        
        rd %>% 
            e_charts(x,elementId = 'radar_id') %>%
            e_radar(y, max = 750, name = "计划生产数量") %>%
            e_radar(z, max = 550, name = "实作数量") %>%
            e_tooltip(trigger = "item")%>% e_theme(theme = themes[8])
        
        
    })
    #dt2
    output$dt2 <- renderDT({
        if (!is.null(filter_date())) {
            data <- data %>% filter(name == filter_date())
        }
        data <- data %>% select(name, value,value2, proportion) 
        datatable(
            data, 
            extensions = 'Scroller',
            options = list(
                deferRender = TRUE,
                scrollY = 200,
                scroller = TRUE
            )
            
        )%>% formatStyle(
            'name',
            target = 'row',
            backgroundColor = styleEqual(c(0, 1), c('gray', 'yellow'))
        )
    })
    
 

})
