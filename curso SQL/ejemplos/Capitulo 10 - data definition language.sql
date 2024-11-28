/********************/
/* Database Objects */
/********************/
/*
--------------------------------------------------------------------------
Object      Description
--------------------------------------------------------------------------
Table       Basic unit of storage; composed of rows
View        Logically represents subsets of data from one or more tables
Sequence    Generates numeric values
Synonym     Gives alternative name to an object
Index       Improves the performance of some queries
--------------------------------------------------------------------------
*/
--------------------------------------------------------------------------
-- Naming Rules
--------------------------------------------------------------------------
/*
Table names and column names:
    
    - Must begin with a letter
    
    - Must be 1–30 characters long
    
    - Must contain only A–Z, a–z, 0–9, _, $, and #
    
    - Must not duplicate the name of another object owned by
      the same user
    
    - Must not be an Oracle server–reserved word
*/
--------------------------------------------------------------------------
-- CREATE TABLE Statement
--------------------------------------------------------------------------
/*
You must have:

    - CREATE TABLE privilege
    
    - A storage area

    CREATE TABLE [schema.]table
    (column datatype [DEFAULT expr][, ...]);

You specify:

    - Table name
    
    - Column name, column data type, and column size
*/
--------------------------------------------------------------------------
-- DEFAULT Option
--------------------------------------------------------------------------
/*
Literal values, expressions, or SQL functions are legal values.

- Another column’s name or a pseudocolumn are illegal values.

- The default data type must match the column data type.

    CREATE TABLE hire_dates
    (id NUMBER(8),
    hire_date DATE DEFAULT SYSDATE);
*/
--------------------------------------------------------------------------
-- Column Data Types
--------------------------------------------------------------------------
/*
---------------------------------------------------------------------------------------
Data Type                   Description
---------------------------------------------------------------------------------------
VARCHAR2(size)              Variable-length character data
CHAR(size)                  Fixed-length character data
NUMBER(p,s)                 Variable-length numeric data
DATE                        Date and time values
LONG                        Variable-length character data (up to 2 GB)
CLOB                        Character data (from 4 GB to 32 TB)
RAW and LONG RAW            Raw binary data
BLOB                        Binary data (from 4 GB to 32 TB)
BFILE                       Binary data stored in an external file (from 4 GB to 32 TB)
ROWID                       A base-64 number system representing the unique
                            address of a row in its table
TIMESTAMP                   Date with fractional seconds
INTERVAL YEAR TO MONTH      Stored as an interval of years and months
INTERVAL DAY TO SECOND      Stored as an interval of days, hours, minutes,
                            and seconds
---------------------------------------------------------------------------------------
*/
--------------------------------------------------------------------------
-- Including Constraints
--------------------------------------------------------------------------
/*
- Constraints enforce rules at the table level.

- Constraints prevent the deletion of a table if there
  are dependencies.

- The following constraint types are valid:

    - NOT NULL
    - UNIQUE
    - PRIMARY KEY
    - FOREIGN KEY
    - CHECK
----------------------------------------------------------------------------------------
Constraint      Description
----------------------------------------------------------------------------------------
NOT NULL        Specifies that the column cannot contain a null value
UNIQUE          Specifies a column or combination of columns whose values
                must be unique for all rows in the table
PRIMARY KEY     Uniquely identifies each row of the table
FOREIGN KEY     Establishes and enforces a referential integrity between the
                column and a column of the referenced table such that values
                in one table match values in another table.
CHECK           Specifies a condition that must be true
*/
--------------------------------------------------------------------------
-- Constraint Guidelines
--------------------------------------------------------------------------
/*
- You can name a constraint, or the Oracle server generates
  a name by using the SYS_Cn format.

- Create a constraint at either of the following times:

    - At the same time as the creation of the table
    - After the creation of the table

- Define a constraint at the column or table level.

- View a constraint in the data dictionary.

*/
--------------------------------------------------------------------------
-- Defining Constraints
--------------------------------------------------------------------------
/*
- Syntax:

    CREATE TABLE [schema.]table
    (column datatype [DEFAULT expr]
    [column_constraint],
    ...
    [table_constraint][,...]);

- Column-level constraint syntax:

    column [CONSTRAINT constraint_name] constraint_type,

- Table-level constraint syntax:

    column,...
    [CONSTRAINT constraint_name] constraint_type

*/
--------------------------------------------------------------------------
-- Example of Defining Constraints
--------------------------------------------------------------------------
/*
- Example of a column-level constraint:

    CREATE TABLE employees(
    employee_id NUMBER(6) CONSTRAINT emp_emp_id_pk PRIMARY KEY,
    first_name VARCHAR2(20),
    ...);

- Example of a table-level constraint:

    CREATE TABLE employees(
    employee_id NUMBER(6),
    first_name VARCHAR2(20),
    ...
    job_id VARCHAR2(10) NOT NULL,
    CONSTRAINT emp_emp_id_pk PRIMARY KEY (EMPLOYEE_ID));
*/
--------------------------------------------------------------------------
-- UNIQUE Constraint
--------------------------------------------------------------------------
/*
Defined at either the table level or the column level:

    CREATE TABLE employees(
    employee_id NUMBER(6),
    last_name VARCHAR2(25) NOT NULL,
    email VARCHAR2(25),
    salary NUMBER(8,2),
    commission_pct NUMBER(2,2),
    hire_date DATE NOT NULL,
    ...
    CONSTRAINT emp_email_uk UNIQUE(email));
*/
--------------------------------------------------------------------------
-- FOREIGN KEY Constraint
--------------------------------------------------------------------------
/*
Defined at either the table level or the column level:

    CREATE TABLE employees(
    employee_id NUMBER(6),
    last_name VARCHAR2(25) NOT NULL,
    email VARCHAR2(25),
    salary NUMBER(8,2),
    commission_pct NUMBER(2,2),
    hire_date DATE NOT NULL,
    ...
    department_id NUMBER(4),
    CONSTRAINT emp_dept_fk FOREIGN KEY (department_id) REFERENCES departments(department_id),
    CONSTRAINT emp_email_uk UNIQUE(email));

Keywords

- FOREIGN KEY: Defines the column in the child table at the
  table-constraint level

- REFERENCES: Identifies the table and column in the parent
  table

- ON DELETE CASCADE: Deletes the dependent rows in the
  child table when a row in the parent table is deleted

- ON DELETE SET NULL: Converts dependent foreign key
  values to null
  
*/
--------------------------------------------------------------------------
-- CHECK Constraint
--------------------------------------------------------------------------
/*
- Defines a condition that each row must satisfy

- The following expressions are not allowed:
    - References to CURRVAL, NEXTVAL, LEVEL, and ROWNUM
      pseudocolumns
    - Calls to SYSDATE, UID, USER, and USERENV functions
    - Queries that refer to other values in other rows

..., salary NUMBER(2) CONSTRAINT emp_salary_min CHECK (salary > 0),...

*/

