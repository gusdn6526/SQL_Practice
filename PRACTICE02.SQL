-- AGGREGATE PRACTICE 02

-- 문제 01

SELECT MAX (SALARY) AS "최고 임금",
       MIN (SALARY) AS "최저 임금",
       (MAX (SALARY) - MIN (SALARY)) AS "최고 - 최저"
  FROM EMPLOYEES;

-- 문제 02

SELECT TO_CHAR (MAX (HIRE_DATE), 'YYYY-MM-DD') AS "최근 사원 입사일"
  FROM EMPLOYEES;

-- 문제 03

  SELECT DEPARTMENT_ID,
         AVG (SALARY),
         MAX (SALARY),
         MIN (SALARY)
    FROM EMPLOYEES
GROUP BY DEPARTMENT_ID
ORDER BY AVG (SALARY), MAX (SALARY), MIN (SALARY) DESC;

-- 문제 04

  SELECT JOB_ID,
         AVG (SALARY),
         MAX (SALARY),
         MIN (SALARY)
    FROM EMPLOYEES
GROUP BY JOB_ID
ORDER BY AVG (SALARY), MAX (SALARY), MIN (SALARY) DESC;

-- 문제 05

SELECT TO_CHAR (MIN (HIRE_DATE), 'YYYY-MM-DD')
          AS "오래 일한 직원 입사일"
  FROM EMPLOYEES;

-- 문제 06

  SELECT DEPARTMENT_ID,
         ROUND (AVG (SALARY)),
         MIN (SALARY),
         ROUND (AVG (SALARY) - MIN (SALARY)) AS "AVG-MIN"
    FROM EMPLOYEES
GROUP BY DEPARTMENT_ID
  HAVING AVG (SALARY) - MIN (SALARY) < 2000
ORDER BY AVG (SALARY) - MIN (SALARY) DESC;

-- 문제 07

  SELECT JOB_TITLE, MAX_SALARY - MIN_SALARY AS "차이"
    FROM JOBS
ORDER BY MAX_SALARY - MIN_SALARY DESC;