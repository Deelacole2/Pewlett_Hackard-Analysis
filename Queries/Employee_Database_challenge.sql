
-- PART 1 - Retirement Titles csv
SELECT e.emp_no, 
    e.first_name, 
    e.last_name, 
    t.title, 
    t.from_date, 
    t.to_date
INTO retirement_titles
FROM employees as e
INNER JOIN titles as t
ON (e.emp_no = t.emp_no)
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31');

-- PART 2 -  Unique Titles csv
-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no) emp_no,
first_name,
last_name,
title
INTO unique_titles
FROM retirement_titles
ORDER BY emp_no, to_date DESC;

-- PART 3 - Retiring Titles csv
--Creating list with counts for retiring titles
SELECT title, COUNT(title)
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY COUNT DESC;

-- DELIVERABLE 2
-- Create mentorship eligibilty table
SELECT DISTINCT ON(e.emp_no) e.emp_no, 
    e.first_name, 
    e.last_name, 
    e.birth_date,
    de.from_date,
    de.to_date,
    t.title
INTO mentorship_eligibility
FROM employees as e 
INNER JOIN dept_emp as de
ON (e.emp_no = de.emp_no)
INNER JOIN titles as t
ON (e.emp_no = t.emp_no)
WHERE (birth_date BETWEEN '1965-01-01' AND '1965-12-31')
AND (de.to_date = '9999-01-01')
ORDER BY e.emp_no;


------------------------- Challenge summary code
-- Count of Retiring Staff
SELECT COUNT(retirees.emp_no)
FROM (SELECT DISTINCT ON (emp_no) emp_no,
first_name,
last_name,
title
FROM retirement_titles
ORDER BY emp_no, to_date DESC) as retirees;

-- Count of Mentees -- 1549
SELECT COUNT(mentees.emp_no)
FROM (SELECT DISTINCT ON(e.emp_no) e.emp_no, 
    e.first_name, 
    e.last_name, 
    e.birth_date,
    de.from_date,
    de.to_date,
    t.title
--INTO mentorship_eligibility
FROM employees as e 
INNER JOIN dept_emp as de
ON (e.emp_no = de.emp_no)
INNER JOIN titles as t
ON (e.emp_no = t.emp_no)
WHERE (birth_date BETWEEN '1965-01-01' AND '1965-12-31')
AND (de.to_date = '9999-01-01')
ORDER BY e.emp_no) as mentees;

--By Dept

SELECT by_dept.dept_no, COUNT(by_dept.dept_no), by_dept.dept_name
FROM (SELECT DISTINCT ON(e.emp_no) e.emp_no, 
		e.first_name, 
		e.last_name, 
		e.birth_date,
		de.from_date,
		de.to_date,
		de.dept_no,
	    d.dept_name,
		t.title
	-- INTO 
	FROM employees as e 
	INNER JOIN dept_emp as de
	ON (e.emp_no = de.emp_no)
	INNER JOIN titles as t
	ON (e.emp_no = t.emp_no)
	INNER JOIN departments as d
	ON (de.dept_no = d.dept_no)
	WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
	AND (de.to_date = '9999-01-01')
	ORDER BY e.emp_no) as by_dept
GROUP BY by_dept.dept_no, by_dept.dept_name
ORDER BY COUNT DESC;

