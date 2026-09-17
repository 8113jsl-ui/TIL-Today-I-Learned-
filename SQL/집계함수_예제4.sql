use hyundai;
select * from 고객;

-- [예제 4-1]
-- count 함수 null 제외하고 집계 (null 미포함)
-- count(컬럼) : null을 반영하지 않는다   <-------->  count(*) : null 값 포함한다!
-- null은 계산할 수 없는 값 (unknown을 의미)
select count(*),
	count(고객번호),  -- PK : Unique + Not Null (유일성 + Null 불가능)
	count(도시),
	count(지역)
from 고객;


-- [예제 4-2]
select sum(마일리지),
	   avg(마일리지),
	   max(마일리지),
	   min(마일리지)
from 고객;

-- [예제 4-3]
select sum(마일리지), avg(마일리지), min(마일리지), max(마일리지)
from 고객
where 도시 = '서울특별시';


-- [예제 4-4]
select 도시, count(*), avg(마일리지)  -- count(*) : null 값 포함한다!
from 고객
group by 도시
order by count(*) desc, avg(마일리지) desc;
-- order by count(*), 마일리지 desc;  -- 마일리지를 쓸 수 없다! (group by로 지정한 컬럼들만 가능 - 도시, count(*), avg(마일리지))


select 도시, count(*), avg(마일리지)  -- count(*) : null 값 포함한다!
from 고객
group by 1;  -- 첫번쨰 컬럼(도시) 그룹핑


-- [예제 4-5]

-- 테이블 구조 확인 
desc 고객;
describe 고객; 

-- 코드 짜는 데 급급하지 말고,
-- 데이터 구조를 직접 확인해서 판단하기!
select 담당자직위, 도시, count(*) 고객수, avg(마일리지) 평균마일리지
from 고객
group by 1, 2
order by 1, 2;


-- [예쩨 4-6]
select 도시, count(*) 고객수, avg(마일리지) 평균마일리지
from 고객
group by 도시
having 고객수 >= 10;


-- [예제 4-7]
desc 고객;
select * from 고객;

select 고객번호, 마일리지
from 고객
where 고객번호 like 'T%';


select 도시, sum(마일리지) '마일리지 합'
from 고객
where 고객번호 like 'T%'  -- 테이블 전체에 대한 조건
group by 1
having sum(마일리지) >= 1000; -- 그룹에 대한 조건



-- [확인문제]
-- 1 : where  /  2 : 담당자직위  / 3 : having


-- [예제 4-8-1]
select 도시, count(*) 고객수, avg(마일리지) 평균마일리지
from 고객
where 지역 is null
group by 1
with rollup;


-- [예제 4-8-2]
select ifnull(지역, '총계') 도시, count(*) 고객수, avg(마일리지) 평균마일리지
from 고객
group by 지역
with rollup;


-- [예제 4-9]
select * from 고객;
select 담당자직위 from 고객;

select 담당자직위, 도시, count(*) 고객수
from 고객
where 담당자직위 like '%마케팅%'
group by 담당자직위, 도시
with rollup;


-- [예제 4-10]
SELECT 지역
      ,COUNT(*) AS 고객수, grouping(지역) as 구분
FROM 고객
WHERE 담당자직위 = '대표 이사'
GROUP BY 지역
WITH ROLLUP;

-- 담당자직위 = '대표 이사'인 레코드 중, 지역 컬럼이 null인 레코드가 14개
-- with rollup으로 나온 null -> 총계
-- 두 null을 구분하기 위해 -> grouping 함수
-- with rollup의 null = 1  /  지역이 null인 경우 = 0
-- 즉 1은 총계를 표시하는 표시? 플래그? 라고 할 수 잇다


-- [예시 4-11]
select group_concat(이름)
from 사원;


-- [예시 4-12]
select group_concat(지역)
from 고객;


-- [예제 4-13]
select 도시, group_concat(고객회사명)
from 고객
group by 도시;


-- [확인문제]
-- 1 : ifnull  /  2 : count(*)