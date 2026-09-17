use hyundai;


-- [예제 5-1]
select * from 부서;
select * from 사원;

-- ANSI
select 부서.부서번호, 부서명, 이름, 사원.부서번호
from 사원
cross join 부서
where 이름 = '배재용';

-- Non-ANSI
select 부서.부서번호, 부서명, 이름, 사원.부서번호
from 사원, 부서
where 이름 = '배재용';


-- 1. 사원 -> 부서 (한 부서에는 여러 사원이 속함)
DESC 사원;

ALTER TABLE 사원
ADD CONSTRAINT FK_사원_부서
FOREIGN KEY (부서번호) REFERENCES 부서(부서번호);


SELECT DISTINCT 부서번호 FROM 부서;
SELECT DISTINCT 부서번호, 사원번호 FROM 사원;
-- # Error Code: 1452. Cannot add or update a child row: a foreign key constraint fails (`hyundai`.`#sql-15e8_3c`, CONSTRAINT `FK_사원_부서` FOREIGN KEY (`부서번호`) REFERENCES `부서` (`부서번호`)) 0.031 sec
-- # Error Code: 1452 이유 : 아직 부서가 없는 직원이 존재하기 때문에

UPDATE 사원 SET 부서번호 = NULL WHERE 사원번호 = 'E10';
COMMIT;

SELECT DISTINCT 부서번호, 사원번호 FROM 사원;


-- 2. 사원 --사원
SELECT 상사번호, 사원번호 FROM 사원;


DESC 사원;
SELECT 상사번호, 사원번호 FROM 사원;

ALTER TABLE 사원
ADD constraint FK_사원_상사
Foreign key (상사번호) references 사원(사원번호);

UPDATE 사원
SET 상사번호 = null
WHERE TRIM(상사번호) = '';  -- 상사번호가 '공백'일 때
COMMIT;



-- 3. 주문----주문세부
-- 주문 하나에 세부 항목이 여러개 있을 수 있다
-- 주문세부.주문번호 -> 주문.주문번호
SELECT DISTINCT 주문번호 FROM 주문;
SELECT DISTINCT 주문번호 FROM 주문세부;

DESC 주문;
DESC 주문세부;

ALTER TABLE 주문세부
ADD constraint FK_주문세부_주문
Foreign key (주문번호) references 주문(주문번호);



-- 4. 고객---주문
-- 고객 한명이 여러번 주문
-- 주문.고객번호 ->고객.고객번호
SELECT DISTINCT 고객번호 FROM 고객;
SELECT DISTINCT 고객번호 FROM 주문;

DESC 고객;
DESC 주문;

ALTER TABLE 주문
ADD constraint FK_주문_고객
Foreign key (고객번호) references 고객(고객번호);



-- 5. 제품----주문세부
-- 제품하나가 여러 주문 세부에 나타날 수 있다.
-- 주문세부.제품번호 ->제품.제품번호
SELECT DISTINCT 제품번호 FROM 제품;
SELECT DISTINCT 제품번호 FROM 주문세부;

DESC 제품;
DESC 주문세부;

ALTER TABLE 주문세부
ADD constraint FK_주문세부_제품
Foreign key (제품번호) references 제품(제품번호);


-- 6. 주문 → 사원  (한 사원은 여러 주문을 처리 : 1:N)
--    주문.사원번호 가 사원.사원번호 를 참조
-- ------------------------------------------------------------
ALTER TABLE 주문
    ADD CONSTRAINT FK_주문_사원
    FOREIGN KEY (사원번호) REFERENCES 사원(사원번호);