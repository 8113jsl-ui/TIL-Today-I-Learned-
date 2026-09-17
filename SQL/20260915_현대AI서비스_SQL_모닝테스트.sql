CREATE DATABASE IF NOT EXISTS bookstore;
use bookstore;

CREATE TABLE book (
    book_id        VARCHAR(10)  PRIMARY KEY,
    title          VARCHAR(100) NOT NULL,
    category       VARCHAR(20),
    author         VARCHAR(30),
    price          INT,
    stock          INT,
    discount_rate  INT,
    pub_date       DATE,
    publisher      VARCHAR(30)
);

-- 문제 1
select * from book;

-- 문제 2
select title as '도서명', author as '저자명', price as '판매가' from book;

-- 문제 3
select  title as '도서명', price as '정가', discount_rate as '할인율', price*(1-discount_rate/100) as '할인가' from book;

-- 문제 4
select title as '도서명', author as '저자' , price as '정가' 
from book
where price >= 20000;

-- 문제 5
select * from book where category = 'IT';

-- 문제 6
select title as '도서명', publisher as '출판사' from book where publisher <> '비즈니스북스';

-- 문제 7
select 
title as '도서명', stock as '재고' 
from book 
where stock < 10 
order by stock asc;

# order by stock asc; 가 없는 경우 -> book_id 기준으로 정렬된다
select 
book_id, title as '도서명', stock as '재고' 
from book 
where stock < 10;

-- 문제 8
select title as '도서명', price as '정가' from book where category = '에세이' order by 2 desc;

-- 문제 9
select distinct category as '분야' from book order by category asc;

-- 문제 10
SELECT
    title AS '도서명',
    author AS '저자',
    price * (1 - discount_rate / 100) AS '추천가'
FROM book
WHERE stock >= 5
  AND price * (1 - discount_rate / 100) <= 15000
ORDER BY 추천가 ASC;












