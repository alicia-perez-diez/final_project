# Analysis of Fatal Traffic Accidents in the U.S. in 2022

Analysis and predictive modeling of fatal traffic accidents occurring in the 51 states of the U.S. throughout 2022.

## 👋 Introduction

Hello, data analyst or curious reader! 📈 I'm Alicia, a data analysis student at Ironhack. In this notebook, which represents my final project, you'll find a detailed analysis of accidents with at least one fatality that occurred in the United States in 2022 and a predictive model that accurately forecasts the number of fatalities for the next 8 weeks in each state.

## Table of Contents

- Metadata
- Analysis Structure
- Visual Insights

## Metadata

- Author: Alicia Pérez.
- Creation Date: 07/06/2024.
- Last Modified: 07/06/2024.
- Data Source: <a href= "https://www.nhtsa.gov/file-downloads?p=nhtsa/downloads/FARS/2022/National/">United States Department of Transportation (NHTSA)</a>.

## Analysis Structure

- Project Planning: project type selection, database selection, goal definition, and ERD development.
- Data Import with Python to MySQL Workbench.
- Data Cleaning and Formatting with MySQL.
- Final Aggregation, Statistical Analysis, and Graphical Visualization with PowerBI.
- Development of ABT, PCA, and Predictive Model with Python.

## 📊 Visual Insights: Data Analysis

![PowerBI dashboard](https://github.com/alicia-perez-diez/final_project/blob/main/images/dashboard.gif)

Download the PowerBI dashboard via this <a href="https://drive.google.com/file/d/1tNa_nt9-yHBv2XsX27upeD5dxSDrV-nV/view?usp=drive_link">link</a>.

## 📊 Visual Insights: Predictive Model

![Correlation heatmap](https://github.com/alicia-perez-diez/final_project/blob/main/images/correlation_heatmap.gif)

This heatmap shows possible correlations between variables, highlighting significant correlations between seat position, person type, response times, and the type of accident causing fatalities. This underscores the need to perform PCA to reduce data dimensionality before proceeding with the predictive model.

Download it <a href="https://drive.google.com/file/d/1dAf6f0uyVGJLgKJBIuusFNsUtUXbvc40/view?usp=drive_link">here</a>.

![Time series for 1 random state](https://drive.google.com/uc?export=view&id=1_3nYQxFsc6YUbA4D_e4ykrMIoVvEMPhW)

The time series analysis for a randomly selected state showed daily variability without a defined pattern. Therefore, data was grouped by week to smooth the trend and reveal clearer patterns. This strategy facilitated a more structured understanding of the evolution of traffic accidents in each state.

![Features importance](https://drive.google.com/uc?export=view&id=1DIG-oZtVGaTHg0E8w5Q-qp8SMmObcASZ)

The term 'ma8' represents the 8-week moving average in the context of analyzing traffic accident fatalities. This indicator reflects the historical trend of fatalities over a specific period. By calculating this average, a smoother view of the trend in accident incidence over time is obtained, allowing for the detection of significant patterns or trends. This technique helps identify changes in accident frequency and provides a clearer understanding of the underlying data dynamics.

![Fatalities forecast](https://drive.google.com/uc?export=view&id=1vZsqLiPsbykqSfg6T_Qj5F2Rz0xN53Z4)

The prediction graph shows a clear trend in traffic accident fatalities in 2022, highlighting significant peaks of up to 939 and 934 fatalities per week in the last weeks of the year. These peaks indicate critical periods of high risk. For the next 8 weeks, the model predicts figures of 871, 844, 849, 850, 845, 849, 817, and 848 fatalities per week, indicating critical weeks that will require special attention.

Detailed information about the project at the following <a href="https://docs.google.com/presentation/d/1AKr2wNU-6pMedlli2poKJx5BKxoEVtAbk5RP1vD4Xw8/edit?usp=sharing">link</a>.

Link to the ERD <a href="https://drive.google.com/file/d/1WEghHFbpD1ldkTyGZPo3oXcFeZM19uF5/view?usp=drive_link">here</a>.

Thanks for reading 😊!