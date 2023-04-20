# RemoteWorkAnalysis

## Project Overview:

Following the peak of the COVID-19 pandemic, organizations across various industries have adopted widely varying permanent remote work policies for their employees. In this project, we analyzed data collected from remote employees across various industries in Australia in a 2-year study taking place during the height of the COVID-19 pandemic.

With our analysis, we aim to provide helpful insights for organizations seeking to enact remote work policies that maximize productivity and align with permanent demand for virtual and hybrid environments following the peak of the global pandemic. Our analysis is designed to help organizational stakeholders identify which factors play the largest role in worker productivity so they can make informed decisions around who should be considered for remote work and how much flexibility for remote work employees should receive.

## Preliminary Research into Work Trends of the past 3 years:
In our initial investigation of the topic, we found an abundance of research from Human Resources and Industrial Organizational Psychology experts focusing on the benefits of remote work for employees during and after the COVID-19 pandemic. Two factors we continuously noticed in the ongoing conversation were 1) the comparison between time saved commuting and time spent working for employees adjusting to remote work arrangements and 2) how family dynamic plays a part in the schedule of a remote employee. We decided to use these questions to guide our data analysis when constructing our key research questions around productivity and policy making.

## Guiding Questions for Our Analysis:
### Productivity:
  * What factors are most tied to worker productivity in remote environments?
  * Do workers that strongly prefer remote arrangements tend to be more productive? 
  * Do more productive employees tend to be more satisfied in their jobs?

### Analysis of Time Spent:
  * Commuting: What do employees do with the time they save commuting? What factors influence how saved time is used?
  * Do employees who save time commuting use saved time working? How much?
  
### Organizational Policy Practices:  
  * What percentage of remote work yields the highest rate of productivity? 
  * What position types are most productive when remotely working?
  

## Data:

### About the Data
The dataset used for this analysis was accessed via Kaggle’s dataset library, which contained a post of the dataset sourced from Maven Analytics. This data was collected by the New South Wales (NSW) Productivity Commission, a government task force in Australia tasked with identifying opportunities to boost productivity, through a series of “Remote Working Insight” surveys in 2020 and 2021. Each of the two surveys were completed through interviews with 1,500 employed workers in the New South Wales area who were identified as “remoteable” (defined as “having experience of remote working in their current job”) across a variety of industries and occupations. 
We selected this dataset because it provided insights into a wide range of variables related to remote work - including employee attitudes and preferences, organizational characteristics and policies, and breakdown of time allocated to tasks - as well as standard productivity measures. As described in the NSW summary, the survey questions asked participants about the following topics:
* Their attitudes to remote working 
* The amount of time they spent working remotely 
* Their employers’ policies, practices, and attitudes
* How they spent their time when working remotely
* How barriers to remote working have changed 
* The barriers they faced to hybrid working
* Their expectations for the future remote working 
*Source: 2021 Remote Working Survey Appendix A

### Initial Exploration

Initial exploration of the 2020 and 2021 datasets was conducted in Jupyter Notebook and Excel. During this step, we looked at features of the dataset, the values of unique responses, descriptive statistics of specific variables of interest, and patterns among population groups. As we began to examine both datasets prior to analysis, we noted a few patterns in the features of the data:

* Many survey questions changed from year to year as the commission identified the need for new or refined data. The 2021 survey incorporated over thirty additional questions. Survey questions were worded slightly differently and contained inconsistent punctuation.
* Nearly all data types are strings - Most of the survey questions prompted participants to select from a menu of categorical responses. As a result, the majority of columns contain object values.
* There are several outliers in responses where participants estimated the number of hours in a day spent on various activities. The range of estimated hours spent on tasks like commuting, caring and domestic responsibilities, and working sometimes exceeded more than 24 hours in a day. 
* Surveys were distributed to a diverse sample to ensure that demographics were representative of the workforce. The data has an even split of gender, age, and managers vs non-managers. Respondents are slightly skewed towards metro locations, organizations with more than 200 employees, and employees who have worked in their current organization for more than 5 years. While the most common industry types included the somewhat typically remote fields of “Professional, scientific, and technical” and “Financial services”, the survey design intentionally sampled more from a wider range of 19 industries in an effort to be more representative of the total workforce. The datasets did not include information about race or salary.
* There is inherent bias in the sample towards those who work remotely (and who prefer to work remotely) - Plotting the response frequency for questions around the proportion of time working remotely shows that our dataset is skewed towards respondents who complete most of their work remotely or have a strong preference for working remotely. This is not surprising, given the survey was only distributed to workers whose jobs could be completed remotely.

