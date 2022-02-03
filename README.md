# Homer Consultanting Database Implementation

_This project is completed in Oracle Database 11g Express_

In this project, I created database for Homer Consulting and the company's structure is shown in the ER diagram. The relationships among the tables are shown in the schema.

## Description of the model

In _Homer Consulting_ each employee is employed by one department. One of the employees
from a department manages the department. Some employees (especially in larger departments)
supervise other employees in their department. Thus, one employee may have a supervisor and
may also supervise other employees as well. The CEO supervises the top-level employee of
each department.

The company runs projects for external clients. Information on both current clients (those that
have had projects done in the past) as well as potential clients (those who have not requested
projects yet) is kept. For billing purposes, each project is contained within one department.
Administration department does not run any projects. For each project start date and the total
cost is recorded. The total cost of a project can only be estimated (and recorded) after the project
is completed. For an ongoing project, the total cost will have a NULL value.

Each project has several employees working on (assigned to) the project. Most (but not
necessarily all) of employees assigned to a project come from one department. Newly hired
employees are not assigned to any project for the first few months and may be trained internally
or by attending a formal workshop. Each assignment is recorded on month-by-month base.
Within each month the date employee was assigned to that project, and the end date of the
assignment in that month (not necessarily the last day of the month) is recorded. In addition, the
total number of hours spent by the employee on the project in that month is kept. If an employee
worked on a project for two months, then two records would be created, one record for each
month. Number of hours used within each month is known and recorded after the monthly
assignment is completed. For an assignment in a current month, both the end date and hours
spent are NULL.

_Homer Consulting_ maintains a list of desired skills. For each desired skill, code, name and
category is kept. Not all of these skills might be represented among the employees. Whenever
an employee acquires a skill, through some form of training (i.e. completing a course at a
college, completing a technical training program, or a workshop) approved by the company, the
date when it was acquired and a comment regarding the training is recorded. Each employee
may take the same training more that once since some of the skills might need to be updated or
renewed. Each project requires one “major” skill.


## ER Diagram:

![image](https://user-images.githubusercontent.com/35508198/152398498-9d835717-e848-4a9d-9eeb-d677820e5758.png)


## Schema: 

![image](https://user-images.githubusercontent.com/35508198/152398127-0cf59c38-d583-4401-95ed-ed50fef9f634.png)
