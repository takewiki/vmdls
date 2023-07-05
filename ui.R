#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  #head-----------
  #设置样式表-----
  tags$head(
    tags$link(rel = "stylesheet", type = "text/css", href = "index.css")
  ),
    
    # Application title----
    div(class='main',
        # 头部定义-------
        # header---------
        div(class='header',
        
            div(class="header-center fl",
                div(class="header-title","     域华电子生产看板OverView"),
                
                ),
            div(class="header-img"),
         
            div(class="header-bottom fl")
        ),
        div(class="center",style="display: flex;",
            div(class="center-left",
                div(class="left-top",
                    div(class="title","管理指标"),
                   
                    div(class="kpi",
                        
                       fluidRow(column(6,echarts4rOutput('kpi1')),
                                column(6,echarts4rOutput('kpi2')))
                        )
                    ),
                div(class="left-bottom",
                    div(class="title","生产进度追踪"),
                    div(class="dt1",dataTableOutput('dt'),style = "font-size:80%"
                    )
                    )),
            div(class="center-cen",
                div(class="cen-top",
                    div(class="title","生产进度汇总"),
                    div(class="top-bottom fl",
                      
                        div(class="chart",echarts4rOutput('chart'))
                        
                        
                        ))
                ),
            div(class="center-right",
                div(class="right-top",
                    div(class="title","产线统计分析表"),
                    div(class="echart_radar",
                        div(id="rd1", class="radar_chart",
                            echarts4rOutput('radar')
                        
                        ))),
            
            div(class="right-cen",
                div(class="title","overDue List"),
                div(class="echart wenzi2",
                    div(class="dt2",dataTableOutput('dt2'),style = "font-size:80%"
                    )
                    
                    ))
        ))
        # header---------
      
        
        
        
        ),
  div(class='sec',
      div(class="sec-left",
          tagList( 
            daterangepicker(
              inputId = "daterange",
              label = "生产周选择器",
              start = '2023-03-01', end = Sys.Date(),options = daterangepickerOptions(drops = 'up')
              
            )
            
          )),
      div(class="sec-left2",  
          div(class="reset_btn",  tags$p('请重新选择产品分组:'),
              shinyWidgets::actionBttn(
            inputId = 'reset_filter',
            label = '重置',color = 'warning',size = 'lg',
            icon = icon('redo')
          )) ),
      
      div(class="sec-center",   radioGroupButtons(
        inputId = "moStatus",
        label = "生产任务单状态:",
        choiceNames = c("全部","下达",'开工','完工','结案'),
        choiceValues = c("全部","下达",'开工','完工','结案'),selected = '全部',size = 'lg',
        status = "warning",justified = FALSE
      )),
      div(class='sec-right',radioGroupButtons(
        inputId = "overDueType",
        label = "逾期选项:",
        choiceNames = c("产品逾期","备件逾期"),
        choiceValues = c("overDuePrd","overDueSpareparts"),selected = 'overDuePrd',size = 'lg',
        status = "warning"
      ))
      
      
  )
   
    

  
    )
)