Based on these initial observations in the dataset, we noted our cleaning needs and developed plans to prepare the data for our model and analysis.


### Preparing the Data for Analysis
* Merging of the data sets 
Our first step in preparing the data for analysis was merging the datasets collected during 2020 and 2021 into one file with similar columns. The biggest challenge associated with this task revolved around column names: while both data frames asked similar questions, edits were made to the phrasing of most questions, which resulted in most columns having different names. 

To begin the process, we thoroughly examined both datasets and identified the columns that were conveying the same information. Secondly, we created a column key that helped us keep track of the original question and how they related to the newly created column labels. Finally, we used the column key to identify a final list of 30 shared columns that would be useful in our analysis, which were later merged into one dataset for cleaning. We used a python notebook to merge the desired columns from both datasets into a merged data frame with the code below. 

![Merge Table Code](https://github.com/betsysavage/RemoteWorkAnalysis/blob/main/Resources/Images/Data%20Merging%20Code.png)

The shapes of our various data frames:
- The 2020 data frame had 1507 rows and 109 columns.
- The 2021 data frame had 1512 and 73 columns.
- Our merged dataset has 3019 rows and 30 columns before cleaning. 

### Cleaning the Data 

In order to prepare the merged dataset for modeling, we took the following steps to clean and transform the data:
*   **Transforming column headers** - Because spaces, question marks, and colons can make running code more challenging, these common punctuation marks were removed or replaced with underscores. To provide a unique reference id for each survey response, a column indicating a “responder_id” was added in place of the response ids, which repeated for each of the two datasets.
*   **Resolving null values** - We used a loop to print the number of null values for each column. Because the dataset is small, each row contains valuable information, and survey results should only be excluded from the dataset if necessary. Null values within categorical response columns were replaced with another string option - “No response” - to analyze potential patterns in skipped responses when modeling. If the null values occurred within a column with a numerical data type, the null values were replaced with the column’s median to reduce the impact of potential outliers on the model. 
*   **Identifying and replacing outliers** - Although most of the data types in this survey were object or string responses, several questions asked the respondents to estimate the number of hours in a day they spent on a variety of activities when working remotely compared to working in the office. Because the question was open-ended, participants could list any number, leading to a risk of outliers. When examining the data with boxplot visualizations and print statements of the maximum values, it became clear that several respondents interpreted the question as the number of hours per week instead of the number of hours per day, resulting in some values that exceeded 24 hours. Since someone cannot spend 40 hours per day working, these outliers needed to be addressed to improve the accuracy of the model. We adjusted the outliers by using a loop to: 1.)  identify responses exceeding three standard deviations from the mean and 2.) replace these values with the median of the column. 
*   **Bucketing categorical variables** - To prepare the data for a machine-learning model, all categorical variable types needed to be encoded into numeric values representing the response. If the column offers a large number of unique responses, the number of encoded variables becomes more complex. To make our model easier to analyze, we chose to “bucket” responses for categorical variables into broader categories in order to improve the efficiency of the model and reduce the impact of rare occurrences. For example, we examined the distribution of industry and occupation descriptors (which had 26 and 50 unique values, respectively) and recategorized those occurring with the lowest frequency as “other.” Additionally, many questions asked respondents to select from a menu of options the proportion of time they work remotely or would prefer to work remotely. Options included both percentages and text (ex: “20%”, “50%-About half of my time”), as well as similar values (“Rarely,” “Less than 10% of my time”), making the responses more difficult to interpret. In order to simplify these categories, we chose to reframe the options in the context of the number of days in the workweek, as outlined in the survey questions (“If you work a 5-day week, 1 day equals 20% of your work time.”). By recategorizing the response options from percentages and text to five categories representing the number of weekdays (0-1 days, 1-2 days, 2-3 days, 3-4 days, 4-5 days), we made our variables easier to analyze and interpret.   
*   **Adding engineered features of interest for our analysis** - To make our analysis more robust, we then explored opportunities to generate calculated fields from existing columns that may provide insight into our research questions. Since we are interested in exploring how time being saved from commuting may be redistributed among remote workers (either towards working more productively or towards other areas of work-life balance), we generated a new field called “commute_time_difference” by subtracting the remote commute time from the in-person commute time. Additional calculated fields may be created as the analysis progresses.   


