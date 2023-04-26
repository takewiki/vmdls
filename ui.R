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
                actionButton(
                  inputId = 'reset_filter', 
                  label = '重置',
                  icon = icon('redo'),width = '80%'
                )),
            div(class="header-center fl",
                div(class="header-title","域华电子生产看板"),
                div(class="header-img")),
            div(class="header-right",'工单状态'),
            div(class="header-bottom fl")
            ),
        div(class="center",style="display: flex;",
            div(class="center-left",
                div(class="left-top",
                    div(class="title","管理指标(1,1):left-top"),
                    div(class="kpi",
                        echarts4rOutput('kpi')
                        )
                    ),
                div(class="left-cen",
                    div(class="title","逾期订单分析(2,1):left-cen"),
                    div(class="bottom-b",
                        div(id="chart3",class="allnav")
                        
                        
                        )),
                div(class="left-bottom",
                    div(class="title","生产进度追踪表(3,1):left-bottom"),
                    div(class="dt1",dataTableOutput('dt'),style = "font-size:80%"
                    )
                    )),
            div(class="center-cen",
                div(class="cen-top",
                    div(class="title","生产品类统计表(1,2):cen-top"),
                    div(class="top-bottom fl",
                        #div(id="chart1",class="allnav")
                        echarts4rOutput('chart')
                        
                        ))
                ),
            div(class="center-right",
                div(class="right-top",
                    div(class="title","生产信息(1,3):right-top"),
                    div(class="echart wenzi",
                        div(class="heading2",
                            tags$span("产线"),
                            tags$span("产品类别"),
                            tags$span("订单数"),
                            tags$span("完工数")),
                        div(id="FontScroll", class="myscroll",
                        tags$ul(
                          tags$li(div(class="fontInner1 clearfix",
                                            tags$span("生产线"),
                                            tags$span("vScan Tx"),
                                            tags$span("4"),
                                            tags$span("1")
                                           )
                                        ),
                          tags$li(div(class="fontInner1 clearfix",
                                      tags$span("生产线2"),
                                      tags$span("vCam 5"),
                                      tags$span("10"),
                                      tags$span("10")
                          )),
                          tags$li(div(class="fontInner1 clearfix",
                                      tags$span("生产线3"),
                                      tags$span("VX Camera"),
                                      tags$span("7"),
                                      tags$span("7"))),
                          tags$li(div(class="fontInner1 clearfix",
                                      tags$span("生产线3"),
                                      tags$span("Spare Parts"),
                                      tags$span("20"),
                                      tags$span("20"))) )
                        ))),
            
            div(class="right-cen",
                div(class="title","生产信息(2,3):right-cen"),
                div(class="echart wenzi",
                    div(class="heading2",
                        tags$span("产线"),
                        tags$span("产品类别"),
                        tags$span("订单数"),
                        tags$span("完工数")),
                    div(id="FontScroll", class="myscroll",
                        tags$ul(
                          tags$li(div( class="fontInner1 clearfix",
                                       tags$span("生产线4"),
                                       tags$span("Loc3-Pro Rx"),
                                       tags$span("2"),
                                       tags$span("2")
                          )),
                          tags$li(div( class="fontInner1 clearfix",
                                       tags$span("生产线5"),
                                       tags$span("VM-850"),
                                       tags$span("5"),
                                       tags$span("5"))),
                          tags$li(div( class="fontInner1 clearfix",
                                       tags$span("生产线6"),
                                       tags$span("6"),
                                       tags$span("0"),
                                       tags$span("0")))
                        )
                        )
                    
                    )),
            div(class="right-bottom",
                div(class="title","生产信息(3,3):right-bottom"),
                div(class="echart wenzi",
                    div(class="heading2",
                        tags$span("产线"),
                        tags$span("产品类别"),
                        tags$span("订单数"),
                        tags$span("完工数")),
                    div(id="FontScroll", class="myscroll",
                        tags$ul(
                          tags$li(div( class="fontInner1 clearfix",
                                       tags$span("生产线4"),
                                       tags$span("Loc3-Pro Rx"),
                                       tags$span("2"),
                                       tags$span("2")
                          )),
                          tags$li(div( class="fontInner1 clearfix",
                                       tags$span("生产线4"),
                                       tags$span("VM-850"),
                                       tags$span("5"),
                                       tags$span("5") )),
                          tags$li(div( class="fontInner1 clearfix",
                                       tags$span("生产线4"),
                                       tags$span("VM-810"),
                                       tags$span("2"),
                                       tags$span("2")
                          )),
                   
                          tags$li(div( class="fontInner1 clearfix",
                                       tags$span("生产线7"),
                                       tags$span("6"),
                                       tags$span("0"),
                                       tags$span("0")))
                          
                          
                        ))))
        )))
    
   
    

  
    )
)

