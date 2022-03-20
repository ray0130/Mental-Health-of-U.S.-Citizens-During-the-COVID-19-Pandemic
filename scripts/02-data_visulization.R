#### Preamble ####
# Purpose: Visulization of the data
# Author: Isfandyar Virani
# Data: 20 March 2022
# Contact: isfandyar.virani@mail.utoronto.ca
# License: MIT
# Pre-requisites: 
# - Need to have downloaded the GSS data and saved it to inputs/data


####Workplace Setup####
raw_data <- haven::read_dta("inputs/data/2021_stata/gss2021.dta")

gss2021 <- raw_data
#=============================================================================
labels <- c("Female", "Male")
gss2021$sex_group <- cut(gss2021$sex, 2, labels = labels)

#Recoding mental health
# Changed good or better to 'Good'
# Change poor and fair to 'Not Good'
gss2021 <- gss2021 %>%
  mutate(`Mental Health` = case_when(
    hlthmntl == 1 ~ 'Good',
    hlthmntl == 2 ~ 'Good',
    hlthmntl == 3 ~ 'Good',
    hlthmntl == 4 ~ 'Not Good',
    hlthmntl == 5 ~ 'Not Good',
  ))

#=============================================================================
# Percent Graph - Mental health - Male Vs Female
gss2021 %>% filter(!is.na(`Mental Health`), !is.na(sex_group)) %>% ggplot(aes(x= `Mental Health`,  group=sex_group)) +
  geom_bar(aes(y = ..prop.., fill = factor(..x..)), stat="count") +
  geom_text(aes( label = scales::percent(..prop..),
                 y= ..prop.. ), stat= "count", vjust = -.5) +
  labs(y = "Percent", x = 'Mental Health', title = 'Mental Health: Male vs. Female') +
  facet_grid(~sex_group) +
  scale_y_continuous(labels = scales::percent) + theme(legend.position="none") + scale_fill_brewer(palette = "Spectral")

#=============================================================================  

#Recoding physical health
gss2021 <- gss2021 %>%
  mutate(`Physical Health` = case_when(
    hlthphys == 1 ~ 'Good',
    hlthphys == 2 ~ 'Good',
    hlthphys == 3 ~ 'Good',
    hlthphys == 4 ~ 'Not Good',
    hlthphys == 5 ~ 'Not Good',
  ))

#=============================================================================

# Percent Graph Physical health - Good Mental health vs Bad Mental Health
gss2021 %>% filter(!is.na(`Mental Health`), !is.na(sex_group), !is.na(`Physical Health`)) %>%
  ggplot(aes(x= `Physical Health`,  group= `Mental Health`)) +
  geom_bar(aes(y = ..prop.., fill = factor(..x..)), stat="count") +
  geom_text(aes( label = scales::percent(..prop..),
                 y= ..prop.. ), stat= "count", vjust = -.5) +
  labs(y = "Percent", fill="Physical Health", x = 'Physical Health', title = "Mental Health vs. Physical Health" ) +
  facet_grid(~`Mental Health` , labeller = label_both) +
  scale_y_continuous(labels = scales::percent) + theme(legend.position="none") + scale_fill_brewer(palette = "Spectral")

#=============================================================================

# Percent Graph - Poor Mental health = Physical health within Sex_Group comparison
gss2021 %>% filter(!is.na(`Mental Health`), !is.na(sex_group), !is.na(`Physical Health`), `Mental Health` =='Not Good') %>%
  ggplot(aes(x= `Physical Health`,  group=sex_group)) +
  geom_bar(aes(y = ..prop.., fill = factor(..x..)), stat="count") +
  geom_text(aes( label = scales::percent(..prop..),
                 y= ..prop.. ), stat= "count", vjust = -.5) +
  labs(y = "Percent", x="Physical Health", title = "Physical Health Comparison of Male Vs. Female with Poor Mental Health") +
  facet_grid(~sex_group) +
  scale_y_continuous(labels = scales::percent) + theme(legend.position="none") + scale_fill_brewer(palette = "Spectral")


#=============================================================================

# Recording Age Group
gss2021 <- gss2021 %>%
  mutate(`Age Group` = case_when(
    age >= 18 & age <= 29 ~ '18-29',
    age >= 30 & age <=39~ '30-39',
    age >= 40 & age <=49~ '40-49',
    age >= 50 & age <=64~ '50-64',
    age >= 65 & age <=89~ '65-89'
  ))

#=============================================================================

# Percent Graph - Mental health (Age Group Analysis)
gss2021 %>% filter(!is.na(`Mental Health`), !is.na(sex_group),!is.na(`Age Group`)) %>%
  ggplot(aes(x= `Mental Health`,  group=`Age Group`)) +
  geom_bar(aes(y = ..prop.., fill = factor(..x..)), stat="count") +
  geom_text(aes( label = scales::percent(..prop..),
                 y= ..prop.. ), stat= "count", vjust = -.5) +
  labs(y = "Percent", x="Mental Health", title = "Mental Health: Comparison of Different Age Groups") +
  facet_grid(~`Age Group`, labeller = label_both) +
  scale_y_continuous(labels = scales::percent) + theme(legend.position="none") + scale_fill_brewer(palette = "Spectral")