/**************************************************************/
/* Creación de restricciones de integridad a nivel de columna */
/**************************************************************/

--DROP TABLE DEPARTMENTS_COPY;

--CREATE TABLE DEPARTMENTS_COPY (	
--    DEPARTMENT_ID NUMBER(4,0)    CONSTRAINT DEPT_ID_PK_COPY PRIMARY KEY, 
--	DEPARTMENT_NAME VARCHAR2(30) CONSTRAINT DEPT_NAME_NN_COPY NOT NULL, 
--	MANAGER_ID NUMBER(6,0), 
--	LOCATION_ID NUMBER(4,0)      CONSTRAINT DEPT_LOC_FK_COPY  REFERENCES LOCATIONS (LOCATION_ID) 
--    );

--DROP TABLE employees_copy;

--CREATE TABLE employees_copy
--( employee_id NUMBER(6)   CONSTRAINT emp_employee_id_copy PRIMARY KEY,
--  first_name VARCHAR2(20),
--  last_name VARCHAR2(25)  CONSTRAINT emp_last_name_nn_copy NOT NULL,
--  email VARCHAR2(25)      CONSTRAINT emp_email_nn_copy NOT NULL
--                          CONSTRAINT emp_email_uk_copy  UNIQUE, 
--  phone_number VARCHAR2(20),
--  hire_date DATE          CONSTRAINT emp_hire_date_nn_copy NOT NULL,
--  job_id VARCHAR2(10)     CONSTRAINT emp_job_nn_copy NOT NULL,
--  salary NUMBER(8,2)      CONSTRAINT emp_salary_ck_copy CHECK (salary>0),
--  commission_pct NUMBER(2,2), 
--  manager_id NUMBER(6)    CONSTRAINT emp_manager_fk_copy REFERENCES employees (employee_id),
--  department_id NUMBER(4) CONSTRAINT emp_dept_fk_copy REFERENCES departments (department_id));

