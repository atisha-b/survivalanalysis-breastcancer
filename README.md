# Survival Analysis for Breast Cancer
## Overview
### This project aims to analyze survival data from breast cancer patients to understand factors such as survival and recurrence rates. 
## NKI Breast Cancer Data summary
272 breast cancer patients (as rows), 1570 columns.
Network built using only gene expression.
Meta data includes patient info, treatment, and survival.

Each node is a group of patients similar to each other. Flares (left) represent sub-populations that are distinct from the larger population. (One differentiating factor between the two flares is estrogen expression (low = top flare, high = bottom flare)). Bottom flare is a group of patients with 100% survival. Top flare shows a range of survival – very poor towards the tip (red), and very good near the base (circled).

The circled group of good survivors have genetic indicators of poor survivors (i.e. low ESR1 levels, which is typically the prognostic indicator of poor outcomes in breast cancer) – understanding this group could be critical for helping improve mortality rates for this disease. Why this group survived was quickly analysed by using the Outcome Column (here Event Death - which is binary - 0,1) as a Data Lens (which we term Supervised vs Unsupervised analyses).

Published in 2 papers - Nature and PNAS:

http://www.nature.com/articles/srep01236

https://d1bp1ynq8xms31.cloudfront.net/wp-content/uploads/2015/02/Topology_Based_Data_Analysis_Identifies_a_Subgroup_of_Breast_Cancer_with_a_unique_mutational_profile_and_excellent_survival.pdf

## Features
Dataset: The dataset (NKI_cleaned.csv) includes the following variables:
survival: Time until death or last follow-up (in months).
eventdeath: Indicator for death (1) or censoring (0).
timerecurrence: Time until recurrence or last follow-up (in months).
recurrence: Indicator for recurrence (1) or censoring (0).
Other demographic and clinical variables (age, sex, treatment history, tumor characteristics).

# Analysis
## Survival Analysis:
Estimation of overall survival (OS) and recurrence-free survival (RFS) probabilities.
Median survival calculation and survival at specific time points.
Visualization of survival curves using Kaplan-Meier plots.
## Effect of Treatment:
Investigation of the impact of chemotherapy and hormonal therapy on recurrence-free survival.
Cox proportional hazards modeling to assess the association between treatment and survival outcomes.

# Results
The analysis reveals significant differences in survival probabilities between treatment groups.
Chemotherapy is associated with improved recurrence-free survival, while hormonal therapy shows varying effects depending on patient characteristics.
Cox proportional hazards model identifies treatment, age, and tumor characteristics as significant predictors of survival outcomes.
