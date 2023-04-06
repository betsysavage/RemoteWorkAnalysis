# RemoteWorkAnalysis

## Project Overview:

Following the peak of the COVID-19 pandemic, organizations across various industries have adopted widely varying permanent remote work policies for their employees. In this project, we analyzed data collected from remote employees across various industries in Australia in a 2-year study taking place during the height of the COVID-19 pandemic. 

With our analysis, we aim to provide helpful insights for organizations seeking to enact remote work policies that maximize productivity and align with permanent demand for virtual and hybrid environments following the peak of the global pandemic. Our analysis is designed to help organizational stakeholders identify which factors play the largest role in worker productivity so they can make informed decisions around who should be considered for remote work and how much flexibility for remote work employees should receive. 

## Preliminary Research into Work Trends of the past 3 years:
In our initial investigation of the topic, we found an abundance of research from Human Resources and Industrial Organizational Pychology experts focusing on the benefits of remote work for employees during and after the COVID-19 pandemic. Two factors we continuously noticed in the ongoing conversation were 1) the comparison between time saved commuting and time spent working for employees adjusting to remote work arrangements and 2) how family dynamic plays a part in the schedule of a remote employee. We decided to use these questions to guide our data analysis when constructing our key research questions around productivity and policy making. 

## Guiding Questions for Our Analysis:
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

![Merge Table Code](https://github.com/betsysavage/RemoteWorkAnalysis/blob/main/Resources/Images/Data%20Merging%20Code.png)

The shapes of our various datframes:
- The 2020 dataframe had 1507 rows and 109 columns.
- The 2021 dataframe had 1512 and 73 columns.
- Our merged dataset has 3019 rows and 30 columns before cleaning. 

### Cleaning the Data - Status: Complete

In order to prepare the merged dataset for modeling, we took the following steps to clean and transform the data:
*   **Transforming column headers** - Because spaces, question marks, and colons can make running code more challenging, these common punctuation marks were removed or replaced with underscores. To provide a unique reference id for each survey response, a column indicating a “responder_id” was added in place of the response ids, which repeated for each of the two datasets.
*   **Resolving null values** - We used a loop to print the number of null values for each column. Because the dataset is small, each row contains valuable information, and survey results should only be excluded from the dataset if absolutely necessary. Null values within categorical response columns were replaced with another string option - “No response” - in order to analyze potential patterns in skipped responses when modeling. If the null values occurred within a column with a numerical data type, the null values were replaced with the column’s median to reduce the impact of potential outliers on the model. 
*   **Identifying and replacing outliers** - Although most of the data types in this survey were object or string responses, several questions asked the respondents to estimate the number of hours in a day they spent on a variety of activities when working remotely compared to working in the office. Because the question was open-ended, participants could list any number, leading to a risk of outliers. When examining the data with boxplot visualizations and print statements of the maximum values, it became clear that several respondents interpreted the question as the number of hours per week instead of the number of hours per day, resulting in some values that exceeded 24 hours. Since someone cannot spend 40 hours per day working, these outliers needed to be addressed to improve the accuracy of the model. We adjusted the outliers by using a loop to: 1.)  identify responses exceeding three standard deviations from the mean and 2.) replace these values with the median of the column. 
*   **Bucketing categorical variables** - In order to prepare the data for a machine-learning model, all categorical variable types needed to be encoded into numeric values representing the response. If the column offers a large number of unique responses, the number of encoded variables becomes more complex. To make our model easier to analyze, we chose to “bucket” responses for categorical variables into broader categories in order to improve the efficiency of the model and reduce the impact of rare occurrences. For example, we examined the distribution of industry and occupation descriptors (which had 26 and 50 unique values, respectively) and recategorized those occurring with the lowest frequency as “other.” Additionally, many questions asked respondents to select from a menu of options the proportion of time they work remotely or would prefer to work remotely. Options included both percentages and text (ex: “20%”, “50%-About half of my time”), as well as similar values (“Rarely,” “Less than 10% of my time”), making the responses more difficult to interpret. In order to simplify these categories, we chose to reframe the options in the context of the number of days in the workweek, as outlined in the survey questions (“If you work a 5 day week, 1 day equals 20% of your work time.”). By recategorizing the response options from percentages and text to five categories representing the number of weekdays (0-1 days, 1-2 days, 2-3 days, 3-4 days, 4-5 days), we made our variables easier to analyze and interpret.   
*   **Adding engineered features of interest for our analysis** - To make our analysis more robust, we then explored opportunities to generate calculated fields from existing columns that may provide insight into our research questions. Since we are interested in exploring how time being saved from commuting may be redistributed among remote workers (either towards working more productively or towards other areas of work-life balance), we generated a new field called “commute_time_difference” by subtracting the remote commute time from the in-person commute time. Additional calculated fields may be created as the analysis progresses.   


* Assembling the database (Nik)

### Assembling Machine Learning Model (Sean)

### Creating Visualization and Presentation (TBD)

### Things we're hoping to find... (Nik)
