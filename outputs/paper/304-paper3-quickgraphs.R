library("readxl")
library(dplyr)
library(tidyverse)
library(vtable)


library(haven)
gss2021 <- read_dta("D:/Downloads/Downloads/2021_stata/gss2021.dta")
View(gss2021)


glimpse(gss2021)
glimpse(gss2021$hlthmntl)


#=================


# HLTHMNTL <--- Mental health
# HLTHPHYS <---- Physical health
# SEXORNT <---- Sexual orientation
# SEXBIRTH1
# SEXNOW
# SUICIDE
# AGE
# activnat <--- Activity in Nature


library(tidyverse)
library(ggplot2)
library(dplyr)


labels <- c("Female", "Male")
gss2021$sex_group <- cut(gss2021$sex, 2, labels = labels)

ggplot(data = gss2021, aes(x = sex_group)) +
  ggtitle("Survey respondents's gender") +
  geom_bar()

#recoding mental health
# Changed good or better to 'Good'
# Change poor and fair to 'Not Good'
gss2021 <- gss2021 %>%
  mutate(mntl_poor = case_when(
    hlthmntl == 1 ~ 'Good',
    hlthmntl == 2 ~ 'Good',
    hlthmntl == 3 ~ 'Good',
    hlthmntl == 4 ~ 'Not Good',
    hlthmntl == 5 ~ 'Not Good',
  ))

gss2021$hlthphys

#Count Graph - Mental Health - Male Vs Female
gss2021 %>% filter(!is.na(mntl_poor), !is.na(sex_group)) %>%  ggplot(aes(x = mntl_poor, fill=sex_group)) +
  geom_bar()



# Percent Graph - Mental health - Male Vs Female
gss2021 %>% filter(!is.na(mntl_poor), !is.na(sex_group)) %>% ggplot(aes(x= mntl_poor,  group=sex_group)) +
  geom_bar(aes(y = ..prop.., fill = factor(..x..)), stat="count") +
  geom_text(aes( label = scales::percent(..prop..),
                 y= ..prop.. ), stat= "count", vjust = -.5) +
  labs(y = "Percent", fill="mntl_poor") +
  facet_grid(~sex_group) +
  scale_y_continuous(labels = scales::percent)


#Recoding physical health
gss2021 <- gss2021 %>%
  mutate(phys_poor = case_when(
    hlthphys == 1 ~ 'Good',
    hlthphys == 2 ~ 'Good',
    hlthphys == 3 ~ 'Good',
    hlthphys == 4 ~ 'Not Good',
    hlthphys == 5 ~ 'Not Good',
  ))


# Percent Graph Physical health
# Percent Graph Physical health - Male vs Female
gss2021 %>% filter(!is.na(mntl_poor), !is.na(sex_group), !is.na(phys_poor)) %>% ggplot(aes(x= phys_poor, fill = mntl_poor)) + geom_bar()


#===

# Percent Graph - Poor Mental health = Physical health within Sex_Group comparison
gss2021 %>% filter(!is.na(mntl_poor), !is.na(sex_group), !is.na(phys_poor), mntl_poor =='Not Good') %>%
  ggplot(aes(x= phys_poor,  group=sex_group)) +
  geom_bar(aes(y = ..prop.., fill = factor(..x..)), stat="count") +
  geom_text(aes( label = scales::percent(..prop..),
                 y= ..prop.. ), stat= "count", vjust = -.5) +
  labs(y = "Percent", fill="Physical Health") +
  facet_grid(~sex_group) +
  scale_y_continuous(labels = scales::percent)

#====

# Recording Age Group
gss2021 <- gss2021 %>%
  mutate(Age_Group = case_when(
    age >= 18 & age <= 29 ~ '18-29',
    age >= 30 & age <=39~ '30-39',
    age >= 40 & age <=49~ '40-49',
    age >= 50 & age <=64~ '50-64',
    age >= 65 & age <=89~ '65-89'
  ))

#======

# Percent Graph - Mental health (Age Group Analysis)
gss2021 %>% filter(!is.na(mntl_poor), !is.na(sex_group), !is.na(phys_poor),!is.na(Age_Group)) %>%
  ggplot(aes(x= Age_Group,  group=mntl_poor)) +
  geom_bar(aes(y = ..prop.., fill = factor(..x..)), stat="count") +
  geom_text(aes( label = scales::percent(..prop..),
                 y= ..prop.. ), stat= "count", vjust = -.5) +
  labs(y = "Percent", fill="Age Group") +
  facet_grid(~mntl_poor) +
  scale_y_continuous(labels = scales::percent)


#=======================

# Recoding Sexual orientation

gss2021 <- gss2021 %>%
  mutate(sexual_orientation = case_when(
    sexornt == 1 ~ 'LGBTQ+',
    sexornt == 2 ~ 'LGBTQ+',
    sexornt == 3 ~ 'Straight'
  ))

unique(gss2021$sexual_orientation)

# Percent Graph - Mental health (Age Group Analysis)
gss2021 %>% filter(!is.na(mntl_poor), !is.na(sex_group), !is.na(phys_poor),!is.na(Age_Group), !is.na(sexual_orientation)) %>%
  ggplot(aes(x= sexual_orientation,  group=mntl_poor)) +
  geom_bar(aes(y = ..prop.., fill = factor(..x..)), stat="count") +
  geom_text(aes( label = scales::percent(..prop..),
                 y= ..prop.. ), stat= "count", vjust = -.5) +
  labs(y = "Percent", fill="Age Group") +
  facet_grid(~mntl_poor) +
  scale_y_continuous(labels = scales::percent)

