# RemoteWorkAnalysis

## Purpose:

* Project Overview:

Following the peak of the COVID-19 pandemic, the workforce has seen different organizations across industries practice different levels of permanent adoption of remote work policies for employees. In this project, we analyzed worker data collected from a  employees across various industries in  Australia during the yea

With this analysis, we set out to provide helpful insights for organizations seeking to create remote work policies that maximizes productivity and aligns with worker demand for remote work environments. Our analysis is designed to help organizational stakeholders identify which factors play the largest role in worker productivity so they can make informed decisions around who should be considered for remote work and how much flexibility for remote work employees should receive. 

* Research into Work Trends of the past 3 years:
In our research, we found an abundance of work from Human Resources and Industrial Organizational Pychology experts focusing on the benefits of remote work for employees during and after the COVID-19 pandemic. Two factors we continuously noticed in the conversation were 1) the comparison between time saved commuting and time spent working for employees adjusting to remote work arrangements and 2) how family dynamic plays a part in the schedule of a remote employee. We decided to use these questions to guide our data analysis when constructing our key research questions. 

* Guiding Questions for Our Analysis:
### Productivity:
  - What factors are most tied to worker productivity in remote environments?
  - Do workers that strongly prefer remote arrangements tend to be more productive? 
  - Do more productive employees tend to be more satisfied in their jobs?

### Analysis of Time Spent:
  - Commuting: What do employees do with the time they save commuting? How does this change by family type?
  - How do job and industry types play a role in the daily schedule of a remote employee?
  
### Organizational Policy Practices: 
  - What percentage of employees should be given the ability to remote work? 
  - What percentage of remote work yields the highest rate of productivity? 
  - What position types are most collaborative when remotely working?
  

## Data:
### Description of the Data (Betsy)
* How it was accessed, collected, responses, and features
* Links to exploratory analysis and main highlights from exploratory analysis - what we found and challenges we anticipate

### Preparing the Data for Analysis
* Merging of the data sets 
Our first step in preparing the data for analysis was merging the datasets collected during 2020 and 2021 into one file with similar columns. The biggest challenge associated with this task revolved around column names: while both dataframes asked similar questions, edits were made to the phrasing of most questions, which resulted in most columns having different names. 

To begin the process, we thoroughly examined both datasets and identified the columns that were conveying the same information. Secondly, we created a column key that helped us keep track of the original question language how they related to the newly created column labels. Finally, we used the column key to identify a final list of 30 shared columns that would be useful in our analysis, which were later merged into one dataset for cleaning. We used a python notebook ot merge the desired columns from both datasets into a merged dataframe with the code below. 

The shapes of our various datframes:
- The 2020 dataframe had 1507 rows and 109 columns.
- The 2021 dataframe had 1512 and 73 columns.
- Our merged dataset has 3019 rows and 30 columns before cleaning. 

* Overview of cleaning steps taken and reasoning behind certain cleaning decisions (Betsy)

* Assembling the database (Nik)

### Assembling Machine Learning Model (Sean)

### Creating Visualization and Presentation (TBD)

### Things we're hoping to find... (Nik)
