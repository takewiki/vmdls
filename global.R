library(echarts4r)
library(dplyr)
library(DT)
library(DTeditCn)

DTeditCn::setDTtoCn()

# 创建列表数据
df_list <- data.frame(
  name = LETTERS,
  value = 1:26,
  value2 = 1:26*2,
  proportion = 1:26
)

kpi <- data.frame(val = c(0.6, 0.5, 0.4))

# 数据标准化
data <- df_list %>% 

  select(name, value,value2, proportion) %>% 
  arrange_all()

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