------------------------------------------------------------------------------------------
-- la siguiente restricción no se puede crear antes de que exista la tablA EMPLOYEES_COPY
------------------------------------------------------------------------------------------

-- ALTER TABLE DEPARTMENTS_COPY ADD CONSTRAINT DEPT_MGR_FK_COPY FOREIGN KEY(manager_id) REFERENCES EMPLOYEES_COPY (EMPLOYEE_ID) ;

/************************************************************/
/* Creación de restricciones de integridad a nivel de tabla */
/************************************************************/
--DROP TABLE DEPARTMENTS_COPY;

--CREATE TABLE DEPARTMENTS_COPY (
--    DEPARTMENT_ID NUMBER(4,0),
--    DEPARTMENT_NAME VARCHAR2(30) CONSTRAINT DEPT_NAME_NN_COPY NOT NULL, 
--    MANAGER_ID NUMBER(6,0),
--    LOCATION_ID NUMBER(4,0),
--    CONSTRAINT DEPT_ID_PK_COPY PRIMARY KEY (DEPARTMENT_ID),
--      CONSTRAINT DEPT_DEPT_NN_COPY CHECK (DEPARTMENT_NAME IS NOT NULL),
--    CONSTRAINT DEPT_LOC_FK_COPY FOREIGN KEY (LOCATION_ID) REFERENCES LOCATIONS (LOCATION_ID)
--);

--DROP TABLE employees_copy;

--CREATE TABLE EMPLOYEES_COPY (
--  EMPLOYEE_ID NUMBER(6),
--  FIRST_NAME VARCHAR2(20),
--  LAST_NAME VARCHAR2(25),
--  EMAIL VARCHAR2(25),
--  PHONE_NUMBER VARCHAR2(20),
--  HIRE_DATE DATE,
--  JOB_ID VARCHAR2(10),
--  SALARY NUMBER(8,2),
--  COMMISSION_PCT NUMBER(2,2),
--  MANAGER_ID NUMBER(6),
--  DEPARTMENT_ID NUMBER(4),
--  CONSTRAINT EMP_EMPLOYEE_ID_COPY PRIMARY KEY (EMPLOYEE_ID),
--  CONSTRAINT EMP_LAST_NAME_NN_COPY CHECK (LAST_NAME IS NOT NULL),
--  CONSTRAINT EMP_EMAIL_NN_COPY CHECK (EMAIL IS NOT NULL),
--  CONSTRAINT EMP_EMAIL_UK_COPY UNIQUE (EMAIL),
--  CONSTRAINT EMP_HIRE_DATE_NN_COPY CHECK (HIRE_DATE IS NOT NULL),
--  CONSTRAINT EMP_JOB_NN_COPY CHECK (JOB_ID IS NOT NULL),
--  CONSTRAINT EMP_SALARY_CK_COPY CHECK (SALARY > 0),
--  CONSTRAINT EMP_MANAGER_FK_COPY FOREIGN KEY (MANAGER_ID) REFERENCES EMPLOYEES (EMPLOYEE_ID),
--  CONSTRAINT EMP_DEPT_FK_COPY FOREIGN KEY (DEPARTMENT_ID) REFERENCES DEPARTMENTS (DEPARTMENT_ID)
--);

------------------------------------------------------------------------------------------
-- la siguiente restricción no se puede crear antes de que exista la tablA EMPLOYEES_COPY
------------------------------------------------------------------------------------------

-- ALTER TABLE DEPARTMENTS_COPY ADD CONSTRAINT DEPT_MGR_FK_COPY FOREIGN KEY(manager_id) REFERENCES EMPLOYEES_COPY (EMPLOYEE_ID) ;


