-- Module 7.3.2
DROP TABLE IF EXISTS retirement_info;

-- Retirement eligibility
SELECT emp_no, first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');
-- Check the table
select * from retirement_info;

-- Module 7.3.3
-- Joining departments and dept_manager tables
SELECT d.dept_name,
	dm.emp_no,
	dm.from_date,
	dm.to_date
FROM departments AS d
INNER JOIN dept_manager AS dm
ON d.dept_no = dm.dept_no
ORDER BY emp_no;

-- Joining retirement_info and dept_emp tables
DROP TABLE IF EXISTS current_emp;
SELECT ri.emp_no,
	ri.first_name,
	ri.last_name,
	de.to_date
INTO current_emp
FROM retirement_info AS ri
LEFT JOIN dept_emp AS de 
ON ri.emp_no = de.emp_no
WHERE de.to_date = ('9999-01-01');

-- list of current employees eligible for retirement
SELECT * FROM current_emp;

-- Module 7.3.4
-- Employee count by department
DROP TABLE IF EXISTS emp_by_dept;

SELECT COUNT(ce.emp_no), de.dept_no
INTO emp_by_dept
FROM current_emp AS ce
LEFT JOIN dept_emp AS de
ON ce.emp_no = de.emp_no
GROUP BY de.dept_no
ORDER BY de.dept_no;

SELECT * from emp_by_dept;

-- Module 7.3.5
-- Explore salaries table
SELECT * FROM salaries
ORDER BY to_date DESC;

-- LIST 1
-- Employee info table:  eligible current employess for retirements, including gender and salary
DROP TABLE IF EXISTS emp_info;

SELECT e.emp_no, e.first_name, e.last_name, e.gender,
	s.salary,
	de.to_date
INTO emp_info
FROM employees AS e
INNER JOIN salaries AS s
ON (e.emp_no = s.emp_no)
INNER JOIN dept_emp AS de
ON (e.emp_no = de.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
	AND (e.hire_date BETWEEN '1985-01-01' AND '1988-12-31')
	AND (de.to_date = '9999-01-01');

SELECT * FROM emp_info;

-- LIST 2
-- List of manager by department
DROP TABLE IF EXISTS manager_info;

SELECT dm.dept_no,
		d.dept_name,
		dm.emp_no,
		ce.last_name,
		ce.first_name,
		dm.from_date,
		dm.to_date
INTO manager_info
FROM dept_manager AS dm
	INNER JOIN departments AS d
		ON (dm.dept_no = d.dept_no)
	INNER JOIN current_emp AS ce
		ON (dm.emp_no = ce.emp_no);

SELECT * FROM manager_info;

-- LIST 3
-- List of department retirees
DROP TABLE IF EXISTS dept_info;

SELECT ce.emp_no,
		ce.first_name,
		ce.last_name,
		d.dept_name
INTO dept_info
FROM current_emp AS ce
INNER JOIN dept_emp AS de
ON (ce.emp_no = de.emp_no)
INNER JOIN departments AS d
ON (de.dept_no = d.dept_no)
--WHERE d.dept_name IN ('Sales','Development');

SELECT * FROM dept_info;

-- List of department retirees
SELECT count(ce.emp_no),
		--ce.first_name,
		--ce.last_name,
		d.dept_name
-- INTO dept_info
FROM current_emp AS ce
INNER JOIN dept_emp AS de
ON (ce.emp_no = de.emp_no)
INNER JOIN departments AS d
ON (de.dept_no = d.dept_no)
WHERE d.dept_name IN ('Sales','Development')
GROUP BY d.dept_name;

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (______) _____,
______,
______,
______

--INTO retirement_titles
FROM emp_info
ORDER BY _____, _____ DESC;
