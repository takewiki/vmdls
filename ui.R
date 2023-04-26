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
  # tags$head(tags$script(src = "echarts_chart_demo.js")),
  # tags$head(tags$script(src = "echarts.min_demo.js")),
  #tags$head(tags$script(src = "jquery.js")),
  #tags$head(tags$script(src = "jquery.min.js")),
  #tags$head(tags$script(src = "fontscroll.js")),
  
  
    
    # Application title----
    div(class='main',
        # 头部定义-------
        # header---------
        div(class='header',
            div(class="header-left fl",
                tagList( 
                  daterangepicker(
                    inputId = "daterange",
                    label = "生产周选择器",
                    start = Sys.Date() - 30, end = Sys.Date(),
                    style = "width:100%; border-radius:4px",
                    icon = icon("calendar")
                  )
               
                )),
            div(class="header-center fl",
                div(class="header-title","域华电子生产看板OverView"),
                div(class="header-img")),
            div(class="header-right",   radioGroupButtons(
              inputId = "moStatus",
              label = "生产任务单状态",
              choiceNames = c("全部","下达",'开工','完工','结案'),
              choiceValues = c("全部","下达",'开工','完工','结案'),selected = '全部',
              status = "warning",justified = FALSE
            )),
            div(class="header-bottom fl")
            ),
        div(class="center",style="display: flex;",
            div(class="center-left",
                div(class="left-top",
                    div(class="title","管理指标"),
                    div(class="kpi",
                        echarts4rOutput('kpi')
                        )
                    ),
                div(class="left-bottom",
                    div(class="title","生产进度追踪表"),
                    div(class="dt1",dataTableOutput('dt'),style = "font-size:80%"
                    )
                    )),
            div(class="center-cen",
                div(class="cen-top",
                    div(class="title","生产品类统计表"),
                    div(class="top-bottom fl",
                        #div(id="chart1",class="allnav")
                        shinyWidgets::actionBttn(
                          inputId = 'reset_filter',
                          label = '重置',color = 'warning',size = 'sm',
                          icon = icon('redo')
                        ),
                        echarts4rOutput('chart')
                        
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
                div(class="title","逾期列表"),
                div(class="echart wenzi2",
                    div(id="FontScroll2", class="myscroll2",
                        radioGroupButtons(
                          inputId = "overDueType",
                          label = "",
                          choiceNames = c("产品","备件"),
                          choiceValues = c("产品","备件"),selected = '产品',
                          status = "warning"
                        )
                        )
                    
                    ))
        )))
    
   
    

  
    )
)

