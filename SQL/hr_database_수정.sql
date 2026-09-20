-- 1. 권역
CREATE TABLE regions (
    region_id   INT PRIMARY KEY,
    region_name VARCHAR(25) NOT NULL
);

-- 2. 국가
CREATE TABLE countries (
    country_id   CHAR(2) PRIMARY KEY,
    country_name VARCHAR(25) NOT NULL,
    region_id    INT NOT NULL
);

-- 3. 위치
CREATE TABLE locations (
    location_id    INT PRIMARY KEY,
    street_address VARCHAR(40),
    postal_code    VARCHAR(10),
    city           VARCHAR(25) NOT NULL,
    state_province VARCHAR(25),
    country_id     CHAR(2) NOT NULL
);

-- 4. 부서
CREATE TABLE departments (
    department_id   INT PRIMARY KEY,
    department_name VARCHAR(30) NOT NULL,
    manager_id      INT,
    location_id     INT NOT NULL
);

-- 5. 직무
CREATE TABLE jobs (
    job_id     VARCHAR(10) PRIMARY KEY,
    job_title  VARCHAR(35) NOT NULL,
    min_salary INT NOT NULL,
    max_salary INT NOT NULL,

    CHECK (min_salary >= 0),
    CHECK (max_salary >= min_salary)
);

-- 6. 직원
CREATE TABLE employees (
    employee_id    INT PRIMARY KEY,
    first_name     VARCHAR(20),
    last_name      VARCHAR(25) NOT NULL,
    email          VARCHAR(25) NOT NULL UNIQUE,
    phone_number   VARCHAR(20),
    hire_date      DATE NOT NULL,
    job_id         VARCHAR(10) NOT NULL,
    salary         INT NOT NULL,
    commission_pct DECIMAL(4,2),
    manager_id     INT,
    department_id  INT NOT NULL,

    CHECK (salary > 0)
);

-- 7. 직무 변경 이력
CREATE TABLE job_history (
    employee_id   INT NOT NULL,
    start_date    DATE NOT NULL,
    end_date      DATE NOT NULL,
    job_id        VARCHAR(10) NOT NULL,
    department_id INT NOT NULL,

    PRIMARY KEY (employee_id, start_date),

    CHECK (end_date > start_date)
);

-- 8. 급여 등급
CREATE TABLE job_grades (
    grade_level VARCHAR(3) PRIMARY KEY,
    lowest_sal  INT NOT NULL,
    highest_sal INT NOT NULL,

    CHECK (lowest_sal >= 0),
    CHECK (highest_sal >= lowest_sal)
);

-- 외래키 연결
ALTER TABLE countries
ADD FOREIGN KEY (region_id)
    REFERENCES regions(region_id)
    ON DELETE NO ACTION;

ALTER TABLE locations
ADD FOREIGN KEY (country_id)
    REFERENCES countries(country_id)
    ON DELETE NO ACTION;

ALTER TABLE departments
ADD FOREIGN KEY (location_id)
    REFERENCES locations(location_id)
    ON DELETE NO ACTION;

ALTER TABLE employees
ADD FOREIGN KEY (job_id)
    REFERENCES jobs(job_id)
    ON DELETE NO ACTION;

ALTER TABLE employees
ADD FOREIGN KEY (department_id)
    REFERENCES departments(department_id)
    ON DELETE NO ACTION;

ALTER TABLE employees
ADD FOREIGN KEY (manager_id)
    REFERENCES employees(employee_id)
    ON DELETE NO ACTION;

ALTER TABLE departments
ADD FOREIGN KEY (manager_id)
    REFERENCES employees(employee_id)
    ON DELETE NO ACTION;

ALTER TABLE job_history
ADD FOREIGN KEY (employee_id)
    REFERENCES employees(employee_id)
    ON DELETE NO ACTION;

ALTER TABLE job_history
ADD FOREIGN KEY (job_id)
    REFERENCES jobs(job_id)
    ON DELETE NO ACTION;

ALTER TABLE job_history
ADD FOREIGN KEY (department_id)
    REFERENCES departments(department_id)
    ON DELETE NO ACTION;
