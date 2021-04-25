-- MODULE CHALLENGE
-- DELIVERABLE 1.
-- STEPS 1-7
DROP TABLE IF EXISTS retirement_titles;

SELECT 	e.emp_no, 
		e.first_name, 
		e.last_name,
		t.title,
		t.from_date,
		t.to_date
INTO retirement_titles
FROM employees AS e
	LEFT JOIN titles AS t 
	ON e.emp_no = t.emp_no
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY emp_no;

SELECT * FROM retirement_titles;

-- STEPS 8-14
-- Use Dictinct with Orderby to remove duplicate rows
DROP TABLE IF EXISTS unique_titles;

SELECT DISTINCT ON (emp_no) 
	emp_no, 
	first_name, 
	last_name,
	title
INTO unique_titles
FROM retirement_titles
ORDER BY emp_no, to_date DESC;

SELECT * FROM unique_titles;

-- STEPS 15-20
-- Number of employees by their most recent job title who are about to retire
DROP TABLE IF EXISTS retiring_titles;

SELECT count(*), title
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY count(*) DESC;

SELECT * FROM retiring_titles;

-- DELIVERABLE 2
-- Steps 1-11
DROP TABLE IF EXISTS mentorship_eligibility;

SELECT	e.emp_no,
		e.first_name, e.last_name,
		e.birth_date,
		de.from_date, de.to_date,
		t.title
INTO mentorship_eligibility
FROM employees AS e
LEFT JOIN dept_emp AS de
	ON e.emp_no = de.emp_no
LEFT JOIN   -- latest title for each employee
	(SELECT DISTINCT ON (emp_no) 
	 	emp_no, title
	 FROM titles
	 ORDER BY emp_no, to_date DESC) AS T
	ON e.emp_no = t.emp_no 
WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
	AND (de.to_date = '9999-01-01')		-- current employees
ORDER BY e.emp_no;

SELECT * FROM mentorship_eligibility;

-- Alternate solution
SELECT DISTINCT ON (e.emp_no) 
		e.emp_no,
		e.first_name,
		e.last_name,
		e.birth_date,
		de.from_date,
		de.to_date,
		t.title
--INTO mentorship_elibility
FROM employees AS e
LEFT JOIN dept_emp AS de
	ON e.emp_no = de.emp_no
LEFT JOIN titles AS t
	ON e.emp_no = t.emp_no AND t.to_date=de.to_date
WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
	AND (de.to_date = '9999-01-01')
ORDER BY e.emp_no