### Assembling the Database 
**Organizing the Data into Tables**

* Once the data was cleaned, the dataset was then broken down into three groups: respondents, organizational data, and time management. 
* A Respondents table was created using columns of data that asked questions about the participants personal attributes such as birth year, gender, years at job and occupation description. 

* The second table, Organizational Data, was created by using columns of survey questions that asked the participants about the organization that they worked for. These questions addressed the size of the organization that they worked for, whether the organization encouraged remote work, or if the employer would support remote work if the pandemic was over. 
* Thirdly, a Time Management table was created using columns of survey questions that asked the respondents about how they spent their time while remote working. This included questions like what percent of time they spent remote working in 2020, and their productivity at home versus at the office.   Other columns of this table asked about time spent commuting, hours spent working, and hours of personal family time for both remote and in-person work.

**Creating the Database**
* After the data was grouped into these three tables the following Entity Relationship Diagram (ERD) was created to map out the database. Note that a “responder_id” column was added to each of the tables as a primary and foreign key to create relationships between the SQL tables.

![database erd](https://github.com/betsysavage/RemoteWorkAnalysis/blob/dace2a6c6f8fa63089c9b085562d917060cfbf13/database_erd/remote_work_database_erd.png)


* A jupyter notebook was then used to create data frames for each of these tables, and then exported these data frames into their own csv files. 
* Using pgAdmin 4, PostgreSQL [schemas](AWS/remote_work_db_schema.sql) were developed to create the database structure. 
* Using Amazon Web services (AWS) and RDS, each csv was loaded into an S3 bucket. An engine was created to connect to AWS using a [Colab](AWS/remoteworking_rds_setup.ipynb) notebook. From there the csv files were written into postgres SQL. The following tables were created in the “RemoteWorking” database. 


#### Respondents
![respondents table](Resources/Images/respondents_sql_table.png)

#### Organizational Data
![organization table](Resources/Images/orginizational_data_sql_table.png)

#### Time Management
![time man table](Resources/Images/time_managment_sql_table.png)



**Connecting to the Database**
* Using another [Colab](remote_working__rds_connection.ipynb) notebook, SQL alchemy was used to connect to the AWS database. An engine was created to read in the SQL database tables. The data was read into the notebook as dictionaries, which were then converted into a pandas data frame.

### Analysis Using Machine Learning Models
Due to the vast number of features in our dataset, we first implemented machine learning models to help us determine which features were closest tied to worker productivity. Since our analysis revolved around categorical variables, we focused on finding the best logistical regression models to predict levels of self-reported work productivity in workers from our dataset. 

While preparing our models, we decided to group responses indicating the same level of productivity while working remotely with responses indicated higher levels of productivity under the reasoning that employees who have similar output in both arrangements would tend to support a case for remote work. 
Image:

Initially we tested for 6 different types of logistical regression models to find a best fit:

- Ensemble Models
    - Random Forest
    - Easy Ensemble AdaBoost
- Resampling Models:
    - SMOTE Oversampling
    - Naive Random Over-sampling
    - Cluster Centroids Under-sampling
    - SMOTEENN Combined Sampling

From the 6 models we tested, the Random Forest model initially performed the best for precision and accuracy when it came to predicting employees who were more productive while working in remote environments (precision of .61 and accuracy of .93), however we found that none of our models performed particularly well when it came to predicting employees who reported less the same level of productivity. We decided to perform Hyperparameter tuning to optimize our model. 

## Our model before performing hyperparameter tuning
![Class Report](https://github.com/betsysavage/RemoteWorkAnalysis/blob/main/Resources/Images/Random%20Forest%20Results%20Untuned.png)

## Our Random Forest Model after performing hyperparameter tuning:
![Class Report](https://github.com/betsysavage/RemoteWorkAnalysis/blob/main/Resources/Images/Random%20Forest%20Results%20Tuned.png)

#### Feature Importance 
Using our Random Forest model, we also generated a list of the most important features when it comes to predicting levels of worker productivity. The top 5 weighted factors are shown below:
    1) Worker Age (.056)
    2) Hours spent on personal/family time when remote (2020) (weight of .04)
    3) Hours spent working when remote (2020) (weight of .039)
    4) Hours spent working when in person (pre-pandemic) (weight of .036)
    5) Hours spent on domestic responsibilities when remote (2020) (weight of .033)

