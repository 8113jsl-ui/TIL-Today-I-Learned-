-- 04 함수2 : 집계 함수
-- [점검문제]


-- [문제 1]
select * from 고객;

select count(도시), count(distinct 도시)
from 고객;


-- [문제 2]
select * from 주문;

select year(주문일) 주문년도, count(*)
from 주문
group by 주문년도;


-- [문제 3]
select year(주문일) 주문년도, quarter(주문일) 분기, count(*) 주문건수
from 주문
group by 주문년도, 분기
with rollup;


-- [문제 4]
select * from 주문;
select month(주문일) 주문월, count(*) 주문건수
from 주문
where 요청일 < 발송일
group by 1
order by 1;


-- [문제 5]
select * from 제품;

select 제품명, sum(재고)
from 제품
group by 제품명
having 제품명 like '%아이스크림%';


-- [문제 6]
select * from 고객;

select
	case
    when 마일리지 >= 50000 then 'VIP고객'
    else '일반고객'
    end 고객구분,
    count(*) 고객수,
    avg(마일리지) 평균마일리지
from 고객
group by 고객구분;