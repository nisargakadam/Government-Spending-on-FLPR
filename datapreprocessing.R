library(dplyr)
library(tidyverse)
library(ggplot2)



data2 <- 
  data2 %>%
  select(sex.label, classif1.label, classif2.label, time, obs_value) %>%
  filter(sex.label=="Sex: Female",
         classif1.label=="Education (ISCED-11): 0. Early childhood education"|
           classif1.label=="Education (ISCED-11): 1. Primary education"|
           classif1.label=="Education (ISCED-11): 2. Lower secondary education"|
           classif1.label=="Education (ISCED-11): 3. Upper secondary education"|
           classif1.label=="Education (ISCED-11): 5. Short-cycle tertiary education"|
           classif1.label=="Education (ISCED-11): 6. Bachelor's or equivalent level"|
           classif1.label=="Education (ISCED-11): 7. Master's or equivalent level"|
           classif1.label=="Education (ISCED-11): 8. Doctoral or equivalent level",
         classif2.label=="Marital status (Detailed): Single"|
           classif2.label=="Marital status (Detailed): Married"|
           classif2.label=="Marital status (Detailed): Widowed"|
           classif2.label=="Marital status (Detailed): Divorced or legally separated")



data2<- data2 %>%
  rename("sex" = "sex.label", "education"="classif1.label", "ms"="classif2.label")




data2$education0<- ifelse(data2$education=="Education (ISCED-11): 0. Early childhood education",1,0)
data2$education1<- ifelse(data2$education=="Education (ISCED-11): 1. Primary education",1,0)
data2$education2<- ifelse(data2$education=="Education (ISCED-11): 2. Lower secondary education",1,0)
data2$education3<- ifelse(data2$education=="Education (ISCED-11): 3. Upper secondary education",1,0)
data2$education4<- ifelse(data2$education=="Education (ISCED-11): 5. Short-cycle tertiary education",1,0)
data2$education5<- ifelse(data2$education=="Education (ISCED-11): 6. Bachelor's or equivalent level",1,0)
data2$education6<- ifelse(data2$education=="Education (ISCED-11): 7. Master's or equivalent level",1,0)
data2$education7<- ifelse(data2$education=="Education (ISCED-11): 8. Doctoral or equivalent level",1,0)

data2$single<- ifelse(data2$ms=="Marital status (Detailed): Single",1,0)
data2$married<- ifelse(data2$ms=="Marital status (Detailed): Married",1,0)
data2$widowed<- ifelse(data2$ms=="Marital status (Detailed): Widowed",1,0)
data2$divorced<- ifelse(data2$ms=="Marital status (Detailed): Divorced or legally separated",1,0)

##preprocessing to join datasets 

ss<- ss %>%
  filter(LOCATION=='USA')

ss <- ss%>%
  filter(TIME>=2012)

ss <- ss%>%
  filter(SUBJECT=='PUB')

ss <- ss%>%
  filter(MEASURE=='PC_GDP')

ss <- ss%>%
  select(TIME, Value)


ss <- ss%>%
  rename('time'='TIME')



df3<- data2 %>% left_join( ss, 
                             by='time')

df3 <- df3%>%
  filter(time<2022)



df3 <- df3%>%
  rename('ss_gdp'='Value', 'flpr'='obs_value')


f3 <- df3[,!names(df3) %in% c("sex", "education", "ms",'time')]
write.csv(f3, "/Users/nisar/Downloads/dataset_df.csv", row.names=FALSE)

#graphs

dfg <- df2%>%
  select(obs_value, Value)


ggpairs(dfg)


write.csv(social_sp, "/Users/nisar/Downloads/social_sp.csv", row.names=FALSE)
