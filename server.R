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
shinyServer(function(input, output,session) {
 
    
       
    
    

    filter_date <- reactiveVal(value = NULL)
    
    # Update the filter date on click on data point
    observeEvent(input$chart_clicked_data, {
        filter_date(input$chart_clicked_data$value[1])
    })
    
    # Reset the filter date
    observeEvent(input$reset_filter, {
        filter_date(NULL)
        #重期日期选择
        daterangepicker::updateDaterangepicker(session = session,inputId = 'daterange',label = '生产周选择器',start = Sys.Date() - 90, end = Sys.Date())
        #print(input$daterange)
    })
    
    # Display the filter date
    output$filter_title <- renderText({
        if (is.null(filter_date())) return('Showing all flights')
        paste('Showing flights on', filter_date())
    })
    
    # Create an interactive chart
    output$chart <- renderEcharts4r({
       
      
        data %>% 
            e_charts(Fcategory) %>% 
            e_line(FPlanQty, name = '计划生产数量',symbolSize = 12) %>% 
            e_x_axis(boundaryGap = FALSE)%>% 
            e_area(FActualQty, name = '实作数',symbolSize = 12) %>%
            e_area(FQualifiedQty, name = '合格数',symbolSize = 12) %>%
            e_legend(
                orient = 'vertical', 
                left = 'right', 
                top = 0
              
            ) %>%e_tooltip(trigger = "axis")%>%e_datazoom(toolbox = FALSE) %>%
            e_theme(theme = themes[3])
           
    })
    
    # Create a table with detailed information
    output$dt <- renderDT({
        data =vmdlspkg::moDetail_query(Fcategory = filter_date()) 
        print(data)
        datatable(
            data, 
            extensions = 'Scroller',
            options = list(
                deferRender = TRUE,
                scrollY = 200,
                scroller = TRUE
            )
            
        )%>% formatStyle(
            'Fcategory',
            target = 'row',
            backgroundColor = styleEqual(c(0, 1), c('gray', 'yellow'))
        )
    })
    
    #生产周变动时
    observeEvent(input$daterange,{
        
        print(input$daterange)
        
        df_list = vmdlspkg::moStat_query(FStartDate = input$daterange[1], FEndDate =input$daterange[2] )
        print(df_list)
        
        data <- df_list %>% 
            select(Fcategory, FPlanQty,FActualQty, FQualifiedQty) %>% 
            arrange_all()
        
        print(data)
        if(nrow(data) >0){
          output$chart <- renderEcharts4r({
            
            print('chartdata:')
            print(data)
            data %>% 
              e_charts(Fcategory) %>% 
              e_line(FPlanQty, name = '计划生产数量',symbolSize = 12) %>% 
              e_x_axis(boundaryGap = FALSE)%>% 
              e_area(FActualQty, name = '实作数',symbolSize = 12) %>%
              e_area(FQualifiedQty, name = '合格数',symbolSize = 12) %>%
              e_legend(
                orient = 'vertical', 
                left = 'right', 
                top = 0
                
              ) %>%e_tooltip(trigger = "axis")%>%e_datazoom(toolbox = FALSE) %>%
              e_theme(theme = themes[3])
            
          })
          
          # Create a table with detailed information
          output$dt <- renderDT({
            data =vmdlspkg::moDetail_query(Fcategory = filter_date(),FStartDate = input$daterange[1], FEndDate =input$daterange[2] ) 
            datatable(
              data, 
              extensions = 'Scroller',
              options = list(
                deferRender = TRUE,
                scrollY = 200,
                scroller = TRUE
              )
              
            )%>% formatStyle(
              '产品组',
              target = 'row',
              backgroundColor = styleEqual(c(0, 1), c('gray', 'yellow'))
            )
          })
          
          output$radar <- renderEcharts4r({
            rd = vmdlspkg::prdLineStat_query(FStartDate = input$daterange[1], FEndDate =input$daterange[2]  )
            
            
            rd %>% 
              e_charts(FProductionLine,height = '30%') %>%
              e_radar(FPlanQty, max = max(rd$FPlanQty), name = "计划生产数量") %>%
              e_radar(FActualQty, max = max(rd$FActualQty), name = "实作数量") %>%
              e_tooltip(trigger = "item")%>% e_theme(theme = themes[8])
            
            
          })
          
          
        }
        
        
        
        
    })
    
    #kpi
    
    output$kpi1 <- renderEcharts4r({
        
        
        # kpi %>%   
        #     e_charts() %>%
        #     e_liquid(val) %>% e_title(text = '排产率%') %>%
        #     e_theme(theme = themes[3])
        
        e_charts() %>% 
            e_gauge(95, "%") %>%
            e_title("完工率") %>%
        e_theme(theme = themes[3])
        
        
    })
    
    output$kpi2 <- renderEcharts4r({
        
        
        e_charts() %>% 
            e_gauge(98, "%") %>%
            e_title("一次性合格率") %>%
            e_theme(theme = themes[3])
        
        
    })
    
    #radar
    output$radar <- renderEcharts4r({
        
        
        rd %>% 
            e_charts(FProductionLine) %>%
            e_radar(FPlanQty, max = max(rd$FPlanQty), name = "计划生产数量") %>%
            e_radar(FActualQty, max = max(rd$FActualQty), name = "实作数量") %>%
            e_tooltip(trigger = "item")%>% e_theme(theme = themes[8])
        
        
    })
    #dt2
    output$dt2 <- renderDT({
        #判断逾期类型
        if(input$overDueType == 'overDuePrd'){
            data = vmdlspkg::overDuePrd_query(FCategory =filter_date() )
        }else{
            data = vmdlspkg::overDueSParts_query()
        }
       
        datatable(
            data, 
            extensions = 'Scroller',
            options = list(
                deferRender = TRUE,
                scrollY = 200,
                scroller = TRUE
            )
            
        )%>% formatStyle(
            'Category',
            target = 'row',
            backgroundColor = styleEqual(c(0, 1), c('gray', 'yellow'))
        )
    })
    
 

})