![MLM Features](https://github.com/betsysavage/RemoteWorkAnalysis/blob/main/Resources/Images/MLM%20features%20.png)

We used these heavily weighted factors to guide our exploration into what makes workers report higher levels of productivity. In our visualization, you'll find we consistently explore how worker age and time spent relate to worker productivity across various other factors.

## Results 

### Population Demographics

![demographics](https://github.com/betsysavage/RemoteWorkAnalysis/blob/d0ada1ff3e33a1015c4d7f0dc3b69c8db6f4e162/Resources/Images/dashboard%20png/demographics.png)

* There were 3019 respondents that answered the survey over the two-year period.
* Millennials and Gen X make up most of the remote workers surveyed. Gen Z made up only a small percentage of the respondents as they are still entering the workforce. 
* There were 1,570 males, and 1,443 female respondents. Six responded as unknown.
* The average age for workers surveyed was between the ages of 40 and 45 years old. 
* Overall, the younger employees were more heavily weighted towards being female, whereas the age increased males outweighed the number of females. 
* Most respondents are partnered with dependent children. This seemed to affect how they chose to use the time gained from remote working.  


### Age 

![Age](https://github.com/betsysavage/RemoteWorkAnalysis/blob/d0ada1ff3e33a1015c4d7f0dc3b69c8db6f4e162/Resources/Images/dashboard%20png/age.png)

* Filtering the pie chart on different generations shows that every generation feels more productive when remote working. 
* Millennials had the highest percentage of feeling more productive. Although a majority of boomers felt more productive as well, the percentage of them feeling more productive was smaller than every other generation.  
* As a whole, a majority of survey respondents rated themselves as “more productive” when working remotely for all age groups, but this “more productive” proportion was the greatest among Millennial and Gen X respondents. Baby Boomers had the highest response of “same productivity” when compared to other age groups, indicating that they may be less interested in working in one type of environment over the other.
* Overall, people who work remotely completed more working hours than those at the office. Millennials tend to put in the most working hours when they are working 4-5 days per week remotely. Baby Boomers tend to work more when working remotely 0-1 days per week remotely.

### Time Spent 

![Time spent](https://github.com/betsysavage/RemoteWorkAnalysis/blob/d0ada1ff3e33a1015c4d7f0dc3b69c8db6f4e162/Resources/Images/dashboard%20png/time_spent.png)

* If someone was spending over three hours commuting to and from work, they were losing hours spent working as well as personal family time. 
* The hours saved when working remotely allowed time to be spent in other areas of life. These people reported more time spent working and more personal family time. 
* Organizations in turn gained hours of work from their employees.
 
### Organization Size 

![Organization Size](https://github.com/betsysavage/RemoteWorkAnalysis/blob/d0ada1ff3e33a1015c4d7f0dc3b69c8db6f4e162/Resources/Images/dashboard%20png/organization_size.png)

* There is an increasing amount of monthly virtual work hours being logged as company size grows (shown by line graph)
* In the case of a company consisting of 200 employees, they were averaging an extra 154 bonus work hours per month, simply by making the move to remote work. This number goes up for companies with older employees (shown in bar chart). 

### Remote Work Preference

![Remote Work Preference](https://github.com/betsysavage/RemoteWorkAnalysis/blob/d0ada1ff3e33a1015c4d7f0dc3b69c8db6f4e162/Resources/Images/dashboard%20png/remote_work_preference.png)

* Remote workers report that they are most productive on a hybrid 2-to-3-day work schedule or fully remote 4-to-5 days.
* Productivity on actual number of remote days worked shows that working 4-to-5 days is much more productive or about the same as in person.
* Productivity on preferred number of remote days they would like to work showed more of a preference to work 2-3 days compared their actual schedule. They also showed the same strong preference to work 4-5 days.
* Between these two heat maps, it really shows that people’s preference matters. Organizations may want to listen to their employees’ preferences as they report being more productive having a schedule that they prefer.

### Organization Policy Recommendations 

![org policy recs](https://github.com/betsysavage/RemoteWorkAnalysis/blob/d0ada1ff3e33a1015c4d7f0dc3b69c8db6f4e162/Resources/Images/dashboard%20png/organization_policy_recs.png)

* Regardless of whether the employees have been with the organization for less than a year, less than five years, or more than five years, over 58% of employees reported more productivity being remote. 
* New employees between six and twelve months reported higher productivity, more so than employees that had been with the organization for over a year.  61.76 % of new employees reported being more productive. 
* Would recommend remote learning opportunities for new employees not just remote work availability for more senior employees. 
* For employees that did not think their organization was ready for remote work, they did not report higher productivity. Higher productivity is seen more if the employee felt like their organization was ready to provide remote work opportunities.

## Recommendations

### Recommendations for Employers

As displayed in our dashboard visuals, remote work seems to be associated with improvements in average productivity (both in self-reported comparisons and in the amount of time spent on work) across industries and demographic groups. This analysis supports the idea that remote work strategies offer a net benefit to employers as well as employees. Furthermore, remote work trends established during Covid seem to have continued - A recent study from the New York Times suggests that nearly 40% of workers participate in some form of hybrid or remote work model. If remote work is here to stay, how can employers maximize the benefits of this model with policies that promote productivity and benefit their employees?

**1. Use the above dashboard to examine how findings change for specific industry types and available positions** Filters for industry and occupation types were added to each dashboard view in order to encourage employers to identify trends specific to their employee base in order to make informed business decisions about the best remote work policies and structure.

**2. When designing a hybrid remote/in-person model:** 

* Consider the demographic characteristics of your organization: As shown in our age analysis, the ideal number of workdays may vary based on the employee's generation. If the company's workforce consists of large proportion of baby boomers, offering 1 day of remote work per week may yield the highest return of working hours - but if the company profile has more millennials, the ideal split may consist of 3-4 remote days per week. 
* Identify trends in employee commutes: As employees save time on commuting, the time they save is often dedicated towards working more. A survey to collect data on the average commute time of the organization's workforce would allow an employer to offer an ideal number of remote workdays per week. 
* Think about growth goals: Our analysis demonstrated that as the organization size grew, so did the additional number of hours spent working remotely as compared to working in the office. This could be due to a variety of factors - Perhaps larger companies are offering more structure or better technology for their remote workers. As an organization scales in size, it would be wise to include conversations about remote work policy alongside other strategic goals. 
 
**3. Create structures for support and collaboration when working remotely**: Our analysis found a strong correlation between the opportunities for collaboration when working remotely and the self-assessed degree of productivity when compared to working remotely. 

**4. Trust employees to manage their time effectively when working remotely**: It is a common concern among employers that when workers operate remotely, they may become distracted and work less. When we examined our target productivity variable throughout our analysis, we saw similar trends in productivity when swapping features like worker preference for number of remote workdays, the actual number of remote workdays, and the number of daily hours worked. These patterns suggest that when workers express a strong preference for remote work or work their desired number of days per week from home, their number of actual working hours and productivity increase. If we draw the conclusion that employees are likely to express their preferences honestly and deliver productive working time, conducting internal surveys on remote work preferences would provide valuable information.   

### Recommendations for Future Research:

#### Limitations of Current Dataset

While this dataset allowed us to explore a broad set of factors affecting remote work, there were some limitations to the data that impacted our ability to draw more meaningful conclusions about remote work.

Some drawbacks of this data included:

1.) **Geographically specific:** Trends observed in a specific region in Australia may not be reflective of another geographic or cultural setting.

2.) **Point-in-time specific:** While the dataset captured attitudes and trends in 2020-2021, the landscape of Covid restrictions and isolation practices have shifted significantly with availability of vaccines. As remote work opportunities respond to employee demand, we may see an adjustment in these patterns or preferences. 

3.) **Only representative of remote workers:** Because the workers in the dataset were already accustomed to working remotely and express stronger preferences for working remotely, they may have self-selected into remote work positions. Sampling from the entire working population would have provided a clearer picture of the preferences and challenges of of the overall workforce.

#### Recommended Next Steps
In order to determine if these patterns apply to American culture in 2023, our group would identify a more recent data set with similar productivity measures. We would then replicate our modeling technique and compare trends.

