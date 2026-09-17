USE bookstore;
 
CREATE TABLE book_order (
    order_id       VARCHAR(10) PRIMARY KEY,
    book_id        VARCHAR(10),
    customer_name  VARCHAR(30),
    qty            INT,
    order_date     DATE,
    request_date   DATE,
    ship_date      DATE,
    FOREIGN KEY (book_id) REFERENCES book(book_id)
);


select * from book;
select * from book_order;
select * from book where book_id = 'BK001';

-- 실습 문제 1 (9/16)
select 
	title, concat(left(title, 6), '..') as 미리보기 
from book;

-- 문제 2
select 
	concat(left(book_id, 2), '-', right(book_id, 3)) 도서코드_신규 
from book;

-- 문제 3
select 
	concat(left(author,1), repeat('*', char_length(author) - 1)) 저자_마스킹 
from book;

-- 문제 4
select 
	title 도서명, price 정가, truncate(price*(1-(discount_rate/100)), -2) 실판매가 
from book;

-- 문제 5
select title 도서명, stock 재고수량,
	case 
		 when stock < 5 then '품절입박'
		 when stock >= 30 then '충분'
		 else '보통'
	end as 재고등급
from book
order by 재고수량;


-- 문제 6
select category 분야, title 도서명, price 정가,
	case
    when price < 15000 then '저가'  -- when, where 절 : 별칭 사용 x
    when price <= 25000 then '저가'
	else '저가'
    end 가격대
from book
order by 분야 asc, 정가 desc;

-- 문제 7
select title 도서명, pub_date 출간일, quarter(pub_date) '출간 분기', monthname(pub_date) '출간 월',
	case weekday(pub_date)
    when 0 then '월요일'
	when 1 then '화요일'
    when 2 then '수요일'
	when 3 then '목요일'
    when 4 then '금요일'
	when 5 then '토요일'
    when 6 then '일요일'
    end 출간요일
from book;

-- 문제 8 : 
select title 도서명, pub_date 출간일, datediff(now(), pub_date) 경과일수
from book
where datediff(now(), pub_date) >= 1000
order by 경과일수 desc;   -- 요즘 업계에서는 order by 쓰지 않는다 : 리소스 잡아먹고 시간 오래 걸림 -> 그래서 sorting하지 않고 어플리케이션에 보내서, 그 프론트에서 sorting하는 게 빠름

-- 문제 9 : 다가올 이벤트 예측테이터 -> 예측 이벤트 구현
select 
	title 도서명, pub_date 출간일, adddate(pub_date, 1000) '출간1000일_기념일'  -- adddate : 1일 단위로 가산함
from book
order by pub_date;

-- 문제 10
select
    customer_name as 고객명, 
    request_date as 요청일, 
    ship_date as 발송일, 
    datediff(ship_date, request_date) as 지연일수,
    if(datediff(ship_date, request_date) >= 3, '지연', '정상') as 배송상태  -- select (새 컬럼) as (별명) -> 새 컬럼을 추가할 수 있음!!!!!!
from book_order 
where datediff(ship_date, request_date) >= 3 
order by 지연일수 desc;