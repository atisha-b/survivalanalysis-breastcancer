library(survival)
library(survminer)
data<-read_csv('NKI_cleaned.csv')
library(ranger)
library(ggplot2)
library(dplyr)
library(ggfortify)
library(devtools)

length(data)
ncol(data)
nrow(data)
head(data)

colnames(data)
data$recurrence = 1

os <- survfit(Surv(survival, eventdeath) ~ 1, data = data)
rfs <- survfit(Surv(timerecurrence, recurrence) ~ 1, data = data)

# Median Survival
os
rfs
# Survival at every month
summary(os, times=1*(0:20))
summary(rfs, times=1*(0:20))

# 18 Month Survival
summary(os, times = 18)
summary(rfs, times = 18)

# Creating the plots
fit<-list(RFS = rfs, OS = os)
p<- ggsurvplot(fit,  data = data,
               combine = TRUE, #combine curves
               risk.table = TRUE, 
               pval = FALSE,
               xlim=c(0,18),
               xlab = "Time (months)",
               break.x.by=2,
               conf.int = TRUE,
               censor.shape="|", censor.size = 2, 
               palette =c("#a0ced9","#ffc09f"),
               tables.theme = theme_light(),
               legend = c(0.2, 0.2),
               ggtheme = theme_light())

# Code added so I could save the plot using ggsave
grid.draw.ggsurvplot <- function(x){
  survminer:::print.ggsurvplot(x, newpage = FALSE)
}

ggsave(plot = p, dpi = 500, filename = "BreastCancer_SurvivalPlots.jpeg")

##### Checking the effect of chemo on Recurrence free survival
rfs <- survfit(Surv(timerecurrence, recurrence) ~ chemo, data = data)
p<- ggsurvplot(rfs,
               risk.table = TRUE, 
               pval = TRUE, data = data,
               xlab = "Time (months)",
               break.x.by=2,
               conf.int = TRUE,
               xlim=c(0,18),
               censor.shape="|", censor.size = 2, 
               palette =c("#7700ff","#00aaff"),
               tables.theme = theme_light(),
               legend = c(0.8, 0.7),
               ggtheme = theme_light())

ggsave(plot = p, dpi = 500, filename = "BreastCancer_SurvivalPlots_chemo.jpeg")


##### Checking the effect of hormonal on Recurrence free survival
rfs <- survfit(Surv(timerecurrence, recurrence) ~ hormonal, data = data)
p<- ggsurvplot(rfs,
               risk.table = TRUE, 
               pval = TRUE, data = data,
               xlab = "Time (months)",
               break.x.by=2,
               conf.int = TRUE,
               xlim=c(0,18),
               censor.shape="|", censor.size = 2, 
               palette =c("#7700ff","#00aaff"),
               tables.theme = theme_light(),
               legend = c(0.8, 0.7),
               ggtheme = theme_light())

ggsave(plot = p, dpi = 500, filename = "BreastCancer_SurvivalPlots_hormonal.jpeg")

# Method 1 for CPH (if we define categories)

data$chemo = as.factor(data$chemo)
data$hormonal = as.factor(data$hormonal)
data$amputation = as.factor(data$amputation)


# Method 1
coxph(Surv(timerecurrence, recurrence) ~ c(chemo) + age + c(hormonal) +
        c(amputation) + diam, data = data, ties="breslow") %>% summary()

# Method 2
# Method 2 for CPH
library(survivalAnalysis)
fit1 = data %>%
  analyse_multivariate(vars(timerecurrence, recurrence),
                       covariates = vars(chemo,age,hormonal,amputation, diam))

coxphsummary<- fit1$coxph %>% summary

anova(fit1$coxph)

library(tidyverse)
library(gt)

### PICTORIAL PLOT# Creating the plots
fit<-list(RFS = rfs, OS = os)
p<- ggsurvplot(fit,  data = data,
               combine = TRUE, #combine curves
               risk.table = TRUE, 
               pval = FALSE,
               xlim=c(0,18),
               xlab = "Time (months)",
               break.x.by=2,
               conf.int = TRUE,
               censor.shape="|", censor.size = 2, 
               palette =c("#a0ced9","#ffc09f"),
               tables.theme = theme_light(),
               legend = c(0.2, 0.2),
               ggtheme = theme_light())

