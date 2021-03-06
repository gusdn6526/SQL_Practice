--SUB QUERY
--문) 이름(FIRST_NAME)이 Lex 사원보다 많은 월급을 받는 직원들의 이름과 직책

SELECT FIRST_NAME, ROUND (SALARY)
  FROM EMPLOYEES
 WHERE SALARY > (SELECT ROUND (SALARY)
                   FROM EMPLOYEES
                  WHERE FIRST_NAME = 'Lex');



SELECT A.FIRST_NAME, ROUND (B.SALARY)
  FROM EMPLOYEES A,
       (SELECT SALARY
          FROM EMPLOYEES
         WHERE FIRST_NAME = 'Lex') B
 WHERE A.SALARY > B.SALARY;


 -- SINGLE ROW SUBQUERY

SELECT SALARY
  FROM EMPLOYEES
 WHERE FIRST_NAME = 'Lex';



SELECT FIRST_NAME, ROUND (SALARY)
  FROM EMPLOYEES
 WHERE SALARY >= (SELECT ROUND (SALARY)
                    FROM EMPLOYEES
                   WHERE FIRST_NAME = 'Lex');

-- 전체 직원의 평균 월급보다 많은 월급을 받고 있는 직원 이름,월급 출력

SELECT FIRST_NAME, ROUND (SALARY)
  FROM EMPLOYEES
 WHERE SALARY > (SELECT AVG (SALARY) FROM EMPLOYEES);


-- MULTI LOW SUBQUERY
-- Q) JOB_ID가 'IT_PROG'인 직원이 받는 월급 보다 많이 받고 있는 직원의 이름과 월급

SELECT SALARY
  FROM EMPLOYEES
 WHERE JOB_ID = 'IT_PROG';

-- ALL

SELECT FIRST_NAME, ROUND (SALARY)
  FROM EMPLOYEES
 WHERE SALARY > ALL (SELECT SALARY
                       FROM EMPLOYEES
                      WHERE JOB_ID = 'IT_PROG');


-- Q) JOB_ID가 'IT_PROG'인 직원이 받는 월급과 똑같은 월급을 받고  있는 직원의 이름과 월급
-- IN

SELECT FIRST_NAME, ROUND (SALARY)
  FROM EMPLOYEES
 WHERE SALARY IN (SELECT SALARY
                    FROM EMPLOYEES
                   WHERE JOB_ID = 'IT_PROG');

-- ANY

SELECT FIRST_NAME, ROUND (SALARY)
  FROM EMPLOYEES
 WHERE SALARY = ANY (SELECT SALARY
                       FROM EMPLOYEES
                      WHERE JOB_ID = 'IT_PROG');



-- CORRELATED SUBQUERY
-- Q) 각 부서별로 최고 월급을 받는 직원의 이름과 월급 출력

  SELECT DEPARTMENT_ID, MAX (SALARY)
    FROM EMPLOYEES
GROUP BY DEPARTMENT_ID;

-- 1) WHERE

SELECT DEPARTMENT_ID, FIRST_NAME, ROUND (SALARY)
  FROM EMPLOYEES
 WHERE (DEPARTMENT_ID, SALARY) IN (  SELECT DEPARTMENT_ID, MAX (SALARY)
                                       FROM EMPLOYEES
                                   GROUP BY DEPARTMENT_ID);

-- 2) FROM

SELECT A.DEPARTMENT_ID, A.FIRST_NAME, ROUND (A.SALARY)
  FROM EMPLOYEES A,
       (  SELECT DEPARTMENT_ID, MAX (SALARY) AS MAX_SALARY
            FROM EMPLOYEES
        GROUP BY DEPARTMENT_ID) B
 WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID AND A.SALARY = B.MAX_SALARY;


-- 3) CORRELATED

SELECT DEPARTMENT_ID, FIRST_NAME, ROUND (SALARY)
  FROM EMPLOYEES A
 WHERE SALARY IN (SELECT MAX (SALARY)
                    FROM EMPLOYEES
                   WHERE A.DEPARTMENT_ID = DEPARTMENT_ID);



-- Q) 자기 부서의 평균 월급보다 적은 월급을 받는 직원의 이름과 월급 출력

-- 2) FROM

SELECT A.DEPARTMENT_ID,
       A.FIRST_NAME,
       ROUND (A.SALARY),
       ROUND (B.AVG_SALARY)
  FROM EMPLOYEES A,
       (  SELECT DEPARTMENT_ID, AVG (SALARY) AS AVG_SALARY
            FROM EMPLOYEES
        GROUP BY DEPARTMENT_ID) B
 WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID AND A.SALARY < B.AVG_SALARY;


-- 3) CORRELATED

SELECT DEPARTMENT_ID, FIRST_NAME, ROUND (SALARY)
  FROM EMPLOYEES A
 WHERE SALARY < (SELECT AVG (SALARY)
                   FROM EMPLOYEES
                  WHERE A.DEPARTMENT_ID = DEPARTMENT_ID);



-- TOK-K

-- 잘못된 형식

  SELECT ROWNUM, EMPLOYEE_ID, ROUND (SALARY)
    FROM EMPLOYEES
   WHERE HIRE_DATE LIKE '06%'
ORDER BY SALARY DESC;


-- ORDER BY 를 먼저 하고 ROWNUM 한다.
SELECT *
FROM(
	SELECT ROWNUM AS RN, EMPLOYEE_ID, ROUND (SALARY)
  	FROM (  SELECT EMPLOYEE_ID, SALARY
            FROM EMPLOYEES
           WHERE HIRE_DATE LIKE '06%'
        ORDER BY SALARY DESC))
WHERE 6 <= RN AND RN <= 10;