#=============================================================================

# Recoding Sexual orientation

gss2021 <- gss2021 %>%
  mutate(sexual_orientation = case_when(
    sexornt == 1 ~ 'LGBTQ+',
    sexornt == 2 ~ 'LGBTQ+',
    sexornt == 3 ~ 'Heterosexual'
  ))

#=============================================================================

# Percent Graph - Mental health (Sexual Orientation Analysis)
gss2021 %>% filter(!is.na(`Mental Health`), !is.na(sexual_orientation)) %>%
  ggplot(aes(x= `Mental Health`,  group=sexual_orientation)) +
  geom_bar(aes(y = ..prop.., fill = factor(..x..)), stat="count") +
  geom_text(aes( label = scales::percent(..prop..),
                 y= ..prop.. ), stat= "count", vjust = -.5) +
  labs(y = "Percent", x="Mental Health", title = "Mental Health: Heterosexual vs. LGBTQ+") +
  facet_grid(~sexual_orientation) +
  scale_y_continuous(labels = scales::percent) + theme(legend.position="none") + scale_fill_brewer(palette = "Spectral")


#=============================================================================
# Recoding Social Class

gss2021 <- gss2021 %>%
  mutate(`Social Class` = case_when(
    class1 == 1 ~ "lower",
    class1 == 2 ~ "working",
    class1 == 3 ~ "lower middle",
    class1 == 4 ~ "middle",
    class1 == 5 ~ "upper middle",
    class1 == 6 ~ "upper"))

#=============================================================================
# 'Mental Health: Comparison of Different Social Classes'
gss2021 %>% filter(!is.na(`Mental Health`), !is.na(`Social Class`)) %>% ggplot(aes(x= `Mental Health`,  group= `Social Class`))+
  geom_bar(aes(y = ..prop.., fill = factor(..x..)), stat="count") +
  geom_text(aes( label = scales::percent(..prop..),
                 y= ..prop.. ), stat= "count", vjust = -.5) +
  labs(y = "Percent", fill="mntl_poor", title = 'Mental Health: Comparison of Different Social Classes') +
  facet_grid(~factor(`Social Class`, levels = c('lower', 'working','lower middle', 'middle', 'upper middle', 'upper'))) +
  scale_y_continuous(labels = scales::percent) + theme(legend.position="none") + scale_fill_brewer(palette = "Spectral")

#=============================================================================
# Recoding Family Income
gss2021 <- gss2021 %>% 
  mutate(Income = case_when(
    income16 <= 8 ~ "< $10,000",
    income16 <= 12 ~ "$10,000 - $20,000",
    income16 <= 17 ~ "$20,000 - $40,000",
    income16 <= 19 ~ "$40,000 - $60,000",
    income16 <= 21 ~ "$60,000 - $90,000",
    income16 > 21 ~ "> $90,000"))

#=============================================================================
# 'Mental Health: Comparison by Total Family Income'
gss2021 %>% filter(!is.na(`Mental Health`), !is.na(Income)) %>%  ggplot(aes(x= `Mental Health`,  group=Income))+
  geom_bar(aes(y = ..prop.., fill = factor(..x..)), stat="count") +
  geom_text(aes( label = scales::percent(..prop..),
                 y= ..prop.. ), stat= "count", vjust = -.5) +
  labs(y = "Percent" , title = 'Mental Health: Comparison by Total Family Income') +
  facet_grid(~factor(Income, levels = c('< $10,000', "$10,000 - $20,000", "$20,000 - $40,000", "$40,000 - $60,000", "$60,000 - $90,000", "> $90,000"))) +
  scale_y_continuous(labels = scales::percent) + theme(legend.position="none") + scale_fill_brewer(palette = "Spectral")

#=============================================================================
# Recoding Age when first kid is born
gss2021 <- gss2021 %>%
  mutate(`Kid Born` = case_when(
  agekdbrn < 18 ~ '< 18',
  agekdbrn >= 18 & agekdbrn <= 29 ~ '18-29',
  agekdbrn >= 30 & agekdbrn <=39~ '30-39',
  agekdbrn >= 40 & agekdbrn <=49~ '40-49',
  agekdbrn >= 50 & agekdbrn <=64~ '50-64',
  agekdbrn >= 65 & agekdbrn <=89~ '65-89'
))

#=============================================================================
#  "Mental Health: Comparison by age when first child was born"
gss2021 %>% filter(!is.na(`Mental Health`), !is.na(`Kid Born`))  %>% ggplot(aes(x= `Mental Health`,  group=`Kid Born`))+
  geom_bar(aes(y = ..prop.., fill = factor(..x..)), stat="count") +
  geom_text(aes( label = scales::percent(..prop..),
                 y= ..prop.. ), stat= "count", vjust = -.5) +
  labs(y = "Percent", title = "Mental Health: Comparison by Age When First Child was Born") +
  facet_grid(~`Kid Born`) +
  scale_y_continuous(labels = scales::percent) + theme(legend.position="none") + scale_fill_brewer(palette = "Spectral")
#=============================================================================