# Code added so I could save the plot using ggsave
grid.draw.ggsurvplot <- function(x){
  survminer:::print.ggsurvplot(x, newpage = FALSE)
}

ggsave(plot = p, dpi = 500, filename = "BreastCancer_SurvivalPlots.jpeg")

##### Checking the effect of chemo on Recurrence free survival
rfs <- survfit(Surv(timerecurrence, recurrence) ~ chemo, data = data)
p<- ggsurvplot(rfs,
           risk.table = TRUE, 
           pval = TRUE, data = data,
           xlab = "Time (months)",
           break.x.by=2,
           conf.int = TRUE,
           xlim=c(0,18),
           censor.shape="|", censor.size = 2, 
           palette =c("#7700ff","#00aaff"),
           tables.theme = theme_light(),
           legend = c(0.8, 0.7),
           ggtheme = theme_light())

ggsave(plot = p, dpi = 500, filename = "BreastCancer_SurvivalPlots_chemo.jpeg")


##### Checking the effect of hormonal on Recurrence free survival
rfs <- survfit(Surv(timerecurrence, recurrence) ~ hormonal, data = data)
p<- ggsurvplot(rfs,
           risk.table = TRUE, 
           pval = TRUE, data = data,
           xlab = "Time (months)",
           break.x.by=2,
           conf.int = TRUE,
           xlim=c(0,18),
           censor.shape="|", censor.size = 2, 
           palette =c("#7700ff","#00aaff"),
           tables.theme = theme_light(),
           legend = c(0.8, 0.7),
           ggtheme = theme_light())

ggsave(plot = p, dpi = 500, filename = "BreastCancer_SurvivalPlots_hormonal.jpeg")

# Method 1 for CPH (if we define categories)

data$chemo = as.factor(data$chemo)
data$hormonal = as.factor(data$hormonal)
data$amputation = as.factor(data$amputation)


# Method 1
coxph(Surv(timerecurrence, recurrence) ~ c(chemo) + age + c(hormonal) +
        c(amputation) + diam, data = data, ties="breslow") %>% summary()

# Method 2
# Method 2 for CPH
library(survivalAnalysis)
fit1 = data %>%
  analyse_multivariate(vars(timerecurrence, recurrence),
                       covariates = vars(chemo,age,hormonal,amputation, diam))

coxphsummary<- fit1$coxph %>% summary

anova(fit1$coxph)

library(tidyverse)
library(gt)

### PICTORIAL PLOT
df<- cox_as_data_frame(coxphsummary, unmangle_dict = NULL, factor_id_sep = ":",sort_by = NULL)

p <- df %>% ggplot(aes(x=log(HR), y =  factor.id )) + theme_bw()
p <- p + geom_point(aes(x=log(HR)), shape=15, color='blue', size=2) +
  geom_errorbar(aes(xmin=log(Lower_CI), xmax=log(Upper_CI)), width = 0.2)+
  geom_vline(xintercept = 0, linetype="dashed") +
  labs(x='log(HR) (95% CI)', y="")+
  coord_cartesian(ylim=c(1,5), xlim=c(-1, 1))+ theme(aspect.ratio=1/3, plot.margin=unit(c(0.3,0.1,0.3,0.1), "null")) 


ggsave(plot = p, dpi = 500, filename = "BreastCancer_pictorial_plot.jpeg")

df<- cox_as_data_frame(coxphsummary, unmangle_dict = NULL, factor_id_sep = ":",sort_by = NULL)
p <- df %>% ggplot(aes(x=log(HR), y =  factor.id )) + theme_bw()
p <- p + geom_point(aes(x=log(HR)), shape=15, color='blue', size=2) +
  geom_errorbar(aes(xmin=log(Lower_CI), xmax=log(Upper_CI)), width = 0.2)+
  geom_vline(xintercept = 0, linetype="dashed") +
  labs(x='log(HR) (95% CI)', y="")+
  coord_cartesian(ylim=c(1,5), xlim=c(-1, 1))+ theme(aspect.ratio=1/3, plot.margin=unit(c(0.3,0.1,0.3,0.1), "null")) 


ggsave(plot = p, dpi = 500, filename = "BreastCancer_pictorial_plot.jpeg")
