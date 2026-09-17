use bookstore;

INSERT INTO book_order VALUES
('O011','BK006','서준호',2,'2025-08-14','2025-08-18','2025-08-19'),
('O012','BK009','한소연',1,'2025-08-15','2025-08-19','2025-08-20'),
('O013','BK001','김도윤',3,'2025-08-16','2025-08-20','2025-08-21'),
('O014','BK010','박지훈',2,'2025-08-17','2025-08-21','2025-08-27'),
('O015','BK003','정하늘',1,'2025-08-18','2025-08-22','2025-08-23'),
('O016','BK006','이수민',4,'2025-08-19','2025-08-23','2025-08-24');

select * from book_order;


-- [문제 1]
select count(*) 전체도서수 from book;

-- [문제 2]
select count(distinct category) 분야수 from book;

-- [문제 3]
select count(*) IT도서수
from book
where category = 'IT';

-- [문제 4]
select sum(stock) 전체재고수량 from book;

-- [문제 5]
select sum(stock) 재고부족합계
from book
where stock < 10;

-- [문제 6]
select format(round(avg(price),0),'0,000') 평균정가
from book;

-- [문제 7]
select format(max(price),'0,000') 최고가, format(min(price),'0,000') 최저가
from book;

-- [문제 8]
select format(sum(price * stock), '0,000') 재고자산총액
from book;

-- [문제 9]
select category 분야, count(*) 도서수
from book
group by 분야
order by 도서수 desc;

-- [문제 10]
select category 분야, round(avg(price),0) 평균정가
from book
group by 1
order by 평균정가 desc;

-- [문제 11]
select category 분야, sum(stock) 재고합계
from book
group by 1
order by 2 desc;

-- [문제 12]
select category 분야, max(price)-min(price) 가격격차
from book
group by 분야
order by 가격격차 desc;

-- [문제 13]
select publisher 출판사, count(*) 출간도서수
from book
group by 출판사
having 출간도서수 >= 2
order by 출간도서수 desc;

-- [문제 14]
select category 분야, truncate(avg(price),0) 평균정가
from book
group by 분야
having 평균정가 >= 18000
order by 평균정가 desc;

-- [문제 15]
select category 분야, truncate(avg(stock),0) 평균재고
from book
where stock >= 5
group by 분야
having 평균재고 >= 20
order by 분야;

-- [문제 16]
select category 분야, count(*) 도서수
from book
group by 분야
having 도서수 = 1;

-- [문제 17]
select
	case
    when price < 15000 then '저가'
    when price <= 25000 then '중가'
    else '고가'
    end 가격대,
    count(*) 도서수, round(avg(stock),0) 평균재고
from book
group by 가격대
order by 도서수 desc;

-- [문제 18]
select count(*) 전체주문건수, sum(qty) 총주문수량
from book_order;

-- [문제 19]
select book_id 도서코드, count(*) 주문건수, sum(qty) 총주문수량
from book_order
group by 1
having 주문건수 >= 2
order by 총주문수량 desc;

-- [문제 20]
select customer_name 고객명, count(*) 주문건수, round(avg(ship_date-order_date),0) 평균배송소요일
from book_order
group by 고객명
having 평균배송소요일 > 5
order by 평균배송소요일 desc;



















