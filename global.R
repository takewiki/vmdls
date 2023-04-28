library(echarts4r)
library(dplyr)
library(DT)
library(DTeditCn)
library(shinyWidgets)
library(daterangepicker)
library(vmdlspkg)

DTeditCn::setDTtoCn()

# 创建列表数据
# df_list <- data.frame(
#   name = LETTERS,
#   value = 1:26,
#   value2 = 1:26*2,
#   proportion = 1:26*3
# )
df_list = vmdlspkg::moStat_query()

data <- df_list %>% 
  select(Fcategory, FPlanQty,FActualQty, FQualifiedQty) %>% 
  arrange_all()

kpi <- data.frame(val = c(0.95, 0.8, 0.6))


rd <- vmdlspkg::prdLineStat_query()



#主题定义
themes = c(
  'dark',
  
  'vintage',
  
  'westeros',
  
  'essos',
  
  'wonderland',
  
  'walden',
  
  'chalk',
  
  'infographic',
  
  'macarons',
  
  'roma',
  
  'shine',
  
  'purple-passion',
  
  'halloween',
  
  'auritus'
)

themeConfig =c(3,6,11,14)

# 自定义主题配色
# e_theme_custom('{"color":["#ffffff","#ffff00","#FF0000"]}')