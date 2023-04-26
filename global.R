library(echarts4r)
library(dplyr)
library(DT)
library(DTeditCn)
library(shinyWidgets)
library(daterangepicker)

DTeditCn::setDTtoCn()

# 创建列表数据
df_list <- data.frame(
  name = LETTERS,
  value = 1:26,
  value2 = 1:26*2,
  proportion = 1:26*3
)

data <- df_list %>% 
  # mutate(date = as.Date(time_hour)) %>% 
  # filter(data <= as.Date('2013-01-31')) %>% 
  select(name, value,value2, proportion) %>% 
  arrange_all()

kpi <- data.frame(val = c(0.95, 0.8, 0.6))


rd <- data.frame(
  x = c('段永利','龚逸飞','焦仑','李宝荣','李燕','彭美娇','赵聪'),
  y = c(100,
        732,
        150,
        650,
        560,
        194,
        512),
  z = c(100,
        332,
        150,
        550,
        310,
        194,
        442)
)

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