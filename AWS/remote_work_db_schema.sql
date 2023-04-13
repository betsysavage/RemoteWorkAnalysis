--SQL SCHEMAS

-- Creating tables for Respondents
CREATE TABLE Respondents(
    responder_id INT NOT NULL,
    birth_year INT,
    gender VARCHAR (25),
    industry_desc VARCHAR (60),
    occupation_desc VARCHAR (90), 
    manage_others VARCHAR (15), 
    household VARCHAR (60),
    years_at_job VARCHAR (25),
    metro_or_regional VARCHAR (10),
    PRIMARY KEY (responder_id)
);
--DROP TABLE Respondents CASCADE;
SELECT * FROM Respondents

-- Creating tables for Orginizational_Data
CREATE TABLE Orginizational_Data(
    responder_id INT NOT NULL,
    organization_size VARCHAR (50),
    org_encouraged_rw VARCHAR (30),
    org_prepared_for_rw VARCHAR (30),
    rw_is_common_at_org VARCHAR (30), 
    rw_permission_is_attainable VARCHAR (30), 
    rw_collaboration_easy VARCHAR (30),
    if_no_covid_employer_encourage_rw VARCHAR (30),
    if_no_covid_employer_support_rw VARCHAR (30),
    if_no_covid_i_would_have_choice_about_rw VARCHAR (30),
    FOREIGN KEY (responder_id) REFERENCES Respondents (responder_id),
    PRIMARY KEY (responder_id)
);
--DROP TABLE Orginizational_Data CASCADE;
SELECT * FROM Orginizational_Data

-- Creating tables for Productivity
CREATE TABLE Time_Management(
    responder_id INT NOT NULL, 
    rw_percentage_2020 VARCHAR (15),
    preferred_rw_percentage_2020 VARCHAR (15),
    preferred_rw_percentage_future VARCHAR (15),
    productivity_remote_vs_office VARCHAR (30),
    inperson_hours__commuting FLOAT,
    inperson_hours__working FLOAT,
    inperson_hours__personal_family_time FLOAT, 
    inperson_hours_domestic_responsibilities FLOAT, 
    remote_hours_commuting FLOAT,
    remote_hours_working FLOAT,
    remote_hours_personal_family_time FLOAT,
    remote_hours_domestic_responsibilities FLOAT,
    commute_time_difference FLOAT,
    FOREIGN KEY (responder_id) REFERENCES Respondents (responder_id),
    PRIMARY KEY (responder_id)
);
--DROP TABLE Time_Management CASCADE;
SELECT * FROM Time_Management