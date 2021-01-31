# Pewlett_Hackard-Analysis

## Overview/Purpose of the Analysis:
-Our company, Pewlett Hackard, is coming up on a time period where a record number of our employees will begin to retire, the so-called 'Silver Tsunami'. In order to avoid a crisis with so many people leaving at the same time. I was tasked with querying our newly created sql database, to find the answers to the following questions:
 
 - How many people are retiring?
 - For each title, how many retirees do we have?
 - Which employees are eligible for the mentorship program?
_ We are also looking to start a mentorship program within the company since we are losing so many senior members of our staff. We will compile a list of employees that are eligible for such a program
## Results
### There were 4 major points that I need to bring forward:
1. We 
1. We have approximately 90,000 employes that will be retiring soon.
2. There are 7 different titles we will need to account for during the hiring process. Three out of the 7 are senior level positions.
3. Between out senior engineers and senior staff, we will retire almost 60,000 staff members. Finding enough qualified applicants for these roles may be difficult
4. With the current eleigibilty parameters, there will be 1,549 staff members that will be eligible for our mentorship programs. 

## Summary:  Provide high-level responses to the following questions, then provide two additional queries or tables that may provide more insight into the upcoming "silver tsunami."

  * How many roles will need to be filled as the "silver tsunami" begins to make an impact? 90,398 will
  SELECT 
  * Are there enough qualified, retirement-ready employees in the departments to mentor the next generation of Pewlett Hackard employees? No there is not, we will need yo widen the parameters for the program. I added 2 years to the parameter, 1963-1965. This change amounts to about 40,000 employees that we could train to fill the soon-to-be positions.
  
  SELECT DISTINCT ON(e.emp_no) e.emp_no, 
    e.first_name, 
    e.last_name, 
    e.birth_date,
    de.from_date,
    de.to_date,
    t.title
FROM employees as e 
INNER JOIN dept_emp as de
ON (e.emp_no = de.emp_no)
INNER JOIN titles as t
ON (e.emp_no = t.emp_no)
WHERE (birth_date BETWEEN '1963-01-01' AND '1965-12-31')
AND (de.to_date = '9999-01-01')
ORDER BY e.emp_no;

